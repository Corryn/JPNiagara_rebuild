class JellystoneniagaraController < ApplicationController

=begin
    @title - Specifies tab/window title for page.
    @renderSlider - Indicates whether to include image slider on page.
    @renderContent - Indicates whether to include content blocks on page. 
    @alternate - If true, content blocks will alternate image left, content right and vice-versa.
    @contentRecs - List of content records to be displayed on a given page.
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

  def familyfun
    
    @title = "Family Fun"
    @renderSlider = false
    
    ##
    # <Variables needed>
    # @Date
    #
    @currDate = DateTime.now.beginning_of_month
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
    @contentRecs = Content.getContent(5)
    @renderContent = true
  end

  def parkmap
    @title = "Park Map"
    @renderSlider = false
    @content = false
  end

  def imagegallery
    @title = "Image Gallery"
    @renderSlider = false
  end

  def specials
    @title = "Specials"
    @renderSlider = true
  end

  def test
    @title = "Test Page"
    @currDate = DateTime.now.beginning_of_month
    endOfMonth = @currDate.end_of_month
    @currMonthEvents = CalendarEvent.getCurrMonth(@currDate,endOfMonth)
    puts @currMonthEvents.inspect
  end

end