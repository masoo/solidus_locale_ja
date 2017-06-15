# Possibly already created by a migration.
require 'carmen'
ActiveRecord::Base.transaction do
  p "add Japan Country data."
  japan = Carmen::Country.named('Japan')
  Spree::Country.find_or_create_by!(iso_name: 'JAPAN') do |s|
    s.name =            '日本'
    s.iso =             japan.alpha_2_code
    s.iso3 =            japan.alpha_3_code
    s.iso_name =        japan.name.upcase
    s.numcode =         japan.numeric_code
    s.states_required = japan.subregions?
  end

  p "add Return Reson data."
  Spree::ReturnReason.delete_all
  ["より良い値段のものが他にあった", # 'Better price available'
   "到着予定日を過ぎた", # 'Missed estimated delivery date'
   "部品や付属品がない", # 'Missing parts or accessories'
   "商品に傷がある/不良品", # 'Damaged/Defective'
   "注文したものと違う", # 'Different from what was ordered'
   "説明と違う", # 'Different from description'
   "もう必要ない/欲しくない", # 'No longer needed/wanted'
   "間違った注文", # 'Accidental order'
   "自分の認定なく勝手に買われた", # 'Unauthorized purchase'
  ].each do |sentence|
    Spree::ReturnReason.find_or_create_by!(name: sentence)
  end

  p "add Role data."
  Spree::Role.find_or_create_by!(name: 'admin')

  p "add State data."
  country_japan = Spree::Country.find_by(iso_name: 'JAPAN')
  ["北海道",
   "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
   "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
   "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県",
   "岐阜県", "静岡県", "愛知県", "三重県",
   "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
   "鳥取県", "島根県", "岡山県", "広島県", "山口県",
   "徳島県", "香川県", "愛媛県", "高知県", 
   "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県",
  ].each do |state|
    Spree::State.create!(name: state, country: country_japan)
  end

  p "add Store Credit"
  Spree::StoreCreditCategory.find_or_create_by!(name: Spree.t("store_credit_category.default"))
  Spree::PaymentMethod.find_by(name: "Store Credit").update!(
    name: "ストアクレジット",
    description: "ストアクレジット（返品した品物と同金額分の買い物）"
  )
  Spree::PaymentMethod.create_with(
    name: "銀行振り込み",
    description: "銀行振り込み",
    active: true
  ).find_or_create_by!(
    type: "Spree::PaymentMethod::Check"
  )
  Spree::StoreCreditType.create_with(priority: 1).find_or_create_by!(name: '有効期限付き') # name: 'Expiring'
  Spree::StoreCreditType.create_with(priority: 2).find_or_create_by!(name: '無期限') # name: 'Non-expiring'
  Spree::ReimbursementType.create_with(name: "ストアクレジット（ポイント）").find_or_create_by!(type: 'Spree::ReimbursementType::StoreCredit') # name: "Store Credit"
  Spree::StoreCreditCategory.find_or_create_by!(name: 'ギフトカード') # 'Gift Card' 
  Spree::StoreCreditUpdateReason.find_or_create_by!(name: 'ストアクレジットにエラーがでる') # 'Credit Given In Error'

  p "add Store data."
  Spree::Store.find_or_create_by(code: 'spree') do |s|
    s.code              = 'spree'
    s.name              = 'Spree Demo Site'
    s.url               = 'demo.spreecommerce.com'
    s.mail_from_address = 'spree@example.com'
    s.cart_tax_country_iso = Spree::Config.admin_vat_location
  end

  p "add Zone data."
  asia = Spree::Zone.find_or_create_by!(name: "アジア", description: "アジアの地域を構成している国")
  %w(JP).each do |symbol|
    asia.zone_members.create!(zoneable: Spree::Country.find_by!(iso: symbol))
  end

  p "add Spree::ReimbursementType."
  Spree::ReimbursementType.delete_all
  Spree::ReimbursementType.create!(name: "クレジット", type: "Spree::ReimbursementType::Credit")
  Spree::ReimbursementType.create!(name: "両替", type: "Spree::ReimbursementType::Exchange")
  Spree::ReimbursementType.create!(name: "元と同じ支払い", type: "Spree::ReimbursementType::OriginalPayment")
  Spree::ReimbursementType.create!(name: "ストアクレジット（ポイント）", type: "Spree::ReimbursementType::StoreCredit")

  p "add Spree::RefundReason."
  Spree::RefundReason.delete_all
  Spree::RefundReason.create!(name: "返品処理", mutable: false)
end
