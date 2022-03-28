class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed(resource.errors.full_messages)
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed(messages=["Something went wrong."])
    render json: { messages: messages }, status: 500
  end
end
