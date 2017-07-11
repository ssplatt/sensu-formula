require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package("sensu") do
  it { should be_installed }
end

describe package("uchiwa") do
  it { should be_installed }
end

describe file("/etc/sensu/conf.d/api.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\{"api": {\"bind": "0\.0\.0\.0", "host": "localhost", "port": 4567\}\}/ }
end

describe file("/etc/sensu/conf.d/client.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\{"client": \{"address": "127\.0\.0\.1", "environment": "development", "name": "debiantest", "socket": \{"bind": "127\.0\.0\.1", "port": 3030\}, "subscriptions": \["dev", "debian"\]\}\}/ }
end

describe file("/etc/sensu/conf.d/rabbitmq.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\{"rabbitmq": {"heartbeat": 30, "host": "127\.0\.0\.1", "password": "secret", "port": 5671, "prefetch": 50, "ssl": \{"cert_chain_file": "\/etc\/pki\/test_ca\/certs\/sensu.crt", "private_key_file": "\/etc\/pki\/test_ca\/certs\/sensu\.key"\}, "user": "sensu", "vhost": "\/sensu"\}\}/ }
end

describe file("/etc/sensu/conf.d/redis.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\{"redis": \{"host": "127\.0\.0\.1", "password": "secret", "port": 6379\}\}/ }
end

describe file("/etc/sensu/conf.d/transport.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\{"transport": \{"name": "rabbitmq", "reconnect_on_error": true\}\}/ }
end

describe file("/etc/sensu/dashboard.d/uchiwa.json") do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /\{"sensu": \[\{"host": "localhost", "name": "TestLocal", "port": 4567\}\], "uchiwa": \{"host": "0.0.0.0", "port": 3000\}\}/ }
end

describe process("uchiwa") do
  it { should be_running }
  its(:user) { should eq "uchiwa" }
end

describe process("sensu-client") do
  it { should be_running }
  its(:user) { should eq "sensu" }
end

describe process("sensu-api") do
  it { should be_running }
  its(:user) { should eq "sensu" }
end

describe process("sensu-server") do
  it { should be_running }
  its(:user) { should eq "sensu" }
end

describe port(3000) do
  it { should be_listening.on('::').with('tcp6') }
end

describe port(4567) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end
