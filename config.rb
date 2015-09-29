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

###
# Helpers
###

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

helpers do
  def image_url(source)
    host_with_port = "https://utisak.com"
    host_with_port + image_path(source)
  end

  def svg(file_name)
    partial "inline-assets/#{file_name}"
  end

  def page_classes
    yield_content(:page_classes)
  end

  def t(key)
    locale = "sr_latin"
    data.locales.instance_eval { eval "#{locale}.#{key}" }
  end
end


configure :development do
  activate :directory_indexes
  activate :minify_html, remove_input_attributes: false
end

configure :build do
  activate :directory_indexes
  activate :asset_hash
  activate :minify_html, remove_input_attributes: false
  activate :minify_css
  activate :minify_javascript
  activate :gzip
# activate :imageoptim
end

after_build do
  `chmod -R +xr build`
end
