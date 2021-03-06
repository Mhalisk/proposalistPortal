require 'uri'

class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  access all: [:index, :show, :new, :edit, :create, :update, :destroy], user: :all
  include EncorDividend
  include JobsApi

  # GET /jobs
  def index
    @jobs = Job.all
  end

  def list_encor_jobs
    @encor_jobs = Job.encor
  end

  def list_powerhome_jobs
    @powerhome_jobs = Job.powerhome
  end

  # GET /jobs/1
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new 
    url_parser()
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)  
    puts @job.first_name
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id]) 
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:first_name, :last_name, :address, :city, :state, :zip, :email, :phone_number, :ssn, :annual_income, :mortgage_payment, :job_link, :company_id, :location_id)
    end
end
