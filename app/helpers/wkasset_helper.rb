module WkassetHelper

	def getRatePerHash(needBlank)
		ratePerHash = { 'h' => l(:label_hourly), 'd' => l(:label_daily), 'm' => l(:label_monthly), 'q' => l(:label_quarterly), 'sa' => l(:label_semi_annually), 'a' => l(:label_annually) }
		if needBlank
			ratePerHash = { '' => "", 'h' => l(:label_hourly), 'd' => l(:label_daily), 'm' => l(:label_monthly), 'q' => l(:label_quarterly), 'sa' => l(:label_semi_annually), 'a' => l(:label_annually) }
		end
		ratePerHash
	end
	
	def getAssetTypeHash(needBlank)
		assetType = { 'O'  => l(:label_own), 'R' =>  l(:label_rental), 'L' => l(:label_lease) }
		if needBlank
			assetType = { '' => "", 'O'  => l(:label_own), 'R' =>  l(:label_rental), 'L' => l(:label_lease) }
		end
		assetType
	end
	
	def getCurrentAssetValue(asset)
		latestDepreciation = WkAssetDepreciation.where(:inventory_item_id => asset.id).order(:depreciation_date =>:desc).first
		if latestDepreciation.blank?
			curVal = asset.asset_property.current_value.blank? ? (asset.cost_price + asset.over_head_price) : asset.asset_property.current_value
		else
			curVal = latestDepreciation.actual_amount - latestDepreciation.depreciation_amount
		end
		curVal
	end
end