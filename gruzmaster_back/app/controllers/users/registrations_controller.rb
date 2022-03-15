class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    begin
      super
    rescue Exception => e
      if e.is_a? ActiveRecord::RecordNotUnique
        register_failed("This email already exists")
      else
        register_failed(message)
      end
    end
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed(message="Something went wrong.")
    render json: { message: message }, status: 500
  end
end
