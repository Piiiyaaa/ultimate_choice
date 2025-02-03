Rails.application.config.assets.version = "1.0"

# SCSSファイルのパスを追加
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets')

# プリコンパイル対象に追加
Rails.application.config.assets.precompile += %w( 
  application.scss
  _variables.scss
  auth.scss
  layout.scss
  questions/index.scss 
  questions/show.scss
)