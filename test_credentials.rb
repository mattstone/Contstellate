#!/usr/bin/env ruby

require 'active_support/encrypted_configuration'

key = File.read('config/credentials/production.key').strip
credentials_path = 'config/credentials/production.yml.enc'

encrypted_config = ActiveSupport::EncryptedConfiguration.new(
  config_path: credentials_path,
  key_path: nil,
  env_key: nil,
  raise_if_missing_key: false
)

# Set the key directly
encrypted_config.instance_variable_set(:@key, key)

begin
  config = encrypted_config.config
  puts "✓ Successfully decrypted production credentials"
  puts "✓ secret_key_base present: #{config.key?(:secret_key_base)}"
  puts "✓ secret_key_base value length: #{config[:secret_key_base]&.length}"
rescue => e
  puts "✗ Failed to decrypt: #{e.message}"
end