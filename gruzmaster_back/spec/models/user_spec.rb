require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:user_roles).dependent(:destroy) }
    it { should have_many(:roles).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of :password }
  end

  describe 'methods' do
    context 'is_admin?' do
      let(:admin_role){ FactoryBot.create(:role, :admin) }
      let(:user){ FactoryBot.create(:user) }
      let(:admin_user){ FactoryBot.create(:user, roles: [admin_role]) }
      
      it 'returns false if user is not admin' do
        expect(user.is_admin?).to be false
      end

      it 'return true if user is admin' do
        expect(admin_user.is_admin?).to be true
      end
    end

  end
end
