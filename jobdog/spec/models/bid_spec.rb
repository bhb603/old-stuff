require 'spec_helper'

describe Bid do
  it "fails validation without a bidder"
  it "fails validation without a job" 
  it "fails validation when bidder has already bid that job"
  it "fails validation when job is not open"
  it "fails validation when user bids on his own job"
  it "passes validation when job and bidder are valid"
end
