module Sphinx
  module God
    def sphinx_god(options = {})
      recipe :sphinx
      recipe :god

      exec "god restart #{configuration[:application]}-sphinx",
        :require => exec("rake thinking_sphinx:index")

      file "/etc/god/#{configuration[:application]}-sphinx.god",
        :require => file('/etc/god/god.conf'),
        :content => template(sphinx_template_dir.join('sphinx.god')),
        :notify => exec('restart_god')
    end
  end
end
