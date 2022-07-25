FROM devopsfaith/krakend:latest as builder
ARG env=prod

COPY krakend.json .
COPY config .

## Save temporary file to /tmp to avoid permission errors
RUN FC_ENABLE=1 \
    FC_OUT="/tmp/krakend.json" \
    FC_PARTIALS="/etc/krakend/partials" \
    FC_SETTINGS="/etc/krakend/settings/$env" \
    FC_TEMPLATES="/etc/krakend/templates" \
    krakend check -d -t -c krakend.json

# The linting needs the final krakend.json file
RUN krakend check -c /tmp/krakend.json --lint

FROM devopsfaith/krakend:latest
COPY --from=builder --chown=krakend /tmp/krakend.json .
COPY --from=builder --chown=krakend /etc/krakend/plugins ./plugins
# Uncomment with Enterprise image:
# COPY LICENSE /etc/krakend/LICENSE

EXPOSE 80
