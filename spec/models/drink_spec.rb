require "spec_helper"

describe Drink do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:drink_liquors).dependent(:destroy) }
end
