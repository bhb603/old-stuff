# gems
require 'rest_client'
require 'nokogiri'

# std lib
require 'yaml'
require 'debugger'
require 'logger'

# files
require_relative 'web_page.rb'

class Crawler
  attr_accessor :domain, :visited, :to_visit, :site_map
  
  def initialize(domain)
    @domain = domain
    @to_visit = [ URI::HTTP.build({ host: domain, path: '/'}).to_s ]
    @visited = []
    @site_map = {}
    @logger = Logger.new('crawler.log', 'daily')
  end
  
  def go(times = nil)
    loops = 0
    log(Logger::INFO, "begin crawing #{domain}")
    loop do
      break if to_visit.count == 0 || loops == times
      uri = to_visit.pop
      response = visit_uri(uri) 
      if response
        links = find_links(response.to_s)
        add_uris_to_visit(links)
        save_to_site_map(uri, response)
      end
      loops += 1
    end
    log(Logger::INFO, "done crawing #{domain}")
    save_site_map
  end
  
  def save_site_map
    f = File.open("site_map.yaml", "w")
    f.puts(YAML.dump(site_map))
    f.close
  end
  
  private
  
  def visit_uri(uri)
    @visited << uri
    begin
      response = RestClient.get(uri)
      log(Logger::INFO, "visited #{uri}")
      response
    rescue => e
      log(Logger::ERROR, "#{e.message} | #{uri}")
      return false
    end
  end
  
  def find_links(html)
    doc = Nokogiri::HTML(html)
    a_tags = doc.xpath('//a')
    links = []
    a_tags.each do |a|
      next unless a.attribute('href')
      links << a.attribute('href').value
    end
    links
  end
    
  def add_uris_to_visit(links)
    links.each do |link|
      begin
        if /^\// =~ link # href begins with /
          uri = URI("http://#{domain + link}")
        elsif /^http/ =~ link # href begins with http
          uri = URI(link)
        end
      
        if uri && uri.host == domain && !@visited.include?(uri.to_s) && !@to_visit.include?(uri.to_s)
          @to_visit << uri.to_s
        end
      rescue Exception => e
        log(Logger::ERROR, "#{e.message}")
      end
    end  
  end
  
  def save_to_site_map(uri, response)
    @site_map[uri] = WebPage.build_web_page(response.to_s, uri)
  end
  
  def log(severity, msg)
    puts msg
    @logger.add(severity, msg)
  end
end
