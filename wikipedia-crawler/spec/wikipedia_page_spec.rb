require 'wikipedia_page.rb'

RSpec.describe WikipediaPage do
  
  it "can be instantiated with a wikipedia url" do
    url = "http://en.wikipedia.org/wiki/Ruby_(programming_language)"
    w = WikipediaPage.new(url)
    expect(w.class).to eq WikipediaPage
    expect(w.url).to eq url
  end

  it "finds the first link in a wikipedia page" do
    url = "http://en.wikipedia.org/wiki/Ruby_(programming_language)"
    w = WikipediaPage.new(url)
    expect(w.first_link).to eq "http://en.wikipedia.org/wiki/Dynamic_programming_language"
  end

  it "skips pronunciation links when finding the first link" do
    url = "http://en.wikipedia.org/wiki/Iran"
    w = WikipediaPage.new(url)
    expect(w.first_link).to eq "http://en.wikipedia.org/wiki/Country"
  end

  it "skips links in parentheses when finding the first link" do
    url = "http://en.wikipedia.org/wiki/Greek_language"
    w = WikipediaPage.new(url)
    expect(w.first_link).to eq "http://en.wikipedia.org/wiki/Indo-European_languages"
  end

  it "skips external links when finding the first link" do
    url = "http://en.wikipedia.org/wiki/Human"
    w = WikipediaPage.new(url)
    expect(w.first_link).to eq "http://en.wikipedia.org/wiki/Hominini"
  end

end

