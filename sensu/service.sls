# vim: ft=sls
# Manage service for service sensu
{% from "sensu/map.jinja" import sensu with context %}

sensu_client_service:
 service.{{ sensu.service.client.state }}:
   - name: {{ sensu.service.client.name }}
   - enable: {{ sensu.service.client.enable }}
   - watch:
     - file: sensu_config_client

sensu_api_service:
 service.{{ sensu.service.api.state }}:
   - name: {{ sensu.service.api.name }}
   - enable: {{ sensu.service.api.enable }}
   - watch:
     - file: sensu_config_api

sensu_server_service:
 service.{{ sensu.service.server.state }}:
   - name: {{ sensu.service.server.name }}
   - enable: {{ sensu.service.server.enable }}
   - watch:
     - file: sensu_config_transport
     - file: sensu_config_redis
     - file: sensu_config_rabbitmq

{% if sensu.uchiwa %}
sensu_dash_uchiwa_service:
  service.{{ sensu.service.uchiwa.state }}:
    - name: {{ sensu.service.uchiwa.name }}
    - enable: {{ sensu.service.uchiwa.enable }}
    - watch:
      - file: sensu_dashconfig_uchiwa
{% endif %}
