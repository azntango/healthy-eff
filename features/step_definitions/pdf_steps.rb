include DateFormat
module PDF
  class PdfToText
    def initialize(pdf_file)
      @receiver = PDF::SimplePageTextReceiver.new
      pdf = PDF::Reader.file(pdf_file, @receiver)
    end

    def get_text
      @receiver.content.inspect
    end
  end
end

module PDF
  class SimplePageTextReceiver
    attr_accessor :content

    def initialize
      @content = []
    end

    # Called when page parsing starts
    def begin_page(arg = nil)
      @content << ""
    end

    # record text that is drawn on the page
    def show_text(string, *params)
      @content.last << string.strip
    end

    # there's a few text callbacks, so make sure we process them all
    alias :super_show_text :show_text
    alias :move_to_next_line_and_show_text :show_text
    alias :set_spacing_next_line_show_text :show_text

    # this final text callback takes slightly different arguments
    def show_text_with_positioning(*params)
      params = params.first
      params.each { |str| show_text(str) if str.kind_of?(String)}
    end
  end
end


When(/^I follow the PDF button "([^"]+)"$/) do |label|
  click_button(label)
  temp_pdf = Tempfile.new('pdf')
  temp_pdf << page.source.force_encoding('UTF-8')
  temp_pdf.close
  @pdf_text = PDF::PdfToText.new(temp_pdf.path)
  page.driver.response.instance_variable_set('@body', @pdf_text.get_text)
end

Then(/^the following names should be listed on the audit form: "(.*)"$/) do |last|
	assert_not_equal(page.driver.response.instance_variable_get('@body').index(/#{last}/), nil)
end

When (/I check names: (.*)$/) do |names_list|
  names = names_list.split(", ")
  for i in 0..names.length - 1
    first = names[i].split[0]; last = names[i].split[1]
    check 'selected_' + last
  end
end

When (/I select all/) do
  check 'selectAll'
  find(:css, "input#selectAll[value='selectAll']").set(true)
  expect(find(:css, "input#selectAll[value='selectAll']")).to be_checked
end

Given (/^(.*) has logged (\d+) (?:activity|activities)/) do |name, num|
  full_name = name.split(" ")

  u = User.find_by_last_name(full_name[1])
  if u.nil?
    u = User.create! :email => full_name[0] + "@blah.com",
                     :password => "?1Asdfjkl;asdfjkl;",
                     :password_confirmation => "?1Asdfjkl;asdfjkl;",
                     :first_name => full_name[0],
                     :last_name => full_name[1]
  end
  today = get_today
  m = Month.create_month_model(u.id, today.month, today.year)
  m.num_of_days = num.to_i
  m.save!
  # num.to_i.times do
  for i in 0..num.to_i - 1
    d = Day.create! :approved => true,
                :denied => false,
                :date => today - i.days,
                :total_time => 60,
                :reason => 'none',
                :month_id => m.id
    d.save
  end
end
