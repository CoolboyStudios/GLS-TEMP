<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScan Initiation...</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <link type="text/css" href="includes/apps.css" rel="stylesheet">
        <script type="text/javascript">
            function funRedirectPage() {
                //document.FrmInit.txtWidth.value = screen.width;
                //document.forms["FrmInit"].action = "maintenance.htm";
                //document.forms["FrmInit"].submit();
                
                NewWindow("actions?req=init", "login", screen.width, screen.height, 'yes', '');
            }
            var win = null;

            function NewWindow(mypage,myname,w,h,scroll,pos){
                if (pos === "random"){
                    LeftPosition = (screen.width) ? Math.floor(Math.random()*(screen.width-w)) : 100;
                    TopPosition = (screen.height) ? Math.floor(Math.random()*((screen.height-h)-75)) : 100;
                }

                if (pos === "center"){
                    LeftPosition = (screen.width) ? (screen.width-w)/2 : 100;
                    TopPosition = (screen.height) ? (screen.height-h)/2 : 100;
                } 
                else if ((pos !== "center" && pos !== "random") || pos === null){
                    LeftPosition = 0;
                    TopPosition = 20;
                }

                settings = 'width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';
                win = window.open(mypage,myname,settings);
            }
        </script>
    </head>
    <body onload="funRedirectPage();">
        <form name="FrmInit" action="actions?req=init" method="post">
            <input name="txtWidth" type="hidden" id="txtWidth">
        </form>  
    </body>
</html>
