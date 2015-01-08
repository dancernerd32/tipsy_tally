require "spec_helper"

describe Vote do
  let(:blank_values) { [nil, ""] }

  it { should have_valid(:score).when(1,-1,0) }
  it { should_not have_valid(:score).when(*blank_values) }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(*blank_values) }

  it { should have_valid(:review_id).when(1) }
  it { should_not have_valid(:review_id).when(*blank_values) }

  it { should belong_to(:user) }
  it { should belong_to(:review)}
end
