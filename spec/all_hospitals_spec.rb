require 'rails_helper'

describe Api::V1::HospitalsController, :type => :controller do
#  let!(:hospitals) {create(:hospital)}

  context 'when the hospitals exist' do

    subject { get :index }
    it { is_expected.to be_successful }
    it "get all hospitals" do
    	ap body = JSON.parse(subject.body)
    	expect(body['data'].length).to eq(1)
    	# expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
