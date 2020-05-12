module ApplicationHelper
  def studying?
    if current_user
      @record = current_user.unfinished_records.last
    end
  end
end
