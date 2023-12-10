# 1 - build process
FROM devopsfaith/krakend:latest as builder
ARG env=prod

COPY krakend.tmpl .
COPY config .

## Save temporary file to /tmp to avoid permission errors
RUN FC_ENABLE=1 \
    FC_OUT="/tmp/krakend.json" \
    FC_PARTIALS="/etc/krakend/partials" \
    FC_SETTINGS="/etc/krakend/settings/$env" \
    FC_TEMPLATES="/etc/krakend/templates" \
    krakend check -d -t -c krakend.tmpl

# The linting needs the final krakend.tmpl file
RUN krakend check -c /tmp/krakend.json --lint

# 2 - runtime environment
FROM devopsfaith/krakend:latest
COPY --from=builder --chown=krakend /tmp/krakend.json .
COPY --from=builder --chown=krakend /etc/krakend/plugins /etc/krakend/plugins
# Uncomment with Enterprise image:
# COPY LICENSE /etc/krakend/LICENSE

EXPOSE 80
