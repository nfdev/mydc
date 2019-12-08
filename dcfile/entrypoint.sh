#!/bin/bash

if [ ! -f /orghome/initialized ]; then
  cp -raf /orghome/hogemin /home/
  touch /orghome/initialized
fi

/bin/bash
