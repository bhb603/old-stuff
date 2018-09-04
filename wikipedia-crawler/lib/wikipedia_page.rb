require "nokogiri"
require "open-uri"
require_relative "helpers.rb"

class WikipediaPage

  attr_accessor :url, :title, :first_link

  def initialize(url)

    @url = url

    # get the page and parse for the title and first link
    doc = Nokogiri::HTML(open(url))
    @title = doc.css("h1#firstHeading").first.content
    href = nil
    doc.css("div#mw-content-text > p > a").each do |link|
      # skip external links (where href="//asdf" rather than href="/asdf")
      next if /\/\// =~ link.attributes["href"]

      # skip links within parenthesis
      next if in_parens?(link)

      href = link.attributes["href"]
      break
    end

    @first_link = (href && href.value) ? "http://en.wikipedia.org#{href.value}" : nil

  end

  private

  def in_parens?(link)
    
    str = ""

    # build string of everything prior to the link
    node = link #.previous_sibling
    while (node)
      str = node.content + str
      node = node.previous_sibling
    end

    # use helper function
    return ! Helpers.complete_parentheses?(str)

  end
end
