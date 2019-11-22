# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SmokeAndMirrors
  REQUIRED_ENVS = %w[github_user github_token github_repo].freeze

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # The code below is custom for catching missing ENVs early and clearly
    begin
      Figaro.require_keys REQUIRED_ENVS
    rescue Figaro::MissingKeys => e
      puts Rainbow("\nCannot start application!!!!").black.bg(:orchid)
      puts Rainbow("Make sure 'config/application.yml' is present and has the required environment variables.").orchid.bg(:black)
      puts Rainbow(e).orchid.bg(:black)
      throw(:abort)
    end
  end
end
