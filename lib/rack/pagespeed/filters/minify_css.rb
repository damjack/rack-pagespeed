require 'csso'

begin
  require 'md5'
rescue LoadError
  require 'digest/md5'
end

class Rack::PageSpeed::Filters::MinifyCSS < Rack::PageSpeed::Filters::Base
  requires_store
  name      'minify_css'
  priority  2

  def execute! document
    nodes = document.css('link[rel="stylesheet"][href]')
    return false unless nodes.count > 0
    nodes.each do |node|
      if match = %r(^/rack-pagespeed-(.*)).match(node['href'])
        store = @options[:store]
        store[match[1]] = Csso.optimize(store[match[1]])
      else
        status, headers, body = content_for node
        next unless node.name == 'link' && status == 200
        css = ""; body.each do |part| css << part end
        hash = Digest::MD5.hexdigest headers['Last-Modified'] + css
        @options[:store]["#{hash}.css"] = Csso.optimize(css)
        node['href'] = "/rack-pagespeed-#{hash}.css"
      end
    end
  end
end
