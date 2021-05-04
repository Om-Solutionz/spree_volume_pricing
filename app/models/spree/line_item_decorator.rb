module Spree::LineItemDecorator
  # pattern grabbed from: http://stackoverflow.com/questions/4470108/

  # the idea here is compatibility with spree_sale_products
  # trying to create a 'calculation stack' wherein the best valid price is
  # chosen for the product. This is mainly for compatibility with spree_sale_products
  #
  # Assumption here is that the volume price currency is the same as the product currency
  
  def copy_price
    if variant
      if changed? && changes.keys.include?('quantity')
        vprice = variant.volume_price(quantity, order.user)
        if price.present? && vprice <= variant.price
        self.price = vprice and return
        end
      end

      self.price = variant.price if price.nil?
    end
  end
end

Spree::LineItem.prepend Spree::LineItemDecorator
