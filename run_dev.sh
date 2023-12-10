#!/bin/bash


# set environment variables when uses krakend Flexible configuration
export FC_ENABLE=1
export FC_SETTINGS="config/settings/local"
export FC_PARTIALS="config/partials"
export FC_TEMPLATES="config/templates"
export FC_OUT="output.json"

rm output.json 2> /dev/null

krakend run -dc "krakend.tmpl"
