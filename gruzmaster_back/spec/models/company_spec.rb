require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:company_name) }
    it { should validate_presence_of(:company_description) }
  end
end
