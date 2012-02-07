class BPS.Routers.PaymentsRouter extends Backbone.Router
  initialize: (options) ->
    @payments = new BPS.Collections.PaymentsCollection()
    @payments.reset []
    @user_full_name = options.user_full_name
    
  routes:
    "index"     : "index"
    "/new"      : "newPayment"
    "/:id"      : "show"
    ".*"        : "index"

  index: ->
    new BPS.Views.Payments.IndexView(el: "#payments", user_full_name: @user_full_name).render()

  newPayment: ->
    @view = new BPS.Views.Payments.NewView(collection: @payments)
    $("#payments").html(@view.render(@user_full_name).el)
    
  show: (id) ->
    payment = new BPS.Models.Payment({ id: id })
    payment.fetch
      success: ->
        @view = new BPS.Views.Payments.ShowView(model: payment)
        $("#payments").html(@view.render().el)
    