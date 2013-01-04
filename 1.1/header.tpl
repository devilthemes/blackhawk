{*
* 2007-2012 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2012 PrestaShop SA
*  @version  Release: $Revision: 6594 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

	
	<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="{$lang_iso}"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="{$lang_iso}"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="{$lang_iso}"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="{$lang_iso}"> <!--<![endif]-->
<head>
	
	
		<title>{$meta_title|escape:'htmlall':'UTF-8'}</title>
{if isset($meta_description) AND $meta_description}
		<meta name="description" content="{$meta_description|escape:html:'UTF-8'}" />
{/if}
{if isset($meta_keywords) AND $meta_keywords}
		<meta name="keywords" content="{$meta_keywords|escape:html:'UTF-8'}" />
{/if}
		<meta charset="utf-8">
		
		<meta name="generator" content="PrestaShop" />
		<meta name="robots" content="{if isset($nobots)}no{/if}index,{if isset($nofollow) && $nofollow}no{/if}follow" />
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$favicon_url}?{$img_update_time}" />
		<link rel="shortcut icon" type="image/x-icon" href="{$favicon_url}?{$img_update_time}" />
		<script type="text/javascript">
			var baseDir = '{$content_dir}';
			var baseUri = '{$base_uri}';
			var static_token = '{$static_token}';
			var token = '{$token}';
			var priceDisplayPrecision = {$priceDisplayPrecision*$currency->decimals};
			var priceDisplayMethod = {$priceDisplay};
			var roundMode = {$roundMode};
		</script>
		<link rel="stylesheet" href="{$css_dir}base.css" />
{if isset($css_files)}
	{foreach from=$css_files key=css_uri item=media}
		
	<link href="{$css_uri}" rel="stylesheet"  media="{$media}" />
	{/foreach}
{/if}


{if isset($js_files)}
	{foreach from=$js_files item=js_uri  }
	
	
	
		<script type="text/javascript" src="{$js_uri}" ></script>
	
	
	{/foreach}
{/if}
<!--[if lt IE 9]>
		<script src="{$js_dir}html5.js"></script>
	<![endif]-->


		{$HOOK_HEADER}
			<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="{$css_dir}layout.css" />
	
	</head>
	<body {if isset($page_name)}id="{$page_name|escape:'htmlall':'UTF-8'}"{/if} class="{if $hide_left_column}hide-left-column{/if} {if $hide_right_column}hide-right-column{/if}">
	{if !$content_only}
		{if isset($restricted_country_mode) && $restricted_country_mode}
		<div id="restricted-country">
			<p>{l s='You cannot place a new order from your country.'} <span class="bold">{$geolocation_country}</span></p>
		</div>
		{/if}
		<div id="page" class=" clearfix page loading">

			<!-- Header -->
			<div id="header" class="header container  ">
				<div class="headerInner sixteen columns">
				<a id="header_logo" href="{$base_dir}" title="{$shop_name|escape:'htmlall':'UTF-8'}">
					<img class="logo" src="{$logo_url}" alt="{$shop_name|escape:'htmlall':'UTF-8'}" {if $logo_image_width}width="{$logo_image_width}"{/if} {if $logo_image_height}height="{$logo_image_height}" {/if} />
				</a>
				
					{$HOOK_TOP}
				</div>
			</div>
			{if $page_name =='index'}
			<div class="homeBlock">{$HOOK_HOME}</div>
			{/if}
		
		<div id="columns" class="content  clearfix">
				<div class="container columnsInner">
				
		

				
				<!-- Center -->
			{if $page_name =='category' OR $page_name =='product' OR $page_name =='products-comparison'  }
				<div id="center_column" class="twelve columns">
				{else}
				<div id="center_column" class="sixteen columns">
				{/if}
				
				
				
	{/if}
