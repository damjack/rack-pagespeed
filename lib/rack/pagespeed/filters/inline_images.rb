class Rack::PageSpeed::Filters::InlineImages < Rack::PageSpeed::Filter
  priority 8
  
  def execute! document
    nodes = document.css('img')
    return false unless nodes.count > 0
    nodes.each do |node|
      status, headers, body = content_for node
      next if status != 200 or headers['Content-Length'].to_i > (@options[:max_size] or 1024)
      url = node['src']
      img = node.clone
      full_body = ""; body.each do |part| full_body << part end
      img['src'] = "data:#{Rack::Mime.mime_type(File.extname(path_for(node)))};base64,#{[full_body].pack('m')}"
      img['alt'] = node['alt'] if node['alt']
      node.before img
      node.remove
    end
  end
end
