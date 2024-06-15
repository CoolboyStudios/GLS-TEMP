<%-- 
    Document   : newjsp
    Created on : Nov 15, 2012, 6:55:32 AM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <title>Upload files...</title>
  <link href="scripts/swfupload/default.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="scripts/swfupload/swfupload.js"></script>
  <script type="text/javascript" src="scripts/swfupload/swfupload.queue.js"></script>
  <script type="text/javascript" src="scripts/swfupload/fileprogress.js"></script>
  <script type="text/javascript" src="scripts/swfupload/handlers.js"></script>
  <script type="text/javascript" src="scripts/swfupload/session.js"></script>
    
    <script type="text/javascript">
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

        var swfu1;
        window.onload = function() {
            // Check to see if SWFUpload is available
            if (typeof(SWFUpload) === "undefined") {
                    return;
            }

            var settings = {
            // Backend Settings
                    flash_url : "scripts/swfupload/swfupload.swf",
                    upload_url: "upload?"
                            + "NPID=" + queryString("NPID") 
                            + "&DTREL=" + queryString("DTREL")
                            + "&NTID=" + queryString("NTID")
                            + "&PGNO=" + queryString("PGNO")
                            + "&RELNO=" + queryString("RELNO")
                            + "&ADNO=" + queryString("ADNO")
                        ,
                    assume_success_timeout: 10,
                    post_params : {},
            // File Upload Settings
                    file_size_limit : "10 MB",
                    file_types : "*.pdf;*.gif;*.png;*.img;*.jpg;*.tif",
                    file_types_description : "PDF and Web Images Filese",
                    file_upload_limit : 100,
                    file_queue_limit : 0,

                    custom_settings : {
                        progressTarget : "fsUploadProgress",
                        cancelButtonId : "btnCancel"
                    },
            // Debug Settings
                    debug: false,
                    use_query_string : true,

                    // Button settings
                    button_image_url: "scripts/swfupload/img/TestImageNoText_65x29.png",
                    button_width: "65",
                    button_height: "29",
                    button_placeholder_id: "spanButtonPlaceHolder",
                    button_text: '<span class="theFont" style="width:115px">Browse...</span>',
                    button_text_style: ".btnText { font-size: 10; font-weight: bold; font-family: MS Shell Dlg; }",
                    button_text_left_padding: 5,
                    button_text_top_padding: 3,
                    button_action : SWFUpload.BUTTON_ACTION.SELECT_FILES,

                    // The event handler functions are defined in handlers.js
                    file_queued_handler : fileQueued,
                    file_queue_error_handler : fileQueueError,
                    file_dialog_complete_handler : fileDialogComplete,
                    upload_start_handler : uploadStart,
                    upload_progress_handler : uploadProgress,
                    upload_error_handler : uploadError,
                    upload_success_handler : uploadSuccess,
                    upload_complete_handler : uploadComplete,
                    queue_complete_handler : queueComplete	// Queue plugin event
            };

            swfu1 = new SWFUpload(settings);
        };
    </script>
    </head>
    <body>
        <form>
            <div class="fieldset flash" id="fsUploadProgress">
			<span class="legend">Upload Queue</span>
			</div>
		<div id="divStatus">0 Files Uploaded</div>
			<div>
				<span id="spanButtonPlaceHolder"></span>
				<input id="btnCancel" type="button" value="Cancel All Uploads" 
                       onclick="swfu.cancelQueue();" disabled="disabled" 
                       style="margin-left: 2px; font-size: 8pt; height: 29px;" />
                <input id="btnClose" type="button" value="Close" 
                       onclick="javascript:var URL = unescape(window.opener.location.pathname);window.opener.location.href = URL; window.close();"
                       style="margin-left: 2px; font-size: 8pt; height: 29px;" />
			</div>
        </form>
    </body>
</html>
