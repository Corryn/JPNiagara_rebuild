class JellystoneniagaraController < ApplicationController

=begin
    @title - Specifies tab/window title for page.    
    @renderContent - Indicates whether to include content blocks on page.    
    @contentRecs - List of content records to be displayed on a given page.
    @alternate - If true, content blocks will alternate image left, content right and vice-versa.
    @renderSlider - Indicates whether to include image slider on page.
    @sliderFolder - Name of the folder in public/images/slider where the corresponding page's slider images are
=end

  def home
    # Content Type ID: 1
    @title = "Home" 
    @renderContent = true
    @contentRecs = Content.getContent(1)
    @alternate = true
    @sliderFolder = "main"
    @renderSlider = true
    
  end

  def rates
    # Content Type ID: 2
    @title = "Rates"
    @renderSlider = false
  end

  def lodging
    # Content Type ID: 3
    @title = "Lodging"
    @contentRecs = Content.getContent(3)
    @renderSlider = true
    @sliderFolder = "lodging"
    
  end

  def rvcampsites
    # Content Type ID: 4
    @title = "RVs & Campsites"
    @siteinfo = Sitetype.where("id < ?",11)
    @open = params[:id]
  end

  def getSite
    @siteinfo = Sitetype.where(:id => params[:num])
    @siteinfo = @siteinfo.first;
    @siteimages = Picture.where(:sitetype_id => params[:num])
    render :partial => "/layouts/site"
  end

  def moreinfo
    @title = "More Info"
    @siteinfo = Sitetype.where(:id => params[:data])
    @siteinfo = @siteinfo.first;
    @siteimages = Picture.where(:sitetype_id => params[:data])
  end

  def familyfun
    # Content Type ID: 6
    @title = "Family Fun"
  end

  def activities
    # Content Type ID: 7
    @title = "Activities"
    @renderContent = true
    @contentRecs = Content.getContent(7)
    @alternate = true
    @renderSlider = true
    @sliderFolder = "activities"
  end

  def calendar
    # Content Type ID: 8
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
    # name - The name and the title of the event
    # tag - short description to be used as a quick summary / in use with the left content div
    # text - a full description used to populate the bottom content div
    # link - a Link to another section if desired
    # picture_id - a linkt to a picture to be used in the content block
    # date_start - the date the event starts
    # date_finish - the date the event finishes
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

  def description
    @currDate = params[:date].to_date
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
    @num = params[:data].to_i
    @color = params[:data2]
    render :partial => 'layouts/description'
  end

  def getData
    @currDate = params[:date].to_date
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
    if @currMonthEvents[params[:num].to_i].picture != nil
      json = {:event => @currMonthEvents[params[:num].to_i], :picture => @currMonthEvents[params[:num].to_i].picture.file}.to_json
    else
      json = {:event => @currMonthEvents[params[:num].to_i]}
    end
    render :json => json
  end

  def areaattractions
    # Content Type ID: 9
    @title = "Area Attractions"   
    @contentRecs = Content.getContent(9)
    @renderContent = true
    @alternate = true
    @renderSlider = true
  end

  def toursandshuttles
    # Content Type ID: 10
    @title = "Tours and Shuttles"
    @renderContent = true
    @contentRecs = Content.where(:content_type_id => 10).where(:tour_id => 0)
    @alternate = true
    @tourRecs = []
    @forDelete = []
    @tours = Tour.all
  end

  def attractionsandcoupons
    # Content Type ID: 11
    @title = "Attractions and Coupons"
    @renderContent = true
    @contentRecs = Content.getContent(11)
    @alternate = true
  end

  def areamap
    # Content Type ID: 12
    @title = "Area Map"
    @mapAttractions = Attraction.where(Attraction.arel_table[:latitude].not_eq(nil)).where(Attraction.arel_table[:longitude].not_eq(nil)).order(:name)
  end

  def getAttraction
    @attraction = Attraction.where(:id => params["id"].to_i).first
    render :partial => "layouts/attraction"
  end

  def parkmap
    # Content Type ID: 13
    @title = "Park Map"
    @renderSlider = false
  end

  def parkmapinfo
    @parkMapInfo = Sitetype.where(:id => params[:id].to_i).first
    @picture = Picture.where(:sitetype_id => params[:id].to_i).first;
    render :partial => 'layouts/parkmapinfo'
  end

  def imagegallery
    # Content Type ID: 14
    @title = "Image Gallery"
    @renderSlider = false
    @items = Gallery.select([:id, :name])
    puts @items.inspect
  end

  def gallery
    @images = Picture.where(:gallery_id => params["gallery"])
    render :partial => 'layouts/gallery'
  end

  def specials
    # Content Type ID: 15
    @title = "Specials"
    @renderSlider = false
  end

  def getDeal
    if params[:sd] == "specials"
      currDate = DateTime.now
      specials = Special.getCurrentSpecials(currDate)
      s = []
      x = 0
      y = 0
      specials.each do |item|
        r = []
        r[x] = item
        x = x + 1
        r[x] = Picture.find_by_id(item[:link_id])
        x = x + 1
        r[x] = Picture.find_by_id(item[:view_id]) 
        x = x + 1
        s[y] = r
        y = y + 1
        x = 0
      end
      @specials = s
      render :partial => "/layouts/specials"
    elsif params[:sd] == "discounts"
      render :partial => "/layouts/discounts"
    else
      puts "How did you get here?"
    end
  end

  def contact
    # Content Type ID: 24
    @title = "Contact"
    if session[:params].nil?
       @params = Hash.new
    else
       @params = session[:params]
    end
    session[:params] = nil;

    @captcha_code = session[:session_id][0..10]
  end

  def postcomment
    require 'open-uri'
    captcha_answer = params[:captcha][:answer][/[a-z0-9]+/i]#just take letters and numbers
    response  = open("http://captchator.com/captcha/check_answer/#{session[:session_id][0..10]}/#{captcha_answer}") {|f| f.read }
    if response == "1"
      c = Comment.create(:name => params["name"], :email => params["email"], :message => params["message"])
      puts "\033[1;31m #{c.errors.messages}\033[0m\n"
      if c.errors.messages == {} then flash[:notice] = "Comment posted successfully."
      else flash[:notice] = "Error posting comment."
      end
    else
      flash[:notice] = "Sorry, your captcha message was not correct."
      session[:params] = params
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def camp
    # Content Type ID: 25
    @title = "Summer Camp"
    @resources = Resource.where(:use => "daycamp")
  end

  def classtrips
    # Content Type ID: 26
    @title = "Class Trips"
    @resources = Resource.where(:use => "classtrip")
  end

  def facilities
    # Content Type ID: 27
    @renderSlider = true
    @sliderFolder = "facilities"
    @facilities = Facility.all
  end

  def entry
    if session[:admin] == false then redirect_to("/admin/menu") end
    @title = "Database Management"
  end

  def formtypeenter
    t = ContentType.create(:content_name => params["tname"])
    puts "\033[1;31m #{t.errors.messages}\033[0m\n"
    if t.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formcontententer
    c = Content.create(:name => params["cname"], :content_type_id => params["ctype"], :picture_id => params["cpic"], :text => params["ctext"], :link => params["clink"], :link_text => params["clinktext"], :tour_id => params["ctid"])
    puts "\033[1;31m #{c.errors.messages}\033[0m\n"
    if c.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formpictureenter
    p = Picture.create(:description => params["pdesc"], :file => params["pfile"], :sitetype_id => params["pstid"], :gallery_id => params["pgid"])
    puts "\033[1;31m #{p.errors.messages}\033[0m\n"
    if p.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formevententer
    if params["elink"] == "" then params["elink"] = nil end
    e = CalendarEvent.create(:name => params["ename"], :picture_id => params["epic"], :tag => params["etag"], :text => params["etext"], :link => params["elink"], :start_date => params["esdate"].to_date, :end_date => params["eedate"].to_date)
    puts "\033[1;31m #{e.errors.messages}\033[0m\n"
    if e.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formspecialenter
    s = Special.create(:name => params["sname"], :description => params["sdesc"], :link_id => params["slink"], :view_id => params["sview"], :start_date => params["ssdate"], :end_date => params["sedate"], :resource_id => params["srid"])
    puts "\033[1;31m #{s.errors.messages}\033[0m\n"
    if s.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formattractionenter 
    a = Attraction.create(:name => params["aname"], :content_id => params["acid"], :latitude => params["alat"], :longitude => params["alon"], :color => params["acolor"], :marker_label => params["alabel"])
    puts "\033[1;31m #{a.errors.messages}\033[0m\n"
    if a.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formsitetypeenter
    st = Sitetype.create(:name => params["stname"], :desc_short => params["stdescs"], :desc_long => params["stdescl"], :inseason_weekday => params["stisweekday"], :inseason_weekend => params["stisweekend"], :inseason_weekly => params["stisweekly"], :holiday => params["stholiday"], :offseason_weekday => params["stosweekday"], :offseason_weekend => params["stosweekend"], :offseason_weekly => params["stosweekly"], :rewards_tier => params["strewards"], :suitability => params["stsuitability"], :notes => params["stnotes"])
    puts "\033[1;31m #{st.errors.messages}\033[0m\n"
    if st.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formresourceenter
    r = Resource.create(:description => params["rdesc"], :use => params["ruse"], :path => params["rpath"])
    puts "\033[1;31m #{r.errors.messages}\033[0m\n"
    if r.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formfacilityenter
    f = Facility.create(:name => params["fname"], :description => params["fdesc"], :picture_id => params["fpid"])
    puts "\033[1;31m #{f.errors.messages}\033[0m\n"
    if f.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formgalleryenter
    g = Gallery.create(:name => params["gname"])
    puts "\033[1;31m #{g.errors.messages}\033[0m\n"
    if g.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def formtourenter 
    t = Tour.create(:name => params["tname"], :picture_id => params["tpid"], :description => params["tdesc"], :coupon_desc => params["tcdesc"], :color => params["tcolor"])
    puts "\033[1;31m #{t.errors.messages}\033[0m\n"
    if t.errors.messages == {} then flash[:notice] = "Row created successfully."
    else flash[:notice] = "Error creating row."
    end
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
      @itemType = CalendarEvent
      @itemNames = CalendarEvent.column_names
      @itemValues = CalendarEvent.all
    elsif params[:data] == "special_base"
      @itemType = Special
      @itemNames = Special.column_names
      @itemValues = Special.all
    elsif params[:data] == "attraction_base"
      @itemType = Attraction
      @itemNames = Attraction.column_names
      @itemValues = Attraction.all
    elsif params[:data] == "sitetype_base"
      @itemType = Sitetype
      @itemNames = Sitetype.column_names
      @itemValues = Sitetype.all
    elsif params[:data] == "resource_base"
      @itemType = Resource
      @itemNames = Resource.column_names
      @itemValues = Resource.all 
    elsif params[:data] == "facility_base"
      @itemType = Facility
      @itemNames = Facility.column_names
      @itemValues = Facility.all
    elsif params[:data] == "gallery_base"
      @itemType = Gallery
      @itemNames = Gallery.column_names
      @itemValues = Gallery.all
    elsif params[:data] == "tour_base"
      @itemType = Tour
      @itemNames = Tour.column_names
      @itemValues = Tour.all
    end
    render :partial => "dbm/base_view"
  end

  def updatedb

    #Everytime a column is added to a model the matching function also needs to be updated
    #Everytime a new model / table is added a new function needs to be added
    #The form linked to each model will also need to be updated

    if params["bdata"] == "bct"
      item = ContentType.find_by_id(params["fid"].to_i).update_attributes(:content_name => params["fcontent_name"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bc"
      item = Content.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"], :content_type_id => params["fcontent_type_id"], :picture_id => params["fpicture_id"], :text => params["ftext"], :link => params["flink"], :link_text => params["flink_text"], :tour_id => params["ftour_id"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bp"
      item = Picture.find_by_id(params["fid"].to_i).update_attributes(:description => params["fdescription"], :file => params["ffile"], :sitetype_id => params["fsitetype_id"], :gallery_id => params["fgallery_id"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "be"
      item = CalendarEvent.find_by_id(params["fid"].to_i).update_attributes(:picture_id => params["fpicture_id"], :name => params["fname"], :tag => params["ftag"], :text => params["ftext"], :link => params["flink"], :start_date => params["fstart_date"], :end_date => params["fend_date"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bs"
      item = Special.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"], :description => params["fdescription"], :link_id => params["flink_id"], :view_id => params["fview_id"], :start_date => params["fstart_date"], :end_date => params["fend_date"], :resource_id => params["fresource_id"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "ba"
      item = Attraction.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"], :content_id => params["fcontent_id"], :latitude => params["flatitude"], :longitude => params["flongitude"], :color => params["fcolor"], :marker_label => params["fmarker_label"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bst"
      item = Sitetype.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"], :desc_short => params["fdesc_short"], :desc_long => params["fdesc_long"], :inseason_weekday => params["finseason_weekday"], :inseason_weekend => params["finseason_weekend"], :inseason_weekly => params["finseason_weekly"], :holiday => params["fholiday"], :offseason_weekday => params["foffseason_weekday"], :offseason_weekend => params["foffseason_weekend"], :offseason_weekly => params["foffseason_weekly"], :rewards_tier => params["frewards_tier"], :suitability => params["fsuitability"], :notes => params["fnotes"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "br"
      item = Resource.find_by_id(params["fid"].to_i).update_attributes(:description => params["fdescription"], :use => params["fuse"], :path => params["fpath"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bf"
      item = Facility.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"], :description => params["fdescription"], :picture_id => params["fpicture_id"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bg"
      item = Gallery.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"])
      puts "\033[1;31m #{item}\033[0m\n"
    elsif params["bdata"] == "bt"
      item = Tour.find_by_id(params["fid"].to_i).update_attributes(:name => params["fname"], :picture_id => params["fpicture_id"], :description => params["fdescription"], :coupon_desc => params["fcoupon_desc"], :color => params["fcolor"])
      puts "\033[1;31m #{item}\033[0m\n"
    end
    if item == true then flash[:notice] = "Row updated successfully."
    else flash[:notice] = "Error updating row."
    end
    redirect_to(request.env["HTTP_REFERER"])

  end

  def deleteitem 
    tableRow = Object.const_get(params["content"])
    tableRow.destroy(params["id"])
    flash[:notice] = "Row deleted successfully."
    redirect_to :back
  end

  def menu
    @title = "Admin"
    @renderSlider = false
  end

  def login
    if params[:pass] == "banana"
      session[:admin] = true
    else
      session[:admin] = false
      flash[:notice] = "Incorrect username or password."
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

  def logout
    session[:admin] = false
    redirect_to(request.env["HTTP_REFERER"])
  end

  def comments
    if session[:admin] == false then redirect_to("/admin/menu") end
    @title = "Comment Viewer"
    @renderSlider = false
    @comments = Comment.all
  end

  def deletecomment
    c = Comment.destroy(params["id"])
    redirect_to(request.env["HTTP_REFERER"])
  end

  def test
    if session[:admin] == false then redirect_to("/admin/menu") end
    @title = "Test Page"
    @currDate = DateTime.now.beginning_of_month
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
  end

end