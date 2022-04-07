adminServiceUrl = "";
realm = "";

function registerOnAdmission(adminServiceUrl, realm) {
    console.log('registering on Admission Service');
    this.adminServiceUrl = adminServiceUrl;
    this.realm = realm;
}


// date validation
async function validateDate(inputText) {
    // here as bootstrap field validation no align correctly manual label added. that need to be emptyed as well.
    document.getElementById('registerDatePicker').innerHTML = '';


    // date picker takes some time to populate value into input field
    await new Promise(resolve => setTimeout(resolve, 200));

    var dateformat = /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/;
    // Match the date format through regular expression
    if (inputText.value.match(dateformat)) {
        //Test which seperator is used '/' or '-'
        var opera1 = inputText.value.split('/');
        var opera2 = inputText.value.split('-');
        lopera1 = opera1.length;
        lopera2 = opera2.length;
        // Extract the string into month, date and year
        if (lopera1 > 1) {
            var pdate = inputText.value.split('/');
        } else if (lopera2 > 1) {
            var pdate = inputText.value.split('-');
        }
        var dd = parseInt(pdate[0]);
        var mm = parseInt(pdate[1]);
        var yy = parseInt(pdate[2]);
        // Create list of days of a month [assume there is no leap year by default]
        var ListofDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (mm == 1 || mm > 2) {
            if (dd > ListofDays[mm - 1]) {
                document.getElementById('registerDatePicker').innerHTML = "Invalid date.";
                inputText.style.border = "thin solid #dc2626";
                return false;
            } else {
                document.getElementById('registerDatePicker').innerHTML = "";
                inputText.style.border = "";
                return true;
            }
        }
        if (mm == 2) {
            var lyear = false;
            if ((!(yy % 4) && yy % 100) || !(yy % 400)) {
                lyear = true;
            }
            if ((lyear == false) && (dd >= 29)) {
                document.getElementById('registerDatePicker').innerHTML = "Invalid date.";
                inputText.style.border = "thin solid #dc2626";
                return false;
            } else {
                document.getElementById('registerDatePicker').innerHTML = "";
                inputText.style.border = "";
                return true;
            }
            if ((lyear == true) && (dd > 29)) {
                document.getElementById('registerDatePicker').innerHTML = "Invalid date.";
                inputText.style.border = "thin solid #dc2626";
                return false;
            } else {
                document.getElementById('registerDatePicker').innerHTML = "";
                inputText.style.border = "";
                return true;
            }
        }
    } else {
        document.getElementById('registerDatePicker').innerHTML = "Invalid date.";
        inputText.style.border = "thin solid #dc2626";
        return false;
    }
}


