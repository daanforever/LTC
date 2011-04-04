# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ltc_session',
  :secret      => '75d47be79dbe849afd3001d3a9c5eb020f3ecce2e1dfcea42212f276a975a9176ff396bde9284ec87d76426f77e817afa6fc94e170b3158129fcaac66c86af56'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
