require 'active_support/concern'

module Spree::CouponsGiftCertificates::Order
  extend ActiveSupport::Concern

  included do 
    alias :spree_complete_order :complete_order
  end

  def complete_order
    line_items.each do |line_item|
      if line_item.variant.product.is_gift_cert?
        line_item.quantity.times do
          coupon = Coupon.create(:code => generate_coupon_code, :description => "Gift Certificate", :combine => true, :calculator => Calculator::FlatRate.new)
          coupon.calculator.update_attribute(:preferred_amount, line_item.variant.price)
          line_item.coupons << coupon
        end
        line_item.save
      end
    end


    coupons_credit.select{ |coupon_credit| coupon_credit.adjustment_source.code =~ /^giftcert-/}.each do |coupon_credit|
      coupon = coupon_credit.adjustment_source
      amount = coupon.calculator.preferred_amount - (item_total + charges.total)
      coupon.calculator.update_attribute(:preferred_amount, amount < 0 ? 0 : amount)
    end
    spree_complete_order
  end

  def generate_coupon_code
    base = 'giftcert-'
    chars = [('0'..'9').to_a, ('a'..'z').to_a].flatten
    rand = (0..16).map{ chars[rand(chars.length)]}.join
    code = base + rand
    coupon = Coupon.find_by_code(code)

    coupon ? generate_coupon_code : coupon
  end

  def purchased_gift_certs?
    line_items.collect{|li| li.product}.any?{|p| p.is_gift_cert?}
  end
end
