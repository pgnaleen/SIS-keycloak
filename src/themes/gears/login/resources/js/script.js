adminServiceUrl="";
realm="";

function registerOnAdmission(adminServiceUrl, realm) {
    console.log('registering on Admission Service');
    this.adminServiceUrl=adminServiceUrl;
    this.realm=realm;
}

// Because we want to access DOM nodes,
// we initialize our script at page load.
window.addEventListener( 'load', function () {

    //enable register button based terms checkbox
    const termCheckBox = document.getElementById('termCheckBox');
    const registerBtn = document.getElementById('registerBtn');
    termCheckBox.onchange = function() {
        registerBtn.disabled = !this.checked;
    };


    // These variables are used to store the form data
    // const text = document.getElementById( "fullName" ).value;
    const file = {
        dom    : document.getElementById( "user.attributes.studentPhoto" ),
        binary : null
    };

    // Use the FileReader API to access file content
    const reader = new FileReader();

    // Because FileReader is asynchronous, store its
    // result when it finishes to read the file
    // this load event will be fired when file reading is done
    reader.addEventListener( "load", function () {
        file.binary = reader.result;
    } );

    // At page load, if a file is already selected, read it.
    if( file && file.dom && file.dom.files[0] ) {
        reader.readAsBinaryString( file.dom.files[0] );
    }

    // If not, read the file once the user selects it.
    file.dom.addEventListener( "change", function () {
        if( reader.readyState === FileReader.LOADING ) {
            reader.abort();
        }

        reader.readAsBinaryString( file.dom.files[0] );
    } );

    // If there is a selected file, wait it is read
    // If there is not, delay the execution of the function
    if( !file.binary && file.dom.files.length > 0 ) {
        setTimeout( sendData, 10 );
        return;
    }

    // sendData is the main function
    function sendData() {
        var formData = new FormData();

        formData.append("nameTitle", document.getElementById( "user.attributes.nameTitle" ).value);
        formData.append("gender", document.getElementById( "user.attributes.gender" ).value);
        formData.append("fullName", document.getElementById( "user.attributes.fullName" ).value);
        // formData.append("dob", "22-02-27");
        formData.append("dob", document.getElementById( "user.attributes.dob" ).value);
        formData.append("nationality", document.getElementById( "user.attributes.nationality" ).value);
        formData.append("address", document.getElementById( "user.attributes.address" ).value);
        formData.append("country", document.getElementById( "user.attributes.country" ).value);
        formData.append("email", document.getElementById( "email" ).value);
        formData.append("username", document.getElementById( "username" ).value);
        formData.append("password", document.getElementById( "password" ).value);
        formData.append("maritalStatus", document.getElementById( "user.attributes.maritalStatus" ).value);
        formData.append("religion", document.getElementById( "user.attributes.religion" ).value);
        formData.append("parentPhone", document.getElementById( "user.attributes.parentPhone" ).value);
        formData.append("parentMobile", document.getElementById( "user.attributes.parentMobile" ).value);
        formData.append("parentEmail", document.getElementById( "user.attributes.parentEmail" ).value);
        formData.append("realm", this.realm);
        formData.append("activeStatus", true);

        var blob = new Blob([file.binary], { type: "text/jpeg"});
        formData.append("studentPhoto", blob);

        var request = new XMLHttpRequest();
        request.open("POST", this.adminServiceUrl);
        request.send(formData);

    }

    // Access the form...
    const form = document.getElementById( "kc-register-form" );

    // ...to take over the submit event
    form.addEventListener( 'submit', function ( event ) {
        // event.preventDefault();
        sendData();
    });

    document.getElementById( "user.attributes.studentPhoto" )
        .addEventListener('change',  function() {

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

} );
