# vim: ft=sls
# Init sensu
{% from "sensu/map.jinja" import sensu with context %}

{% if sensu.enabled %}
include:
  - sensu.install
  - sensu.config
  - sensu.service
{% else %}
'sensu-formula disabled':
  test.succeed_without_changes
{% endif %}
