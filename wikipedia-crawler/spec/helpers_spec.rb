require "helpers.rb"

RSpec.describe Helpers, "#complete_parentheses?" do


  it "returns true when a string has no parentheses" do
    str = "hello there"
    expect(Helpers.complete_parentheses?(str)).to eq true
  end

  it "returns true when a string has a complete parentheses pair" do
    str = "hello (there)"
    expect(Helpers.complete_parentheses?(str)).to eq true
  end


  it "returns true when a string has complete and nested parentheses pairs" do
    str = "hello (the(r)e)"
    expect(Helpers.complete_parentheses?(str)).to eq true
  end

  it "returns false when a string has incomplete parentheses" do
    str = "hello (there"
    expect(Helpers.complete_parentheses?(str)).to eq false

    str = "hello there) you"
    expect(Helpers.complete_parentheses?(str)).to eq false
  end

  it "returns false when a string has incomplete nested parentheses" do
    str = "hello (there(s) you"
    expect(Helpers.complete_parentheses?(str)).to eq false
    str = "hello there(s) yo)u"
    expect(Helpers.complete_parentheses?(str)).to eq false
  end
end
