module Patrimony
  class ReportsController < ApplicationController


    def index
       @report = Good.new
       @codhab = Property.find_by_name('CODHAB/DF')
       @segeth = Property.find_by_name('SEGETH/DF')
       @goods_codhab = Good.property(@codhab).count
       @goods_segeth = Good.property(@segeth).count
       @goods = Good.all.count
       @type_materials = TypeMaterial.all
       @materials = Material.all
    end

    def index_codhab
      @codhab = Property.find_by_name('CODHAB/DF')
      @goods_codhab = Good.property(@codhab)
      
      respond_to do |format|
        format.html
          format.pdf do
            render pdf: "index_codhab.pdf"

          end
      end
    end

   
    def index_segeth
      @segeth = Property.find_by_name('SEGETH/DF')
      @goods_segeth = Good.property(@segeth)
    end
  end
end