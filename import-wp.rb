require 'rexml/document'
require 'date'
require 'fileutils'

include REXML # so that we don't have to prefix everything with REXML::...

file = File.new( "wordpress.2009-05-01.xml" )
doc = REXML::Document.new file

entries = []

doc.elements.each("//item") do |element| 
  title = element.get_text("title")
  link = element.get_text("link")
  post_name = element.get_text("wp:post_name")
  status = element.get_text("wp:status")
  datestr = "#{element.get_text("pubDate")}"
  d = DateTime.parse(datestr).strftime("%Y-%m-%d")
  desc = element.get_text("content:encoded")
  category = element.get_text("category")
  category.value.downcase! unless category.nil?
  category = "general" if category == "" or category.nil? or category == "124"
  puts category 
  puts d
  puts title
  puts post_name
  puts status
  dir = "_posts/#{category}/"
  dir = "drafts/#{category}/" if status == "draft"
  FileUtils.mkdir(dir) if !File.exists?(dir)
  filename = dir + "#{d}-#{post_name}.html"
  post = "---\n"
  post += "layout: post-import\n"
  post += "title: \"#{title}\"\n"
  post += "categories: ['wp-import', '#{category}']\n"
  post += "wpimport-url: \"#{link}\"\n"
  post += "---\n"
  post += desc.to_s.gsub("â€™", "'").gsub("\n\n", "<br/>\n")
  File.open(filename, 'w') { |f| f.write(post) }
end



