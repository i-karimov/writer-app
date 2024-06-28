class PostPolicy < ApplicationPolicy
  def new?
    true
  end

  def index?
    true
  end

  def create?
    true
  end

  def edit?
    user.admin_role? || (user.author?(record) && record.draft?)
  end

  def update?
    user.admin_role? || (user.author?(record) && record.draft?)
  end

  def show?
    user.admin_role? || user.author?(record)
  end

  def destroy?
    user.admin_role? || (user.author?(record) && record.draft?)
  end
end
