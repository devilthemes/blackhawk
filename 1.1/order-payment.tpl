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

{if !$opc}
	<script type="text/javascript">
	// <![CDATA[
	var currencySign = '{$currencySign|html_entity_decode:2:"UTF-8"}';
	var currencyRate = '{$currencyRate|floatval}';
	var currencyFormat = '{$currencyFormat|intval}';
	var currencyBlank = '{$currencyBlank|intval}';
	var txtProduct = "{l s='product'}";
	var txtProducts = "{l s='products'}";
	// ]]>
	</script>

	{capture name=path}{l s='Your payment method'}{/capture}
	{include file="$tpl_dir./breadcrumb.tpl"}
{/if}

{if !$opc}<h1 class="paymentmethod">{l s='Choose your paymentmethod'}</h1>{else}<h2 class="paymentmethod"><span>3</span> {l s='Choose your payment method'}</h2>{/if}

{if !$opc}
	{assign var='current_step' value='payment'}
	{include file="$tpl_dir./order-steps.tpl"}

	{include file="$tpl_dir./errors.tpl"}
{else}
	<div id="opc_payment_methods" class="opc-main-block">
		<div id="opc_payment_methods-overlay" class="opc-overlay" style="display: none;"></div>
{/if}

<div class="paiement_block">

<div id="HOOK_TOP_PAYMENT">{$HOOK_TOP_PAYMENT}</div>

{if $HOOK_PAYMENT}
	{if !$opc}
