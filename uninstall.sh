#!/system/bin/sh
# Extreme L3 Uninstall Script
# by HUNTERZEN

ui_print "• Removing Extreme L3 configuration files"

# Remove config file
rm -f /data/adb/extremel3.conf

# Remove boot notification flag
rm -f /data/adb/extremel3.booted

ui_print "• Restoring CPU governors to default (schedutil)"

# Restore CPU governors
for cpu in /sys/devices/system/cpu/cpu*; do
  [ -d "$cpu" ] || continue
  echo schedutil > "$cpu/cpufreq/scaling_governor" 2>/dev/null

  MINF=$(cat "$cpu/cpufreq/cpuinfo_min_freq" 2>/dev/null)
  MAXF=$(cat "$cpu/cpufreq/cpuinfo_max_freq" 2>/dev/null)

  [ -n "$MINF" ] && echo "$MINF" > "$cpu/cpufreq/scaling_min_freq"
  [ -n "$MAXF" ] && echo "$MAXF" > "$cpu/cpufreq/scaling_max_freq"
done

ui_print "• Restoring GPU governor to stock (msm-adreno-tz)"

# Restore GPU governor
GPU=/sys/class/kgsl/kgsl-3d0/devfreq/governor
echo msm-adreno-tz > "$GPU" 2>/dev/null

ui_print "• Extreme L3 removed successfully"
ui_print "• Reboot recommended"

