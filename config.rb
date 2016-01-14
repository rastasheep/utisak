###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }
#
activate :s3_sync do |s3_sync|
  # s3_sync.aws_access_key_id        = "AWS KEY ID"
  # s3_sync.aws_secret_access_key    = "AWS SECRET KEY"
  # s3_sync.bucket                   = "beta.utisak.com"
  s3_sync.region                     = "eu-central-1"
  s3_sync.index_document             = "index.html"
  s3_sync.error_document             = "404/index.html"
end

###
# Helpers
###

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

helpers do
  def image_url(source)
    config[:host_with_port] + image_path(source)
  end

  def svg(file_name)
    partial "inline-assets/#{file_name}"
  end

  def page_classes
    yield_content(:page_classes)
  end

  def t(key)
    locale = config[:locale]
    data.locales.instance_eval { eval "#{locale}.#{key}" }
  end
end

set :host_with_port, "https://utisak.com"
set :locale, "sr_latin"

configure :development do
  set :tracking_id, "UA-xxxxxxxx-x"
  set :swiftype_id, "usDLCN3HtvZf3ciRhAAN"
  set :api_url, "http://local.go/vesti"

  activate :directory_indexes
  activate :minify_javascript, inline: true
  activate :minify_css, inline: true
  activate :minify_html, remove_input_attributes: false
end

configure :build do
  set :tracking_id, "UA-67280148-1"
  set :swiftype_id, "usDLCN3HtvZf3ciRhAAN"
  set :api_url, "https://api.utisak.com/vesti"

  activate :directory_indexes
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :minify_html, remove_input_attributes: false
  activate :gzip
# activate :imageoptim
end

after_build do
  `chmod -R +xr build`
end
