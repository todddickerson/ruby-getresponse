module GetResponse

  class FollowUp < Message

    attr_reader :day_of_cycle

    # Delete follow up message.
    def destroy
      response = @connection.send_request("delete_follow_up", :message => @id)["result"]
      response["deleted"].to_i == 1
    end


    # Method sets a day of cycle for follow-up. Passed value must be integer number. There can't be
    # more than one follow-up for day.
    #
    # value:: Fixnum
    def day_of_cycle=(value)
      params = {:message => @id, :day_of_cycle => value}
      response = @connection.send_request("set_follow_up_cycle", params)["result"]
      @day_of_cycle = value.to_i if response["updated"].to_i == 1
    end


    # Save follow-up message. When object can't be saved <tt>GetResponseError</tt> is raised,
    # otherwise returns <tt>true</tt>.
    def save
      params = {
        campaign: @campaign_id,
        subject: @subject,
        contents: @contents,
        day_of_cycle: @day_of_cycle
      }
      result = @connection.send_request(:add_follow_up, params)
      result["added"] == 1
    end

  end

end

