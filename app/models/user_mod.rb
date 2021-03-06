# == Schema Information
#
# Table name: user_mods
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  mod_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserMod < ApplicationRecord
  belongs_to :user
  belongs_to :mod
  belongs_to :semester

  # validates prerequisite
  validate :prerequisite_class
  validate :check_uniq

  def prerequisite_class
    text = self.mod&.module_prerequisite
    mod_id = Mod.find_by(module_code: text) 
    if UserMod.find_by(user_id: self.user_id, mod_id: mod_id).blank?
      errors.add("mod_id", "#{text} must be read before reading this module")
    end
  end


  def check_uniq
    if UserMod.find_by(user_id: self.user_id, mod_id: self.mod_id, semester_id: self.semester_id)
      errors.add("mod_id", "You have already added this mod!")
    end
  end
end
