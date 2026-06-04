# frozen_string_literal: true

module Relay::Pages
  class ShowContext < Base
    prepend Relay::Hooks::RequireUser

    def call(id)
      context = find_context(id)
      if context
        response["content-type"] = "text/html"
        session["provider"] = context.provider
        sync_context!(context)
        page("chat", title: "Relay", messages: ctx.messages)
      else
        r.redirect "/"
      end
    end

    private

    def find_context(id)
      Relay::Models::Context.where(user_id: user.id, id:).first
    end
  end
end
