require 'rails_helper'

describe Hospital do
  before(:all) do
    @hospital = create(:hospital)
  end

  describe 'associations' do
    # it { should has_many(:hospital_doctors) }
  end
end