class UserPolicy < ApplicationPolicy
  def index
    record.admin_role? || false
  end

  def show?
    user = record
  end

  def create?
    true
  end

  def update?
    user == record
  end

  def destroy?
    false
  end
end
