#!/usr/bin/env ruby

require_relative "../lib/wikipedia_crawler.rb"

wc = WikipediaCrawler.new(ARGV[0])
wc.find_philosophy
wc.print_results
