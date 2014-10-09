class Rack::PageSpeed::Filters::InlineJavaScripts < Rack::PageSpeed::Filter
  name      'inline_javascripts'
  priority  8
      
  def execute! document
    nodes = document.css('script[src]')
    return false unless nodes.count > 0
    nodes.each do |node|
      status, headers, body = content_for node
      next if status != 200 or headers['Content-Length'].to_i > (@options[:max_size] or 2048)
      inline = Nokogiri::XML::Node.new 'script', document
      full_body = ""; body.each do |part| full_body << part end
      inline.content = JSMin.minify(full_body)
      node.before inline
      node.remove
    end
  end
end
