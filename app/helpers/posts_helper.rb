module PostsHelper
  #views/posts/branch/_create_new_post.html.erb
  def create_new_post_partial_path
    if user_signed_in?
      'posts/branch/create_new_post/signed_in'
    else
      'posts/branch/create_new_post/not_signed_in'
    end
  end

  # views/posts/branch/_categories.html.erb
  def all_categories_button_partial_path
    if params[:category].blank?
      'posts/branch/categories/all_selected'
    else
      'posts/branch/categories/all_not_selected'
    end
  end

  # views/posts/_branch.html.erb
  def no_posts_partial_path
    @posts.empty? ? 'posts/branch/no_posts' : 'shared/empty_partial'
  end
end
