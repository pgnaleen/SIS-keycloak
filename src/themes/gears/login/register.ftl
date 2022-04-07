<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        <div class="text-4xl py-2 font-medium">
            ${msg("registerTitle")}
        <div
    <#elseif section = "form">
        <div class="row my-2 ${properties.kcFormGroupClass!}">
            <div id="kc-form-options" class="col-12 ${properties.kcFormOptionsClass!}">
                <div class="${properties.kcFormOptionsWrapperClass!}">
                    <span>Already have an account? <a
                                href="${url.loginUrl}">${kcSanitize(msg("signIn"))?no_esc}</a></span>
                </div>
            </div>
        </div>
        <form id="kc-register-form"
              class="g-3 needs-validation ${properties.kcFormClass!} ${properties.gearsFormClass!}"
              action="${url.registrationAction}" method="post"
              onsubmit=registerOnAdmission("${properties.adminServiceUrl!}","${realm.name!}")
              novalidate>
            <div class="row my-2">
                <div class="col-6 ${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('nameTitle',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="nameTitle" class="${properties.kcLabelClass!}">${msg("nameTitle")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select
                                id="user.attributes.nameTitle"
                                class="mandatory-field ${properties.kcInputClass!}"
                                name="user.attributes.nameTitle"
                                value="${(register.formData['user.attributes.nameTitle']!'')}"
                                required>
                            <div class="invalid-feedback">
                                Name Title is required.
                            </div>
                        </select>
                    </div>
                </div>

                <div class="col-6 ${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('gender',properties.kcFormGroupErrorClass!)}">
                    <div class=" ${properties.kcLabelWrapperClass!}">
                        <label for="gender" class="${properties.kcLabelClass!}">${msg("gender")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select
                                id="user.attributes.gender"
                                class="mandatory-field ${properties.kcInputClass!}"
                                name="user.attributes.gender"
                                value="${(register.formData['user.attributes.gender']!'')}"
                                required>
                        </select>
                        <div class="invalid-feedback">
                            Gender is required.
                        </div>
                    </div>
                </div>

            </div>



            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.firstName"
                           class="mandatory-field ${properties.kcInputClass!}"
                           name="user.attributes.firstName"
                           autocomplete="user.attributes.firstName"
                           maxlength="30"
                           onchange="createFullName()"
                           onblur="isRequired(document.getElementById('user.attributes.firstName'),
                                           'firstNameError', 'First name is required.')"
                           aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                           required/>
                    <#--                    this bootstrap error message should be at right next to input element-->
                    <div class="invalid-feedback">
                        First Name is required.
                    </div>
                    <label id="firstNameError" class="error-msg"/>

                    <#if messagesPerField.existsError('firstName')>
                        <span id="input-error-fullname" class="error-msg ${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                        ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                    </span>
                    </#if>
                </div>
            </div>


            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.middleName" class="${properties.kcLabelClass!}">${msg("middleName")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.middleName"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.middleName"
                           autocomplete="user.attributes.middleName"
                           maxlength="30"
                           onchange="createFullName()"/>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.thirdName" class="${properties.kcLabelClass!}">${msg("thirdName")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.thirdName"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.thirdName"
                           autocomplete="user.attributes.thirdName"
                           maxlength="30"
                           onchange="createFullName()"/>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.familyName" class="${properties.kcLabelClass!}">${msg("familyName")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.familyName"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.familyName"
                           autocomplete="user.attributes.familyName"
                           maxlength="30"
                           onchange="createFullName()"/>
                </div>
            </div>


            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.fullName" class="${properties.kcLabelClass!}">${msg("fullName")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.fullName"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.fullName"
                           autocomplete="user.attributes.fullName"
                           maxlength="100"/>
                </div>
            </div>



            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.firstName2L" class="${properties.kcLabelClass!}">${msg("firstName2L")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.firstName2L"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.firstName2L"
                           autocomplete="user.attributes.firstName2L"
                           maxlength="30"
                           onchange="createFullName2L()"/>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.middleName2L" class="${properties.kcLabelClass!}">${msg("middleName2L")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.middleName2L"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.middleName2L"
                           autocomplete="user.attributes.middleName2L"
                           maxlength="30"
                           onchange="createFullName2L()"/>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.thirdName2L" class="${properties.kcLabelClass!}">${msg("thirdName2L")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.thirdName2L"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.thirdName2L"
                           autocomplete="user.attributes.thirdName2L"
                           maxlength="30"
                           onchange="createFullName2L()"/>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.familyName2L" class="${properties.kcLabelClass!}">${msg("familyName2L")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.familyName2L"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.familyName2L"
                           autocomplete="user.attributes.familyName2L"
                           maxlength="30"
                           onchange="createFullName2L()"/>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.fullName2L" class="${properties.kcLabelClass!}">${msg("fullName2L")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.fullName2L"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.fullName2L"
                           autocomplete="user.attributes.fullName2L"
                           maxlength="100"/>
                </div>
            </div>



            <div class="row my-2">
                <div class="col-6 form-group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.dob"
                               class="${properties.kcLabelClass!}">${msg("dob")}</label>
                    </div>

                    <div id="dobDatePicker" class="input-group date ${properties.kcInputWrapperClass!}">
                        <input type="text"
                               class="mandatory-field form-control ${properties.kcInputClass!}"
                               id="user.attributes.dob"
                               name="user.attributes.dob"
                               value="${(register.formData['user.attributes.dob']!'')}"
                               onblur="validateDate(document.getElementById('user.attributes.dob'))"
                               required/>
                        <span class="input-group-append">
                            <span class="input-group-text bg-white">
                                <i class="fa fa-calendar p-1"
                                   onblur="validateDate(document.getElementById('user.attributes.dob'))"></i>
                            </span>
                        </span>
                        <#-- this bootstrap validation not align properly. so added manual error here. that need to be emptied as well-->
                        <#--                        <div class="invalid-feedback">-->
                        <#--                            Date of Birth is required.-->
                        <#--                        </div>-->

                    </div>
                    <label id="registerDatePicker" class="error-msg"/>
                </div>

                <div class="col-6 ${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.nationality"
                               class="${properties.kcLabelClass!}">${msg("nationality")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select
                                id="user.attributes.nationality"
                                class="mandatory-field ${properties.kcInputClass!}"
                                name="user.attributes.nationality"
                                value="${(register.formData['user.attributes.nationality']!'')}"
                                required>
                        </select>
                        <div class="invalid-feedback">
                            Nationality is required.
                        </div>

                        <#if messagesPerField.existsError('nationality')>
                            <span id="input-error-nationality" class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                        ${kcSanitize(messagesPerField.get('nationality'))?no_esc}
                    </span>
                        </#if>
                    </div>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.contactNumber"
                           class="${properties.kcLabelClass!}">${msg("contactNumber")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text"
                           id="user.attributes.contactNumber"
                           class="mandatory-field ${properties.kcInputClass!}"
                           name="user.attributes.contactNumber"
                           maxlength="20"
                           value="${(register.formData['user.attributes.contactNumber']!'')}"
                           onblur="validatePhoneNumber(document.getElementById('user.attributes.contactNumber'),
                                                            'contactNumberError')"
                           aria-invalid="<#if messagesPerField.existsError('contactNumber')>true</#if>"
                           required/>
                    <div class="invalid-feedback">
                        Contact Number is required.
                    </div>
                    <label id="contactNumberError" class="error-msg"/>

                    <#if messagesPerField.existsError('contactNumber')>
                        <span id="input-error-contact-number" class="${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                        ${kcSanitize(messagesPerField.get('contactNumber'))?no_esc}
                    </span>
                    </#if>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.address" class="${properties.kcLabelClass!}">${msg("address")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text"
                           id="user.attributes.address"
                           class="${properties.kcInputClass!}"
                           name="user.attributes.address"
                           value="${(register.formData['user.attributes.address']!'')}"
                           maxlength="1000"
                           aria-invalid="<#if messagesPerField.existsError('address')>true</#if>"/>
                    <div class="invalid-feedback">
                        Address is required.
                    </div>
                    <#if messagesPerField.existsError('address')>
                        <span id="input-error-address" class="${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                        ${kcSanitize(messagesPerField.get('address'))?no_esc}
                    </span>
                    </#if>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('country',properties.kcFormGroupErrorClass!)}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="country" class="${properties.kcLabelClass!}">${msg("country")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <select
                            id="user.attributes.country"
                            class="mandatory-field ${properties.kcInputClass!}"
                            name="user.attributes.country"
                            value="${(register.formData['user.attributes.country']!'')}"
                            required>
                    </select>
                    <div class="invalid-feedback">
                        Country is required.
                    </div>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="email"
                           id="email"
                           class="mandatory-field ${properties.kcInputClass!}"
                           name="email"
                           value="${(register.formData.email!'')}"
                           autocomplete="email"
                           maxlength="30"
                           aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                           onblur="userEmailValidation('email','emailError')"
                           required/>
                    <div class="invalid-feedback">
                        Valid Email is required.
                    </div>
                    <label id="emailError" class="error-msg"></label>

                    <#if messagesPerField.existsError('email')>
                        <span id="input-error-email" class="error-msg ${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                        ${kcSanitize(messagesPerField.get('email'))?no_esc}
                    </span>
                    </#if>
                </div>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="row my-2 ${properties.kcFormGroupClass!}">
                    <div class="col-12 ${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                    </div>
                    <div class="col-12 ${properties.kcInputWrapperClass!}">
                        <input type="text" id="username"
                               class="mandatory-field ${properties.kcInputClass!}"
                               name="username"
                               value="${(register.formData.username!'')}"
                               autocomplete="username"
                               maxlength="30"
                               onblur="usernameValidation(document.getElementById('username'), 'usernameError')"
                               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                               required/>
                        <div class="invalid-feedback">
                            Username is required.
                        </div>
                        <label id="usernameError" class="error-msg"/>

                        <#if messagesPerField.existsError('username')>
                            <span id="input-error-username" class="error-msg ${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                            ${kcSanitize(messagesPerField.get('username'))?no_esc}
                        </span>
                        </#if>
                    </div>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="row my-2 ${properties.kcFormGroupClass!}">
                    <div class="col-12 ${properties.kcLabelWrapperClass!}">
                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    </div>
                    <div class="col-12 ${properties.kcInputWrapperClass!}">
                        <#--                        <div class="input-group" id="show_hide_password">-->
                        <input type="password"
                               id="password"
                               class="mandatory-field ${properties.kcInputClass!}"
                               name="password"
                               autocomplete="new-password"
                               maxlength="30"
                               onblur="passwordValidation(document.getElementById('password'), 'passwordError')"
                               aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                               required/>
                        <a id="show_hide_password" class="eye-icon" href=""><i class="fa fa-eye-slash"
                                                                               aria-hidden="true"></i></a>
                        <#--                        </div>-->
                        <div class="invalid-feedback">
                            Password is required.
                        </div>
                    </div>
                    <label id="passwordError" class="error-msg"/>

                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="error-msg ${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
                    </#if>
                </div>

                <div class="row my-2 ${properties.kcFormGroupClass!}">
                    <div class="col-12 ${properties.kcLabelWrapperClass!}">
                        <label for="password-confirm"
                               class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                    </div>
                    <div class="col-12 ${properties.kcInputWrapperClass!}">
                        <#--                        <div class="input-group" id="">-->
                        <input type="password"
                               id="password-confirm"
                               class="mandatory-field ${properties.kcInputClass!}"
                               name="password-confirm"
                               maxlength="30"
                               onblur="confirmPasswordMatch('password','password-confirm', 'passwordConfirmError')"
                               aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                               required/>
                        <a id="show_hide_confirm_password" class="eye-icon" href=""><i class="fa fa-eye-slash"
                                                                                       aria-hidden="true"></i></a>
                        <div class="invalid-feedback">
                            Confirm Password is required.
                        </div>
                        <#--                        </div>-->
                    </div>
                    <label id="passwordConfirmError" class="error-msg"/>

                    <#if messagesPerField.existsError('password-confirm')>
                        <span id="input-error-password-confirm"
                              class="error-msg ${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                    </#if>

                </div>
            </#if>

            <div class="row my-2">
                <div class="col-6 ${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('maritalStatus',properties.kcFormGroupErrorClass!)}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.maritalStatus"
                               class="${properties.kcLabelClass!}">${msg("maritalStatus")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select
                                id="user.attributes.maritalStatus"
                                class="mandatory-field ${properties.kcInputClass!}"
                                name="user.attributes.maritalStatus"
                                value="${(register.formData['user.attributes.maritalStatus']!'')}"
                                required>
                        </select>
                        <div class="invalid-feedback">
                            Marital Status is required.
                        </div>
                    </div>
                </div>

                <div class="col-6 ${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.religion"
                               class="${properties.kcLabelClass!}">${msg("religion")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select
                                id="user.attributes.religion"
                                class="mandatory-field ${properties.kcInputClass!}"
                                name="user.attributes.religion"
                                value="${(register.formData['user.attributes.religion']!'')}"
                                aria-invalid="<#if messagesPerField.existsError('religion')>true</#if>"
                                required>
                        </select>
                        <div class="invalid-feedback">
                            Religion is required.
                        </div>
                        <#if messagesPerField.existsError('religion')>
                            <span id="input-error-religion" class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                        ${kcSanitize(messagesPerField.get('religion'))?no_esc}
                    </span>
                        </#if>
                    </div>
                </div>
            </div>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.parentName" class="${properties.kcLabelClass!}">${msg("parentName")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="text" id="user.attributes.parentName"
                           class="mandatory-field ${properties.kcInputClass!}"
                           name="user.attributes.parentName"
                           autocomplete="user.attributes.parentName"
                           maxlength="100"
                           onblur="isRequired(document.getElementById('user.attributes.parentName'),
                                           'parentNameError', 'Parent Name is required.')"
                           required/>
                    <#--                    this bootstrap error message should be at right next to input element-->
                    <div class="invalid-feedback">
                        Parent Name is required.
                    </div>
                    <label id="parentNameError" class="error-msg"/>

                    <#if messagesPerField.existsError('parentName')>
                        <span id="input-error-parentname" class="error-msg ${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                        ${kcSanitize(messagesPerField.get('parentName'))?no_esc}
                    </span>
                    </#if>
                </div>
            </div>

            <div class="row my-2">
                <div class="col-6 ${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.parentPhone"
                               class="${properties.kcLabelClass!}">${msg("parentPhone")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text" id="user.attributes.parentPhone" class="${properties.kcInputClass!}"
                               name="user.attributes.parentPhone"
                               maxlength="20"
                               value="${(register.formData['user.attributes.parentPhone']!'')}"
                               onblur="validatePhoneNumber(document.getElementById('user.attributes.parentPhone'),
                                                            'phoneNumberError')"
                               aria-invalid="<#if messagesPerField.existsError('parentPhone')>true</#if>"
                        />
                        <label id="phoneNumberError" class="error-msg"/>
                        <#if messagesPerField.existsError('parentPhone')>
                            <span id="input-error-parentPhone" class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                        ${kcSanitize(messagesPerField.get('parentPhone'))?no_esc}
                    </span>
                        </#if>
                    </div>
                </div>

                <div class="col-6 ${properties.kcFormGroupClass!}">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.parentMobile"
                               class="${properties.kcLabelClass!}">${msg("parentMobile")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input type="text"
                               id="user.attributes.parentMobile"
                               class="mandatory-field ${properties.kcInputClass!}"
                               name="user.attributes.parentMobile"
                               maxlength="20"
                               value="${(register.formData['user.attributes.parentMobile']!'')}"
                               onblur="validatePhoneNumber(document.getElementById('user.attributes.parentMobile'),
                                                            'mobileNumberError')"
                               aria-invalid="<#if messagesPerField.existsError('parentMobile')>true</#if>"
                               required/>
                        <div class="invalid-feedback">
                            Parent Mobile is required.
                        </div>
                        <label id="mobileNumberError" class="error-msg"/>

                        <#if messagesPerField.existsError('parentMobile')>
                            <span id="input-error-parentMobile" class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                        ${kcSanitize(messagesPerField.get('parentMobile'))?no_esc}
                    </span>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.parentEmail"
                           class="${properties.kcLabelClass!}">${msg("parentEmail")}</label>
                </div>
                <div class="col-12 ${properties.kcInputWrapperClass!}">
                    <input type="email"
                           id="user.attributes.parentEmail"
                           class="mandatory-field ${properties.kcInputClass!}"
                           name="user.attributes.parentEmail"
                           value="${(register.formData['user.attributes.parentEmail']!'')}"
                           aria-invalid="<#if messagesPerField.existsError('parentEmail')>true</#if>"
                           onblur="userEmailValidation('user.attributes.parentEmail', 'lblErrorParentEmail')"
                           required/>
                    <div class="invalid-feedback">
                        Valid Parent Email is required.
                    </div>
                    <label id="lblErrorParentEmail" class="error-msg"></label>
                    <#--                    <input type="text" name="email" id="txtEmail" onblur="validateForm()">-->
                    <#--                    <label id="lblError" style="color:red"></label>-->
                    <#if messagesPerField.existsError('parentEmail')>
                        <span id="input-error-parentEmail" class="${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                        ${kcSanitize(messagesPerField.get('parentEmail'))?no_esc}
                    </span>
                    </#if>
                </div>
            </div>

            <div class="row my-2">
                <div class="col-12 ${properties.kcLabelWrapperClass!}">
                    <label for="user.attributes.userPhoto"
                           class="${properties.kcLabelClass!}">${msg("userPhoto")}</label>
                </div>
                <div class="col-12">
                    <div class="file-drop-area ${properties.kcInputClass!}">
                        <span class="choose-file-button">choose file</span> <span class="file-message">or drag and drop files here</span>
                        <input type="file"
                               class="file-input validate-image-size ${properties.kcInputClass!}"
                               id="user.attributes.userPhoto"
                               accept=".jfif,.jpg,.jpeg,.png,.gif,image/*"
                               value="${(register.formData['user.attributes.userPhoto']!'')}"
                               aria-invalid="<#if messagesPerField.existsError('userPhoto')>true</#if>"
                                <#--   multiple-->/>

                        <#if messagesPerField.existsError('userPhoto')>
                            <span id="input-error-userPhoto" class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('userPhoto'))?no_esc}
                                </span>
                        </#if>
                    </div>
                </div>
                <div class="col-12">
                    <div class="img-txt-hint">Image should be in .jpg, .jpeg, .png file format. Maximum resolution is
                        600px x 600px. Maximum file size is 2MB.
                    </div>
                    <div class="rounded mx-auto d-block preview" id="divImageMediaPreview"></div>
                </div>
            </div>


            <div class="row my-2">
                <div class="col-1">
                    <input type="checkbox" id="termCheckBox" name="termCheckBox" class="cbox-style">
                </div>
                <div class="col-11 px-0">
                    <span>I agree to the <a
                                href="${properties.frontEnd!}/#/public/terms-conditions" target="_blank">Terms and condition</a> and <a
                                href="${properties.frontEnd!}/#/public/privacy-policy" target="_blank">Privacy policy</a>.</span>
                </div>
            </div>

            <#if recaptchaRequired??>
                <div class="row my-2 form-group">
                    <div class="col-12 ${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <div class="row my-2 ${properties.kcFormGroupClass!}">
                <div id="kc-form-buttons" class="col-12 ${properties.kcFormButtonsClass!}">
                    <input class="btn btn-primary ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                           type="submit" id="registerBtn" value="${msg("doRegister")}" disabled/>
                </div>
            </div>
        </form>
        <div hidden
             class="col-8 ${properties.kcFormGroupClass!} ${messagesPerField.printIfExists('gender',properties.kcFormGroupErrorClass!)}">
            <div class=" ${properties.kcLabelWrapperClass!}">
                <label id="adminServiceUrl" value="${properties.adminServiceUrl!}"
                       class="${properties.kcLabelClass!}">${properties.adminServiceUrl!}</label>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>