// email validation
function userEmailValidation(inputId, errorLabelId) {
    const regex = /[!"`'#%&,:;<>={}~$()*+\/\\?\[\]^|]+/;
    const emailElement = document.getElementById(inputId);

    if (emailElement.value === '') {
        if (!document.getElementsByClassName('was-validated')[0]) {
            document.getElementById(errorLabelId).innerHTML = "Invalid email. Please enter a valid email";
        }

        document.getElementById(inputId).style.border = "thin solid #dc2626";
    } else if (!emailElement.checkValidity() || emailElement.value.match(regex)) {
        if (!document.getElementsByClassName('was-validated')[0]) {
            document.getElementById(errorLabelId).innerHTML = "Invalid email. Please enter a valid email";
        }

        document.getElementById(inputId).style.border = "thin solid #dc2626";
    } else {
        document.getElementById(errorLabelId).innerHTML = "";
        document.getElementById(inputId).style.border = "";
    }
}


function validatePhoneNumber(inputElement, errorLabel) {
    const regExp = /^\+?\d{10,}$/; // with or without + and more than 10 numbers

    if (inputElement.value === '') {
        if (!document.getElementsByClassName('was-validated')[0]) {// this should be this long error as it necessary at very first register page
            document.getElementById(errorLabel).innerHTML = "Invalid Phone number. Please enter a valid Phone number";
        } else {
            document.getElementById(errorLabel).innerHTML = "";
        }

        inputElement.style.border = "thin solid #dc2626";
        return false;
    } else if (!inputElement.value.match(regExp)) {
        // if (!document.getElementsByClassName('was-validated')[0]) {// no need to check bootstrap validation as bootstrap error go away when data is there
        document.getElementById(errorLabel).innerHTML = "Invalid Phone number. Please enter a valid Phone number";
        // }

        inputElement.style.border = "thin solid #dc2626";
        return false;
    } else {
        document.getElementById(errorLabel).innerHTML = "";
        inputElement.style.border = "";
        return true;
    }
}


function usernameValidation(inputElement, errorLabel) {
    if (inputElement.value === '') {
        if (!document.getElementsByClassName('was-validated')[0]) {
            document.getElementById(errorLabel).innerHTML = "Username is required";
        }

        inputElement.style.border = "thin solid #dc2626";
        return false;
    } else {
        inputElement.value = inputElement.value.toLowerCase();
    }

    return false;
}


function passwordValidation(inputElement, errorLabel) {
    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/

    if (inputElement.value != '' && !inputElement.value.match(regex)) {
        // if (!document.getElementsByClassName('was-validated')[0]) {
        document.getElementById(errorLabel).innerHTML = "Password must be at least 8 characters, 1 number, 1 lower case, 1 upper case and 1 special character";
        // }

        inputElement.style.border = "thin solid #dc2626";
        return false;
    } else {
        document.getElementById(errorLabel).innerHTML = "";
        inputElement.style.border = "";
    }

    if (inputElement.value === '') {
        if (!document.getElementsByClassName('was-validated')[0]) {
            document.getElementById(errorLabel).innerHTML = "Password is required";
        }

        inputElement.style.border = "thin solid #dc2626";
        return false;
    }

    return false;
}


function confirmPasswordMatch(passwordElement, passwordConfirmElement, errorLabel) {
    if (!(document.getElementById(passwordElement).value ===
        document.getElementById(passwordConfirmElement).value)) {

        document.getElementById(errorLabel).innerHTML = "The password confirmation does not match.";
        document.getElementById(passwordConfirmElement).style.border = "thin solid #dc2626";

        return false;
    } else if (document.getElementById(passwordConfirmElement).value === '') {
        if (!document.getElementsByClassName('was-validated')[0]) {
            document.getElementById(errorLabel).innerHTML = "Confirm Password is required.";
        }
        document.getElementById(passwordConfirmElement).style.border = "thin solid #dc2626";
        return false;
    } else {
        document.getElementById(errorLabel).innerHTML = "";
        document.getElementById(passwordConfirmElement).style.border = "";
        return true;
    }
}


// general blank error message for required fields
function isRequired(inputElement, errorLabel, errorMsg) {

    if (inputElement.value === '') {
        if (!document.getElementsByClassName('was-validated')[0]) {
            document.getElementById(errorLabel).innerHTML = errorMsg;
        }
        inputElement.style.border = "thin solid #dc2626";

        return false;
    } else {
        document.getElementById(errorLabel).innerHTML = '';
        inputElement.style.border = "";
        return true;
    }
}


function createFullName() {

    let fullName = '';
    if (document.getElementById('user.attributes.firstName').value &&
        document.getElementById('user.attributes.firstName').value !== '') {
        fullName = document.getElementById('user.attributes.firstName').value + ' ';
    }
    if (document.getElementById('user.attributes.middleName').value &&
        document.getElementById('user.attributes.middleName').value !== '') {
        fullName = fullName + document.getElementById('user.attributes.middleName').value + ' ';
    }
    if (document.getElementById('user.attributes.thirdName').value &&
        document.getElementById('user.attributes.thirdName').value !== '') {
        fullName = fullName + document.getElementById('user.attributes.thirdName').value + ' ';
    }
    if (document.getElementById('user.attributes.familyName').value &&
        document.getElementById('user.attributes.familyName').value !== '') {
        fullName = fullName + document.getElementById('user.attributes.familyName').value;
    }

    document.getElementById('user.attributes.fullName').value = fullName;
}


function createFullName2L() {

    let fullName = '';
    if (document.getElementById('user.attributes.firstName2L').value &&
        document.getElementById('user.attributes.firstName2L').value !== '') {
        fullName = document.getElementById('user.attributes.firstName2L').value + ' ';
    }
    if (document.getElementById('user.attributes.middleName2L').value &&
        document.getElementById('user.attributes.middleName2L').value !== '') {
        fullName = fullName + document.getElementById('user.attributes.middleName2L').value + ' ';
    }
    if (document.getElementById('user.attributes.thirdName2L').value &&
        document.getElementById('user.attributes.thirdName2L').value !== '') {
        fullName = fullName + document.getElementById('user.attributes.thirdName2L').value + ' ';
    }
    if (document.getElementById('user.attributes.familyName2L').value &&
        document.getElementById('user.attributes.familyName2L').value !== '') {
        fullName = fullName + document.getElementById('user.attributes.familyName2L').value;
    }

    document.getElementById('user.attributes.fullName2L').value = fullName;
}


// Because we want to access DOM nodes,
// we initialize our script at page load.
window.addEventListener('load', function () {

    $(document).ready(function () {
        $("#show_hide_password").on('click', function (event) {
            event.preventDefault();
            if ($('#password').attr("type") == "text") {
                $('#password').attr('type', 'password');
                $('#show_hide_password svg').addClass("fa-eye-slash");
                $('#show_hide_password svg').removeClass("fa-eye");
            } else if ($('#password').attr("type") == "password") {
                $('#password').attr('type', 'text');
                $('#show_hide_password svg').removeClass("fa-eye-slash");
                $('#show_hide_password svg').addClass("fa-eye");
            }
        });
    });

    $(document).ready(function () {
        $("#show_hide_confirm_password").on('click', function (event) {
            event.preventDefault();
            if ($('#password-confirm').attr("type") == "text") {
                $('#password-confirm').attr('type', 'password');
                $('#show_hide_confirm_password svg').addClass("fa-eye-slash");
                $('#show_hide_confirm_password svg').removeClass("fa-eye");
            } else if ($('#password-confirm').attr("type") == "password") {
                $('#password-confirm').attr('type', 'text');
                $('#show_hide_confirm_password svg').removeClass("fa-eye-slash");
                $('#show_hide_confirm_password svg').addClass("fa-eye");
            }
        });
    });

    // reset password first new password
    $(document).ready(function () {
        $("#show_hide_password_new").on('click', function (event) {
            event.preventDefault();
            if ($('#password-new').attr("type") == "text") {
                $('#password-new').attr('type', 'password');
                $('#show_hide_password_new svg').addClass("fa-eye-slash");
                $('#show_hide_password_new svg').removeClass("fa-eye");
            } else if ($('#password-new').attr("type") == "password") {
                $('#password-new').attr('type', 'text');
                $('#show_hide_password_new svg').removeClass("fa-eye-slash");
                $('#show_hide_password_new svg').addClass("fa-eye");
            }
        });
    });

    // this is for template general ftl. if error message is for invalid password then display password error instead this message
    $(document).ready(function () {
        // this is for password reset
        if (document.getElementById('templateError') &&
            document.getElementById('templateError').textContent.includes('Invalid password:')) {

            document.getElementById('templateError').innerHTML = "";
            document.getElementById('passwordError').innerHTML = "Password must be at least 8 characters, 1 number, 1 lower case, 1 upper case and 1 special character";
        }
        // this is for register password
        if (document.getElementById('input-error-password') &&
            document.getElementById('input-error-password').textContent.includes('Invalid password:')) {

            document.getElementById('input-error-password').innerHTML = "";
            document.getElementById('passwordError').innerHTML = "Password must be at least 8 characters, 1 number, 1 lower case, 1 upper case and 1 special character";
        }
    });


    // // bootstrap form field validations
    (function () {
        'use strict'
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.querySelectorAll('.needs-validation')

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();

                        // if these lines are not there then both field empty and bootstrap errors will be displayed
                        // when user submitted with fields errors.
                        if (document.getElementById('kc-login')) {
                            document.getElementById('kc-login').disabled = false;
                        }

                        if (document.getElementById('firstNameError')) {
                            document.getElementById('firstNameError').innerHTML = '';
                        }

                        if (document.getElementById('registerDatePicker')) {
                            document.getElementById('registerDatePicker').innerHTML = 'Date of Birth is required.';
                        }

                        if (document.getElementById('contactNumberError')) {
                            document.getElementById('contactNumberError').innerHTML = '';
                        }

                        if (document.getElementById('emailError')) {
                            document.getElementById('emailError').innerHTML = '';
                        }

                        if (document.getElementById('usernameError')) {
                            document.getElementById('usernameError').innerHTML = '';
                        }

                        if (document.getElementById('passwordError')) {
                            document.getElementById('passwordError').innerHTML = '';
                        }

                        if (document.getElementById('passwordConfirmError')) {
                            document.getElementById('passwordConfirmError').innerHTML = '';
                        }

                        if (document.getElementById('mobileNumberError')) {
                            document.getElementById('mobileNumberError').innerHTML = '';
                        }

                        if (document.getElementById('lblErrorParentEmail')) {
                            document.getElementById('lblErrorParentEmail').innerHTML = '';
                        }

                        if (document.getElementById('parentNameError')) {
                            document.getElementById('parentNameError').innerHTML = '';
                        }

                        // add border line when click submit and no data in the field
                        Array.prototype.forEach.call(document.getElementsByClassName('mandatory-field'), function(el) {
                            if (el.value === '') {
                                el.style.border = "thin solid #dc2626";
                            }
                        });

                    }

                    // this was-validated class will be added to the form class list
                    form.classList.add('was-validated');
                }, false)
            })
    })()


    // if kc-attempted-username label is there then it is registered page redirect
    if (document.getElementById('kc-attempted-username') &&
        document.getElementById('kc-registration-container')) {
        $('.toast').toast('show');
        // need to hide this register link as if user clicked on register link login page will be malfunctioned.
        document.getElementById('kc-registration-container').style.visibility = "hidden";
    }


    if (document.getElementById('dobDatePicker')) {
        $('#dobDatePicker').datepicker({
            format: "dd/mm/yyyy",
            // todayBtn: "linked",
            clearBtn: true,
            endDate: 'today',
            daysOfWeekHighlighted: "0,6",
            calendarWeeks: true,
            autoclose: true,
            todayHighlight: true,
            // datesDisabled: ['03/06/2022', '03/21/2022'],
            toggleActive: true,
            // defaultViewDate: { year: 1977, month: 04, day: 25 }
        });
    }


    // get adminServiceUrl from theme.properties
    this.adminServiceUrl = document.getElementById('adminServiceUrl').textContent;


    // get lookups and set into selects
    var nameTitleSelect = document.getElementById('user.attributes.nameTitle');
    var genderSelect = document.getElementById('user.attributes.gender');
    var nationalitySelect = document.getElementById('user.attributes.nationality');
    var countrySelect = document.getElementById('user.attributes.country');
    var maritalStatusSelect = document.getElementById('user.attributes.maritalStatus');
    var religionSelect = document.getElementById('user.attributes.religion');

    fetch(this.adminServiceUrl + "/api/v1/common-lookup/TITLE")
        .then(r => r.json()
            .then(
                j => {
                    console.log('\nREQUEST 2', j);
                    for (let title in j.payload) {
                        let {id, name} = j.payload[title];
                        nameTitleSelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/GENDER")
        .then(r => r.json()
            .then(
                j => {
                    console.log('\nREQUEST 2', j);
                    for (let gender in j.payload) {
                        let {id, name} = j.payload[gender];
                        genderSelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/NATIONALITY")
        .then(r => r.json()
            .then(
                j => {
                    console.log('\nREQUEST 2', j);
                    for (let nationality in j.payload) {
                        let {id, name} = j.payload[nationality];
                        nationalitySelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/countries")
        .then(r => r.json()
            .then(
                j => {
                    console.log('\nREQUEST 2', j);
                    for (let country in j.payload) {
                        let {id, name} = j.payload[country];
                        countrySelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/MARITAL_STATUS")
        .then(r => r.json()
            .then(
                j => {
                    console.log('\nREQUEST 2', j);
                    for (let maritalStatus in j.payload) {
                        let {id, name} = j.payload[maritalStatus];
                        maritalStatusSelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/RELIGION")
        .then(r => r.json()
            .then(
                j => {
                    console.log('\nREQUEST 2', j);
                    for (let religion in j.payload) {
                        let {id, name} = j.payload[religion];
                        religionSelect.add(new Option(name, id));
                    }
                }
            ));


    //enable register button based terms checkbox
    const termCheckBox = document.getElementById('termCheckBox');
    const registerBtn = document.getElementById('registerBtn');
    termCheckBox.onchange = function () {
        registerBtn.disabled = !this.checked;
    };


    // These variables are used to store the form data
    // const text = document.getElementById( "fullName" ).value;
    const file = {
        dom: document.getElementById("user.attributes.userPhoto"),
        binary: null
    };

    // Use the FileReader API to access file content
    const reader = new FileReader();

    // Because FileReader is asynchronous, store its
    // result when it finishes to read the file
    // this load event will be fired when file reading is done
    reader.addEventListener("load", function () {
        file.binary = reader.result;
    });

    // At page load, if a file is already selected, read it.
    if (file && file.dom && file.dom.files[0]) {
        reader.readAsBinaryString(file.dom.files[0]);
    }

    // If not, read the file once the user selects it.
    file.dom.addEventListener("change", function () {
        if (reader.readyState === FileReader.LOADING) {
            reader.abort();
        }

        reader.readAsBinaryString(file.dom.files[0]);
    });

    // If there is a selected file, wait it is read
    // If there is not, delay the execution of the function
    if (!file.binary && file.dom.files.length > 0) {
        setTimeout(sendData, 10);
        return;
    }

    // sendData is the main function
    function sendData() {
        var formData = new FormData();

        formData.append("titleId", document.getElementById("user.attributes.nameTitle").value);
        formData.append("genderId", document.getElementById("user.attributes.gender").value);
        formData.append("firstName", document.getElementById("user.attributes.firstName").value);
        formData.append("middleName", document.getElementById("user.attributes.middleName").value);
        formData.append("thirdName", document.getElementById("user.attributes.thirdName").value);
        formData.append("familyName", document.getElementById("user.attributes.familyName").value);
        formData.append("fullName", document.getElementById("user.attributes.fullName").value);
        formData.append("firstName2L", document.getElementById("user.attributes.firstName2L").value);
        formData.append("middleName2L", document.getElementById("user.attributes.middleName2L").value);
        formData.append("thirdName2L", document.getElementById("user.attributes.thirdName2L").value);
        formData.append("familyName2L", document.getElementById("user.attributes.familyName2L").value);
        formData.append("fullName2L", document.getElementById("user.attributes.fullName2L").value);
        formData.append("dob", document.getElementById("user.attributes.dob").value);
        formData.append("nationalityId", document.getElementById("user.attributes.nationality").value);
        formData.append("contactNumber", document.getElementById("user.attributes.contactNumber").value);
        formData.append("address", document.getElementById("user.attributes.address").value);
        formData.append("countryId", document.getElementById("user.attributes.country").value);
        formData.append("email", document.getElementById("email").value);
        formData.append("username", document.getElementById("username").value);
        formData.append("password", document.getElementById("password").value);
        formData.append("maritalStatusId", document.getElementById("user.attributes.maritalStatus").value);
        formData.append("religionId", document.getElementById("user.attributes.religion").value);
        formData.append("parentName", document.getElementById("user.attributes.parentName").value);
        formData.append("parentPhone", document.getElementById("user.attributes.parentPhone").value);
        formData.append("parentMobile", document.getElementById("user.attributes.parentMobile").value);
        formData.append("parentEmail", document.getElementById("user.attributes.parentEmail").value);
        formData.append("realm", this.realm);
        const date = new Date();
        formData.append("registeredDate", date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear());
        formData.append("activeStatus", true);

        var blob = new Blob([file.binary], {type: "text/jpeg"});
        formData.append("userPhoto", blob);

        var request = new XMLHttpRequest();
        request.open("POST", this.adminServiceUrl + "/api/v1/users/create");
        request.send(formData);

    }

    // Access the form...
    const form = document.getElementById("kc-register-form");

    // ...to take over the submit event
    form.addEventListener('submit', function (event) {
        // event.preventDefault();
        sendData();
    });


    // image preview
    document.getElementById("user.attributes.userPhoto")
        .addEventListener('change', function () {
            var filesCount = $(this)[0].files.length;
            var textbox = $(this).prev();

            if (filesCount === 1) {
                var fileName = $(this).val().split('\\').pop();
                textbox.text(fileName);
            } else {
                textbox.text(filesCount + ' files selected');
            }

            if (typeof (FileReader) != "undefined") {
                var dvPreview = $("#divImageMediaPreview");
                dvPreview.html("");
                $($(this)[0].files).each(function () {
                    var file = $(this);
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var img = $("<img />");
                        img.attr("style", "width: 150px; height:150px; padding: 10px");
                        img.attr("class", "rounded mx-auto d-block")
                        img.attr("src", e.target.result);
                        dvPreview.append(img);
                    }
                    reader.readAsDataURL(file[0]);
                });
            } else {
                alert("This browser does not support HTML5 FileReader.");
            }
        });


    // image size, width and height
    const validateMaxImageFileSize = (e) => {
        e.preventDefault();
        const el = $("input[type='file']")[0];

        if (el.files && el.files[0]) {
            const file = el.files[0];

            const maxFileSize = 2097152; // 5 MB
            const maxWidth = 600;
            const maxHeight = 600;

            const img = new Image();
            img.src = window.URL.createObjectURL(file);
            img.onload = () => {
                if (file.type.match('image.*') && file.size > maxFileSize) {
                    alert('The selected image file is too big. Please choose one that is smaller than 2 MB.');
                } else if (file.type.match('image.*') && (img.width > maxWidth || img.height > maxHeight)) {
                    alert(`The selected image is too big. Please choose one with maximum dimensions of ${maxWidth}x${maxHeight}.`);
                } else {
                    e.target.nodeName === 'INPUT'
                        ? (e.target.form.querySelector("input[type='submit']").disabled = false)
                        : e.target.submit();
                }
            };
        }
    };
    document.getElementById("user.attributes.userPhoto")
        .addEventListener('submit', validateMaxImageFileSize);
    document.getElementById("user.attributes.userPhoto")
        .addEventListener('change', validateMaxImageFileSize);
});

