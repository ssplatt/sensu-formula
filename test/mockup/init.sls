sensu_mockup_add_repo:
  pkgrepo.managed:
    - humanname: sensu
    - name: deb https://sensu.global.ssl.fastly.net/apt sensu main
    - file: /etc/apt/sources.list.d/sensu.list
    - key_url: https://sensu.global.ssl.fastly.net/apt/pubkey.gpg

sensu_mockup_install_rabbitmq:
  pkg.installed:
    - name: rabbitmq-server

sensu_mockup_install_redis:
  pkg.installed:
    - name: redis-server

sensu_mockup_redis_config:
  file.append:
    - name: /etc/redis/redis.conf
    - text:
      - masterauth secret
      - requirepass secret

sensu_mockup_redis_service:
  service.running:
    - name: redis-server
    - enable: true
    - watch:
      - file: sensu_mockup_redis_config

sensu_mockup_rabbitmq_config:
  file.managed:
    - name: /etc/rabbitmq/rabbitmq.config
    - source: salt://test/mockup/files/rabbitmq.config
    - skip_verify: true

sensu_mockup_rabbitmq_service:
  service.running:
    - name: rabbitmq-server
    - enable: true
    - watch:
      - file: sensu_mockup_rabbitmq_config

sensu_mockup_rabbitmq_cluster:
  rabbitmq_cluster.join:
    - name: rabbit@{{ grains.host }}
    - user: rabbit
    - host: {{ grains.host }}

sensu_mockup_rabbitmq_vhost:
  rabbitmq_vhost.present:
    - name: '/sensu'

sensu_mockup_rabbitmq_user:
  rabbitmq_user.present:
    - name: sensu
    - password: secret
    - force: True
    - perms:
      - '/sensu':
        - '.*'
        - '.*'
        - '.*'

sensu_mockup_pki_dir:
  file.directory:
    - name: /etc/pki

sensu_mockup_tls_config:
  file.managed:
    - name: /etc/pki/ca.conf
    - contents:
      - "ca.cert_base_path: /etc/pki"

sensu_mockup_ssl_create_ca:
  module.run:
    - name: tls.create_ca
    - ca_name: test_ca
    - days: 5
    - CN: MyTestCA
    - C: US
    - ST: MyState
    - L: MyCity
    - O: MyOrgUnit
    - emailAddress: test@example.com
    - unless: test -f /etc/pki/test_ca/test_ca_ca_cert.crt

sensu_mockup_ssl_create_csr:
  module.run:
    - name: tls.create_csr
    - ca_name: test_ca
    - CN: sensu
    - unless: test -f /etc/pki/test_ca/certs/sensu.key

sensu_mockup_ssl_sign_csr:
  module.run:
    - name: tls.create_ca_signed_cert
    - ca_name: test_ca
    - CN: sensu
    - unless: test -f /etc/pki/test_ca/certs/sensu.crt
