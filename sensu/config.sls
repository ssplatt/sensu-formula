# vim: ft=sls
# How to configure sensu
{% from "sensu/map.jinja" import sensu with context %}

sensu_conf_dir:
  file.directory:
    - name: /etc/sensu/conf.d

{% for k,v in sensu.conf.iteritems() %}
{% set full = {k:v} %}
sensu_config_{{ k }}:
  file.managed:
    - name: /etc/sensu/conf.d/{{ k }}.json
    - source: salt://sensu/files/conf.j2
    - template: jinja
    - data: {{ full }}
{% endfor %}

{% for k,v in sensu.dashconf.iteritems() %}
sensu_dashconfig_{{ k }}:
  file.managed:
    - name: /etc/sensu/dashboard.d/{{ k }}.json
    - source: salt://sensu/files/conf.j2
    - template: jinja
    - data: {{ v }}
{% endfor %}
