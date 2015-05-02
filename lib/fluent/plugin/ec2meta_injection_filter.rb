module Fluent
  class Ec2metaInjectionFilter < Filter
    Fluent::Plugin.register_filter('ec2meta_injection', self)

    SUPPORTED_META = %w[
      instance_id
      vpc_id
    ].freeze

    def initialize
      super

      require_relative './ec2meta_injection_filter/meta_fetcher'
      @fetcher = MetaFetcher.new(
        fail_on_not_found: true
      )
    end

    def configure(conf)
      super

      init_meta(conf)
    end

    def filter(_tag, _time, record)
      record.merge!(@meta) unless @meta.empty?

      record
    end

    private

    def init_meta(conf)
      @meta = {}

      conf.elements.each do |element|
        next unless element.name == 'meta'

        element.each do |name, value|
          if SUPPORTED_META.include?(name)
            @meta[name] = value.empty? ? @fetcher.send(name.intern) : value
          else
            log.error "Unsupported metadata: #{name}"
            fail Fluent::ConfigError, "Unsupported metadata #{name}"
          end
        end
      end
    end
  end
end
