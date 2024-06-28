class PostPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin_role?
        scope.where(status: :draft).or(Post.where(user_id: user.id))
      else
        scope.where(user_id: user.id)
      end
    end

    private

    attr_reader :user, :scope
  end

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
