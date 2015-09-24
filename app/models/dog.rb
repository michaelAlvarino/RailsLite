require_relative '../../active_record/lib/active_record_manifest'

class Dog < ActiveRecordBase
  validates :name, presence: true
  validates :name, length: { minimum: 1 }
  validates :owner, presence: true
  validates :owner, length: { minimum: 1 }

  finalize!
end