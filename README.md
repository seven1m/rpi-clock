# rpi-clock

![screenshot](https://raw.githubusercontent.com/seven1m/rpi-clock/master/screenshot.jpg)

This is a very simple clock and weather page for Raspberry Pi.

I needed a clock in my office and had a spare (cheap) flat-screen TV and a raspberry pi, so this was born.

It shows the current time, weather conditions (via Erik Flower's beautiful [weather icons](https://erikflowers.github.io/weather-icons/)),
current temperature (using the [OpenWeatherMap API](http://openweathermap.org/api)), low temp, high temp, and sunset.

## Setup

I'm using Raspbian -- you can use any distro, but YMMV.

1. Install Ruby 2.2.2 on your Raspberry Pi. I used RVM, but you can do it however you want.

2. Clone this repo or download the tarball and expand into your home directory on the Pi.

3. Write a script in your home directory to start the app called "run_clock". This is mine:

    ```bash
    #!/bin/bash

    cd /home/pi/rpi-clock
    GEM_PATH=/home/pi/.rvm/gems/ruby-2.2.2@rpi-clock:/home/pi/.rvm/gems/ruby-2.2.2@global /home/pi/.rvm/rubies/ruby-2.2.2/bin/ruby app.rb &
    sleep 30
    midori -e Fullscreen -a http://localhost:4567
    ```

    The `GEM_PATH` stuff and full path to ruby is because I used RVM. You might only need the `ruby app.rb &` part.

    Notice that it sleeps for 30 seconds. This was me being generous because it takes several seconds for my Pi's wifi adapter to connect to the network.

4. Make the script executable:

    ```bash
    chmod +x run_clock
    ```

5. Run the script to make sure it works:

    ```bash
    ./run_clock
    ```

6. Now create a desktop item that will automatically start the script:

    ```bash
    sudo vim /etc/xdg/autostart/clock.desktop
    ```

    Put this in the file:

    ```
    [Desktop Entry]
    Name=Clock App
    Exec=/home/pi/run_clock
    Type=Application
    Terminal=true
    ```

7. Last, set the Pi to start with no desktop:

    ```bash
    sudo vim /etc/xdg/lxsession/LXDE/autostart
    ```

    **Comment out the stuff in that file** and then put this in the file:

    ```
    @xset s off
    @xset -dpms
    @xset s noblank
    ```

8. (Optional) Disable overscan and force HDMI output:

    ```bash
    sudo vim /boot/config.txt
    ```

    Set the following options:

    ```
    disable_overscan=1
    hdmi_force_hotplug=1
    hdmi_drive=2
    ```

Boot the Pi and see if it works!

## Copyright and License

The weather icons are licensed SIL Open Font License 1.1.

All other code was written by me and is public domain. Use it as you wish.
