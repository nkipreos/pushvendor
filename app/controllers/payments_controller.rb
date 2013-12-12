class PaymentsController < ApplicationController

	def make_payment

  	respond_to do |format|
      format.js
    end
  end
end
