module ActiveRecord
  class Base

    private

    def self.add_order!(sql, order, scope = :auto)
      scope = scope(:find) if :auto == scope
      scoped_order = scope[:order] if scope
      if order
        sql << " ORDER BY #{connection.order(order)}"
        sql << ", #{connection.order(scoped_order)}" if scoped_order
      else
        sql << " ORDER BY #{connection.order(scoped_order)}" if scoped_order
      end
    end
  end

end

module ActiveRecord::ConnectionAdapters
  class AbstractAdapter
    def order(order)
      case order
        when :random then "RANDOM()"
        else order.to_s
      end
    end
  end
end

module ActiveRecord::ConnectionAdapters
  class MysqlAdapter
    def order(order)
      case order
        when :random then "RAND()"
        else order.to_s
      end
    end
  end
end