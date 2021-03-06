# MyITCRM - Repairs Business CRM Software
# Copyright (C) 2009-2014  Glen Vanderhel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class ProductsController < ApplicationController

  helper_method :sort_column, :sort_direction

#  Used by CanCan to restrict controller access
  authorize_resource

  def index
    @title = t "products.t_title"
#    @products = Product.paginate :page => params[:page], :order => sort_column+ " " +sort_direction, :per_page => 50
#    @products = Product.order(:id).page params[:page]
    @products = Product.search_products(params[:search_products], sort_column, sort_direction).paginate :per_page => 50, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
    end
  end

  def show
    @title = t "products.t_title"
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
    end
  end

  def new
    @title = t "products.t_add_new"
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @product }
    end
  end

  def edit
    @title = t "products.t_title"
    @product = Product.find(params[:id])

  end

  def create
    @title = t "products.t_title"
    @product = Product.create(product_params)

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@product) }
        format.xml { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @title = t "products.t_title"
    @product = Product.find(params[:id])
    @product.dynamic_attributes = [:taxable, :tax_rate, :discountable, :disc_amount, :disc_percent] if can? :manage, Product

    respond_to do |format|
      if @product.update!(product_params)
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @title = t "products.t_title"
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml { head :ok }
    end
  end

  private

  def product_params
    params.require(:product).permit(:our_sku, :description, :model, :manufacturer, :category_name, :supplier_id,
                                    :supplier_sku, :cost_price, :sell_price, :created_by, :created_at, :product_category_id,
                                    :product_category_name, :name, :updated_at, :warranty_info, :warranty_length, :warranty_unit)
  end

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "our_sku"
  end

  def sort_direction
    %w[ASC DESC].include?(params[:direction]) ? params[:direction] : "ASC"
  end
end
  
