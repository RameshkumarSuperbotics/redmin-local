class EmployeeRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :approver, class_name: 'User', optional: true

  REQUEST_TYPES = %w[
    work_from_home
    hourly_permission
    on_duty
    attendance_regularization
    shift_request
    leave_request
    expense_claim
    advance_request
    salary_slip
  ].freeze

  REQUEST_TYPE_LABELS = {
    'work_from_home'             => 'Work From Home',
    'hourly_permission'          => 'Hourly Permission',
    'on_duty'                    => 'On Duty',
    'attendance_regularization'  => 'Attendance Regularization',
    'shift_request'              => 'Request a Shift',
    'leave_request'              => 'Request Leave',
    'expense_claim'               => 'Claim an Expense',
    'advance_request'            => 'Request an Advance',
    'salary_slip'                => 'View Salary Slips'
  }.freeze

  STATUSES = %w[pending approved rejected].freeze

  validates :user_id, presence: true
  validates :request_type, inclusion: { in: REQUEST_TYPES }
  validates :status, inclusion: { in: STATUSES }

  scope :pending, -> { where(status: 'pending') }
  scope :for_user, ->(user) { where(user_id: user.id) }

  def label
    REQUEST_TYPE_LABELS[request_type] || request_type
  end

  def approve!(approver)
    update(status: 'approved', approver: approver, approved_at: Time.current)
  end

  def reject!(approver)
    update(status: 'rejected', approver: approver, approved_at: Time.current)
  end
end
