# frozen_string_literal: true

module Relay::Routes
  class DeleteContext < Base
    prepend Relay::Hooks::RequireUser

    def call(id)
      Relay::Models::Context.where(id:, user_id: user.id).delete
      partial("fragments/contexts", locals: {contexts:, show_label: true, swap_oob: false})
    end
  end
end
