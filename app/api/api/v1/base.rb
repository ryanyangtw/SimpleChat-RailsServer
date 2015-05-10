
module API
  module V1
    class Base < Grape::API



      include API::V1::Defaults

      #helpers StatusHelpers
      helpers API::V1::StatusHelpers
      mount API::V1::Users
      mount API::V1::Rooms
      mount API::V1::Messages

      add_swagger_documentation api_version: 'v1',
                                hide_documentation_path: true,
                                hide_format: true
    end
  end
end