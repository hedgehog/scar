require 'rubygems'
require 'extlib'
require 'pathname'
require 'nanoc3'

dir = (Pathname(__FILE__).dirname / '..' / 'lib' / 'scar').expand_path
require dir

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Breadcrumbs
include Nanoc3::Helpers::Capturing
include Nanoc3::Helpers::Filtering
include Nanoc3::Helpers::HTMLEscape
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Text
include Nanoc3::Helpers::XMLSitemap
# include Scar::Helpers  # Classes and methods avilable during nonoc3's compilation.s
