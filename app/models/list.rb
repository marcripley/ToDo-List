class List < ActiveRecord::Base
  has_many :items do
    def next
      proxy_target.to_a.rand
    end
  end
  belongs_to :current_item, :class_name => 'Item'

  def get_current_item
    current_item || choose_next_item
  end

  def choose_next_item
    self.current_item = items.next
    self.current_item.update_attribute(:last_seen, Time.now) if self.current_item
    self.current_item
  end
end