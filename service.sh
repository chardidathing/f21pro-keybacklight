#!/system/bin/sh

MODDIR=${0%/*}
LCD_BRIGHTNESS_FILE=/sys/class/leds/lcd-backlight/brightness
KBHACK_EXEC=${MODDIR}/keypad.sh
inotifyd ${KBHACK_EXEC} ${LCD_BRIGHTNESS_FILE}:/w
exit 0