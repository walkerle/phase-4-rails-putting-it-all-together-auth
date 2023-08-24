class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found exception
    render json: { error: "#{exception} not found" }, status: :unauthorized   
  end

  def record_invalid exceptions
    render json: { errors: exceptions.record.errors.full_messages }, status: :unprocessable_entity
  end

end
