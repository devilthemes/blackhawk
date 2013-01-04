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
*  @version  Release: $Revision: 14973 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<!-- Module HomeSlider -->
{if isset($homeslider)}
<link rel="stylesheet" href="{$css_dir}flexslider.css" type="text/css" media="screen" />
<script src="{$js_dir}modernizr.js"></script>
	<script  src="{$js_dir}jquery.flexslider-min.js"></script>
   
  <script type="text/javascript" src="{$js_dir}shCore.js"></script>
  <script type="text/javascript" src="{$js_dir}shBrushXml.js"></script>
  <script type="text/javascript" src="{$js_dir}shBrushJScript.js"></script>
  
  <!-- Optional FlexSlider Additions -->
  <script src="{$js_dir}jquery.easing.js"></script>
  <script src="{$js_dir}jquery.mousewheel.js"></script>
  <script defer src="{$js_dir}demo.js"></script>
  
<script type="text/javascript">
{if isset($homeslider_slides) && $homeslider_slides|@count > 1}
	{if $homeslider.loop == 1}
		var homeslider_loop = true;
	{else}
		var homeslider_loop = false;
	{/if}
{else}
	var homeslider_loop = false;
{/if}
var homeslider_speed = {$homeslider.speed};
var homeslider_pause = {$homeslider.pause};
</script>
{/if}
{if isset($homeslider_slides)}
<div class="frontBanner ">
				<div class="container">
					 <div class="flexslider sixteen columns">
						<ul class="slides">

{foreach from=$homeslider_slides item=slide}
	{if $slide.active}
		<li><a href="{$slide.url}" title="{$slide.description}"><img src="{$smarty.const._MODULE_DIR_}/homeslider/images/{$slide.image}" alt="{$slide.legend}" title="{$slide.description}" height="{$homeslider.height}" width="{$homeslider.width}" /></a></li>
	{/if}
{/foreach}
</ul>
</div>
</div>
</div>
{/if}
<!-- /Module HomeSlider -->
