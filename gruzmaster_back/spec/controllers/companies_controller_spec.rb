require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:role) { FactoryBot.create(:role) }
  let(:admin_role) { FactoryBot.create(:role, :admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, roles: [role, admin_role]) }


  describe "GET #index" do
    let!(:companies){ FactoryBot.create_list(:company, 3) }
    
    before do
      authenticated_header(request, user)
      get :index
    end

    it 'returns array of all companies' do
      expect(assigns(:companies)).to match_array(companies)
    end

    it 'response status is 200' do
      expect(response.status).to be 200
    end
  end

  describe "POST #create" do    
    context "admin user" do
      before do
        authenticated_header(request, admin_user)
      end

      context "creates valid company" do
        let(:do_request) { post :create, params: { company:  FactoryBot.attributes_for(:company) } }

        it 'response status is 200' do
          do_request
          expect(response.status).to be 200
        end

        it 'creates a new company' do
          expect { do_request }.to change(Company, :count)
        end
      end

      context 'creates invalid company' do
        let(:do_request) { post :create, params: { company:  FactoryBot.attributes_for(:company, :invalid) } }
        
        it 'response status is 500' do
          do_request
          expect(response.status).to be 500
        end

        it 'not creates a new company' do
          expect { do_request }.not_to change(Company, :count)
        end
      end
    end

    context 'not admin user' do
      before do
        authenticated_header(request, user)
      end

      let(:do_request) { post :create, params: { company:  FactoryBot.attributes_for(:company, :invalid) } }
      
      it 'not creates a new company' do
        expect { do_request }.to raise_error CanCan::AccessDenied
      end
    end
  end

  describe 'DELETE #destroy' do
    context "admin user" do
      before do
        authenticated_header(request, admin_user)
      end
      
      let(:companies){ FactoryBot.create_list(:company, 3) }

      let(:do_request) { delete :destroy, params: { id: companies.last.id}}

      it 'expect response status is 200' do
        do_request
        expect(response.status).to be 200
      end

      it 'removes company' do
        expect { do_request }.to change(Company, :count)
      end
    end

    context 'not admin user' do
      before do
        authenticated_header(request, user)
      end

      let(:companies){ FactoryBot.create_list(:company, 3) }
      
      let(:do_request) { delete :destroy, params: { id: companies.last.id}}

      it 'not destroys a company' do
        expect { do_request }.to raise_error CanCan::AccessDenied
      end
    end
  end
end
