Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '526124800809362', 'cbd93dd4220941e5e6fcba7592cbda54'
  provider :google_oauth2, '670835943270', '6GSlWuuaQZUE0bHvDKaKfJNG', { name: "google"}
end