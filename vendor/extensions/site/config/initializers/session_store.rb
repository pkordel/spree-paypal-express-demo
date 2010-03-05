# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ppx_demo_session',
  :secret      => '82798c927643408071d352005d2f31d4a87d2c62820829d8ceaf0d411af449ad195881298215049f6e2e9b6dcda75a8f7affcee90cd3de364062d4f82d4b840d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store