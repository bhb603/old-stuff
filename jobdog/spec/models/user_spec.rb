require 'spec_helper'

describe User do
  
  it "fails validation with no email" do
    u = User.new
    expect(u).to have_at_least(1).errors_on(:email)
  end
  
  it "fails validation with valid email" do
    u = User.new(email: "abc")
    expect(u).to have(1).errors_on(:email)
  end
  
  it "fails validation with non-unique email" do
    u1 = User.create!(email: "user1@email.com", password: "password")
    u2 = User.new(email: "user1@email.com")
    expect(u2).to have(1).errors_on(:email)
  end
  
  it "passes validation with valid email" do
    u = User.new(email: "user123@gmail.com")
    expect(u).to have(0).errors_on(:email)
  end
  
  it "fails validation with no password digest" do
    u = User.new();
    expect(u).to have(1).errors_on(:password)
  end
  
  it "fails validation with password length under minimum" do
    u = User.new(password: "123")
    expect(u).to have(1).errors_on(:password)
  end
  
  it "passes validation with password length over minimum" do
    u = User.new(password: "1234")
    expect(u).to have(0).errors_on(:password)
  end
  
  
end
