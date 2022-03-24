<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
<#if section = "header">
    <div class="text-4xl py-2 font-medium">
        ${msg("emailForgotTitle")}
    <div
    <#elseif section = "form">
        <div class="row">
            <div class="col-12">
                ${msg("emailInstruction")}
            </div>
        </div>
        <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="row mt-4 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <#--                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>-->
                    <label for="username" class="${properties.kcLabelClass!}">${msg("email")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="email"
                           id="username"
                           name="username"
                           class="mandatory-field ${properties.kcInputClass!}"
                           value="${(auth.attemptedUsername!'')}"
                            <#--                           onblur="isRequired(document.getElementById('username'), 'usernameError', 'Email address is required.')"-->
                           onblur="userEmailValidation('username', 'usernameError')"
                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                    <label id="usernameError" class="error-msg"/>
                    <#if messagesPerField.existsError('username')>
                        <span id="input-error-username" class="error-msg ${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
<#--                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}-->
                            Email address is required.
                        </span>
                    </#if>
                </div>
            </div>
            <div class="row mt-3 ${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                <div id="kc-form-buttons" class="col-12 ${properties.kcFormButtonsClass!}">
                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                           type="submit" value="${msg("doSubmitForgotPassword")}"/>
                </div>

                <div id="kc-form-options" class="col-12 mt-3 ${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>
            </div>
        </form>
    <#elseif section = "info" >

    </#if>
    </@layout.registrationLayout>
