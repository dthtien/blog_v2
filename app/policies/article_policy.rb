class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user.is_author?(record)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
