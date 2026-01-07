require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

namespace :docs do
  desc "Generate YARD documentation for current version"
  task :generate do
    require_relative "lib/funes/version"
    version = Funes::VERSION
    output_dir = "docs/v#{version}"

    puts "Generating documentation for version #{version}..."
    system("yard doc --output-dir #{output_dir}") || abort("Failed to generate documentation")

    # Copy assets to root docs directory
    FileUtils.mkdir_p("docs")
    %w[css js].each do |asset_dir|
      if Dir.exist?("#{output_dir}/#{asset_dir}")
        FileUtils.cp_r("#{output_dir}/#{asset_dir}", "docs/#{asset_dir}")
      end
    end

    puts "Documentation generated in #{output_dir}/"
    Rake::Task["docs:build_index"].invoke
  end

  desc "Build version selector index page"
  task :build_index do
    versions = Dir.glob("docs/v*").map { |d| File.basename(d) }.sort.reverse

    if versions.empty?
      puts "No versions found. Run 'rake docs:generate' first."
      exit 1
    end

    latest_version = versions.first

    html = <<~HTML
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <meta http-equiv="refresh" content="0; url=#{latest_version}/index.html">
        <title>Funes Documentation</title>
        <style>
          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
          }
          .message {
            margin-top: 100px;
            color: #666;
          }
          a {
            color: #0066cc;
            text-decoration: none;
          }
          a:hover {
            text-decoration: underline;
          }
        </style>
        <script>
          window.location.href = "#{latest_version}/index.html";
        </script>
      </head>
      <body>
        <div class="message">
          <p>Redirecting to the latest version (#{latest_version})...</p>
          <p>If you are not redirected, <a href="#{latest_version}/index.html">click here</a>.</p>
        </div>
      </body>
      </html>
    HTML

    File.write("docs/index.html", html)
    puts "Version index page created at docs/index.html"
  end

  desc "List all documented versions"
  task :list do
    versions = Dir.glob("docs/v*").map { |d| File.basename(d) }.sort.reverse

    if versions.empty?
      puts "No versions documented yet."
    else
      puts "Documented versions:"
      versions.each { |v| puts "  - #{v}" }
    end
  end
end
