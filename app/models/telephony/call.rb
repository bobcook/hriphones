module Telephony
  class Call < Base
    include NumberHelper
    include CallStateMachine

    belongs_to :conversation
    has_many :recordings
    has_one :voicemail
    has_many :events, class_name: 'Events::Base'
    belongs_to :agent

    attr_accessible :sid,
      :number,
      :state,
      :participant_id,
      :participant_type,
      :connected_at,
      :terminated_at,
      :agent

    def number with_protocol = false
      if agent
        agent.number with_protocol
      else
        customer_number
      end
    end

    def sanitized_number
      normalize_number(number)
    end

    def make!
      provider_call = Telephony.provider.call id, number(true), caller_id
      update_attribute :sid, provider_call.sid
    end

    def dial_into_conference!
      provider_call = Telephony.provider.dial_into_conference id, number(true), caller_id
      update_attribute :sid, provider_call.sid
    end

    def caller_id
      conversation.caller_id
    end

    def whitelisted_number?
      agent || number != Telephony.provider.uncallable_number
    end

    def record!(options)
      if options.include?(:RecordingUrl) && options.include?(:RecordingDuration)
        recordings.create url: options[:RecordingUrl],
                          duration: options[:RecordingDuration],
                          start_time: options[:RecordingDuration].to_i.seconds.ago
      end
    end

    def recorded?
      agent.nil?
    end

    def redirect_to_dial
      Telephony.provider.redirect_to_dial id, sid
    end

    def redirect_to_inbound_connect csr_id
      Telephony.provider.redirect_to_inbound_connect csr_id, sid
    end

    def redirect_to_conference
      Telephony.provider.redirect_to_conference id, sid
    end

    def redirect_to_hold
      Telephony.provider.redirect_to_hold id, sid
    end

    def agent?
      agent.present?
    end

    private

    def number_without_whitelisting
      self[:number]
    end

    def customer_number
      number_without_whitelisting &&
        Telephony.with_whitelisting(number_without_whitelisting)
    end
  end
end
