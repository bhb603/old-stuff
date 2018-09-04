require 'spec_helper'

describe Job do
  
  it "fails validation without a user" do
    j = Job.new
    expect(j).to have(1).errors_on(:user)
  end
  
  it "fails validation without a title" do 
    j = Job.new
    expect(j).to have(1).errors_on(:title)
  end
  
  # it "fails validation when 'complete_by' is not a datetime" do
  #   j = Job.new
  #   j.complete_by = "xxx"
  #   expect(j).to have(1).errors_on(:complete_by)
  # end
  
  it "passes validation with a title, user" do
    u = User.new(email: "a@a.c", password: "1234")
    u.jobs.new(title: "title")
    expect(u).to have(0).errors
  end
  
  it "passes validation with a valid datetime for 'complete_by'" do
    j = Job.new(complete_by_hash: {month: '10', day: '29', year: '2014'})
    expect(j).to have(0).errors_on(:complete_by)
  end
  
  it "cannot be closed unless the current status is 'completed'"
  it "can be closed if the current status is 'completed'"
  
end
