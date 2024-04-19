#!/system/bin/sh

MODDIR=${0%/*}

LCD_BRIGHTNESS_FILE=/sys/class/leds/lcd-backlight/brightness
LCD_MAX_BRIGHTNESS=255

LED1_FILE=/sys/class/leds/mt6370_pmu_led1/brightness
LED2_FILE=/sys/class/leds/mt6370_pmu_led2/brightness
LED_MAX_BRIGHTNESS=6

LCD_VALUE=$(cat ${LCD_BRIGHTNESS_FILE})

# lcd off = button lights off :3
if [ "$LCD_VALUE" -eq 0 ]; then
    echo 0 > $LED1_FILE
    echo 0 > $LED2_FILE
    # JANK - I WILL FIND THE PROPER TIMING EVENTUALLY
    sleep 0.1
    echo 0 > $LED1_FILE
    echo 0 > $LED2_FILE
    # JANK - I WILL FIND THE PROPER TIMING EVENTUALLY
    sleep 0.2
    echo 0 > $LED1_FILE
    echo 0 > $LED2_FILE
    # JANK - I WILL FIND THE PROPER TIMING EVENTUALLY
    sleep 0.3
    echo 0 > $LED1_FILE
    echo 0 > $LED2_FILE
    # JANK - I WILL FIND THE PROPER TIMING EVENTUALLY
    sleep 0.4
    echo 0 > $LED1_FILE
    echo 0 > $LED2_FILE
else
    # Get light sensor value (THIS IS JANK AS SHIT AND ONLY WORKS IF AUTOBRIGHTNESS IS ON AAAAAAA)
    LIGHT_SENSOR_VALUE=$(dumpsys sensorservice | grep "LIGHT: last 50 events" -A 50 | tail -n 1 | awk '{gsub(/.00,/, "", $(NF-2)); print $(NF-2)}')

    # Set keypad brightness based on light sensor value, and if we don't know, turn it on anyway
    if [ -z "$LIGHT_SENSOR_VALUE" ]; then
        echo 6 > $LED1_FILE
        echo 6 > $LED2_FILE
    elif (( $(echo "$LIGHT_SENSOR_VALUE < 100" | bc -l) )); then
        echo 6 > $LED1_FILE
        echo 6 > $LED2_FILE
    else
        echo 0 > $LED1_FILE
        echo 0 > $LED2_FILE
        sleep 0.3
        echo 0 > $LED1_FILE
        echo 0 > $LED2_FILE
    fi
fi

exit 0
