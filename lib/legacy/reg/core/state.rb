module Legacy
  module Reg
    module Core
      module State

        def self.included(base)
          base.class_eval do
          end

          base.extend StateClassMethods
        end

        # constant must equal respective record in the countries table
        UNKNOWN = "Unknown"


        module StateClassMethods

          def get_all_states(order_field = :id, order = "DESC")
            order = order.upcase
            order = "DESC" if (order != "ASC" && order != "DESC")

            # new nil state to handle state_id being 0
            [State.new].concat(State.all(:order => _(order_field) + " " + order + ", " + _(:id) + " " + order))
          end


          def get_all_states_from_country(country, order_field = :id, order = "DESC")
            country ||= ""
            order = order.upcase
            order = "DESC" if (order != "ASC" && order != "DESC")

            # new nil state to handle state_id being 0
            [State.new].concat(State.all(:joins => :country,
                                         :order => _(order_field) + " " + order + ", " + _(:id) + " " + order,
                                         :conditions => ["#{__(:description, :country)} = ?", country]))
          end

        end
      end
    end
  end
end
