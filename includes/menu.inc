<ul id="menu">
    <li><a href="actions?req=mnu100"><span class="ui-icon ui-icon-home"></span>Home</a></li>
    <li><a href="actions?req=mnu200"><span class="ui-icon ui-icon-search"></span>Notice Search</a></li>
    <li id="mnuWatch"><a href="javascript:funMnuWatch();"><span class="ui-icon ui-icon-bookmark"></span>Watch List</a></li>
    <li><a href="actions?req=mnu800"><span class="ui-icon ui-icon-key"></span>Change Password</a></li>
    <li><a id="logout" href="actions?req=mnu900"><span class="ui-icon ui-icon-power"></span>Logout</a></li>
</ul>

    <script type="text/javascript">
        $(document).ready(function() {
            $( "#menu" ).menu({
                position: {at: "left bottom"}
            });
        });
    </script>
    <style type="text/css">
        .ui-menu { overflow: hidden;}
        .ui-menu .ui-menu { overflow: visible !important; }
        .ui-menu > li { float: left; display: block; width: auto !important; }
        .ui-menu > li { margin: 2px 5px !important; padding: 0 0 !important; }
        .ui-menu > li > a { float: left; display: block; clear: both; overflow: hidden;}
        .ui-menu .ui-menu-icon { margin-top: 0.3em !important;}
        .ui-menu .ui-menu .ui-menu li { float: left; display: block;}    
        #menu {border: none}
    </style>