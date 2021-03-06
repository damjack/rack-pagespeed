require 'csso'
class Rack::PageSpeed::Filters::InlineCSS < Rack::PageSpeed::Filter
  priority 10
  
  def execute! document
    nodes = document.css('link[rel="stylesheet"][href]')
    return false unless nodes.count > 0
    nodes.each do |node|
      status, headers, body = content_for node
      next if !status == 200 or headers['Content-Length'].to_i > (@options[:max_size] or 2048)
      inline = Nokogiri::XML::Node.new 'style', document
      full_body = ""; body.each do |part| full_body << part end
      inline.content = Csso.optimize(full_body)
      node.before inline
      node.remove
    end
  end
end
