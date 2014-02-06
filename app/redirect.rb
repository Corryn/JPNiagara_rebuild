class Redirect < ActiveRecord::Base

   validates_presence_of   :bounce_code_old,:bounce_code_new

end
