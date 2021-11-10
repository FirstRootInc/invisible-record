module InvisibleRecord
  module Model
    def acts_as_invisible(**options)
      raise 'Only call acts_as_invisible once per model' if respond_to?(:invisible_record_model?)

      class_eval do
        class << self
          def invisible_record_model?
            true
          end
        end

        self.attribute_names.each do |attribute|
          define_method attribute do |*args|
            return self.attributes['deleted_at'] if attribute == 'deleted_at'
            if self.attributes['deleted_at'].present?
              nil
            else
              self.attributes[attribute]
            end
          end

          unless self.respond_to? attribute
            define_method "hidden_#{attribute}" do |*args|
              self.attributes[attribute]
            end
          end
        end

        def restore
          self.deleted_at = nil
        end

        def restore!
          restore
          save!
        end
      end
    end
  end
end
