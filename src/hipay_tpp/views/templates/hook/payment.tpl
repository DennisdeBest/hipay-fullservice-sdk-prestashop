{*
* 2007-2013 Profileo
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to contact@profileo.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade Profileo to newer
* versions in the future. If you wish to customize Profileo for your
* needs please refer to http://www.profileo.com for more information.
*
*  @author Profileo <contact@profileo.com>
*  @copyright  2007-2013 Profileo
*
*  International Registered Trademark & Property of Profileo
*}
<!--// HiPay_TPP v{$hipay_version} //-->
{if (version_compare($PS_VERSION,'1.6','>'))}
<div class="row">
	<div class="col-xs-12 col-md-6">
		<span id="hipaypayment" style="border: 1px solid rgb(214, 212, 212);background: #fbfbfb;margin-bottom: 10px;width: 100%;">
		{else}
		<span id="hipaypayment" style="">
{/if}
{* Validate if card available for selected currency *}
{if ($card_currency_ok == '1')}
	{* Mode Iframe ou dedicated *}
	{if (($payment_mode == '0') || ($payment_mode == '1' ))}
		{* If allow_memorize is true AND customer has token memorized already *}
		{if ($allow_memorize == 'true')}
			<span class="control-group">
				<p class="payment_module">
				<table>
					<tr>
						<td rowspan="3">
						<span class="hipay_btn"{if (version_compare($PS_VERSION,'1.6','>') && $count_ccards > 3)} style="margin-top: -16px;"{/if}>
								{$btn_image}
						</span>
						</td>
						<td style="text-transform: uppercase;">
							{if (version_compare($PS_VERSION,'1.6','>'))}
								<label class="control-label" style="margin: 0 0 0 5px; font-size: 15px;">{l s='Pay by HiPay' mod='hipay_tpp'} </label>
							{else}
								{l s='Pay by HiPay' mod='hipay_tpp'}
							{/if}
							<br />
						</td>
					</tr>
					<tr>
						<td>
						{if (version_compare($PS_VERSION,'1.6','>'))}
							<span class="controls">
						{else}
							<span class="controls" style="float: left">
						{/if}
						{if ($token_display == 'true')}
							<br />
							<input type="radio" name="cartUseExistingTokenZero" value="0" checked="checked" id="cartUseExistingTokenZero" /> <label class="control-label" for="cartUseExistingTokenZero" style="margin: 0 0 0 5px; font-size: 15px;">{l s='Enter card details' mod='hipay_tpp'}</label>
							<br />
							<input type="radio" name="cartUseExistingTokenZero" value="1" id="cartUseExistingTokenOne" /> <label class="control-label" for="cartUseExistingTokenOne" style="margin: 0 0 0 5px; font-size: 15px;">{l s='Use memorized card' mod='hipay_tpp'}</label>
							<br />
						{else}
							<input type="hidden" name="cartUseExistingTokenZero" value="0" id="cartUseExistingTokenZero" />
						{/if}
						</td>
					</tr>
					<tr>
						<td>
							<span class="enter_card" style="display: block; margin: 0px 0px 0px 0px;">
								<form name="hipay_form" action="{$link->getModuleLink('hipay_tpp', 'payment', [], $hipay_ssl)|escape:'html'}" method="post">
									<input type="hidden" name="payment_product_list_upd" value="{$payment_product_list_upd}">
									<br />
									<input type="checkbox" name="cartMemorizeToken" value="1" checked="checked" id="cartMemorizeToken" /> 
									<label class="control-label" for="cartUseExistingTokenZero" style="margin: 0 0 0 5px; font-size: 15px;">{l s='Memorize card' mod='hipay_tpp'}</label>
									<br />
									<span class="cart_navigation">
										<a class="exclusive" title="{l s='Pay' mod='hipay_tpp'}" href="javascript:void(0);"  id="payHiPay">
											{l s='Pay' mod='hipay_tpp'} »
										</a>
									</span>
									<div id="hipay-loading" style="display:none;"><img src="{$modules_dir}hipay_tpp/img/loading_transparent.gif" /></div>
								</form>
							</span>
							<br />
							{if ($token_display == 'true')}
								<span class="enter_token" style="display:none; margin: 0px 0px 0px 0px;">
									<form enctype="application/x-www-form-urlencoded" class="form-horizontal" action="{$link->getModuleLink('hipay_tpp', 'paymentapi', [], true)|escape:'html'}" method="post" name="tokenizerForm" id="tokenizerForm">
										<span style="margin: 15px 0 0 0;">
											<span id="cardTokenEnabled">
												<span class="control-group">
													<label class="control-label" for="cardToken" style="float:left; margin: 0 49px 0 0; font-size: 15px; font-weight: bold;">{l s='Select your card' mod='hipay_tpp'}: &nbsp;</label>
													<span class="controls" style="float:left;">
														<select size="1" class="input-mini" name="cardToken" id="cardToken">
															<option value="">{l s='Please select your card' mod='hipay_tpp'}</option>
															{foreach $tokens as $key=>$value }
                        										<option value="{$value['token']}" >{$value['brand']} / {$value['pan']}</option>
															{/foreach}
                                						</select>
                            						</span>
                        						</span>
						                        <input type="hidden" class="input-medium" name="cartId" id="cartId" value="{$cart_id}">
						                        <input type="hidden" class="input-medium" name="cartCurrency" id="cartCurrency" value="{$currency}">
						                        <input type="hidden" class="input-medium" name="cartAmount" id="cartAmount" value="{$amount}">
						                        <input type="hidden" value="tokenizerForm" name="tokenizerForm">
						                        <input type="hidden" value="1" name="cartUseExistingToken">
						                        <span style="clear: both;"></span>
                    						</span>
                						</span>
                						<br />
							            <span class="cart_navigation">
							                <a class="exclusive" title="{l s='Pay' mod='hipay_tpp'}" href="javascript:void(0);" id="payHiPay" >
											{l s='Pay' mod='hipay_tpp'} »
							                </a>
							            </span>
										<div id="hipay-loading" style="display:none;"><img src="{$modules_dir}hipay_tpp/img/loading_transparent.gif" /></div>
        							</form>
        						</span>
   								<br />
							{/if}
    					</span>
    					</td>
    				</tr>
    			</table>
    			</p>
			</span>
			<br />
		{else}
		{*} Mode Iframe ou dedicated, mais sans Memorized card activé {*}
			<form name="hipay_form" action="{$link->getModuleLink('hipay_tpp', 'payment', [], $hipay_ssl)|escape:'html'}" method="post">
			    <p class="payment_module">
				    <input type="hidden" name="payment_product_list_upd" value="{$payment_product_list_upd}">
				    <a href="javascript:void(0);" onclick="{literal}$(this).closest('form').submit();{/literal}">
				    	<span class="hipay_btn"{if (version_compare($PS_VERSION,'1.6','>') && $count_ccards > 3)} style="margin-top: -16px;"{/if}>
							{$btn_image}
				    	</span>
						{l s='Pay by HiPay' mod='hipay_tpp'}
				    </a>
			    </p>
			    <input type="hidden" name="cartMemorizeToken" id="cartMemorizeToken" value="0">
			</form>
		{/if}
	{else}
	{*} Mode API uniquement {*}
	    <form name="hipay_form" action="{$link->getModuleLink('hipay_tpp', 'payment', [], $hipay_ssl)|escape:'html'}" method="post">
	        <p class="payment_module">
		        <input type="hidden" name="payment_product_list_upd" value="{$payment_product_list_upd}">
		        <a href="javascript:void(0);" onclick="{literal}$(this).closest('form').submit();{/literal}">
		        	<span class="hipay_btn"{if (version_compare($PS_VERSION,'1.6','>') && $count_ccards > 3)} style="margin-top: -16px;"{/if}>
						{$btn_image}
		            </span>
					{l s='Pay by HiPay' mod='hipay_tpp'}
		        </a>
	        </p>
	    </form>
	{/if}
{/if}
{*} Mode Local cards uniquement {*}
{if ($allow_local_cards == 'true')}
	{foreach $local_cards_list as $key=>$value }
		{if ($show_cards[$value] == 'true')}
	        <span class="control-group payment_module">
	               <form name="hipay_form" action="{$link->getModuleLink('hipay_tpp', 'payment', [], $hipay_ssl)|escape:'html'}" method="post">
	                    <p class="payment_module">
		                    <a href="javascript:void(0);" onclick="{literal}$(this).closest('form').submit();{/literal}">
		                        <img src="{$local_cards_img[$value]}" alt="{l s='Pay by HiPay' mod='hipay_tpp'}" />
								{l s='Pay by' mod='hipay_tpp'} {$local_cards_name[$value]}
		                    </a>
		                    <input type="hidden" name="localcardToken" class="localcardToken" value="{$value}">
	                    </p>
	                </form>
	        </span>
		{/if}
	{/foreach}
{/if}
</span>																																																				
{if (version_compare($PS_VERSION,'1.6','>'))}
	</div>
</div>
{/if}
{literal}
	<script>
		$(document).ready(function() {

			$( "#tokenizerForm" ).submit(function( event ) {
				var selected_token = $('#cardToken option:selected').val();
				if(selected_token.length != 0) {
					return true;
				}else{
					alert('{/literal}{l s='Select your card' mod='hipay_tpp'}{literal}');
					return false;
				}																					
			});					
		
			$('input[name=cartUseExistingTokenZero]').change(function() {
				var cartUseExistingTokenZero = $('input[name=cartUseExistingTokenZero]:checked').val();
				if (cartUseExistingTokenZero == 1) {
					$('.enter_card').hide('fast');
					$('.enter_token').show('fast');
					$('.enter_token').css("display", "inline-block")
				} else {
					$('.enter_token').hide('fast');
					$('.enter_card').show('fast');
				}
			});
			
			$('#payHiPay').on('click', function(){
				$('span.cart_navigation').hide();
				$('#hipay-loading').show();
				submitHiPay(this);
			});
		
		});

		function submitHiPay(obj){
			$(obj).closest('form').submit();
		}
	</script>
{/literal}