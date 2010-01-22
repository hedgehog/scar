 require 'rubygems'
 module Nanoc3::Filters
   class SyntaxColorize < Nanoc3::Filter

     identifiers :syntax_colorize

     def run(content, params={})
       require 'coderay'
       require 'nokogiri'

       doc = Nokogiri::HTML(content)

       doc.css('pre code[@class*=language-]').each do |e|
         # Get text and language
         code = e.inner_text
         lang = /language-([a-z0-9\-_]+)/.match(e['class'])[1]

         # Process
         e.inner_html = ::CodeRay.scan(code, lang).html(params)
       end

       doc.to_s
     end
     
   end
end

#include Nanoc3::Filters
#include Nanoc3::Helpers::Filtering


#module ::Nanoc3::Helpers
#  module SyntaxColorize
#
#    require 'nanoc3/helpers/capturing'
#    include Nanoc3::Helpers::Capturing
#
#    def syntax_colorize(lang, type=:ultraviolet, &block)
#      # Capture block
#      data = capture(&block)
#
#      # Remove whitespace
#      lines = data.split("\n")
#      min_indent = lines.inject(nil) do |memo, line|
#        next memo if line =~ /^\s*$/
#        next memo if line !~ /^(\s*)/
#        [ memo, $1.size ].compact.min
#      end
#      lines.each do |line|
#        line[0,min_indent] = ''
#      end
#      data = lines.join("\n")
#
#      # Process
#      case type
#      when :ultraviolet
#        begin
#          require 'uv'
#          filtered_data = Uv.parse(data, 'xhtml', lang, false, 'amy')
#        rescue LoadError
#          unless $_WARNED_ABOUT_ULTRAVIOLET
#            warn "WARNING: Couldn't load uv; please install the ultraviolet gem. This message will not appear again."
#          end
#          $_WARNED_ABOUT_ULTRAVIOLET = true
#
#          filtered_data = '<pre class="no-uv">' + h(data) + '</pre>'
#        end
#
#        # Convert to HTML
#        filtered_data = filtered_data.strip.sub(%r{/ ?>}, '>') # convert to HTML
#
#        # Add missing <code> in <pre>
#        filtered_data.sub!(/^\s*(<pre class="[^<]+">)\s*/) { |m| "#{m}<code>" }
#        filtered_data.sub!(/\s*(<\/pre>)\s*$/) { |m| "</code>#{m}" }
#      when :coderay
#        # Find filter
#        klass = Nanoc3::Filter.named(:coderay)
#        filter = klass.new(@item_rep.assigns)
#
#        # Filter captured data
#        filtered_data = filter.run(data, :language => lang).strip
#      else
#        raise ArgumentError, "invalid type: #{type}"
#      end
#
#      # Append filtered data to buffer
#      buffer = eval('_erbout', block.binding)
#      buffer << '<pre><code>' if type == :coderay
#      buffer << filtered_data
#      buffer << '</code></pre>' if type == :coderay
#    end
#
#  end
#
#end
#
# This is a small filter that searches for <pre><code>...</code></pre> blocks inside the
# given document and rams the block through CodeRay. This should allow you to get nice
# syntax highlighted code from straight Markdown (I tested via txt files through Bluecloth).
#
# Some caveats:
#
# - The <pre><code> block is automatically wrapped in a <div class="CodeRay"> by this filter.
# - I've defaulted to C below; current this is hardwired.
# - You'll need to add suitable CSS for CodeRay somewhere; this isn't inlined/generated.
#
# Needs Gems:
#
# - Hpricot
# - CodeRay
#
#class CoderayFilter < ::Nanoc3::Filter
#
#  identifier :coderay
#
#  def run(content, params={:lang => :ruby, :format => :html, :line_numbers => :inline,
#        :hint => :info, :css => :style, :wrap => :div})
#    nanoc_require 'hpricot'
#    nanoc_require 'coderay'
#    opts = params.dup
#    lang = opts.delete(:lang){ :ruby }
#    format =  opts.delete(:format){ :html }
#
#    doc = Hpricot(content)
#
#    blocks = doc.search('pre > code').map do |block|
#
#      # CodeRay will re-escape, leading to a mess as the content is already escaped.
#      # Need to therefore unescape first.
#      #
#      # :ruby,
#      # :html,
#      # :line_numbers => :inline,
#      # :hint => :info,
#      # :css => :style,
#      # :wrap => :div
#
#      code = encode(html_unescape(block.inner_html), lang, format, opts)
#
#      block.inner_html = code
#
#    end
#
#    # Crusty; wrap in div.
#    doc.to_s.gsub('<pre><code>', '<div class="CodeRay"><pre><code>').gsub('</code></pre>', '</code></pre></div>')
#
#  end
#
#  private
#
#   def html_unescape(a_string)
#     a_string.gsub('&amp;', '&').gsub('&lt;', '<').gsub('&gt;', '>').gsub('&quot;', '"')
#   end
#
#   def codify(str, lang)
#     %{#{CodeRay.scan(str, lang).html}}
#   end
#
#end
