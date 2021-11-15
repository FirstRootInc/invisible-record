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
        options = args.last
        options[:datetime] ||= DateTime.now
        assign_timestamp = "#{deleted_ts_attr}="
        send(assign_timestamp, options[:datetime])
      end

      klass.define_method "soft_delete!" do |*_args|
        soft_delete
        save!
      end
    end

    def self.define_hidden_attributes(klass, deleted_ts_attr:)
      klass.attribute_names.each do |attribute|
        klass.define_method attribute do |*_args|
          return attributes[deleted_ts_attr] if attribute == deleted_ts_attr

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
