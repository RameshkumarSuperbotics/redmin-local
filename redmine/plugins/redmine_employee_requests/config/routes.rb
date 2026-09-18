resources :employee_requests, only: [:index, :new, :create, :show] do
  collection do
    get 'mine'
    get 'approvals'
    get 'payslips/new', action: :new_payslip, as: :new_payslip
    post 'payslips', action: :create_payslip, as: :create_payslip
  end
  member do
    post 'approve'
    post 'reject'
  end
end
