module Cms
  class Page < ActiveRecord::Base
    belongs_to :page_category
    validates_presence_of :title, :content, :page_category

    mount_uploader :thumb, ThumbUploader
    end
end
