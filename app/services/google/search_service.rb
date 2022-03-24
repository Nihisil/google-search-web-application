# frozen_string_literal: true

module Google
  class SearchService
    GOOGLE_SEARCH_URL = 'https://www.google.com/search'
    USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '\
                 '(KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36'

    def do_search(keyword)
      result = HTTParty.get(
        GOOGLE_SEARCH_URL,
        query: { q: CGI.escape(keyword), hl: 'en' },
        headers: { 'User-Agent' => USER_AGENT }
      )
      nil if result.response.code != '200'
      result
    rescue HTTParty::Error
      nil
    end
  end
end
