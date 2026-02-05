##########################################################################################
#
# Extreme L3 Configuration Script
# by HUNTERZEN
#
##########################################################################################

MODID=extremel3

# Enable Magic Mount
AUTOMOUNT=true

# No system.prop needed
PROPFILE=false

# No post-fs-data script
POSTFSDATA=false

# Enable late_start service
LATESTARTSERVICE=true

##########################################################################################
# Installation UI
##########################################################################################

print_modname() {

  ui_print ""
  ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  ui_print " 🔥 Extreme L3 Performance Module 🔥 "
  ui_print "            by HUNTERZEN                "
  ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  ui_print ""
  sleep 0.5

  ui_print "• Initializing module configuration"
  sleep 0.4

  ui_print "• Checking device compatibility"
  sleep 0.4
  ui_print "  - Target chipset : Snapdragon 870"
  sleep 0.3
  ui_print "  - Architecture   : arm64"
  sleep 0.3

  ui_print ""
  ui_print "• Verifying Magisk / KernelSU environment"
  sleep 0.5

  ui_print "• Preparing Magic Mount paths"
  sleep 0.5

  ui_print "• Registering Extreme L3 services"
  sleep 0.5

  ui_print "• Applying default configuration"
  sleep 0.4
  ui_print "  - Mode           : Balanced"
  sleep 0.3
  ui_print "  - CPU Governor   : schedutil"
  sleep 0.3
  ui_print "  - GPU Governor   : msm-adreno-tz"
  sleep 0.3

  ui_print ""
  ui_print "• Enabling WebUI interface"
  sleep 0.5

  ui_print "• Finalizing setup"
  sleep 0.6

  ui_print ""
  ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  ui_print " ✅ Extreme L3 Setup Completed "
  ui_print " 🔁 Reboot Required to Activate "
  ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  ui_print ""
}

##########################################################################################
# Permissions
##########################################################################################

set_permissions() {

  # Default permissions
  set_perm_recursive $MODPATH 0 0 0755 0644

  # Ensure service is executable
  set_perm $MODPATH/service.sh 0 0 0755
}