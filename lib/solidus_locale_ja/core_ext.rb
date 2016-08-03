files = Dir[File.join(File.dirname(__FILE__), '../..', '/core/config/locales/ja.yml'),
            File.join(File.dirname(__FILE__), '../..', '/api/config/locales/ja.yml')]
I18n.load_path += files
