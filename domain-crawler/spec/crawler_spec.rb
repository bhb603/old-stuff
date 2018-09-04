require 'rspec'
require 'crawler/crawler.rb'

describe "Crawler" do
  before(:each) do
    @domain = 'example.com'
    @c = Crawler.new(@domain)
  end
  
  it "instantiates a Crawler with a domain" do
    expect(@c).to be_a(Crawler)
    expect(@c.domain).to eq(@domain)
  end
  
  it "seeds the to_visit array with the root uri" do
    expect(@c.to_visit).to include("http://#{@domain}/")
  end
  
  context "adding uris to visit" do

    it "doesn't add a uri which has already been visited" do
      @c.visited = ["http://www.example.com/1/2/3"]
      @c.instance_eval { add_uris_to_visit(["http://www.example.com/1/2/3"]) }
      expect(@c.to_visit).to_not include("http://www.example.com/1/2/3")
    end
    
    it "doesn't add a uri which is already in the to_visit list" do
      expect(@c.to_visit).to include("http://#{@domain}/")
      expect(@c.to_visit.count).to eq(1)
      @c.instance_eval { add_uris_to_visit(["http://#{@domain}/"]) }
      expect(@c.to_visit.count).to eq(1)
    end
    
    it "doesn't add a uri outside of the domain" do
      expect(@c.to_visit.count).to eq(1)
      @c.instance_eval { add_uris_to_visit(["http://newdomain.com/new/path"]) }
      expect(@c.to_visit.count).to eq(1)
    end
    
    it "adds a new uri" do
      expect(@c.to_visit.count).to eq(1)
      @c.instance_eval { add_uris_to_visit(["http://example.com/asdf"]) }
      expect(@c.to_visit.count).to eq(2)
    end
    
  end
end