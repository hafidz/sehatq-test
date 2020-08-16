require 'rails_helper'

describe Hospital do
  subject { create(:hospital) }

  describe 'associations' do
    it { should have_many(:hospital_doctors) }
  end
end