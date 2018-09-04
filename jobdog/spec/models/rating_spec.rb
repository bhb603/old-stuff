require 'spec_helper'

describe Rating do
  it "fails validation without a job"
  it "fails validation without a rater"
  it "fails validation without a rated"
  it "fails validation without a score"
  it "fails validatin if rated is not the job's awardee"
  it "fails validation if the rater is not the job's owner"
  it "passes validation with all the required and valid attributes"
end
