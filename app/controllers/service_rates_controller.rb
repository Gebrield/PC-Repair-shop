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

class ServiceRatesController < ApplicationController
  authorize_resource
  # GET /service_rates
  # GET /service_rates.xml
  def index
    @title = 'Service Rates'
    @service_rates = ServiceRate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @service_rates }
    end
  end

  # GET /service_rates/1
  # GET /service_rates/1.xml
  def show
    @title = 'Service Rate Details'
    @service_rate = ServiceRate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @service_rate }
    end
  end

  # GET /service_rates/new
  # GET /service_rates/new.xml
  def new
    @title = 'Creating New Service Rate'
    @service_rate = ServiceRate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @service_rate }
    end
  end

  # GET /service_rates/1/edit
  def edit
    @title = 'Editing Service Rate'
    @service_rate = ServiceRate.find(params[:id])
  end

  # POST /service_rates
  # POST /service_rates.xml
  def create
    @title = 'Adding New Service Rate'
    @service_rate = ServiceRate.create(service_rate_params)

    respond_to do |format|
      if @service_rate.save
        format.html { redirect_to service_rates_path, :notice => 'Service rate was successfully created.' }
        format.xml { render :xml => @service_rate, :status => :created, :location => @service_rate }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @service_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_rates/1
  # PUT /service_rates/1.xml
  def update
    @service_rate = ServiceRate.find(params[:id])

    respond_to do |format|
      if @service_rate.update!(service_rate_params)
        format.html { redirect_to service_rates_path, :notice => 'Service rate was successfully updated.' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @service_rate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /service_rates/1
  # DELETE /service_rates/1.xml
  def destroy
    @service_rate = ServiceRate.find(params[:id])
    @service_rate.destroy

    respond_to do |format|
      format.html { redirect_to(service_rates_url) }
      format.xml { head :ok }
    end
  end

  private
  def service_rate_params
    params.require(:service_rate).permit(:sku, :description, :rate, :taxable, :tax_rate, :active)
  end
end
