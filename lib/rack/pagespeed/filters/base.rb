require 'uri'

module Rack::PageSpeed::Filters
  class Base
    attr_reader :document, :options
    @@subclasses = []

    def initialize options = {}
      @options = options
    end

    class << self
      def inherited klass
        @@subclasses << klass
      end

      def available_filters
        @@subclasses
      end
      
      def requires_store
        instance_eval do
          def new options = {}
            options[:store] ? super(options) : raise("#{name} requires :store to be specified.")
          end
        end
      end

      def name _name = nil
        _name ? @name = _name : @name ||= underscore(to_s)
      end
      
      def priority _number = nil
        _number ? @priority = _number.to_i : @priority
      end

      private
      def underscore word
        word.split('::').last.
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end
    end

    private
    # Asset is not local if it has either a scheme (e.g. 'http:') or a host (e.g. '//google.com/')
    def is_local? path
      uri = URI.parse(path)
      uri.scheme.nil? && uri.host.nil?
      rescue URI::BadURIError
        false
      rescue URI::InvalidURIError
        false
    end

    def content? node
      content_for(node)[0] == 200
    end

    def content_only node
      status, headers, body = content_for(node)
      return nil if status != 200
      full_body = ""; body.each do |part| full_body << part end
      full_body
    end

    def path_for node
      case node.name
        when 'script'
          node['src']
        when 'img'
          node['src']
        when 'link'
          node['href']
      end
    end

    # Retrieve the referenced asset through the Rack application
    def content_for node
      path = path_for node
      return [404, {}, ""] unless path && is_local?(path)
      app = options[:app]
      env = options[:env].dup
      env['PATH_INFO'] = path
      app.call(env)
    end
  end
  # shortcut
  Rack::PageSpeed::Filter = Base
end