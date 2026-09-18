class EmployeeRequestsController < ApplicationController
  before_action :require_login
  before_action :require_approver, only: [:approvals, :approve, :reject]

  def index
    @request_types = EmployeeRequest::REQUEST_TYPES
  end

  def mine
    @employee_requests = EmployeeRequest.for_user(User.current).order(created_at: :desc)
  end

  def approvals
    @employee_requests = EmployeeRequest.pending.includes(:user).order(created_at: :asc)
  end

  def new
    @employee_request = EmployeeRequest.new(request_type: params[:type])
    unless EmployeeRequest::REQUEST_TYPES.include?(@employee_request.request_type)
      redirect_to action: :index
    end
  end

  def create
    @employee_request = EmployeeRequest.new(employee_request_params)
    @employee_request.user = User.current
    @employee_request.status = 'pending'

    if @employee_request.save
      redirect_to action: :mine, notice: 'Request submitted.'
    else
      render :new
    end
  end

  def show
    @employee_request = EmployeeRequest.find(params[:id])
  end

  def approve
    employee_request = EmployeeRequest.find(params[:id])
    employee_request.approve!(User.current)
    redirect_to action: :approvals, notice: 'Request approved.'
  end

  def reject
    employee_request = EmployeeRequest.find(params[:id])
    employee_request.reject!(User.current)
    redirect_to action: :approvals, notice: 'Request rejected.'
  end

  private

  def employee_request_params
    params.require(:employee_request)
          .permit(:request_type, :subject, :description, :start_date, :end_date, :amount)
  end

  def require_approver
    render_403 unless approver?(User.current)
  end

  def approver?(user)
    user.admin? || user.memberships.any? { |m| m.roles.any? { |r| r.name == 'Team Lead' } }
  end
  helper_method :approver?
end
