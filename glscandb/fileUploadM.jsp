<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>myCollect - Excel file upload</title>
        <link type="image/icon" href="images/sysicon.png" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            @import "scripts/jquery/smoothness/ui.dropdownchecklist.themeroller.css";
        </style>
        
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
                        
            function funUpload() {
                
                //var filename = $("#file").val().replace(/C:\\fakepath\\/i, '');
                //return false;
                
                //var ext = $('#file').val().split('.').pop().toLowerCase();
                //if(ext !== 'xls' && ext !== 'xlsx') {
                //    alert('Please upload excel file only.');
                //    return false;
                //}
                
                // Calling AJAX
                //var formData =new FormData($("#frmUpld"));
                
                
                //var myform = document.getElementById("frmUpld");
                //var formData = $("#frmUpld").serializeArray(); //new FormData(myform );
                
                var data = new FormData();
                $.each($("#file")[0].files, function (key, file){
                    data.append(key, file);
                });  

                $.each($('#frmUpld').serializeArray(), function (i, obj) {
                    data.append(obj.name, obj.value);
                });
                
                var urlQP = "UploadSCls?"
                            + "NPID=" + queryString("NPID") 
                            + "&DTREL=" + queryString("DTREL")
                            + "&NTID=" + queryString("NTID")
                            + "&PGNO=" + queryString("PGNO")
                            + "&RELNO=" + queryString("RELNO")
                            + "&ADNO=" + queryString("ADNO");
                
                $.ajax({
                    url : urlQP,
                    type : 'post',
                    data : data,
                    contentType : false,
                    cache : false,
                    processData : false,
                    success : function(response) {
                        alert(response);
                        $('#msgframe').html(response);
                        //alert(filename);
                        //myUploadComplete(filename);
                        //myform.reset();
                    },
                    beforeSend : function() {
                        $('#msgframe').html('<h1>Uploading, Please wait...</h1>');
                    },
                    error: function (jqXHR, exception) {
                        var msg = '';
                        if (jqXHR.status === 0) {
                            msg = 'Not connect.\n Verify Network.';
                        } else if (jqXHR.status === 404) {
                            msg = 'Requested page not found. [404]';
                        } else if (jqXHR.status === 500) {
                            msg = 'Internal Server Error [500].';
                        } else if (exception === 'parsererror') {
                            msg = 'Requested JSON parse failed.';
                        } else if (exception === 'timeout') {
                            msg = 'Time out error.';
                        } else if (exception === 'abort') {
                            msg = 'Ajax request aborted.';
                        } else {
                            msg = 'Uncaught Error.\n' + jqXHR.responseText;
                        }
                        $('#msgframe').html(msg);
                    }
                });
                funDisable();
                return false;
            }
            function funEnable() {
                $(':input').removeAttr('disabled');
            }
            function funDisable() {
                $('#frmUpld').trigger('reset');
                $('#btnUpd').prop('disabled', true);
                $('#btnClear').prop('disabled', true);
            }
            
            function funClose() {
                var openerWindow = null;
                if (window.dialogArguments) { // Internet Explorer
                    openerWindow = window.dialogArguments;
                } 
                else {        // Firefox, Safari, Google Chrome and Opera
                    if (window.opener) {
                        openerWindow = window.opener;
                    }
                }
                if (openerWindow) {
                    window.close();
                    openerWindow.fnHideLayer("waitLayer");
                } 
                else {
                    window.close(); 
                }
            }
        </script>
    </head>
  
    <body> 
        <div><h3>File Upload ...</h3></div>
        <form id="frmUpld" name="frmUpld" method="post" enctype="multipart/form-data">
            <input type="file"  name="file[]" required="required"  multiple id="file"
                   accept="image/gif,image/jpeg,image/jpg"
                   onchange="funEnable()">
            <br><div id="msgframe"></div><br>
            <input id="btnUpd" type="button" value="Upload" onclick="funUpload();" disabled>
            <input id="btnClear" type="button" value="Clear" disabled onclick="funDisable()">
            <input id="btnClose" type="button" value="Close" onclick="funClose()"
        </form>
    </body>
</html>