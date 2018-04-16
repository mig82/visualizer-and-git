git config --global filter.kony_projectprop.clean "(head -n 1 projectprop.xml; cat projectprop.xml | grep attributes | sed /lastmodifiedtime/d | sort --ignore-case; tail -n -1 projectprop.xml;)"
git config --global filter.kony_projectProperties.clean "jq --indent 4 --sort-keys '.nativeContainerProperties.isModified=false|.nativeContainerProperties.isEnableJSContainer=true|.nativeContainerProperties.isEnableJSContainerAndroid=true|.nativeContainerProperties.isEnableJSContaineriOS=true'"
git config --global filter.kony_forms.clean "jq --indent 4 'del(.device, .prevDevice, .platform, .prevPlatform, .shellCSS, .context.platform)'"
git config --global filter.kony_headless_props.clean 'sed -e "s/\(.*password.*=\).*/\1/"'
