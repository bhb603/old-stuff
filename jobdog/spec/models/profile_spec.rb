require 'spec_helper'

describe Profile do
  it "fails validation without a user" do
    p = Profile.new
    expect(p).to have(1).errors_on(:user)
  end
  
  it "fails validation if same user already has a profile" do
    u1 = User.create!(email: "user1@email.com", password: "password")
    u1.profile = Profile.new
    p2 = Profile.new
    p2.user_id = u1.id
    expect(p2).to have(1).errors_on(:user_id)
  end
end
