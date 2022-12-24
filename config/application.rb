require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module IGClone
  class Application < Rails::Application
    config.load_defaults 6.1

    config.i18n.default_locale = :ja

    config.generators do |g|
      g.assets false
      g.helper false

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end