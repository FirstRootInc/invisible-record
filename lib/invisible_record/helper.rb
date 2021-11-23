# frozen_string_literal: true

module InvisibleRecord
  # Helps other modules complete methods
  module Helper
    def self.define_actions(klass, deleted_ts_attr:)
      klass.define_method "restore" do |*_args|
        assign_timestamp = "#{deleted_ts_attr}="
        send(assign_timestamp, nil)
      end

      klass.define_method "restore!" do |*_args|
        restore
        save!
      end

      klass.define_method "soft_delete" do |*args|
        options = args.last || {}
        options[:datetime] ||= DateTime.now
        assign_timestamp = "#{deleted_ts_attr}="
        send(assign_timestamp, options[:datetime])
      end

      klass.define_method "soft_delete!" do |*args|
        options = args.last || {}
        options[:datetime] ||= DateTime.now
        soft_delete(datetime: options[:datetime])
        save!
      end
    end

    def self.define_hidden_attributes(klass, deleted_ts_attr:)
      klass.attribute_names.each do |attribute|
        klass.define_method attribute do |*_args|
          protected_attributes = ["id", deleted_ts_attr]
          protected_attributes.each do |protected_attr_name|
            return attributes[protected_attr_name] if attribute == protected_attr_name
          end

          if attributes[deleted_ts_attr].present?
            nil
          else
            attributes[attribute]
          end
        end

        klass.define_method "hidden_#{attribute}" do |*_args|
          attributes[attribute]
        end
      end
    end
  end
end
