# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_EfforCalc_session',
  :secret      => '4550181160808a6fad6ba0d3a857202545308a233e56ab2c25fa02c5e2dbeb048eeb64fa4a8b2302bdc6bbfe63d79fa03c4241fe6db89db29dd023d0c5a30916'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
