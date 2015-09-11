/*
 File           :   UserJs.js
 Description    :   This page contains the scripts for the layout.
 Created On     :   05-08-2015
*/

$(document).ready(function(){
	
	//variables declaration
	var firstNameValid = false;
	var lastNameValid = false;
	var emailValid = false;
	var passwordValid = false;
	var ajaxReturnedData = "";
	var regex = /^[a-zA-Z]+$/;

	var emailRegex = /^([a-zA-Z0-9_\.\-])+@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

	//check if email is in correct format
	$("#loginEmail").blur(function(){
		var email = jQuery.trim($("#loginEmail").val());
    	$("#loginEmailError").text("");
    	if(!emailRegex.test(email)){
    		$("#loginEmail").css('border','1px solid red');
    		$("#loginEmailError").css("color","#E66C2C");
    		$("#loginEmailError").html("Please enter a valid Email from a-z, A-Z, 0-9, including the _ (underscore) character");
    		$("#loginEmail").focus();
    		emailValid = false;
    	}
    	else{
    		$("#loginEmail").css('border','1px solid green');
    		emailValid = true;
    	}
	});
	
	// check if password is greater than 6
	$('#loginPassword').blur(function(){
    	password = $('#loginPassword').val();
    	if (password.length < 6) {
    		$("#loginPassword").css('border','1px solid red');
    		$('#loginPasswordError').css('color','#FF0000');
    		$('#loginPasswordError').text('Password too short');
    		$("#loginPassword").focus();
    		passwordValid = false;
    	}
    	else{
    		passwordValid = true;
    		}
		
	});
    $("#btnLogin").click(function(){
        var email = $("#loginEmail").val();
        var password = $("#loginPassword").val();
        if(emailValid & passwordValid){
        	ajaxReturnedData = AjaxCall("../../SecurityCheck.cfc?method=CheckLogin"
                    ,{email: email, password:password}
                    ,"JSON"
                    ,"POST");
		        ajaxReturnedData.success(function(data){
		            if(!data.valid){
		            	$("#loginModal").modal('show');
		            }
		            else{
		            	var welcomeMessage ="Welcome! " + data.email;
		            	$("#loginModal").modal('hide');
		            	$("#userLogin").html("");
		            	var logoutLink = $('<a href="logout.cfm"> Logout</a>');
		            	$("#userLogin").html(welcomeMessage).append(logoutLink);
		            }
	        	});
        }
    });

    $("#btnRegister").click(function(){
        var firstName = $("#signUpFirstName").val();
        var middleName = $("#signUpMiddleName").val();
        var lastName = $("#signUpLastName").val();
        var email = $("#signUpEmail").val();
        var password = $("#signUpPassword").val();
        if(firstNameValid & lastNameValid & emailValid & passwordValid){
        	ajaxReturnedData = AjaxCall("../../SecurityCheck.cfc?method=NewUserDetail"
                    , {firstName:firstName, middleName: middleName, lastName:lastName, email:email, password:password}
                    , "JSON"
                    , "POST");
                ajaxReturnedData.success(function(data){
                	var firstNameValid = false;
                	var lastNameValid = false;
                	var emailValid = false;
                	var passwordValid = false;
                	
                	if(data.IsEmailExist){
                		$("#signUpEmailError").css("color","#E66C2C");
                		$("#signUpEmailError").text("Email already exists.");
                		$("#signUpEmail").val("");
                		$("#signUpPassword").val("");
                		$("#signUpEmail").focus();
                    }
                	else if(!data.IsEmailExist & !data.IsInserted){
                		$("#insertError").css("display","inline");
                		$("#signUpFirstName").val("");
                		$("#signUpMiddleName").val("");
                		$("#signUpLastName").val("");
                		$("#signUpEmail").val("");
                		$("#signUpPassword").val("");
                		$("#passwordStrengthDiv").css("display","none");
                	}
                    else{
                    	$("#loginModal").modal('hide');
                    }
                });
        }
    });

    $("#signUpFirstName").blur(function(){
    	var firstName = jQuery.trim($("#signUpFirstName").val());
    	$("#signUpFirstNameError").text("");
    	
    	if(!regex.test(firstName)){
    		$("#signUpFirstName").css('border','1px solid red');
    		$("#signUpFirstNameError").css("color","#E66C2C");
    		$("#signUpFirstNameError").text("Please enter a valid First Name");
    		$("#signUpFirstName").focus();
    		firstNameValid = false;
    	}
    	else{
    		$("#signUpFirstName").css('border','1px solid green');
    		firstNameValid = true;
    	}
    });
    
    $("#signUpLastName").blur(function(){
    	var lastName = jQuery.trim($("#signUpLastName").val());
    	$("#signUpLastNameError").text("");
    	if(!regex.test(lastName)){
    		$("#signUpLastName").css('border','1px solid red');
    		$("#signUpFirstName").css("color","#E66C2C");
    		$("#signUpLastNameError").text("Please enter a valid Last Name");
    		$("#signUpLastName").focus();
    		lastNameValid = false;
    	}
    	else{
    		$("#signUpLastName").css('border','1px solid green');
    		lastNameValid = true;
    	}
    });

    $("#signUpEmail").blur(function(){
    	var email = jQuery.trim($("#signUpEmail").val());
    	$("#signUpEmailError").text("");
    	if(!emailRegex.test(email)){
    		$("#signUpEmail").css('border','1px solid red');
    		$("#signUpEmailError").css("color","#E66C2C");
    		$("#signUpEmailError").text("Please enter a valid Email");
    		$("#signUpEmail").focus();
    		emailValid = false;
    	}
    	else{
    		$("#signUpEmail").css('border','1px solid green');
    		emailValid = true;
    	}
    });

    $('#signUpPassword').keyup(function(){
    	$("#passwordStrengthDiv").css("display","inline");
    	$('#passwordStrengthSpan').text('Too short');
    	password = $('#signUpPassword').val()
    	//if the password length is less than 6.
    	if (password.length < 6) { 
    		$('#passwordStrengthSpan').css('color','#FF0000');
    		$('#passwordStrengthSpan').text('Too short');
    		passwordValid = false;
    	}
    	else{
    		$('#passwordStrengthSpan').text(checkStrength(password));
    		passwordValid = true;
    		}
		
	});
});
function AjaxCall(url,data,datatype,type){
    return $.ajax({
        url: url,
        data: data,
        dataType: datatype,
        type: type
    });
}
function checkStrength(password)
{
	//initial strength
	var strength = 0;
	
	//if length is 8 characters or more, increase strength value
	if (password.length > 7) strength += 1;
	
	//if password contains both lower and uppercase characters, increase strength value
	if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1;
	
	//if it has numbers and characters, increase strength value
	if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1;
	
	//if it has one special character, increase strength value
	if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1;
	
	//if it has two special characters, increase strength value
	if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1;
	
	//now we have calculated strength value, we can return messages
	
	//if value is less than 2
	if (strength < 2 )
	{
		$('#passwordStrengthSpan').css('color','#E66C2C');
		return 'Weak'			
	}
	else if (strength == 2 )
	{
		$('#passwordStrengthSpan').css('color','#2D98F3');
		return 'Good'		
	}
	else
	{
		$('#passwordStrengthSpan').css('color','#006400');
		return 'Strong'
	}
}

