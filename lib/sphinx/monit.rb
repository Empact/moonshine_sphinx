module Sphinx
  module Monit
    def sphinx_monit(options = {})
      recipe :sphinx
      recipe :monit

      exec "monit restart #{configuration[:application]}-sphinx",
        :require => exec("rake thinking_sphinx:index")

      file "/etc/monit.d/#{configuration[:application]}-sphinx",
        :require => file('/etc/monit/monitrc'),
        :content => template(sphinx_template_dir.join('sphinx.monit')),
        :notify => exec('restart_monit')
    end
  end
end
