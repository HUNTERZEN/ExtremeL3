#!/system/bin/sh
# Extreme L3 - Stable Core Service
# by HUNTERZEN

sleep 25

CONF=/data/adb/extremel3.conf
BOOT_FLAG=/data/adb/extremel3.booted

CPU_PATH=/sys/devices/system/cpu
GPU_PATH=/sys/class/kgsl/kgsl-3d0

# -------- Boot notification (once) --------
if [ ! -f "$BOOT_FLAG" ]; then
  cmd notification post -S bigtext ExtremeL3 \
    "Extreme L3 module is working"
  touch "$BOOT_FLAG"
fi

# -------- Create default config if missing --------
if [ ! -f "$CONF" ]; then
  cat > "$CONF" <<EOF
MODE=balanced
CPU_GOV=schedutil
GPU_GOV=msm-adreno-tz
EOF
fi

apply_gaming() {
  for cpu in $CPU_PATH/cpu*; do
    [ -d "$cpu" ] || continue
    echo performance > $cpu/cpufreq/scaling_governor 2>/dev/null
    MAXF=$(cat $cpu/cpufreq/cpuinfo_max_freq 2>/dev/null)
    [ -n "$MAXF" ] && {
      echo $MAXF > $cpu/cpufreq/scaling_min_freq
      echo $MAXF > $cpu/cpufreq/scaling_max_freq
    }
  done

  echo performance > $GPU_PATH/devfreq/governor 2>/dev/null
  MAXG=$(cat $GPU_PATH/devfreq/max_freq 2>/dev/null)
  [ -n "$MAXG" ] && {
    echo $MAXG > $GPU_PATH/devfreq/min_freq
    echo $MAXG > $GPU_PATH/devfreq/max_freq
  }
}

apply_balanced() {
  CPU_GOV=$(grep CPU_GOV "$CONF" | cut -d= -f2)
  GPU_GOV=$(grep GPU_GOV "$CONF" | cut -d= -f2)

  for cpu in $CPU_PATH/cpu*; do
    [ -d "$cpu" ] || continue
    echo "$CPU_GOV" > $cpu/cpufreq/scaling_governor 2>/dev/null
  done

  echo "$GPU_GOV" > $GPU_PATH/devfreq/governor 2>/dev/null
}

LAST_HASH=""

while true; do
  HASH=$(md5sum "$CONF" | cut -d' ' -f1)

  if [ "$HASH" != "$LAST_HASH" ]; then
    MODE=$(grep MODE "$CONF" | cut -d= -f2)

    if [ "$MODE" = "gaming" ]; then
      apply_gaming
    else
      apply_balanced
    fi

    LAST_HASH="$HASH"
  fi

  sleep 3
done

