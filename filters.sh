git config --global filter.kony_projectprop.clean "(head -n 1 %f; cat %f | grep attributes | sed /lastmodifiedtime/d | sort --ignore-case; tail -n -1 %f; echo;)"
git config --global filter.kony_projectProperties.clean "jq --indent 4 --sort-keys '.nativeContainerProperties.isModified=false|.nativeContainerProperties.isEnableJSContainer=true|.nativeContainerProperties.isEnableJSContainerAndroid=true|.nativeContainerProperties.isEnableJSContaineriOS=true'"
git config --global filter.kony_forms.clean "jq --indent 4 'del(.device, .prevDevice, .platform, .prevPlatform, .shellCSS, .context.platform, currentLocale)'"
git config --global filter.kony_headless_props.clean 'sed -e "s/\(.*password.*=\).*/\1/"'
git config --global filter.rm_whiteline.clean 'sed -e "s/^[[:blank:]]+$//"'
git config --global filter.kony_fabric_config.clean "jq --indent 4 --sort-keys ."
