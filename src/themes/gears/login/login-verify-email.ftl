<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
<#--        <p class="instruction">${msg("emailVerifyInstruction1")}</p>-->
    <#elseif section = "info">
        <p class="instruction">
<#--            ${msg("emailVerifyInstruction2")}-->
            <br/>
        <div id="kc-form-buttons" class="col-12 ${properties.kcFormButtonsClass!}">
            <a href="${url.loginAction}">
            <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="button" value="${msg("doSubmitForgotPassword")}">
                ${msg("emailVerifyInstruction3")}
            </button>
            </a>
        </div>
        </p>
    </#if>
</@layout.registrationLayout>