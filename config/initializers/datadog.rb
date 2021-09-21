require 'datadog/statsd'
# require 'ddtrace'

statsd = Datadog::Statsd.new('localhost', 8125)

require 'lograge'

# Lograge config
config.lograge.enabled = true

# This specifies to log in JSON format
config.lograge.formatter = Lograge::Formatters::Json.new

## Disables log coloration
config.colorize_logging = false

# Log to a dedicated file
config.lograge.logger = ActiveSupport::Logger.new(File.join(Rails.root, 'log', "#{Rails.env}.log"))

# This is useful if you want to log query parameters
config.lograge.custom_options = lambda do |event|
    { :ddsource => 'ruby',
      :params => event.payload[:params].reject { |k| %w(controller action).include? k }
    }
end


# Datadog.configure do |c|
#     # To enable runtime metrics collection, set `true`. Defaults to `false`
#     # You can also set DD_RUNTIME_METRICS_ENABLED=true to configure this.
#     c.runtime_metrics.enabled = true
  
#     # Optionally, you can configure the DogStatsD instance used for sending runtime metrics.
#     # DogStatsD is automatically configured with default settings if `dogstatsd-ruby` is available.
#     # You can configure with host and port of Datadog agent; defaults to 'localhost:8125'.
#     c.runtime_metrics statsd: Datadog::Statsd.new
#   end