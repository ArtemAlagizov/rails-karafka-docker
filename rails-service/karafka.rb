# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] = ENV['RAILS_ENV']
require ::File.expand_path('../config/environment', __FILE__)
Rails.application.eager_load!

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = %w[kafka://kafka:9092]
    config.client_id = "client_id"
    config.backend = :inline
    config.batch_fetching = false
    # Uncomment this for Rails app integration
    config.logger = Rails.logger
  end

  Karafka::Instrumentation::Logger.instance.level = ::Logger::ERROR

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate if you want to achieve max performance,
  # listen to only what you really need for a given environment.
  # Karafka.monitor.subscribe(Karafka::Instrumentation::StdoutListener)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener)

  consumer_groups.draw do
    consumer_group :job_notification do
      topic :jobs do
        consumer JobsConsumer
      end
    end
  end
end

Karafka.monitor.subscribe(Karafka::Instrumentation::Listener)

# Karafka.monitor.subscribe('app.initialized') do
#   # Put here all the things you want to do after the Karafka framework
#   # initialization
# end

KarafkaApp.boot!
