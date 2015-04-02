module SequelBeforeValidation
  def before_validation
    self.created_at ||= Time.now
    super
  end
end