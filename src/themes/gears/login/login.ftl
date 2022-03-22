<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form class="g-3 needs-validation" id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post" novalidate>
                        <div class="row my-2 ${properties.kcFormGroupClass!}">
                            <div class="col-12">
                                <label for="username"
                                       class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                            </div>
                            <div class="col-12">
                                <#if usernameEditDisabled??>
                                    <input tabindex="1" id="username" class="${properties.kcInputClass!}"
                                           name="username" value="${(login.username!'')}" type="text" disabled/>
                                <#else>
                                    <input tabindex="1"
                                           id="username"
                                           class="mandatory-field ${properties.kcInputClass!}"
                                           name="username"
                                           value="${(login.username!'')}"
                                           type="text" autofocus
                                           autocomplete="off"
                                           onblur="isRequired(document.getElementById('username'),
                                           'usernameError', 'Username is required.')"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                           required
                                    />
                                    <label id="usernameError" class="error-msg"/>
                                    <div class="invalid-feedback">
                                        Username is required.
                                    </div>
                                    <#if messagesPerField.existsError('username','password')>
                                        <span id="input-error" class="error-msg ${properties.kcInputErrorMessageClass!}"
                                              aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                                    </#if>
                                </#if>
                            </div>
                        </div>

                        <div class="row my-2 ${properties.kcFormGroupClass!}">
                            <div class="col-12">
                                <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                            </div>
                            <div class="col-12">
                                <div class="input-group" id="show_hide_password">
                                    <input tabindex="2"
                                           id="password"
                                           class="mandatory-field ${properties.kcInputClass!}"
                                           name="password"
                                           type="password" autocomplete="off"
                                           onblur="isRequired(document.getElementById('password'),
                                           'passwordError', 'Password is required.')"
                                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                           required/>
                                    <a class="eye-icon" href=""><i class="fa fa-eye-slash" aria-hidden="true"></i></a>
                                </div>
                                <label id="passwordError" class="error-msg"/>
                                <div class="invalid-feedback">
                                    Password is required.
                                </div>
                            </div>
                        </div>

                        <div class="row my-2 ${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div class="col-6" id="kc-form-options">
                                <#if realm.rememberMe && !usernameEditDisabled??>
                                    <div class="checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                                                       checked class="inpt-w-auto"> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                                                       class="inpt-w-auto"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                            </div>
                            <div class="col-6 text-end ${properties.kcFormOptionsWrapperClass!}">
                                <#if realm.resetPasswordAllowed>
                                    <span><a tabindex="5" href="${url.loginResetCredentialsUrl}"
                                             class="fgt-pwd">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>
                        </div>

                        <div id="kc-form-buttons" class="row my-2 ${properties.kcFormGroupClass!}">
                            <div class="col-12">
                                <input type="hidden" id="id-hidden-input" name="credentialId"
                                       <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                                <input tabindex="4"
                                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                                       name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                            </div>
                        </div>
                    </form>
                </#if>
            </div>

            <#if realm.password && social.providers??>
                <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                    <hr/>
                    <h4>${msg("identity-provider-login-label")}</h4>

                    <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                        <#list social.providers as p>
                            <a id="social-${p.alias}"
                               class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                               type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </#list>
                    </ul>
                </div>
            </#if>

            <div class="toast position-fixed bottom-0 end-0 m-5 p-1 align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        Account has been created.
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>

        </div>
    <#elseif section = "info" >
    </#if>

</@layout.registrationLayout>
