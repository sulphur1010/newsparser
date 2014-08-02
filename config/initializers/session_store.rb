# Be sure to restart your server when you modify this file.

Newsfeed::Application.config.session_store :cookie_store, key: '_newsfeed_session'

unless Rails.env.development?

	Newsfeed::Application.config.session_store :redis_store, key:'_newsfeed_session'
end