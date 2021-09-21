require 'ddtrace'

Datadog.config do |c|
    # This will activate auto-instrumentation for Rails
    c.use :rails
end

