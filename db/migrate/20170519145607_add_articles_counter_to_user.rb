class AddArticlesCounterToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :articles_count, :integer, default: 0

    User.reset_column_information
    User.all.each do |a|
      User.update_counters a.id, articles_count: a.articles.length
    end
  end

  def down   
    remove_column :users, :articles_count
  end
end
