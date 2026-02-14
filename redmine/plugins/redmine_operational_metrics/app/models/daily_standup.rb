class DailyStandup < ActiveRecord::Base
  belongs_to :user

  validates :name, :start_at, :end_at, :user_id, presence: true
  validate :end_after_start

  # calculated, not stored
  def meeting_minutes
    ((end_at - start_at) / 60).to_i
  end

  def meeting_time
    mins = meeting_minutes
    "#{mins / 60}h #{mins % 60}m"
  end

  private

  def end_after_start
    if start_at && end_at && end_at <= start_at
      errors.add(:end_at, 'must be after start time')
    end
  end
end
