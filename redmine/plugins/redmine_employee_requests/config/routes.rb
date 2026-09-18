resources :employee_requests, only: [:index, :new, :create, :show] do
  collection do
    get 'mine'
    get 'approvals'
  end
  member do
    post 'approve'
    post 'reject'
  end
end
