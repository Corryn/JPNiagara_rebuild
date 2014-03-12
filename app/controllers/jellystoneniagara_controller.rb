class JellystoneniagaraController < ApplicationController

=begin
    @title - Specifies tab/window title for page.
    @renderSlider - Indicates whether to include image slider on page.
    @renderContent - Indicates whether to include content blocks on page. 
    @alternate - If true, content blocks will alternate image left, content right and vice-versa.
    @contentRecs - List of content records to be displayed on a given page.
    <Content_Type_IDs>
    1 - home
    2 - rates
    3, 4, 5 - lodging
    6, 7, 8 - Family Fun
    9, 10, 11, 12 - Area Attractions
    13 - Parkmap
    14 - Image Gallery
    15 - Specials
=end

  def home
    @title = "Home"
    @renderSlider = true
    @alternate = true
    @contentRecs = Content.getContent(1)
    @renderContent = true
  end

  def rates
    @title = "Rates"
    @renderSlider = true
  end

  def lodging
    @title = "Lodging"
    @renderSlider = true
    @alternate = false
    @contentRecs = Content.getContent(3)
    @renderContent = true
  end

  def rvcampsites
    @title = "RV & Campsites"
    @alternate = false
    @contentRecs = Content.getContent(4)
    @renderContent = true
  end

  def rentals
    @title = "Rentals"
    @alternate = false
    @contentRecs = Content.getContent(5)
    @renderContent = true
  end

  def moreinfo
    @title = "More Info"
    @siteinfo = Content.where(:id => params[:data]);
  end

  def familyfun
    @title = "Family Fun"
  end

  def activities
    @title = "Activities"
    @alternate = true
    @contentRecs = Content.getContent(7)
    @renderContent = true
  end

  def areamap
    @title = "Area Map"
    @mapAttractions = Attraction.where(Attraction.arel_table[:latitude].not_eq(nil)).where(Attraction.arel_table[:longitude].not_eq(nil))
  end

  def calendar
    
    @title = "Event Calendar"
    @renderSlider = false
    
    if params[:date] == nil 
        @currDate = DateTime.now.beginning_of_month
    else
        @currDate = params[:date].to_datetime
    end
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
    weeks = endOfMonth.mday + @currDate.wday
    weeks = (weeks/7.0).ceil
    @height = (660/weeks) - 6
    # 4 weeks = 159
    # 5 weeks = 126
    # 6 weeks = 104


    ##
    # EVENT CALENDAR
    #
    # <DATABASE INFO>
    # id - the pkey
    # event_name - The name and the title of the event
    # event_tag - short description to be used as a quick summary / in use with the left content div
    # event_text - a full description used to populate the bottom content div
    # event_link - a Link to another section if desired
    # picture_id - a linkt to a picture to be used in the content block
    # event_date_start - the date the event starts
    # event_date_finish - the date the event finishes
    # </DATABASE INFO>
    #
    # @currEvents = Current months events
    # @Date = information on the current date
    # 
    # - Finds the current date(day name)
    # - creates blank calendar panels / frames for the non existant dates  (maximum of 6)
    # - once it gets to the first date it iterates through the calendar building each panel
    # -for(day 1; still days in month; next day)
    # - sets the number to the date
    # - checks the data gathered from the database to see if there is an event on that day and if so populates the day with the information
    # - adds info to the left sidebar which also holds information on the events for the month
    # - tag
    # - end for
    # - once the calendar is complete it populates the bottom content div with information regarding the event that is coming up next
    # - the calendar also has the option to scroll through the months for the current year which would redraw / create the calendar for a different month.
    #
    # (IDEAS)
    # - Add links and other things so that event database items can be a variety of things.
    # - Search through the calendar for specific events
    # - ability to click a button and send the booking information to book your site with the dates the event is going on for
    # - add email notifications to the calendar?
    # - build the calendar using a widget instead of this
   

  end

  def areaattractions
    @title = "Area Attractions"
    @renderSlider = true
    @alternate = true
    @contentRecs = Content.getContent(9)
    @renderContent = true
  end

  def toursandshuttles
    @title = "Tours and Shuttles"
    @alternate = true
    @contentRecs = Content.getContent(10)
    @renderContent = true
  end

  def attractionsandcoupons
    @title = "Attractions and Coupons"
    @alternate = true
    @contentRecs = Content.getContent(11)
    @renderContent = true
  end

  def contact
    @title = "Contact"
  end

  def camp
    @title = "Summer Camp"
  end

  def parkmap
    @title = "Park Map"
    @renderSlider = false
  end

  def parkmapinfo
    puts params[:data]
    @parkMapInfo = Content.where(content_name: params[:data])
    puts @parkMapInfo.first[:content_name].gsub("(tm)","&#8482").inspect
    render :partial => 'layouts/parkmapinfo'
  end

  def imagegallery
    @title = "Image Gallery"
    @renderSlider = false
  end

  def specials
    @title = "Specials"
    @renderSlider = false
    currDate = DateTime.now
    @specials = Special.getCurrentSpecials(currDate)
  end

  def test
    @title = "Test Page"
    @currDate = DateTime.now.beginning_of_month
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
    puts @currMonthEvents.inspect
  end

  def entry
    @title = "Database Management"
  end

  def description
    @currDate = params[:date].to_date
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
    @num = params[:data].to_i
    @color = params[:data2]
    render :partial => 'layouts/description'
  end

  def formtypeenter
    t = ContentType.create(:content_name => params["tname"])
    puts "\033[1;31m #{t.errors.messages}\033[0m\n"
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formcontententer
    c = Content.create(:content_name => params["cname"], :content_type_id => params["ctype"], :picture_id => params["cpic"], :content_text => params["ctext"], :content_link => params["clink"], :content_linktext => params["clinktext"])
    puts "\033[1;31m #{c.errors.messages}\033[0m\n"
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formpictureenter
    p = Picture.create(:picture_description => params["pdesc"], :picture_file => params["pfile"])
    puts "\033[1;31m #{p.errors.messages}\033[0m\n"
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formevententer
    if params["elink"] == "" then params["elink"] = nil end
    e = CalendarEvent.create(:event_name => params["ename"], :picture_id => params["epic"], :event_tag => params["etag"], :event_text => params["etext"], :event_link => params["elink"], :event_start_date => params["esdate"].to_date, :event_end_date => params["eedate"].to_date)
    puts "\033[1;31m #{e.errors.messages}\033[0m\n"
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formspecialenter
    s = Special.create(:special_name => params["sname"], :special_description => params["sdesc"], :link_id => params["slink"], :view_id => params["sview"], :special_start_date => params["ssdate"], :special_end_date => params["sedate"])
    puts "\033[1;31m #{s.errors.messages}\033[0m\n"
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formattractionenter 
    a = Attraction.create(:attraction_name => params["aname"], :latitude => params["alat"], :longitude => params["alon"], :color => params["acolor"], :marker_label => params["alabel"])
    puts "\033[1;31m #{a.errors.messages}\033[0m\n"
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formgrab
    render :partial => "dbm/" + params[:data].to_s
  end

  def datagrab
    if params[:data] == "type_base"
      @itemType = ContentType
      @itemNames = ContentType.column_names
      @itemValues = ContentType.all
    elsif params[:data] == "content_base"
      @itemType = Content
      @itemNames = Content.column_names
      @itemValues = Content.all
    elsif params[:data] == "picture_base"
      @itemType = Picture
      @itemNames = Picture.column_names
      @itemValues = Picture.all
    elsif params[:data] == "event_base"
      @itemType = Content
      @itemNames = CalendarEvent.column_names
      @itemValues = CalendarEvent.all
    elsif params[:data] == "special_base"
      @itemType = Content
      @itemNames = Special.column_names
      @itemValues = Special.all
    elsif params[:data] == "attraction_base"
      @itemType = Content
      @itemNames = Attraction.column_names
      @itemValues = Attraction.all
    end
    render :partial => "dbm/base_view"
  end

  def updatedb

    #Everytime a column is added to a model the matching function also needs to be updated
    #Everytime a new model / table is added a new function needs to be added
    #The form linked to each model will also need to be updated

    if params["bdata"] == "bct"
      ct = ContentType.find_by_id(params["fid"].to_i).update_attributes(:content_name => params["fcontent_name"])
      puts "\033[1;31m #{ct}\033[0m\n"
    elsif params["bdata"] == "bc"
      c = Content.find_by_id(params["fid"].to_i).update_attributes(:content_name => params["fcontent_name"], :content_type_id => params["fcontent_type_id"], :picture_id => params["fpicture_id"], :content_text => params["fcontent_text"], :content_link => params["fcontent_link"], :content_linktext => params["fcontent_linktext"])
      puts "\033[1;31m #{c}\033[0m\n"
    elsif params["bdata"] == "bp"
      p = Picture.find_by_id(params["fid"].to_i).update_attributes(:picture_description => params["fpicture_description"], :picture_file => params["fpicture_file"])
      puts "\033[1;31m #{p}\033[0m\n"
    elsif params["bdata"] == "be"
      e = CalendarEvent.find_by_id(params["fid"].to_i).update_attributes(:picture_id => params["fpicture_id"], :event_name => params["fevent_name"], :event_tag => params["fevent_tag"], :event_text => params["fevent_text"], :event_link => params["fevent_link"], :event_start_date => params["fevent_start_date"], :event_end_date => params["fevent_end_date"])
      puts "\033[1;31m #{e}\033[0m\n"
    elsif params["bdata"] == "bs"
      s = Special.find_by_id(params["fid"].to_i).update_attributes(:special_name => params["fspecial_name"], :special_description => params["fspecial_description"], :link_id => params["flink_id"], :view_id => params["fview_id"], :special_start_date => params["fspecial_start_date"], :special_end_date => params["fspecial_end_date"])
      puts "\033[1;31m #{s}\033[0m\n"
    elsif params["bdata"] == "ba"
      a = Attraction.find_by_id(params["fid"].to_i).update_attributes(:attraction_name => params["fattraction_name"], :content_id => params["fcontent_id"], :latitude => params["flatitude"], :longitude => params["flongitude"], :color => params["fcolor"], :marker_label => params["fmarker_label"])
      puts "\033[1;31m #{a}\033[0m\n"
    end
    redirect_to(request.env["HTTP_REFERER"])

  end

  def admin
    @title = "Admin"
    @renderSlider = false
  end

  def comments
    @title = "Comment Viewer"
    @renderSlider = false
    @comments = Comment.all
  end

  def postcomment
    c = Comment.create(:name => params["name"], :email => params["email"], :message => params["message"])
    puts "\033[1;31m #{c.errors.messages}\033[0m\n"
    if c.errors.messages == {} then flash[:notice] = "Comment posted successfully."
    else flash[:notice] = "Error posting comment."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def deletecomment
    c = Comment.destroy(params["id"])
    redirect_to(request.env["HTTP_REFERER"])
  end

  def deleteitem 
    tableRow = Object.const_get(params["content"])
    tableRow.destroy(params["id"])
    redirect_to :back
  end

end
