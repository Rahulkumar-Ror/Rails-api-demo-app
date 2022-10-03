  class Api::V1::UserSerializer < ActiveModel::Serializer
    attributes :id, :email
    # def manager
    #   {
    #     id: object.manager.id,
    #     email: object.manager.name
    #   }
    # end
  end
