# vim: ft=yaml
# Custom Pillar Data for sensu

sensu:
  enabled: true
  pkg: sensu
  uchiwa: true
  conf:
    client:
      name: debiantest
      address: 127.0.0.1
      environment: development
      subscriptions:
        - dev
        - debian
      socket:
        bind: 127.0.0.1
        port: 3030
    transport:
      name: rabbitmq
      reconnect_on_error: true
    api:
      host: localhost
      bind: 0.0.0.0
      port: 4567
    redis:
      host: 127.0.0.1
      port: 6379
      password: secret
    rabbitmq:
      host: 127.0.0.1
      port: 5671
      vhost: /sensu
      user: sensu
      password: secret
      heartbeat: 30
      prefetch: 50
      ssl:
        cert_chain_file: /etc/pki/test_ca/certs/sensu.crt
        private_key_file: /etc/pki/test_ca/certs/sensu.key
  dashconf:
    uchiwa:
      sensu:
        - name: TestLocal
          host: localhost
          port: 4567
      uchiwa:
        host: 0.0.0.0
        port: 3000
  service:
    client:
      name: sensu-client
      state: running
      enable: true
    api:
      name: sensu-api
      state: running
      enable: true
    server:
      name: sensu-server
      state: running
      enable: true
    uchiwa:
      name: uchiwa
      state: running
      enable: true
