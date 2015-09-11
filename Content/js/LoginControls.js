/**
 * Created by juhi.goel on 8/3/2015.
 */

$(document).ready(function(){
    $(document).on('click','.signup-tab',function(e){
        e.preventDefault();
        $('#signup-taba').tab('show');
    });

    $(document).on('click','.signin-tab',function(e){
        e.preventDefault();
        $('#signin-taba').tab('show');
    });

    $(document).on('click','.forgetpass-tab',function(e){
        e.preventDefault();
        $('#forgetpass-taba').tab('show');
    });
});


$("#userLogin").unbind('click').bind('click', function() {
	$("#signUpLastNameError").text("");
	$("#loginModal").modal('show');
    
});