# frozen_string_literal: true

module Relay::Pages
  ##
  # Renders a saved chat context as a standalone page.
  class Context < Base
    prepend Relay::Hooks::RequireUser

    def call(id)
      context = selected_context(id)
      return r.redirect("/") unless context
      session["provider"] = context.provider
      sync_context!(context)
      response["content-type"] = "text/html"
      page("chat", title: "Relay", messages: ctx.messages)
    end

    private

    def selected_context(id)
      @selected_context ||= Relay::Models::Context.where(user_id: user.id, id:).first
    end
  end
end
