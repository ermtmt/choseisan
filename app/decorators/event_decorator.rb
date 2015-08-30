module EventDecorator
  def owner?
    current_user && current_user == self.owner
  end

  def entered?
    current_user && self.entry_users.exists?(current_user.id)
  end
end
