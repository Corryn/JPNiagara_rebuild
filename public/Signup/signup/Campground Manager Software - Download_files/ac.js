var _wt_url = "live.activeconversion.com/webtracker";
var _wt_http_protocol = "http://";
var _wt_https_protocol = "https://";
var _am_d = document;
var _am_lh = _am_d.location.href;
var _am_debug = (document.URL.indexOf('amtest=1') >= 0);
var _am_removed = 0;

var _am_vip;
var _am_utm_campaign;
var _am_source;
var _am_kw;
var _am_cvt;
var __avc;

var _am_src;
var _am_mda;
var _am_trm;
var _am_ctt;
var __isSubmit = new Array();
var __isIntegratedForm = new Array();
var __current_form_ = new Array();
var __current_index_;
var __originalACOnSubmitFunction = new Array();
var __wtlRetURL = new Array();
     
function __am_parseArgs () {
	sArgs = location.search.slice(1).split('&');
    for (var i = 0; i < sArgs.length; i++) {
        argName  = sArgs[i].slice(0,sArgs[i].indexOf('='));
        argValue = sArgs[i].slice(sArgs[i].indexOf('=')+1);
        __am_setupArgs(argName, argValue);
    }
}

//****/
function __am_setupArgs (argName, argValue) {
    if ('source'==argName) {
        _am_source = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if ('akw'==argName || 'OVKEY'==argName) {
        _am_kw  = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if ('vip'==argName) {
        _am_vip = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if ('acvt'==argName) {
        _am_cvt = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if('utm_source'==argName){
        _am_src = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if('utm_medium'==argName){
        _am_mda = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if('utm_campaign'==argName){
        _am_utm_campaign = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if('utm_term'==argName){
        _am_trm = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if('utm_content'==argName){
        _am_ctt = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    } else if('avc'==argName){
        __avc = (argValue.length > 0 ? unescape(argValue).split(',') : '');
    }
}

function __am_rand() {
    return Math.round(Math.random() * 256).toString(16) + Math.round(Math.random() * 256).toString(16);
}

function __am_uuid() {
    return __am_rand() + "-" + __am_rand() + "-" + __am_rand() + "-" + __am_rand() + new Date().getTime().toString(16);
}

/* This function is used to get cookies */
function __am_valueOf(name) {
    var prefix = name + "="
    var start = _am_d.cookie.indexOf(prefix)

    if (start==-1) {
        return "";
    }

    var end = _am_d.cookie.indexOf(";", start+prefix.length)
    if (end==-1) {
        end=_am_d.cookie.length;
    }

    var value=_am_d.cookie.substring(start+prefix.length, end)
    return unescape(value);
}

function __avc_param_is_valid() {
    var regExPattern = /^\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{8,}$/g;
    return regExPattern.test(__avc);
}

function __am_trackPage() {
    var q = _wt_http_protocol + _wt_url + "/track2.html?method=track";
    var uclkt = 0;

    var domain = __getdomain();

    if (__am_valueOf('__alh_'+__pid).length <= 0) {
		uclkt = 1;
		_am_d.cookie = "__alh_"+__pid+"=" + escape(_am_lh) + "; path=/; domain=."+domain+";";
	}
    __am_parseArgs();

    if (__am_valueOf('__avc_'+__pid).length <= 0) {
        if(__avc != null && __avc_param_is_valid()) {
            _am_d.cookie = "__avc_" + __pid + "=" + __avc + "; path=/; expires=Sun, 18 Jan 2038 00:00:00 GMT; domain=."+domain+";";
        } else {
            _am_d.cookie = "__avc_"+__pid+"=" + __am_uuid() + "; path=/; expires=Sun, 18 Jan 2038 00:00:00 GMT; domain=."+domain+";";
        }
    }
    var __final_source = null;
    if (_am_utm_campaign != null && _am_utm_campaign.length > 0) __final_source = trim(decodeURIComponent(escape(_am_utm_campaign)).replace(/[&:\/?@=+$,;]/g,''));
    if (_am_source != null && _am_source.length > 0) __final_source = _am_source;
    if (__final_source != null && __final_source.length > 0) {
        q += "&clkt=1";
        _am_d.cookie = "__asrc_"+__pid+"="+ __final_source + "; path=/; domain=."+domain+"; ";
        _am_d.cookie = "__akw_"+__pid+"=; path=/; expires=Thu, 01-Jan-70 00:00:01 GMT; domain=."+domain+";";
    }

    if (_am_kw != null && _am_kw.length > 0) {
        _am_d.cookie = "__akw_"+__pid+"=" + _am_kw + "; path=/; domain=."+domain+";";
    }


    if (_am_vip != null && _am_vip.length > 0) {
        q += "&vip=" + _am_vip;
    }


    if( _am_src != null && _am_src.length > 0 ){
        q += "&utm_source="+_am_src;
    }

    if( _am_mda != null && _am_mda.length > 0 ){
        q += "&utm_medium="+_am_mda;
    }

    if( _am_trm != null && _am_trm.length > 0 ){
        q += "&utm_term="+_am_trm;
    }

    if( _am_ctt != null && _am_ctt.length > 0 ){
        q += "&utm_content="+_am_ctt;
    }

    if( _am_utm_campaign != null && _am_utm_campaign.length > 0 ){
        q += "&utm_campaign="+_am_utm_campaign;
    }
    if (window.__am_convert) {
        q += "&actn="+ __am_convert;
    } else if (_am_cvt != null && _am_cvt.length > 0) {
            q += "&actn="+ _am_cvt;
    }

    q += "&pid=" + __pid;
    q += "&uclkt=" + uclkt;
    q += "&alh=" + escape(__am_valueOf('__alh_'+__pid));
    q += "&avc=" + __am_valueOf('__avc_'+__pid);
    q += "&source=" + __am_valueOf('__asrc_'+__pid);
    q += "&keyword=" + __am_valueOf('__akw_'+__pid);
    q += "&ref=" + escape(_am_d.referrer);
    q += "&pageTitle=" + escape(_am_d.title);
    q += "&pageUrl=" + encodeURIComponent(_am_d.location);
    q += "&java=1&amcs="+Math.random();

    var _am_image = new Image(1,1);
    _am_image.src = q;
    _am_image.onload=function() {_amVoid();}
}

function __am_track() {

    __am_trackPage();
    __am_findForm();
    __am_addLinkerEvents();    
}

function _amVoid() { return; }

function __am_findForm() {
    var forms = document.getElementsByTagName('form');
    for ( var index = 0; index < forms.length; index++ ) {
        var form = forms[index];
        var fname = form.getAttribute("name");
        var action = form.action;
        var formIdParam = null;

        if (fname != null && typeof fname == "string" && fname.indexOf("aspnetForm") != -1) {
            continue;
        }

        if(typeof form.formId != "undefined" && typeof form.formId.value != "undefined") {
            formIdParam = form.formId.value;
        }

        populateForm(form, index);
        if (( action.indexOf(_wt_http_protocol + _wt_url + "/form") != -1 ) || (action.indexOf(_wt_https_protocol + _wt_url + "/form") != -1 ) ||
        	(fname != null && typeof fname == "string" && fname.indexOf("acForm") != -1 && formIdParam != null && formIdParam > 0)) {
            action = ((_am_d.location).toString().indexOf(_wt_https_protocol) == 0 ? _wt_https_protocol : _wt_http_protocol) + _wt_url + "/form2.html?method=submit";
            action += "&avc=" + __am_valueOf('__avc_'+__pid);
            action += "&source=" + __am_valueOf('__asrc_'+__pid);
            action += "&alh=" + escape(__am_valueOf('__alh_'+__pid));
            action += "&keyword=" + __am_valueOf('__akw_'+__pid);
            action += "&pageUrl=" + encodeURIComponent(_am_d.location);
            form.action = action;
        }
        else {
            if ( action.indexOf('www.salesforce.com/servlet/servlet.WebToLead') != -1 ) {
                __isSubmit[index] = false;
                __isIntegratedForm[index] = false;
                __trackForm(form, index);
            }
            else {
                if (__isValidForm(form)) {
                    __isSubmit[index] = false;
                    __isIntegratedForm[index] = true;
                    __trackForm(form, index);
                }
            }
        }
    }
}

function __am_addLinkerEvents() {
	var as = document.getElementsByTagName("a");	
	var extDoc = [".pdf",".doc",".xls",".exe",".zip"];

	for(var i=0; i<as.length; i++) {
		var flag = 0;
		var tmp = as[i].getAttribute("onclick");

		if (tmp != null) {
			continue;
		}
		
		// Tracking electronic documents - doc, xls, pdf, exe, zip
		for (var j=0; j<extDoc.length; j++) {
			if (as[i].href.indexOf(extDoc[j]) != -1) {
				as[i].onclick=function(){var splitResult=this.href.split("/");__trackDownload(splitResult[splitResult.length-1]);}
				break;
			}
		}
	}
}

function __isValidForm(frmObj) {

    for (var i = 0; i < frmObj.length; i++) {
        var element = frmObj.elements[i];
        if (typeof element.type != "undefined" && typeof element.type != "undefined") {
            /*
            if (element.type.indexOf("checkbox") == 0 || element.type.indexOf("radio") == 0 || element.type.indexOf("select") == 0 ||
                element.type.indexOf("text") == 0 || element.type.indexOf("image") == 0 || element.type.indexOf("password") == 0 ||
                element.type.indexOf("reset") == 0 || element.type.indexOf("submit") == 0 || element.type.indexOf("textarea") == 0) {
                    if(element.type.indexOf("password") == 0 || element.onclick != null) {
                        return false;
                    }
            }
            */

            if (element.type.indexOf("hidden") == 0 && element.name != null &&  element.name == "ac_ignore" && element.value == "true") {
                return false;
            }
        }
    }
    return true;
}

/* Function to get a form's values in a string */
function getFormAsString(frmObj, prefix) {
    var query = "";
    var prefixParam="";
    if(prefix != null && prefix != undefined){
        prefixParam = prefix;
    }

    for (var i = 0; i < frmObj.length; i++) {
        var element = frmObj.elements[i];
        if (typeof element.type != "undefined" && typeof element.type != "undefined") {
            if (element.type.indexOf("checkbox") == 0 || element.type.indexOf("radio") == 0) {
                if (element.checked) {
                    query += prefixParam + element.name + '=' + escape(element.value) + "&";
                }
            } else if (element.type.indexOf("select") == 0) {
                for (var j = 0; j < element.length ; j++) {
                    if (element.options[j].selected) {
                        query += prefixParam + element.name + '=' + escape(element.value) + "&";
                    }
                }
            } else {
                if (element.type.indexOf("text") == 0 || element.type.indexOf("image") == 0 || element.type.indexOf("password") == 0 || element.type.indexOf("reset") == 0 || element.type.indexOf("submit") == 0 || element.type.indexOf("textarea") == 0) {
                    query += prefixParam + element.name + '=' + escape(element.value) + "&";
                }
            }
        }
    }
    return query;
}

/* This method is used to track online forms. */
function __trackForm(form, index) {
    if (form==null) return;

    var onSubmitFunction = form.onsubmit;

    if (onSubmitFunction != null) {
        __current_form_[index] = form
        __current_index_ = index;
        var onSubmitStr = onSubmitFunction.toString();

        if(onSubmitStr.search(/this[\)]/))
            onSubmitStr = onSubmitStr.replace(/this[\)]/g, '__current_form_[__current_index_])');
        if(onSubmitStr.search(/this[\,]/))
            onSubmitStr = onSubmitStr.replace(/this[\,]/g, '__current_form_[__current_index_],');
        if(onSubmitStr.search(/this[\.]/))
            onSubmitStr = onSubmitStr.replace(/this[\.]/g, '__current_form_[__current_index_].');
        if(onSubmitStr.search(/this[\s]/))
            onSubmitStr = onSubmitStr.replace(/this[\s]/g, '__current_form_[__current_index_] ');

        var expr = "__originalACOnSubmitFunction[__current_index_] = " + onSubmitStr;
        eval(expr);
    }
    if (form.retURL != null) __wtlRetURL[index] = form.retURL.value;
    form.onsubmit = function(event) {
        return __submitACForm(form, index);
    };
}

function submitAfterTrack(form, index) {
    __isSubmit[index] = true;
    if (form.submit && form.submit.value != null) {
        form.submit.click();
    } else if (form.Submit && form.Submit.value != null) {
        form.Submit.click();
    } else {
        form.submit();
    }
}

function __submitACForm(form, index) {
    if (!__isSubmit[index]) {
        __current_index_ = index;
        //only if the form has a onsubmit method
        try {
            if (__originalACOnSubmitFunction[index] != null && __originalACOnSubmitFunction[index]() == false) {  // very important that this is == false rather than !
                return false;
            }
        } catch(e) { /* problems evaluating onSubmit function */ }

        var origAction = form.getAttribute('action');
        var formNameParam = escape(form.getAttribute("name"));
        var isOid = "false";
        var oidParam = "";
        if (origAction.indexOf('www.salesforce.com/servlet/servlet.WebToLead') != -1) {
            origAction = __wtlRetURL[index];
            if (form.oid != null && form.oid.value.length > 0 && form.oid.value.indexOf('undef') < 0) {
                oidParam = escape(form.oid.value);
                isOid = "true";
            }
        }

        if(typeof formNameParam == "undefined" || formNameParam == "undefined" || formNameParam == "null"){
            formNameParam = escape(document.title);
            if (typeof formNameParam == "undefined" || formNameParam == "undefined" || formNameParam == "null")
                formNameParam = "";
        }

        var action = "";
        if(__isIntegratedForm[index]) {
            action = _wt_http_protocol + _wt_url + "/form2.html?method=integratedForm";
        }
        else {
            action = _wt_http_protocol + _wt_url + "/form2.html?method=form2Lead";
        }


        if (origAction.indexOf('http://') == -1 && origAction.indexOf('https://') == -1) {//relative URL?
            if (origAction.indexOf("/") == 0) {
                var protocol = _am_lh.indexOf("http://") == 0 ? "http://" : "https://";
                origAction = protocol + document.domain + origAction;
            } else {
                origAction = _am_lh.substring(0, _am_lh.lastIndexOf("/") + 1) + origAction;
            }
        }

        if (__am_valueOf('__avc_'+__pid).length <= 0) {
            if(__avc != null && __avc_param_is_valid()) {
                _am_d.cookie = "__avc_" + __pid + "=" + __avc + "; path=/; expires=Sun, 18 Jan 2038 00:00:00 GMT;";
            } else {
                _am_d.cookie = "__avc_"+__pid+"=" + __am_uuid() + "; path=/; expires=Sun, 18 Jan 2038 00:00:00 GMT;";
            }
        }

        action += "&isoid=" + isOid;
        action += "&pid=" + __pid;
        action += "&avc=" + __am_valueOf('__avc_' + __pid);
        action += "&source=" + __am_valueOf('__asrc_' + __pid);
        action += "&alh=" + escape(__am_valueOf('__alh_' + __pid));
        action += "&keyword=" + __am_valueOf('__akw_' + __pid);
        action += "&origAction=" + escape(origAction);
        action += "&formName=" + formNameParam;
        action += "&oid=" + oidParam;
        action += "&pageUrl=" + encodeURIComponent(_am_d.location);

        if (window.__am_form) {
            action += "&formId=" + window.__am_form;
        }
        //start:form parameters

        if(!__isIntegratedForm[index]) {
            //name parameters
            if(typeof form.full_Name != "undefined" && typeof form.full_Name.value != "undefined") action += "&full_Name=" + escape(form.full_Name.value);
            if(typeof form.fullName != "undefined" && typeof form.fullName.value != "undefined") action += "&fullName=" + escape(form.fullName.value);
            if(typeof form.full_name != "undefined" && typeof form.full_name.value != "undefined") action += "&full_name=" + escape(form.full_name.value);
            if(typeof form.first_Name != "undefined" && typeof form.first_Name.value != "undefined") action += "&first_Name=" + escape(form.first_Name.value);
            if(typeof form.firstName != "undefined" && typeof form.firstName.value != "undefined") action += "&firstName=" + escape(form.firstName.value);
            if(typeof form.firstname != "undefined" && typeof form.firstname.value != "undefined") action += "&firstname=" + escape(form.firstname.value);
            if(typeof form.first_name != "undefined" && typeof form.first_name.value != "undefined") action += "&first_name=" + escape(form.first_name.value);
            if(typeof form.last_Name != "undefined" && typeof form.last_Name.value != "undefined") action += "&last_Name=" + escape(form.last_Name.value);
            if(typeof form.lastName != "undefined" && typeof form.lastName.value != "undefined") action += "&lastName=" + escape(form.lastName.value);
            if(typeof form.lastname != "undefined" && typeof form.lastname.value != "undefined") action += "&lastName=" + escape(form.lastname.value);
            if(typeof form.last_name != "undefined" && typeof form.last_name.value != "undefined") action += "&last_name=" + escape(form.last_name.value);

            if(typeof form.title != "undefined" && typeof form.title.value != "undefined") action += "&title=" + escape(form.title.value);
            if(typeof form.email != "undefined" && typeof form.email.value != "undefined") action += "&email=" + escape(form.email.value);
            if(typeof form.company != "undefined" && typeof form.company.value != "undefined") action += "&company=" + escape(form.company.value);
            if(typeof form.phone != "undefined" && typeof form.phone.value != "undefined") action += "&phone=" + escape(form.phone.value);
            //end:form parameters
        }
        else {
            var prefix="";
            if(formNameParam != null && formNameParam != undefined){
                prefix = formNameParam+"_";
            }
            else{
                prefix = "__integratedForm_";
            }

            action += "&"+getFormAsString(form, prefix);
        }
        var _am_image = new Image(1,1);
		_am_image.onload=function(){submitAfterTrack(form, index);};
		_am_image.src = action;

		return false;
	}
}

function populateForm(form, index) {
    var url = _wt_http_protocol + _wt_url + "/requestinfo.html";
    var fname = form.getAttribute('name');
    var action = form.action;
    if ((action.indexOf(_wt_http_protocol + _wt_url + "/form") != -1) || (action.indexOf(_wt_https_protocol + _wt_url + "/form") != -1)
          || (fname != null && typeof fname == "string" && fname.indexOf("acForm") != -1)
          || (action.indexOf('www.salesforce.com/servlet/servlet.WebToLead') != -1)) {
        var params = "?vip=" + _am_vip + "&avc=" + __am_valueOf('__avc_' + __pid) + "&pid=" + __pid + "&formIndex=" + index;
        url += params;
        recoverInfo(form, url, index);
    }
}

function recoverInfo(form,url, index) {
    var script = document.createElement('script');
    script.src = url;
    script.type = 'text/javascript';
    form.parentNode.appendChild(script);
}

function callback(index, fullName, firstName, lastName, email, companyName, phoneNumber) {
    var forms = document.getElementsByTagName('form');
    if (forms[index].full_Name != null)
        forms[index].full_Name.value = fullName;
    if (forms[index].fullName != null)
        forms[index].fullName.value = fullName;
    if (forms[index].full_name != null)
        forms[index].full_name.value = fullName;
    if (forms[index].first_Name != null)
        forms[index].first_Name.value = firstName;
    if (forms[index].firstName != null)
        forms[index].firstName.value = firstName;
    if (forms[index].first_name != null)
        forms[index].first_name.value = firstName;
    if (forms[index].last_Name != null)
        forms[index].last_Name.value = lastName;
    if (forms[index].lastName != null)
        forms[index].lastName.value = lastName;
    if (forms[index].last_name != null)
        forms[index].last_name.value = lastName;
    if (forms[index].email != null)
        forms[index].email.value = email;
    if (forms[index].company != null)
        forms[index].company.value = companyName;
    if (forms[index].phone != null)
        forms[index].phone.value = phoneNumber;
}

function trim(stringToTrim) {
    return stringToTrim.replace(/^\s+|\s+$/g,"");
}

function __getdomain(){
     var d=document.domain;
     if(d.substring(0,4)=="www.")
         d=d.substring(4,d.length);
     var a=d.split(".");
        var len=a.length;
     if(len<3)
         return d;
     var e=a[len-1];
     if(e.length<3)
         return d;
     d=a[len-2]+"."+a[len-1];
     return d;
}

function __trackDownload(fileName) {

    var action =  _wt_http_protocol + _wt_url + "/download.html?method=trackDownload";

    action += "&pid=" + __pid;
    action += "&avc=" + __am_valueOf('__avc_'+__pid);
    action += "&fileName=" + escape(fileName);

    var _am_image = new Image(1,1);
    _am_image.src = action;
    _am_image.onload=function() {_amVoid();}

    return true;
}

function __verifyDownload(formId, fileSource) {
    var link = _wt_http_protocol + _wt_url + "/form2.html?method=verify";
    link += "&avc=" + __am_valueOf('__avc_'+__pid) + "&formId=" + formId + "&redirectUrl=" + fileSource;
    window.location = link;
}

