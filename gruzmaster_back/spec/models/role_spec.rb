require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'associations' do
    it { should have_many(:user_roles) }
    it { should have_many(:users) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_inclusion_of(:name).in_array(%w(admin user)) }
    it { should validate_presence_of(:description) }
  end
end
