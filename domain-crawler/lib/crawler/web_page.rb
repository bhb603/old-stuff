require 'nokogiri'
require_relative 'asset.rb'

class WebPage
  attr_accessor :uri, :assets, :links
  
  def self.build_web_page(html, uri)
    wp = WebPage.new(uri)
    wp.links = self.find_links(html)
    wp.assets = self.find_assets(html) 
    wp
  end
  
  def self.find_links(html)
    doc = Nokogiri::HTML(html)
    a_tags = doc.xpath('//a')
    links = []
    a_tags.each do |a|
      next unless a.attribute('href')
      links << a.attribute('href').value
    end
    links.select { |link| /^\// =~ link }
  end
  
  def self.find_assets(html)
    assets = []
    ['img', 'script', 'link'].each do |type|
      doc = Nokogiri::HTML(html)
      nodes = doc.xpath('//' + type)
      nodes.each do |node|
        if type == 'link'
          assets << Asset.new(type, node.attribute('href') ? node.attribute('href').value : nil)
        else
          assets << Asset.new(type, node.attribute('src') ? node.attribute('src').value : nil)
        end
      end 
    end
    assets
  end
  
  def initialize(uri)
    @uri = uri
    @assets = []
    @links = []
  end
end
