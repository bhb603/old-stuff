require_relative "wikipedia_page.rb"

class WikipediaCrawler
  
  attr_accessor :start

  def initialize(url)
    @start = WikipediaPage.new(url)
    @history = {}
    @trail = []
    @found_philosophy = false
    @wiki_loop = false
  end

  def find_philosophy
    
    current_page = @start

    loop do

      @trail << current_page

      #check if we've found philosophy 
      if current_page.url == "http://en.wikipedia.org/wiki/Philosophy"
        @found_philosophy = true
        break
      #check we haven't entered a loop
      elsif  @history[current_page.url]
        @wiki_loop = true
        break
      end
      
      # record in history and grab the next page
      @history[current_page.url] = true
      current_page = WikipediaPage.new(current_page.first_link)
    end

  end


  def print_results
    if @wiki_loop
      header = "We entered a loop!"
    elsif @found_philosophy
      header = "We found philosophy in #{@trail.count - 1} hops"
    else
      header = "???"
    end


    puts "-------------"
    puts header
    puts "-------------"
    @trail.each_with_index do |wikipedia_page, i|
      puts "#{i}. #{wikipedia_page.title} (#{wikipedia_page.url})"
    end
  end

end
