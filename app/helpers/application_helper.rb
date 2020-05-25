module ApplicationHelper
  def studying?
    @record = current_user.unfinished_records.last if current_user
  end
end
