namespace :db do
  namespace :seed do
    desc "Load the seed data from solidus_locale_ja"
    task solidus_locale_ja: :environment do
      SolidusLocaleJa::Engine.load_seed
    end
  end
end
