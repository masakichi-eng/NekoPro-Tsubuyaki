class Profile < ApplicationRecord
  # BIRTHDATE_REGEX = ^(19[0-9]{2}|2[0-9]{3})/0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])$
  # validates_format_of :birth_date, with: BIRTHDATE_REGEX

  with_options presence: true do
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶ]+\z/ } do
      validates :last_name_kana
      validates :first_name_kana
    end
    validates :birth_date
  end

  belongs_to :user
end
