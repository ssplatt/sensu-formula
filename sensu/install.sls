# vim: ft=sls
# How to install sensu
{% from "sensu/map.jinja" import sensu with context %}

sensu_pkg:
  pkg.installed:
    - name: {{ sensu.pkg }}

{% if sensu.uchiwa %}
sensu_dash_uchiwa_pkg:
  pkg.installed:
    - name: uchiwa
{% endif %}