<div id="order-detail-content" class="table_block">
	<div id="cart_summary" class="std">
		
		<ul class="thead row">
			
				<li class="cart_product first_item onecol"><div class="gap">{l s='Product'}</div></li>
				<li class="cart_description item fourcol"><div class="gap">{l s='Description'}</div></li>
				<li class="cart_unit item twocol"><div class="gap">{l s='Unit price'}</div></li>
				<li class="cart_quantity item threecol"><div class="gap">{l s='Qty'}</div></li>
				<li class="cart_total last_item twocol last"><div class="gap">{l s='Total'}</div></li>
			
		</ul>
		
		
		<ul class="tbody tbody1 row">
		{foreach from=$products item=product name=productLoop}
			<li class="cart_item">
			{assign var='productId' value=$product.id_product}
			{assign var='productAttributeId' value=$product.id_product_attribute}
			{assign var='quantityDisplayed' value=0}
			{assign var='cannotModify' value=1}
			{assign var='odd' value=$product@iteration%2}
			{assign var='noDeleteButton' value=1}
			{* Display the product line *}
			{include file="$tpl_dir./shopping-cart-product-line.tpl"}
			{* Then the customized datas ones*}
			{if isset($customizedDatas.$productId.$productAttributeId)}
				{foreach from=$customizedDatas.$productId.$productAttributeId[$product.id_address_delivery] key='id_customization' item='customization'}
					<ul id="product_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}" class="alternate_item cart   row">
						
							
							<li >
								{foreach from=$customization.datas key='type' item='datas'}
									{if $type == $CUSTOMIZE_FILE}
										<div class="customizationUploaded">
											<ul class="customizationUploaded">
												{foreach from=$datas item='picture'}
													<li>
														<img src="{$pic_dir}{$picture.value}_small" alt="" class="customizationUploaded" />
													</li>
												{/foreach}
											</ul>
										</div>
									{elseif $type == $CUSTOMIZE_TEXTFIELD}
										<ul class="typedText">
											{foreach from=$datas item='textField' name='typedText'}
												<li>
													{if $textField.name}
														{l s='%s:' sprintf=$textField.name}
													{else}
														{l s='Text #%s:' sprintf=$smarty.foreach.typedText.index+1}
													{/if}
													{$textField.value}
												</li>
											{/foreach}
										</ul>
									{/if}
								{/foreach}
							</li>
							<li class="cart_quantity">
								{if isset($cannotModify) AND $cannotModify == 1}
									<span style="float:left">{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}</span>
								{else}
									<div style="float:right">
										<a rel="nofollow" class="cart_quantity_delete" id="{$product.id_product}_{$product.id_product_attribute}_{$id_customization}" href="{$link->getPageLink('cart', true, NULL, "delete&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;token={$token_cart}")}"><img src="{$img_dir}icon/delete.gif" alt="{l s='Delete'}" title="{l s='Delete this customization'}" width="11" height="13" class="icon" /></a>
									</div>
									<div id="cart_quantity_button" style="float:left">
									<a rel="nofollow" class="cart_quantity_up" id="cart_quantity_up_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}" href="{$link->getPageLink('cart', true, NULL, "add&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;token={$token_cart}")}" title="{l s='Add'}"><img src="{$img_dir}icon/quantity_up.gif" alt="{l s='Add'}" width="14" height="9" /></a><br />
									{if $product.minimal_quantity < ($customization.quantity -$quantityDisplayed) OR $product.minimal_quantity <= 1}
									<a rel="nofollow" class="cart_quantity_down" id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}" href="{$link->getPageLink('cart', true, NULL, "add&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;op=down&amp;token={$token_cart}")}" title="{l s='Subtract'}">
										<img src="{$img_dir}icon/quantity_down.gif" alt="{l s='Subtract'}" width="14" height="9" />
									</a>
									{else}
									<a class="cart_quantity_down" style="opacity: 0.3;" id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}" href="#" title="{l s='Subtract'}">
										<img src="{$img_dir}icon/quantity_down.gif" alt="{l s='Subtract'}" width="14" height="9" />
									</a>
									{/if}
									</div>
									<input type="hidden" value="{$customization.quantity}" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_hidden"/>
									<input size="2" type="text" value="{$customization.quantity}" class="cart_quantity_input" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}"/>
								{/if}
							</li>
							<li class="cart_total"></li>
						</ul>
					
					{assign var='quantityDisplayed' value=$quantityDisplayed+$customization.quantity}
				{/foreach}
				{* If it exists also some uncustomized products *}
				{if $product.quantity-$quantityDisplayed > 0}{include file="$tpl_dir./shopping-cart-product-line.tpl"}{/if}
			{/if}
			</li>
		{/foreach}
		{assign var='last_was_odd' value=$product@iteration%2}
		{foreach $gift_products as $product}
			{assign var='productId' value=$product.id_product}
			{assign var='productAttributeId' value=$product.id_product_attribute}
			{assign var='quantityDisplayed' value=0}
			{assign var='odd' value=($product@iteration+$last_was_odd)%2}
			{assign var='ignoreProductLast' value=isset($customizedDatas.$productId.$productAttributeId)}
			{assign var='cannotModify' value=1}
			{* Display the gift product line *}
			{include file="./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
		{/foreach}
		</ul>
		<ul class="tfoot">
			{if $use_taxes}
				{if $priceDisplay}
					<li class="cart_total_price">
						<div class="tencol"><div class="gap">{if $display_tax_label}{l s='Total products (tax excl.):'}{else}{l s='Total products:'}{/if}</div></div>
						<div class="price twocol last" id="total_product"><div class="gap">{displayPrice price=$total_products}</div></div>
					</li>
				{else}
					<li class="cart_total_price">
						<div class="tencol"><div class="gap">{if $display_tax_label}{l s='Total products (tax incl.):'}{else}{l s='Total products:'}{/if}</div></div>
						<div class="price  twocol last" id="total_product"><div class="gap">{displayPrice price=$total_products_wt}</div></div>
					</li>
				{/if}
			{else}
				<li class="cart_total_price">
					<div class="tencol"><div class="gap">{l s='Total products:'}</div></div>
					<div class="price twocol last" id="total_product"><div class="gap">{displayPrice price=$total_products}</div></div>
				</li>
			{/if}
			<li class="cart_total_voucher" {if $total_discounts == 0}style="display: none;"{/if}>
				<div class="tencol"><div class="gap">
				{if $use_taxes}
					{if $priceDisplay}
						{if $display_tax_label}{l s='Total vouchers (tax excl.):'}{else}{l s='Total vouchers:'}{/if}
					{else}
						{if $display_tax_label}{l s='Total vouchers (tax incl.):'}{else}{l s='Total vouchers:'}{/if}
					{/if}
				{else}
					{l s='Total vouchers:'}
				{/if}
				</div></div>
				<div class="price-discount price twocol last" id="total_discount">
				<div class="gap">
				{if $use_taxes}
					{if $priceDisplay}
						{displayPrice price=$total_discounts_tax_exc}
					{else}
						{displayPrice price=$total_discounts}
					{/if}
				{else}
					{displayPrice price=$total_discounts_tax_exc}
				{/if}
				</div></div>
			</li>
			<li class="cart_total_voucher" {if $total_wrapping == 0}style="display: none;"{/if}>
				<div class="tencol"><div class="gap">
				{if $use_taxes}
					{if $priceDisplay}
						{if $display_tax_label}{l s='Total gift-wrapping (tax excl.):'}{else}{l s='Total gift-wrapping:'}{/if}
					{else}
						{if $display_tax_label}{l s='Total gift-wrapping (tax incl.):'}{else}{l s='Total gift-wrapping:'}{/if}
					{/if}
				{else}
					{l s='Total gift-wrapping:'}
				{/if}
				</div></div>
				<div class="price-discount price  twocol last" id="total_wrapping">
				<div class="gap">
				{if $use_taxes}
					{if $priceDisplay}
						{displayPrice price=$total_wrapping_tax_exc}
					{else}
						{displayPrice price=$total_wrapping}
					{/if}
				{else}
					{displayPrice price=$total_wrapping_tax_exc}
				{/if}
				</div></div>
			</li>
			{if $total_shipping_tax_exc <= 0 && !isset($virtualCart)}
				<li class="cart_total_delivery">
					<div class="tencol"><div class="gap">{l s='Shipping:'}</div></div>
					<div class="price twocol last" id="total_shipping"><div class="gap">{l s='Free Shipping!'}</div></div>
				</li>
			{else}
				{if $use_taxes}
					{if $priceDisplay}
						<li class="cart_total_delivery" {if $shippingCost <= 0} style="display:none;"{/if}>
							<div class="tencol"><div class="gap">{if $display_tax_label}{l s='Total shipping (tax excl.):'}{else}{l s='Total shipping:'}{/if}</div></div>
							<div class="price twocol last" id="total_shipping"><div class="gap">{displayPrice price=$shippingCostTaxExc}</div></div>
						</li>
					{else}
						<li class="cart_total_delivery"{if $shippingCost <= 0} style="display:none;"{/if}>
							<div class="tencol"><div class="gap">{if $display_tax_label}{l s='Total shipping (tax incl.):'}{else}{l s='Total shipping:'}{/if}</div></div>
							<div class="price twocol last" id="total_shipping" ><div class="gap">{displayPrice price=$shippingCost}</div></div>
						</li>
					{/if}
				{else}
					<li class="cart_total_delivery"{if $shippingCost <= 0} style="display:none;"{/if}>
						<div class="tencol"><div class="gap">{l s='Total shipping:'}</div></div>
						<div class="price twocol last" id="total_shipping" ><div class="gap">{displayPrice price=$shippingCostTaxExc}</div></div>
					</li>
				{/if}
			{/if}

			{if $use_taxes}
				
				{if $voucherAllowed}
				<li class="price twelvecol">
				<div  id="cart_voucher" class="cart_voucher">
					{if isset($errors_discount) && $errors_discount}
						<ul class="error">
						{foreach from=$errors_discount key=k item=error}
							<li>{$error|escape:'htmlall':'UTF-8'}</li>
						{/foreach}
						</ul>
					{/if}
				</div>
				</li>
				{/if}
				
				<li class="price total_price_container twocol last" id="total_price_container">
					<div class="tencol ">
						<div class="gap">{l s='Total:'}</div>
					</div>
					<div class="twocol last">
						<div class="gap">{displayPrice price=$total_price}</div>
					</div>
				</li>
			
			{else}
			
				<li  id="cart_voucher tencol" class="cart_voucher">
				<div class="gap">
				{if $voucherAllowed}
				<div id="cart_voucher" class="table_block">
					{if isset($errors_discount) && $errors_discount}
						<ul class="error">
						{foreach from=$errors_discount key=k item=error}
							<li>{$error|escape:'htmlall':'UTF-8'}</li>
						{/foreach}
						</ul>
					{/if}
					{if $voucherAllowed}
					<form action="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}" method="post" id="voucher">
						<fieldset>
							<h4><label for="discount_name">{l s='Vouchers'}</label></h4>
							<p>
								<input type="text" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}" />
							</p>
							<p class="submit"><input type="hidden" name="submitDiscount" /><input type="submit" name="submitAddDiscount" value="{l s='ok'}" class="button" /></p>
						{if $displayVouchers}
							<h4 class="title_offers">{l s='Take advantage of our offers:'}</h4>
							<div id="display_cart_vouchers">
							{foreach from=$displayVouchers item=voucher}
								<span onclick="$('#discount_name').val('{$voucher.name}');return false;" class="voucher_name">{$voucher.name}</span> - {$voucher.description} <br />
							{/foreach}
							</div>
						{/if}
						</fieldset>
					</form>
					{/if}
				</div>
				{/if}
				</li>
				
				<li  class=" price total_price_container" id="total_price_container">
					
					<div class="telcol"><div class="gap">{l s='Total:'}</div></div>
					<div id="total_price" class="twocol last">{displayPrice price=$total_price_without_tax}</div></div>
				</li>
			
			{/if}
		</ul><!-- tfoot end -->
	{if count($discounts)}
		<ul clas="tbody">
		{foreach from=$discounts item=discount name=discountLoop}
			<li class="cart_discount {if $smarty.foreach.discountLoop.last}last_item{elseif $smarty.foreach.discountLoop.first}first_item{else}item{/if}" id="cart_discount_{$discount.id_discount}">
				<ul class="cart_item row">
					<li class="cart_discount_name"><div class="gap">{$discount.name}</div></li>
					<li class="cart_discount_description" colspan="3"><div class="gap">{$discount.description}</div></li>
					<li class="cart_discount_price"><div class="gap">
						<span class="price-discount">
							{if $discount.value_real > 0}
								{if !$priceDisplay}
									{displayPrice price=$discount.value_real*-1}
								{else}
									{displayPrice price=$discount.value_tax_exc*-1}
								{/if}
							{/if}
						</span></div>
					</li>
				</ul>
			</li>
		{/foreach}
		</ul><!-- tbody end -->
	{/if}
	</div><!-- cart_summary end -->
</div>
{/if}
	{if $opc}<div id="opc_payment_methods-content">{/if}
		<div id="HOOK_PAYMENT">{$HOOK_PAYMENT}</div>
	{if $opc}</div>{/if}
{else}
	<p class="warning">{l s='No payment modules have been installed.'}</p>
{/if}

{if !$opc}
	<p class="cart_navigation"><a href="{$link->getPageLink('order', true, NULL, "step=2")}" title="{l s='Previous'}" class="button">&laquo; {l s='Previous'}</a></p>
{else}
	</div>
{/if}
</div>
