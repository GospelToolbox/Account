# Set SECRET_KEY_BASE in the .env.development.local file for local
# development environments.
Rails.application.configure do
  config.require_master_key = false
  config.read_encrypted_secrets = false
  config.secret_key_base = ENV['SECRET_KEY_BASE']
end
