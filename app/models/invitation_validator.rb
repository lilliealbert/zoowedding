class InvitationValidator < ActiveModel::Validator
  def validate(record)
    if record.guests.present? && record.guests.map(&:email).compact.empty?
      record.errors[:guests] << "must have at least one email address"
    end
  end
end
