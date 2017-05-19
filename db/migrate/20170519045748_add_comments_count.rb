class AddCommentsCount < ActiveRecord::Migration[5.0]
  def up
    add_column :articles, :comments_count, :integer, default: 0

    Article.reset_column_information
    Article.all.each do |a|
      a.update_attribute :comments_count, a.comments.length
    end
  end

  def down   
    remove_column :articles, :comments_count
  end
end
