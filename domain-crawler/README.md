# Domain Crawler

* [About](#about)
* [Basic Usage](#basic-usage)
* [Details](#details)
* [Testing](#testing)

## About

Domain Crawler uses a standard crawling strategy to visit the web pages within a single domain. The crawl produces a Site Map, a hash in which the keys are URIs and the values are WebPage objects. 

## Basic Usage

First install the required gems in the Gemfile. This may be done with [Bundler](http://bundler.io/):

    $ bundle install

The crawler can be run straight from a command line with a domain as an argument. For example:

    $ ruby lib/crawler.rb techcrunch.com
		
The above code will instantiate a crawler and begin crawling techcrunch.com. When complete, the crawler will save the site map to a YAML file *site_map.yaml*.

The Crawler can also be included in a Ruby script to achieve more custom behavior. See the example below:

    require 'lib/crawler.rb'
    
    # Instantiate a crawler with a domain as an argument
    my_crawler = Crawler.new('techcrunch.com')
    
    # Crawl the domain until no more URIs can be found, then dump the Site Map to a YAML file
    my_crawler.go 
    
    # Given an integer, n, as an argument, Crawler#go crawls a max of n URIs. It can be run again at a later time to pick up where it left off
    another_crawler = Crawler.new('example.com')
    another_crawler.go(1) # visit 1 URI and save the Site Map
    # do something else
    another_crawler.go(3) # visit another 3 URIs and save the updated Site Map
    
## Details

### The Crawler

Upon initialization, a crawler has four accessible attributes. These are:

* domain: a string representing the domain of interest
* to_visit: an array of URIs to visit, initially just the root path on the domain
* visited: an array of URIs which have been visited, initially empty
* site_map: a hash in which keys are URIs and values are WebPages

Crawler#go kicks off the domain crawl, a process which can be described as follows:

1. Pop a URI from the *to_visit* array, add it to the *visited* array, and visit it using [REST Client](https://github.com/rest-client/rest-client)
2. From the HTTP response, scrape the html body for links
3. Add links to the *to_visit* array that are in the domain of interest and aren't already in either the *to_visit* or *visited* arrays
4. Build a WebPage object from the HTTP response and add it to the site map
5. Repeat steps 1-4 until there are no more URIs to visit. Optionally, if Crawler#go is given an integer, n, as an argument, the process repeats a maximum n times and then stops.

### The Site Map

The product of the domain crawl is a Site Map, a hash in which the keys are URI strings and the values are WebPage objects. This provides a flexible data structure that can be further analyzed or manipulated to fit one's needs.

The WebPage objects are instances of a custom Ruby class with the following attributes:
  
* uri: a string representing the page's URI
* links: an array of all the links from the page
* assets: an array of all the img, script, and link assets found on the page  

The WebPage class has a factory method WebPage::build_web_page(html, uri), which takes two strings, the raw HTML and the URI. From this it parses through the HTML for links and assets and returns a complete WebPage object as described above. 

## Testing

Tests are written in RSpec. There are currently individual tests for the Crawler and WebPage classes. These can be run as rake tasks as follows:
    
    // run all specs
    $ rake spec
    
    // run just the crawler spec
    $ rake spec spec/crawler_spec.rb
    
    // run just the web_page spec
    $ rake spec spec/web_page_spec.rb
		 
