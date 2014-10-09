require 'jsmin'
begin
  require 'md5'
rescue LoadError
  require 'digest/md5'
end

class Rack::PageSpeed::Filters::MinifyJavaScripts < Rack::PageSpeed::Filters::Base
  requires_store
  name      'minify_javascripts'
  priority  2
      
  def execute! document
    nodes = document.css('script')
    return false unless nodes.count > 0
    nodes.each do |node|
      if !node['src']
        node.content = JSMin.minify node.content
      else
        if match = %r(^/rack-pagespeed-(.*)).match(node['src'])
          store = @options[:store]
          store[match[1]] = JSMin.minify store[match[1]]
        else
          status, headers, body = content_for node
          next unless node.name == 'script' && status == 200
          javascript = ""; body.each do |part| javascript << part end
          hash = Digest::MD5.hexdigest headers['Last-Modified'] + javascript
          compressed = Nokogiri::XML::Node.new 'script', document
          compressed['src'] = "/rack-pagespeed-#{hash}.js"
          @options[:store]["#{hash}.js"] = JSMin.minify javascript
          node.before compressed
          node.remove
        end        
      end
    end
  end
end
