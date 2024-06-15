/*
 *Created on : Oct 25, 2012, 01:02:49 PM
 *Author     : Harshtih
 *Description:Common Java Script File for Bulletindb
*/

//browser detection
var strUserAgent = navigator.userAgent.toLowerCase();
var isIE = strUserAgent.indexOf("msie") > -1;
var isNS6 = strUserAgent.indexOf("netscape6") > -1;
var isNS4 = !isIE && !isNS6  && parseFloat(navigator.appVersion) < 5;
//regular expressions
var reValidChars = /^[-]?([1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|\.[0-9]{1,2})$/; //\d/;
var reValidString = /^[-]?([1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|\.[0-9]{1,2})$/; ///^\d*$/;
var reKeyboardChars = /[\x00\x03\x08\x0D\x16\x18\x1A\x2E]/;
var reClipboardChars = /[cvxz]/i;

var vEscCloseDiv=false;

function fnValidCharSet(pwd, charset)
{
    var i;
    var bret;
    var l;
	var charat;
    
    bret=false;
    l=pwd.length;
   
     // check for Capital Alphabets
    for (i=0; i<l; i++)
    {
        charat=pwd.charAt(i);
        if (charset.indexOf(charat) !== -1)
        {            
            bret=true;                                 
            break;
         }                              
    }    
    return bret;
}

function fnValidPwd(pPWD, pText) {
    var pwd, chr;
    var InvLet=" /\\[]:;|=,+*?<>@\"";
    var CapLet="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var SmLet="abcdefghijklmnopqrstuvwxyz";
    var numLet="0123456789";
    
    pwd = pPWD;
    // length 
    if ( pwd.length < 7 ) {
        alert(pText + "Password should be of minimum 7 characters");
        return false;
    }
    // invalid char
    for (var i=0; i< pwd.length; i++)
    {
        chr=pwd.charAt(i);
        if (InvLet.indexOf(chr) !== -1)
        {            
          alert(pText + " contains invalid character: " + chr + ". \nPassword should not contain characters " + InvLet) ;
          return false;
        }
    }
    var icd = 0;
    if (fnValidCharSet(pwd,CapLet) === true) {
           icd = icd + 1;  
    }
    if (fnValidCharSet(pwd, SmLet) === true) {
           icd = icd + 1;  
    }
    if (fnValidCharSet(pwd, numLet) === true) {
           icd = icd + 1;  
    }
    for (var i=0; i< pwd.length; i++)
    {
        chr=pwd.charAt(i);
        if (numLet.indexOf(chr) === -1)     // if not Digit
        {            
            if(CapLet.indexOf(chr) === -1)    // if not Capital letter
            {
                if(InvLet.indexOf(chr) === -1) // if not notallowed letter            
                {   
                    if (SmLet.indexOf(chr) === -1)   // if not smallcase  letter
                    {   
                        icd = icd + 1 ;                       
                        break;                        
                    }
                }
           }
        }                              
    }
    if (icd >= 3) {
        return true;
    } else {
        alert(pText + " password does not meet the minimum complexity.");
        return false;
    }
}

function fnShowSubPage(pgsrc) {
    if (pgsrc === 'tc') {
        $('#spIframe').css('width', '600px');
        $('#spIframe').css('height', '400px');
        $('#spIframe').attr('src', 'terms.html');
        $('#dialogSubPage').dialog('option', 'title', 'Terms & Conditions');
    } 
    else if (pgsrc === 'con') {
        $('#spIframe').css('width', '400px');
        $('#spIframe').css('height', '200px');
        $('#spIframe').attr('src', 'contact.html');
        $('#dialogSubPage').dialog('option', 'title', 'Contact us');
    }
    else if (pgsrc === 'a2ed') {
        $('#spIframe').css('width', '600px');
        $('#spIframe').css('height', '400px');
        $('#spIframe').attr('src', 'disclaimer.html');
        $('#dialogSubPage').dialog('option', 'title', 'Translation Disclaimer');
    }

    $('#dialogSubPage').dialog('open');
}

function PageQuery(q) {
    if(q.length > 1) this.q = q.substring(1, q.length);
    else this.q = null;
    this.keyValuePairs = new Array();
    if(q) {
        for(var i=0; i < this.q.split("&").length; i++) {
            this.keyValuePairs[i] = this.q.split("&")[i];
        }
    }
    this.getKeyValuePairs = function() { return this.keyValuePairs; };
    this.getValue = function(s) {
            for(var j=0; j < this.keyValuePairs.length; j++) {
                if(this.keyValuePairs[j].split("=")[0] === s)
                return this.keyValuePairs[j].split("=")[1];
            }
            return false;
        };
    this.getParameters = function() {
            var a = new Array(this.getLength());
            for(var j=0; j < this.keyValuePairs.length; j++) {
                a[j] = this.keyValuePairs[j].split("=")[0];
            }
            return a;
        };
    this.getLength = function() { return this.keyValuePairs.length; } ;
}

function queryString(key){
    var page = new PageQuery(window.location.search); 
    return unescape(page.getValue(key)); 
}

function fnClearForm(form) {
    $('#' + form).trigger('reset');
    return;
    //alert("ok");
  // iterate over all of the inputs for the form
  // element that was passed in
    $(':input', form).each(function() {
        var type = this.type;
        var tag = this.tagName.toLowerCase(); // normalize case
        // it's ok to reset the value attr of text inputs,
        // password inputs, and textareas
        if (type === 'text' || type === 'password' || tag === 'textarea')
          this.value = "";
        // checkboxes and radios need to have their checked state cleared
        // but should *not* have their 'value' changed
        else if (type === 'checkbox' || type === 'radio')
          this.checked = false;
        // select elements need to have their 'selectedIndex' property set to -1
        // (this works for both single and multiple select elements)
        else if (tag === 'select')
          this.selectedIndex = -1;
    });
}
                
function fnAddJS(jsname, pos) {
    var th = document.getElementsByTagName(pos)[0];
    var s = document.createElement('script');
    s.setAttribute('type','text/javascript');
    s.setAttribute('src',jsname);
    th.appendChild(s);
}
// String prototype startswith
if (typeof String.prototype.startsWith !== 'function') {
  // see below for better implementation!
    String.prototype.startsWith = function (str){
        return this.indexOf(str) === 0;
    };
}
if (typeof String.prototype.replaceAll !== 'function') {
    String.prototype.replaceAll = function (find, replace) {
    var str = this;
    return str.replace(new RegExp(find.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&'), 'g'), replace);
};
}
//mask functions \x2E
function fnMaskKeyPress(objEvent) {
      var iKeyCode, strKey, objInput;
      if (isIE) {
          iKeyCode = objEvent.keyCode;
              objInput = objEvent.srcElement;
      } else {
          iKeyCode = objEvent.which;
              objInput = objEvent.target;
      }
      strKey = String.fromCharCode(iKeyCode);
      if (isValid(objInput.value)) {
              objInput.validValue = objInput.value;
              if (!reValidChars.test(strKey) && !reKeyboardChars.test(strKey) && !checkClipboardCode(objEvent, strKey)) {
                  alert("Invalid Character Detected!\nKeyCode = " + iKeyCode + "\nCharacter =" + strKey);
                  return false;
              }
      } else {
              alert("Invalid Data");
              objInput.value = objInput.validValue;
              return false;
      }
      return true;
}

// usage - onkeypress="fnMaskInputTo(this, 12, 2, false);"
function fnMaskInputTo(inputElement, maxLength, decimalPlaces, NegA) {
    var i,exceptions=[8,46,37,39,13,9];   // backspace, delete, arrowleft & right, enter, tab
    var isException=false;
    var isNeg=false;
    //alert(event.keyCode);
    var isDot=((190===event.keyCode)&&(new String(inputElement.value).indexOf(".")<=0));       // dot
    isNeg=((45===event.keyCode) && (new String(inputElement.value).indexOf("-")<0));       // dot
    var k=String.fromCharCode(event.keyCode);

    //alert(event.keyCode);
    var sel, rng, r2, curPos=-1;

    //alert(isNeg);
    if(typeof inputElement.selectionStart === "number") {
        curPos=inputElement.selectionStart;
    } 
    else if(document.selection && inputElement.createTextRange) {
        sel = document.selection;
        if(sel) {
            r2=sel.createRange();
            rng=inputElement.createTextRange();
            rng.setEndPoint("EndToStart", r2);
            curPos=rng.text.length;
        }
    }
    
    for(i=0;i<exceptions.length;i++)
        if(exceptions[i]===event.keyCode)
            isException=true;

    if(isNaN(k) && (!isException) && (!isDot) && (!isNeg))
        event.returnValue=false;
    else 
    {
        var p=new String(inputElement.value+k).indexOf(".");
        var n=new String(inputElement.value).indexOf("-");
        var d=new String(inputElement.value).indexOf(".");
        //alert(d);
        if(((p<inputElement.value.length-decimalPlaces && curPos>p) || isDot) && p>-1 && (!isException))
            event.returnValue=false;
        else if(inputElement.value.length>=((p>-1)||isDot?maxLength+1:maxLength) && (!isException))
            event.returnValue=false;
        else if (k === "." && (decimalPlaces!==0) && (d > 0))
            event.returnValue=false;
        else if (decimalPlaces===0 && isDot)
            event.returnValue=false;
        else if (k === "-" && !NegA)
            event.returnValue=false;
        else if (k === "-" && (((n === 0) && (!NegA || !isNeg)) && (!isException))) {
            event.returnValue=false;
        }

        if (k === "-" && ((n < 0)&& (NegA || !isNeg))) {
            inputElement.value = "-"+inputElement.value;
            event.returnValue=false;
        }
    }
}

function fnKeydownfn(e, evntHdlrName, formName)
{
    var nav4;
    var keyPressed;
    //check if the brower is Netscape Navigator 4 or not
    nav4 = window.Event ? true : false;

	//if browser is Navigator 4, the key pressed is called <event object>.which else it's called <event object>.keyCode
	keyPressed = nav4 ? e.which : e.keyCode;

    if (keyPressed === 13)
    {
        if (evntHdlrName !== "")
		{
			// append empty parentheses if none given
			if(evntHdlrName.substr(evntHdlrName.length-1) !== ")")
				evntHdlrName += "()";
			eval(evntHdlrName);
        }
        else
        {
			if (formName === "")
				formName = 0;
            document.forms[formName].submit();
        }
    }
    return true;
}

function fnCheckClipboardCode(objEvent, strKey) {
    if (isNS6)
        return objEvent.ctrlKey && reClipboardChars.test(strKey);
    else
        return false;
}

function fnMaskChange(objEvent) {
        var objInput;

        if (isIE) {
        objInput = objEvent.srcElement;
        } else {
        objInput = objEvent.target;
        }

        if (!isValid(objInput.value)) {
        alert("Invalid data");
                objInput.value = objInput.validValue || "";
                objInput.focus();
        objInput.select();
        } else {
                objInput.validValue = objInput.value;
        }
}

function fnMaskPaste(objEvent) {
    var strPasteData = window.clipboardData.getData("Text");
    var objInput = objEvent.srcElement;

    if (!isValid(strPasteData)) {
        alert("Invalid data");
        objInput.focus();
        return false;
    }
    return true;
}

function fnGetHeight(){
    var body = document.body,
    html = document.documentElement;

    var height = Math.max( body.scrollHeight, body.offsetHeight, 
                       html.clientHeight, html.scrollHeight, html.offsetHeight );
    return height;
}

function fnGetWidth(){
    var body = document.body,
    html = document.documentElement;

    var Width = Math.max( body.scrollWidth, body.offsetWidth, 
                       html.clientWidth, html.scrollWidth, html.offsetWidth );
    return Width;
}

function fnAutoCaps(o){o.value=o.value.toUpperCase().replace(/([^0-9A-Z\s])/g,"");}


// function added on 23-12-2003 to disable F5 and CTRL R key to solve refresh problem
function fnMicrosoftKeyDown()
{
    var rval=true;
    // F5 AND CTRL-R DISABLED
    try
    {
        if ((window.event.ctrlKey) &&
            (window.event.keyCode===82))
        {
                event.keyCode = 0;
                event.returnValue = false;
                event.cancelBubble = true;
                rval= false;

        }
        else if ((window.event) &&
            (window.event.keyCode === 116))
        {
                event.keyCode = 0;
                event.returnValue = false;
                event.cancelBubble = true;
                rval =false;
        }
    }
    catch(e)
    {
    }
    return rval;
}
// manipulation functions
////////////////////////////////////////////////////////////////////////////////
function fnFocus(ctlName, select){
    if ($('#'+ctlName).length !== 0) {
        $('#'+ctlName).focus();
        if (select)
            $('#'+ctlName).select();
    }
//    else
//        document.getElementById(ctlName).select();
}

function fnShowPMRow(param)
{
    if ($('#'+param+'Row').length === 0) {
        alert("Please check the program. (ShowRow:row:"+ param +").");
        return ;
    }
    if ($('#'+param).length === 0) {
        alert("Please check the program. (ShowRow:img:"+ param +").");
        return ;
    }
    var row = document.getElementById(param+'Row');
    var img = document.getElementById(param);

    if (row.style.display === 'none') {
        row.style.display = '';
        if (img!==null) { img.src = "images/exminus.jpg"; }
    }else{
        row.style.display = 'none';
        if (img!==null) { img.src = "images/explus.jpg"; }
    }
}

function fnShowHideElement(opt) {
     if ($('#'+opt).length === 0) {
         alert("Please check the program. (fnShowHideElement:"+opt+").");
        return ;
    }
    var cnt = document.getElementById(opt);
    if (cnt.style.display === 'none') {
        cnt.style.display = '';
    } else {
        cnt.style.display = 'none';
    }
}

function fnSortList(param) {
    var lb = document.getElementById(param);
    
    arrTexts = new Array();
    for(i=0; i<lb.length; i++)  {
         arrTexts[i] = lb.options[i].text + '|' + lb.options[i].value;
    }
    arrTexts.sort();
    //alert(arrTexts);
    for(i=0; i<lb.length; i++)  {
        lb.options[i].text = arrTexts[i].split("|")[0];
        lb.options[i].value = arrTexts[i].split("|")[1];
    }
}

function fnClearCbo(param)
{
    var cbo = document.getElementById(param);
    var lsize = cbo.options.length;
    while (lsize!==0){
        lsize = cbo.options.length-1;
        cbo[lsize] =null;
    }
    
    var ogl=cbo.getElementsByTagName('optgroup');
    for (var i=ogl.length-1; i>= 0; i--){
      cbo.removeChild(ogl[i]) ;
    }
}

function fnSetCbo(opt, val) {
    if ($('#'+opt).length === 0) {
        return;
    }
    var cbo = document.getElementById(opt);
    for( i=0; i< cbo.length; i++){
        if (val===cbo[i].value) {
            cbo[i].selected = true;
        }
    }
}

function fnSetCboMulti(opt, val) {
    if ($('#'+opt).length === 0) {
        return;
    }
    var cbo = document.getElementById(opt);
    for( i=0; i< cbo.length; i++){
        if ( val.indexOf(cbo[i].value) !== -1) {
            cbo[i].selected = true;
        } 
        else {
            cbo[i].selected = false;
        }
    }
}

function fnLockCbo(opt, val) {
    if ($('#'+opt).length === 0) {
        return;
    }
    var cbo = document.getElementById(opt);
    for( i=0; i< cbo.length; i++){
        if (val===cbo[i].value)
            cbo[i].selected = true;
    }
}

function fnGetText(opt) {
    if ($('#'+opt).length === 0) {
        return "";
    }
    return document.getElementById(opt).value;
}

function fnGetParamsVal(arr, sFilter, val, pos) {
    for( i=0; i< arr.length; i++){
        if (arr[i].split("|")[0] === sFilter){
            if (arr[i].split("|")[1] === val)
                return (arr[i].split("|")[pos]);
        }
    }
    return "0";
}

function fnGetComboText(opt, arr, sFilter, pos) {
    if ($('#'+opt).length === 0) {
        return "";
    }
    var cbo = document.getElementById(opt);
    var val = cbo.value;
    for( i=0; i< arr.length; i++){
        if (arr[i].split("|")[0] === sFilter){
            if (arr[i].split("|")[1] === val)
                return (arr[i].split("|")[pos]);
        }
    }
    return "";
}

function fnFillCombo( opt, arr, sFilter, addValue, sWhr)
{
    if ($('#'+opt).length === 0) {
        return;
    }
    fnClearCbo(opt);
    var cbo = document.getElementById(opt);
    var count =0;
    if (addValue.substr(0,1)==="A") {
        cbo[count] = new Option("All", addValue.substr(1,1));
        count++;
    }
    if (addValue.substr(0,2)==="0A") {
        cbo[count] = new Option("All", addValue.substr(0,1));
        count++;
    }
    if (addValue.substr(0,3)==="UAS") {
        //alert(opt);
        cbo[count] = new Option("\ufeff\u0627\u0644\u0631\u062c\u0627\u0621 \u0627\u0644\u0625\u062e\u062a\u064a\u0627\u0631", "0");
        count++;
    }
    if (addValue.substr(0,1)==="S") {
        cbo[count] = new Option("Please Select", addValue.substr(1,1));
        count++;
    }

    if (addValue.substr(0,1)==="E") {
        cbo[count] = new Option("", "0");
        count++;
    }
    if (addValue==="NEW@B") {
        cbo[count] = new Option("-- Add New--", "NEW");
        count++;
    }
    if (addValue==="NA0") {
        cbo[count] = new Option("NA", 0);
        count++;
    }
    for( i=0; i< arr.length; i++){
        
        if (arr[i].split("|")[0] === sFilter){
            if (sWhr) {
                if ((sWhr.indexOf(arr[i].split("|")[1]) !== -1) || sWhr === "") {
                    cbo[count] = new Option(arr[i].split("|")[2], arr[i].split("|")[1]);
                    count++;
                }
            }
            else {
                cbo[count] = new Option(arr[i].split("|")[2], arr[i].split("|")[1]);
                count++;
            }
        }
    }
    if (addValue==="NEW@E") {
        cbo[count] = new Option("-- Add New--", "NEW");
        count++;
    }
    if (addValue==="0NEW@E") {
        cbo[count] = new Option("-- Add New--", "0");
        count++;
    }
}

function fnFillComboGrp( opt, arr, sFilter, addValue, sWhr){
    if ($('#'+opt).length === 0) {
        return;
    }
    fnFillCombo( opt, arr, sFilter, addValue, sWhr);
    
    // make the grouping
    var lb = document.getElementById(opt);
    arrTexts = new Array();
    for(i=0; i<lb.length; i++)  {
         arrTexts[i] = lb.options[i].text + '|' + lb.options[i].value;
    }
    arrTexts.sort();
    var fv = "-";
    var ogrp;
    fnClearCbo(opt);
    var sel = document.getElementById(opt);
    for(i=0; i<arrTexts.length; i++)  {
        var txt = arrTexts[i].split("|")[0];
        var grp = txt.split("~")[0];
        if (fv !== grp) {
            fv = grp;
            ogrp = document.createElement("optgroup");
            if (grp === "") {
                grp = "Others"
            }
            ogrp.label= grp;
            sel.appendChild(ogrp);
        }
        var opt = document.createElement("option");
        opt.text = txt.split("~")[1];
        opt.value = arrTexts[i].split("|")[1];
        ogrp.appendChild(opt);
    }
}

function fnSetText(opt, val) {
    if ($('#'+opt).length === 0) {
        return;
    }
    var txt = document.getElementById(opt);
    txt.value = val;
}

function fnTrim(str, chars) {
    return ltrim(rtrim(str, chars), chars);
}

function fnLTrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
}

function fnRTrim(str, chars) {
    chars = chars || "\\s";
    return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
}

function fnImposeMaxLength(Event, Object, MaxLen) {
    return (Object.value.length <= MaxLen)||(Event.keyCode === 8 ||Event.keyCode===46||(Event.keyCode>=35&&Event.keyCode<=40));
}

function fnBlinkChange(opt)
{
    if ($('#'+opt).length === 0) {
        return;
    }
  document.getElementById(opt).style.color = "red";
  setTimeout("fnSetBlink('"+opt+"');", 1000);
}

function fnSetBlink(opt)
{
    if ($('#'+opt).length === 0) {
        return;
    }
    document.getElementById(opt).style.color= "blue";
    setTimeout("fnBlinkChange('"+ opt +"');", 1000);
}
////////////////////////////////////////////////////////////////////////////////

// for Dark layer
////////////////////////////////////////////////////////////////////////////////
function fnGetBrowserHeight() {
                var intH = 0;
                var intW = 0;

                intH=fnGetHeight();
                intW=fnGetWidth();
//                if(typeof window.innerWidth  == 'number' ) {
//                   intH = window.innerHeight;
//                   intW = window.innerWidth;
//                }
//                else if(document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
//                    intH = document.documentElement.clientHeight;
//                    intW = document.documentElement.clientWidth;
//                }
//                else if(document.body && (document.body.clientWidth || document.body.clientHeight)) {
//                    intH = document.body.clientHeight;
//                    intW = document.body.clientWidth;
//                }
                return { width: parseInt(intW), height: parseInt(intH) };
            }

function fnSetLayerPosition(pLayer) {
    var shadow = document.getElementById("shadow");
    var question = document.getElementById(pLayer);


    var bws = fnGetBrowserHeight();
    shadow.style.width = bws.width + "px";
    shadow.style.height = bws.height + "px";
    var qx = question.style.width;
    if (qx.toString().indexOf('%') !== -1){
        qx = bws.width * parseInt(qx) / 100;
    }

    question.style.left = parseInt((bws.width - parseInt(qx)) / 2) + "px";
    qx = question.style.height;
    if (qx.toString().indexOf('%') !== -1){
        qx = bws.height * parseInt(qx) / 100;
    }
    question.style.top = parseInt((bws.height - parseInt(qx)) / 2) + "px";

    shadow = null;
    question = null;
}

function fnShowLayer(pLayer) {
    fnSetLayerPosition(pLayer);

    var shadow = document.getElementById("shadow");
    var question = document.getElementById(pLayer);

    if (pLayer.substr(0, 4) === "data") {
      vEscCloseDiv=true;
    }
    shadow.style.display = "block";
    question.style.display = "block";

    shadow = null;
    question = null;
}

function fnHideLayer(pLayer) {
    //alert("ok");
    var shadow = document.getElementById("shadow");
    var question = document.getElementById(pLayer);


    shadow.style.display = "none";
    question.style.display = "none";


    shadow = null;
    question = null;
}

function fnSwithLayer(pLayer1, pLayer2){
    var pl1 = document.getElementById(pLayer1);
    var pl2 = document.getElementById(pLayer2);
    fnSetLayerPosition(pLayer2);
    pl1.style.display = "none";
    pl2.style.display = "block";
}

function fnCheckPageFullyLoaded(pLayer, pTimer){
               if(document.getElementById("LastElement")){
                   fnHideLayer(pLayer);
                   window.clearInterval(pTimer);
               }
            }
////////////////////////////////////////////////////////////////////////////////

// validate functions
////////////////////////////////////////////////////////////////////////////////
function isValid(strValue) {
        return reValidString.test(strValue) || strValue.length === 0;
}

function isValidEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\ ".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA -Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
    //return /^((([a-z]|\d|[!#\$%&'*+-/=\?\^_{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+))|((\x22)((((\x20|\x09)(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))(((\x20|\x09)(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))).)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(email);
}

// checks that an input string is an integer, with an optional +/- sign character.
function isValidInteger (s) {
   var isInteger_re     = /^\s*(\+|-)?\d+\s*$/;
   return String(s).search (isInteger_re) !== -1;
}

// Checks that an input string is a decimal number, with an optional +/- sign character.
function isValidDecimal (s) {
   var isDecimal_re     = /^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/;
   return String(s).search (isDecimal_re) !== -1;
}

// Check if string is currency
function isValidCurrency (s) {
   var isCurrency_re    = /^\s*(\+|-)?((\d+((\.\d\d)|(\.\d))?)|((\.\d\d)|(\.\d)))\s*$/;
   return String(s).search (isCurrency_re) !== -1;
}


function fnCheckDuplicateInTable(tbl, colidx, exrowID, cnt, lbl)
{
    var mv = fnGetText(cnt);
    var lblv;
    if (lbl.substr(0,3)==="lbl") {
        lblv = $.trim(document.getElementById(lbl).innerHTML);
    } else {
        lblv = lbl;
    }
    for (var i=1;i<=tbl.nbRows; i++){
        var sno = tbl.GetDataCell(i, 0);
        if ((sno !== exrowID) || (exrowID === 0) ){
            if (mv === tbl.GetDataCell(i, colidx)){
                msg = "'" + mv + "' already exists. \nPlease avoid the dubplicate "+ lblv +"!..." ;
                alert(msg);
                fnFocus(cnt, false);
                return false;
            }
        }
    }
    return true;
}

function fnValidateEmail(cnt, lbl) {
    var val = fnGetText(cnt);
    if (val!==""){
        if (!isValidEmail(val)) {
            if (lbl.substr(0,3)==="lbl") {
                msg = "Please enter the valid " + $.trim(document.getElementById(lbl).innerHTML);
            } else {
                msg = "Please enter the valid " + lbl;
            }
            alert(msg);
            //fnFocus(cnt, false);
            return false;
        }
    }
    return true;
}

function fnValidate(cnt, lbl, length) {
    var msg;
    if (cnt.substr(0,3)==="Txt") {
        if (fnGetText(cnt)==="") {
            if (lbl.substr(0,3)==="lbl") {
                msg = "Please enter the " + $.trim(document.getElementById(lbl).innerHTML);
            } else {
                msg = "Please enter the " + lbl;
            }
            alert(msg);
            fnFocus(cnt, false);
            return false;
        }
    } else {
        var v = fnGetText(cnt);
        if ((v==="0")|| (v===""))  {
            if (lbl.substr(0,3)==="lbl") {
                msg = "Please select the " + $.trim(document.getElementById(lbl).innerHTML);
            } else {
                msg = "Please select the " + lbl;
            }
            alert(msg);
            fnFocus(cnt, true);
            return false;
        }
    }

    if (length!==0) {
        if (fnGetText(cnt).length < length) {
            if (lbl.substr(0,3)==="lbl") {
                msg = "Please enter the valid " + $.trim(document.getElementById(lbl).innerHTML);
            } else {
                msg = "Please enter the valid " + lbl;
            }
            alert(msg);
            fnFocus(cnt, false);
            return false;
        }
    }
    return true;
}

////////////////////////////////////////////////////////////////////////////////
// TimeDiff( to, from)
function TimeDiff(a,b)
{
    var first = a.split(":");
    var second = b.split(":");
    var xx;
    var yy;        
    if(parseInt(first[0]) < parseInt(second[0]))
    {          
        if(parseInt(first[1]) < parseInt(second[1]))
        {
            yy = parseInt(first[1]) + 60 - parseInt(second[1]);
            xx = parseInt(first[0]) + 24 - 1 - parseInt(second[0]);
        }
        else
        {
          yy = parseInt(first[1]) - parseInt(second[1]);
          xx = parseInt(first[0]) + 24 - parseInt(second[0]);
        }
    }
    else if(parseInt(first[0]) === parseInt(second[0]))
    {
        if(parseInt(first[1]) < parseInt(second[1]))
        {
            yy = parseInt(first[1]) + 60 - parseInt(second[1]);
            xx = parseInt(first[0]) + 24 - 1 - parseInt(second[0]);
        }
        else
        {
          yy = parseInt(first[1]) - parseInt(second[1]);
          xx = parseInt(first[0]) - parseInt(second[0]);
        }
    }
    else
    {
        if(parseInt(first[1]) < parseInt(second[1]))
        {
            yy = parseInt(first[1]) + 60 - parseInt(second[1]);
            xx = parseInt(first[0]) - 1 - parseInt(second[0]);            
        }
        else
        {
          yy = parseInt(first[1]) - parseInt(second[1]);
          xx = parseInt(first[0]) - parseInt(second[0]);
        }
    }
    
    if(xx < 10){
        xx = "0" + xx;
    }
    if(yy < 10){
        yy = "0" + yy;
    }
    var m = (parseInt(xx) * 60) + parseInt(yy);
    //alert(xx + ":" + yy);
    return (m);
}

// 
// changeing the default alert to jquery alert dialog
// 
//window.alert = function(message){
//    $(document.createElement('div'))
//        .attr({title: 'Alert', 'class': 'alert'})
//        .html(message)
//        .dialog({
//            buttons: {OK: function(){$(this).dialog('close');}},
//            close: function(){$(this).remove();},
//            draggable: true,
//            modal: true,
//            resizable: false,
//            width: 'auto'
//        });
//};

//function fnMaskNumberInput() {
//    var key_code = window.event.keyCode;
//    var oElement = window.event.srcElement;
//    //alert(key_code);
//    if (!window.event.shiftKey && !window.event.ctrlKey && !window.event.altKey) {
//        if ((key_code > 47 && key_code < 58) ||
//            (key_code > 95 && key_code < 106)) {
//            if (key_code > 95)
//                 key_code -= (95-47);
//            oElement.value = oElement.value;
//        } else if (key_code === 46) {
//            //alert(oElement.value.indexOf("."));
//            if (oElement.value.indexOf(".")>-1)
//                event.returnValue = false;
//        } else if(key_code === 8) {
//            oElement.value = oElement.value;
//        } else if(key_code !== 9) {
//            event.returnValue = false;
//        }
//
//        var l = oElement.value.length;
//        var dp = oElement.value.indexOf(".");
//        if (dp>-1)
//            if ((l-dp) > 2 )
//                event.returnValue = false;
//    }
//}
