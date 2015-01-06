require "spec_helper"

describe Review do
  let(:blank_values) { [nil, ""] }
  it { should have_valid(:title).when(*blank_values, "Any 1 .!@#$%^&*}text") }
  it { should have_valid(:rating).when(1, 2, 3, 4, 5) }
  it { should_not have_valid(:rating).when(*blank_values, (-1), 0, 6) }
  it { should have_valid(:body).when(*blank_values, "Any 1 .!@#$%^&*}text") }

  it { should belong_to :user }
  it { should belong_to :drink }
  # it { should have_many :votes }

end
