require 'rspec'
require 'crawler/web_page.rb'

example_html = """
<!DOCTYPE HTML>
<html>
<head><title>Example</title></head>
<body>
<a href=\"/foo/bar\">foobar</a>
<img src=\"foo/bar.jpg\">
<script src=\"foo/bar.js\"></script>
<link href=\"foo/bar.css\">
</body
</html>
"""

uri = 'http://www.example.com/'

describe 'WebPage' do
  wp = WebPage.build_web_page(example_html, uri)
  
  it "builds a WebPage object from html and a uri" do
    expect(wp).to be_a(WebPage)
    expect(wp.uri).to be(uri)
  end
  
  it "finds the links within it html" do 
    expect(wp.links).to include('/foo/bar')
  end
  
  it "finds the image assets within a page" do
    images = wp.assets.select { |asset| asset.type == 'img'}
    expect(images.first.loc).to eq('foo/bar.jpg')
  end
  
  it "finds the script assets within a page" do
    scripts = wp.assets.select { |asset| asset.type == 'script'}
    expect(scripts.first.loc).to eq('foo/bar.js')
  end
  
  it "finds the link assets within a page" do
    links = wp.assets.select { |asset| asset.type == 'link'}
    expect(links.first.loc).to eq('foo/bar.css')
  end
end