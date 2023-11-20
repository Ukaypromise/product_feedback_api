class Api::V1::CompaniesController < ApplicationController
  def index
    @companies = Company.all
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

  private

  def company_params
    params.require(:company).permit(:name, :description, :product_url)
  end
end
