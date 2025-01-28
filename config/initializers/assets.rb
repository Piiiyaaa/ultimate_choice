Rails.application.config.assets.version = "1.0"

# SCSSファイルのパスを追加
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets', 'questions')

# プリコンパイル対象に追加
Rails.application.config.assets.precompile += %w( questions/index.scss questions/show.scss )
