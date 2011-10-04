class BrokerWorksheetController < ApplicationController
  include StringFormatHelper
  include DelinquencyOrReoHelper

  unloadable

  alias_method_chain :check_if_login_required, :exception

  def for_loan
    @broker_worksheet = BrokerWorksheet.find_by_loan_id(params[:id])
    if @broker_worksheet
      flash.delete(:error)
      render :template => 'broker_worksheet/issues/show', :layout => "broker_worksheet"
    else
      flash[:error] = "No Broker Connect Worksheet found for loan #{params[:id]}"
      render :action => "error"
    end
  end

  def error

  end

  def update_broker_sidebar
    @broker_worksheet = BrokerWorksheet.find(params[:broker_worksheet][:id])
    @broker_worksheet.loan_resolution_specialist_id = params[:broker_worksheet][:loan_resolution_specialist_id]
    @broker_worksheet.save!
    respond_to do |format|
      format.js {
        @broker_worksheet
      }
    end
  end

  def check_if_login_required_with_exception
    check_if_login_required_without_exception unless params[:action] == "for_loan" and request.host == Socket.gethostbyname(Socket.gethostname).first
  end

end
