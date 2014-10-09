class Rack::PageSpeed::Config
  class NoSuchFilter < StandardError; end
  class NoSuchStorageMechanism < StandardError; end
  load "#{::File.dirname(__FILE__)}/store/disk.rb"

  attr_reader :filters, :app

  def initialize options = {}, &block
    @filters, @options, @app = [], options, options[:app]
    filters_to_methods
    enable_filters_from_options
    enable_store_from_options
    instance_eval &block if block_given?
    sort_filters
  end

  def store type = nil, *args
    return @store unless type
    case type
    when {}
      @store = {} # simple in-memory store      
    when Symbol
      @store = load_storage type, *args
    when Hash
      store *type.to_a.first
    else
      raise NoSuchStorageMechanism, "No such storage mechanism: #{type}"
    end
  end

  def method_missing filter, *args
    raise NoSuchFilter, "No such filter \"#{filter}\". Available filters: #{(Rack::PageSpeed::Filter.available_filters).join(', ')}"
  end

  private
  def sort_filters
    @filters = @filters.sort_by do |filter|
      filter.class.priority || 0
    end.reverse
  end
  
  def enable_store_from_options
    return false unless @options[:store]
    case @options[:store]
      when Symbol then store @options[:store]
      when Array then store *@options[:store]
      when Hash
        @options[:store] == {} ? store({}) : store(*@options[:store].to_a.first)
    end
  end

  def enable_filters_from_options
    return false unless @options[:filters]
    case @options[:filters]
      when Array  then @options[:filters].map { |filter| self.send filter }
      when Hash   then @options[:filters].each { |filter, options| self.send filter, options }
    end
  end

  def filters_to_methods
    Rack::PageSpeed::Filter.available_filters.each do |klass|
      (class << self; self; end).send :define_method, klass.name do |*options|
        default_options = {:app => @options[:app], :store => @store}
        instance = klass.new(options.any? ? default_options.merge(*options) : default_options)
        @filters << instance if instance and !@filters.select { |k| k.is_a? instance.class }.any?
      end
    end
  end
  
  def load_storage type, *args
    klass = type.to_s.capitalize
    unless Rack::PageSpeed::Store.const_defined? klass
      lib = ::File.join(::File.dirname(__FILE__), 'store', type.to_s) 
      require lib
    end
    Rack::PageSpeed::Store.const_get(klass).new *args
  end
end