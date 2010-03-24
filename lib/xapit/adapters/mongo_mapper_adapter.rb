module Xapit
	# This adapter is used for all MongoMapper  models. See AbstractAdapter for details.
  class MongoMapperAdapter < AbstractAdapter
    def self.for_class?(member_class)
			member_class.respond_to?(:connection) and member_class.connection.is_a?(Mongo::Connection) and member_class.respond_to?(:embeddable?) and not member_class.embeddable?
    end
    
    def find_single(id, *args)
			@target.find(id, *args)
    end
    
    def find_multiple(ids)
			id_list = ids.map {|i| Mongo::ObjectID.from_string(i) }
			@target.all(:id => id_list)
    end
    
    def find_each(*args, &block)
      @target.find_each(*args, &block)
    end
  end
end
