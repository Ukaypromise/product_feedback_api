class Api::V1::CompaniesController < ApplicationController
  def index
    @companies = Company.order(created_at: :desc)
    render json: {
      data: @companies
    }
  end

  def create
    @company = current_user.companies.build(company_params)
    if @company.save
      render json: {
        status: { code: 200, message: "Company created sucessfully." },
        data: CompanySerializers.new(@company).serializable_hash,
      }, status: :created
    else
      render json: {
               status: { message: "Company couldn't be created successfully."},
               errors: @company.errors.full_messages.to_sentence,
               status: :unprocessable_entity,
             }
    end
  end

  def show
    @company = Company.find(params[:id])
    render json: {
      data: CompanySerializers.new(@company).serializable_hash,
    }, status: :ok
  end

  def update
    @company = Company.find(params[:id])
    if @company.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @company.update(company_params)
      render json: {
        status: { code: 200, message: "Company updated sucessfully." },
        data: CompanySerializers.new(@company).serializable_hash,
      }, status: :created
    else
      render json: {
               status: { message: "Company couldn't be updated successfully."},
               errors: @company.errors.full_messages.to_sentence,
               status: :unprocessable_entity,
             }
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @company.destroy
      render json: {
        status: { code: 200, message: "Company deleted sucessfully." },
        data: CompanySerializers.new(@company).serializable_hash,
      }, status: :created
    else
      render json: {
               status: { message: "Company couldn't be deleted successfully."},
               errors: @company.errors.full_messages.to_sentence,
               status: :unprocessable_entity,
             }
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :description)
  end
end
