<!---
  Created by juhi.goel on 8/3/2015.
--->

<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content login-modal">
            <div class="modal-header login-modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-center" id="loginModalLabel">USER AUTHENTICATION</h4>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <div role="tabpanel" class="login-tab">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a id="signin-taba" href="#home" aria-controls="home" role="tab" data-toggle="tab">Sign In</a></li>
                            <li role="presentation"><a id="signup-taba" href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Sign Up</a></li>
                            <li role="presentation"><a id="forgetpass-taba" href="#forget_password" aria-controls="forget_password" role="tab" data-toggle="tab">Forget Password</a></li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content">
						<!-- Log-In tab -->
                            <div role="tabpanel" class="tab-pane active text-center" id="home">
                                &nbsp;&nbsp;
                                <span id="loginFail" class="response_error" style="display: none;">Logging failed, please try again.</span>
                                <div class="clearfix"></div>
                                <form>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                            <input type="text" class="form-control" id="loginEmail" placeholder="Email">
                                        </div>
                                        <span class="help-block has-error" id="loginEmailError"></span>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-lock"></i></div>
                                            <input type="password" class="form-control" id="loginPassword" placeholder="Password">
                                        </div>
                                        <span class="help-block has-error" id="loginPasswordError"></span>
                                    </div>
                                    <button type="button" id="btnLogin" class="btn btn-block bt-login" data-loading-text="Signing In....">Login</button>
                                    <div class="clearfix"></div>
                                    <div class="login-modal-footer">
                                        <div class="row">
                                            <div class="col-xs-8 col-sm-8 col-md-8">
                                                <i class="fa fa-lock"></i>
                                                <a href="javascript:;" class="forgetpass-tab"> Forgot password? </a>

                                            </div>
                                            <div class="col-xs-4 col-sm-4 col-md-4">
                                                <i class="fa fa-check"></i>
                                                <a href="javascript:;" class="signup-tab"> Sign Up </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>

							<!-- Sign Up tab -->
                            <div role="tabpanel" class="tab-pane" id="profile">
                                &nbsp;&nbsp;
                                <span id="signUpFail" class="reponse_esrror" style="display: none;">Registration failed, please try again.</span>
                                <div class="clearfix"></div>
                                <form>
									<div class="form-group" id="insertError" style="display:none">
										<span style="color:#E66C2C">Some technical error occured while saving. Please try again.</span>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                            <input type="text" class="form-control" id="signUpFirstName" placeholder="FirstName">
                                        </div>
										<div id="error1">
                                        <span class="error" data-error='0' id="signUpFirstNameError"></span>
										</div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                            <input type="text" class="form-control" id="signUpMiddleName" placeholder="MiddleName">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                            <input type="text" class="form-control" id="signUpLastName" placeholder="LastName">
                                        </div>
                                        <span class="error" data-error='0' id="signUpLastNameError"></span>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-at"></i></div>
                                            <input type="text" class="form-control" id="signUpEmail" placeholder="Email">
                                        </div>
                                        <span class="error" data-error='0' id="signUpEmailError"></span>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                            <input type="password" class="form-control" id="signUpPassword" placeholder="Password">
                                        </div>
                                        <span class="error" data-error='0' id="signUpPasswordError"></span>
                                    </div>
									<div class="form-group">
                                        <div id="passwordStrengthDiv" style="display:none">
											Password Strength: <span id="passwordStrengthSpan" style="font-weight: bold;"></span>
                                        </div>
                                    </div>
                                    <button type="button" id="btnRegister" class="btn btn-block bt-login" data-loading-text="Registering....">Register</button>
                                    <div class="clearfix"></div>
                                    <div class="login-modal-footer">
                                        <div class="row">
                                            <div class="col-xs-8 col-sm-8 col-md-8">
                                                <i class="fa fa-lock"></i>
                                                <a href="javascript:;" class="forgetpass-tab"> Forgot password? </a>

                                            </div>
                                            <div class="col-xs-4 col-sm-4 col-md-4">
                                                <i class="fa fa-check"></i>
                                                <a href="javascript:;" class="signin-tab"> Sign In </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div role="tabpanel" class="tab-pane text-center" id="forget_password">
                                &nbsp;&nbsp;
                                <span id="reset_fail" class="response_error" style="display: none;"></span>
                                <div class="clearfix"></div>
                                <form>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                            <input type="text" class="form-control" id="femail" placeholder="Email">
                                        </div>
                                        <span class="help-block has-error" data-error='0' id="femail-error"></span>
                                    </div>
                                    <button type="button" id="reset_btn" class="btn btn-block bt-login" data-loading-text="Please wait....">Forget Password</button>
                                    <div class="clearfix"></div>
                                    <div class="login-modal-footer">
                                        <div class="row">
                                            <div class="col-xs-6 col-sm-6 col-md-6">
                                                <i class="fa fa-lock"></i>
                                                <a href="javascript:;" class="signin-tab"> Sign In </a>

                                            </div>

                                            <div class="col-xs-6 col-sm-6 col-md-6">
                                                <i class="fa fa-check"></i>
                                                <a href="javascript:;" class="signup-tab"> Sign Up </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


