<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <div class="text-4xl py-2 font-medium">
            ${msg("emailVerifyTitle")}
        </div>
    <#elseif section = "form">
        <div class="my-3 text-md">
            ${msg("emailVerifyInstruction1")}
        </div>
    <#elseif section = "info">
        <div class="mt-4 text-xs">
            ${msg("emailVerifyInstruction2")}
        </div>

        <div id="kc-form-buttons" class="col-12 ${properties.kcFormButtonsClass!}">
            <a href="${url.loginAction}">
                <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                        type="button" value="${msg("doSubmitForgotPassword")}">
                    ${msg("emailVerifyInstruction3")}
                </button>
            </a>
        </div>
    </#if>
</@layout.registrationLayout>