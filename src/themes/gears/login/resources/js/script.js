adminServiceUrl = "";
realm = "";

function registerOnAdmission(adminServiceUrl, realm) {
    console.log('registering on Admission Service');
    this.adminServiceUrl = adminServiceUrl;
    this.realm = realm;
}

// function userEmailValidation() {
//     const inpObj = document.getElementById("validationCustomUsername");
//     if (!inpObj.checkValidity()) {
//         document.getElementById('userEmailValidationSpan').innerHTML="Valid Email is required.";
//     } else {
//         document.getElementById('userEmailValidationSpan').innerHTML="";
//     }
//
// }

// Because we want to access DOM nodes,
// we initialize our script at page load.
window.addEventListener('load', function () {

    $(document).ready(function() {
        $("#show_hide_password a").on('click', function(event) {
            event.preventDefault();
            if($('#show_hide_password input').attr("type") == "text"){
                $('#show_hide_password input').attr('type', 'password');
                $('#show_hide_password svg').addClass( "fa-eye-slash" );
                $('#show_hide_password svg').removeClass( "fa-eye" );
            }else if($('#show_hide_password input').attr("type") == "password"){
                $('#show_hide_password input').attr('type', 'text');
                $('#show_hide_password svg').removeClass( "fa-eye-slash" );
                $('#show_hide_password svg').addClass( "fa-eye" );
            }
        });
    });

    $(document).ready(function() {
        $("#show_hide_confirm_password a").on('click', function(event) {
            event.preventDefault();
            if($('#show_hide_confirm_password input').attr("type") == "text"){
                $('#show_hide_confirm_password input').attr('type', 'password');
                $('#show_hide_confirm_password svg').addClass( "fa-eye-slash" );
                $('#show_hide_confirm_password svg').removeClass( "fa-eye" );
            }else if($('#show_hide_confirm_password input').attr("type") == "password"){
                $('#show_hide_confirm_password input').attr('type', 'text');
                $('#show_hide_confirm_password svg').removeClass( "fa-eye-slash" );
                $('#show_hide_confirm_password svg').addClass( "fa-eye" );
            }
        });
    });


    // bootstrap form field validations
    (function () {
        'use strict'
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.querySelectorAll('.needs-validation')

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
    })()


    // if kc-attempted-username label is there then it is registered page redirect
    if (document.getElementById('kc-attempted-username')) {
        $('.toast').toast('show');
    }


    if (document.getElementById('dobDatePicker')) {
        $('#dobDatePicker').datepicker({
            format: "dd/mm/yyyy",
            // todayBtn: "linked",
            clearBtn: true,
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
        .then(r=> r.json()
            .then(
                j=> {
                    console.log('\nREQUEST 2', j);
                    for (let title in j.payload) {
                        let {id, name} = j.payload[title];
                        nameTitleSelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/GENDER")
        .then(r=> r.json()
            .then(
                j=> {
                    console.log('\nREQUEST 2', j);
                    for (let gender in j.payload) {
                        let {id, name} = j.payload[gender];
                        genderSelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/NATIONALITY")
        .then(r=> r.json()
            .then(
                j=> {
                    console.log('\nREQUEST 2', j);
                    for (let nationality in j.payload) {
                        let {id, name} = j.payload[nationality];
                        nationalitySelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/countries")
        .then(r=> r.json()
            .then(
                j=> {
                    console.log('\nREQUEST 2', j);
                    for (let country in j.payload) {
                        let {id, name} = j.payload[country];
                        countrySelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/MARITAL_STATUS")
        .then(r=> r.json()
            .then(
                j=> {
                    console.log('\nREQUEST 2', j);
                    for (let maritalStatus in j.payload) {
                        let {id, name} = j.payload[maritalStatus];
                        maritalStatusSelect.add(new Option(name, id));
                    }
                }
            ));
    fetch(this.adminServiceUrl + "/api/v1/common-lookup/RELIGION")
        .then(r=> r.json()
            .then(
                j=> {
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
        formData.append("fullName", document.getElementById("user.attributes.fullName").value);
        formData.append("dob", document.getElementById("user.attributes.dob").value);
        formData.append("nationalityId", document.getElementById("user.attributes.nationality").value);
        formData.append("address", document.getElementById("user.attributes.address").value);
        formData.append("countryId", document.getElementById("user.attributes.country").value);
        formData.append("email", document.getElementById("email").value);
        formData.append("username", document.getElementById("username").value);
        formData.append("password", document.getElementById("password").value);
        formData.append("maritalStatusId", document.getElementById("user.attributes.maritalStatus").value);
        formData.append("religionId", document.getElementById("user.attributes.religion").value);
        formData.append("parentPhone", document.getElementById("user.attributes.parentPhone").value);
        formData.append("parentMobile", document.getElementById("user.attributes.parentMobile").value);
        formData.append("parentEmail", document.getElementById("user.attributes.parentEmail").value);
        formData.append("realm", this.realm);
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

