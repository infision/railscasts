class AdminController < ApplicationController
  def add_moderator
		if !User.find(:all, :conditions => {:name => params[:name]}).empty?
			User.find(:all, :conditions => {:name => params[:name]}).update_attribute(:moderator => true)
			redirect_to root_url, :notice => "#{params[:name]} is now Moderator."
		end
  end

end
