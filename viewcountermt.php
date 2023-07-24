<?php

import('lib.pkp.classes.plugins.GenericPlugin');

class viewcountermt extends GenericPlugin {
    public function register($category, $path, $mainContextId = NULL) {
        $success = parent::register($category, $path);
            if ($success && $this->getEnabled()) {
               HookRegistry::register('TemplateResource::getFilename', array($this, '_overridePluginTemplates'));
			   HookRegistry::register('TemplateResource::getFilename', array($this, '_overridearticle_summary'));
    
            }
        return $success;
    }

  /**
   * Provide a name for this plugin
   *
   * The name will appear in the plugins list where editors can
   * enable and disable plugins.
   */
	public function getDisplayName() {
		return __('View counter for Material Theme');
	}

	/**
   * Provide a description for this plugin
   *PluginTemplates
   * The description will appear in the plugins list where editors can
   * enable and disable plugins.
   */
	public function getDescription() {
		return __('Plugin que demonstra a quantidade de acessos e downloads de artigos');
	}
	
	/**
	 * Get the name of the settings file to be installed on new context
	 * creation.
	 * @return string
	 */
	function getContextSpecificPluginSettingsFile() {
		return $this->getPluginPath() . '/settings.xml';
	}

	public function _overridePluginTemplates($hookName, $args) {
		$templatePath = $args[0];
		if ($templatePath === 'plugins/themes/material/templates/frontend/objects/article_details.tpl') {
			$args[0] = 'plugins/generic/viewcountermt/templates/frontend/objects/article_details.tpl';
		}
		return false;
	}

	public function _overridearticle_summary($hookName, $args) {
		$templatePath = $args[0];
		if ($templatePath === 'plugins/themes/material/templates/frontend/objects/article_summary.tpl') {
			$args[0] = 'plugins/generic/viewcountermt/templates/frontend/objects/article_summary.tpl';
		}
		return false;
	}



}
