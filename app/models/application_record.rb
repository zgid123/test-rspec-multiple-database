# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  self.default_shard = :primary

  connects_to(
    shards: {
      primary: { writing: :primary, reading: :primary }
    }
  )
end
