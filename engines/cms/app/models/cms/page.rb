module Cms
  class Page < ActiveRecord::Base
    belongs_to :page_category
    validates_presence_of :title, :content
  end
end
