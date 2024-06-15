// items structure
// each item is the array of one or more properties:
// [text, link, settings, subitems ...]
// use the builder to export errors free structure if you experience problems with the syntax

var MENU_ITEMS_ADMIN = [
    ['<span class="ui-icon ui-icon-home"></span> Home', "Actions?req=mnu100"],
    ['<span class="ui-icon ui-icon-gear"></span> Config', null, null,
        ['Branches - افرع',   "Actions?req=mnu201BR"],
        ['Country - بلد',  "Actions?req=mnu201CO"],
        ['Newspaper - الجريدة',  "Actions?req=mnu201NP"],
        ['Notice Types - إشعار نوع',  "Actions?req=mnu201NT"],
        //['Client Licenses - تراخيص العملاء', "Actions?req=mnu207"],
        //['Client Users - عميل المستخدم', "Actions?req=mnu208"],
        ['User Manager - إدارة المستخدمين', "Actions?req=mnu209"],
        ['Subscriptions - تراخيص العملاء', "Actions?req=mnu207"],
        ['Subscriber Users - عميل المستخدم', "Actions?req=mnu208&CSID=0"]
    ],
    ['<span class="ui-icon ui-icon-pencil"></span> Actions', null,null,
        ['Upload Bulletins - تحميل', "Actions?req=mnu303UP"],
        ['Work Allocation - توزيع العمل', "Actions?req=mnu304N"],
        ['My Pendings - المهام المتبقية', "Actions?req=mnu302MP"],
        //['New bulletin - جديدة النشرة', "Actions?req=mnu301N"],
        //['Data Verfication - تاكيد', "Actions?req=mnu302MCP"],
        ['Search - بحث', "Actions?req=mnu302SL"],
        ['Ads Check', "frmCheck.jsp"]
        //['Hot list - قائمة الاهتمام', "Actions?req=mnu303"],
        //['Upload Hot list - تحميل', "Actions?req=mnu309"]
    ],
    ['<span class="ui-icon ui-icon-document"></span>Reports', null, null,
        ['Control Sheet', "Actions?req=rpt400"],  // add 18-05-2015
        ['Upload Details', "Actions?req=rpt401"],
        ['Pending Allocation', "Actions?req=rpt402"],
        ['Allocation Details', "Actions?req=rpt403"],
        ['Pending Job', null, null,
            ['New - User wise', "Actions?req=rpt4041"],
            ['Notice for Verification', "Actions?req=rpt4042"],
            ['Notice to Fix Data Error', "Actions?req=rpt4043"]
        ],
        ['Productivity', null, null,
            ['Detail Userwise', "Actions?req=rpt4071"],
            ['Summary Userwise', "Actions?req=rpt4072"],
            ['News paperwise', "Actions?req=rpt4073"]
        ],
        ['Bulletin Summary', "Actions?req=rpt406"],
        ['Params List', null, null,
            ['Branches - افرع',   "Actions?req=rpt405BR"],
            ['Newspaper - الجريدة',  "Actions?req=rpt405NP"],
            ['Notice Types - إشعار نوع', "Actions?req=rpt405NT"]
        ],
        ['Client', null, null,
            ['Subscription register', "Actions?req=rpt4081"],
            ['User Register', "Actions?req=rpt4082"],
            ['User access log', "Actions?req=rpt4083"],
            ['Watch list summary user wise', "Actions?req=rpt4084"],
            ['Report Generation - Subscriber Month wise', "Actions?req=rpt40851"],
            ['Report Generation - User Date wise', "Actions?req=rpt40852"],
            ['Report Generation Details', "Actions?req=rpt40853"]
        ]
    ],
    ['<span class="ui-icon ui-icon-key"></span> Change Password', "Actions?req=mnu800"],
//    ['CR Actions', null,null,
//        ['Request', "Actions?req=mnu311R"],
//        ['Search Ads', "Actions?req=mnu311S"],
//        ['Translate', "Actions?req=mnu311T"],
//        ['Translate Verifiy', "Actions?req=mnu311V"],
//        ['Report Generate', "Actions?req=mnu311C"],
//        ['Request list', "Actions?req=rpt411"]
//    ],
    ['<span class="ui-icon ui-icon-power"></span> Logout', "Actions?req=mnu900"]
];

var MENU_ITEMS_SADMIN = [
    ['<span class="ui-icon ui-icon-home"></span> Home', "Actions?req=mnu100"],
    ['<span class="ui-icon ui-icon-gear"></span> Config', null, null,
        ['Subscriptions - تراخيص العملاء', "Actions?req=mnu207"],
        ['Subscriber Users - عميل المستخدم', "Actions?req=mnu208&CSID=0"]
    ],
    ['<span class="ui-icon ui-icon-document"></span> Reports', null, null,        
        ['Subscription register', "Actions?req=rpt4081"],
        ['User Register', "Actions?req=rpt4082"],
        ['User access log', "Actions?req=rpt4083"],
        ['Watch list summary user wise', "Actions?req=rpt4084"],
        ['Report Generation - Subscriber Month wise', "Actions?req=rpt40851"],
        ['Report Generation - User Date wise', "Actions?req=rpt40852"],
        ['Report Generation Details', "Actions?req=rpt40853"]            
    ],
    ['<span class="ui-icon ui-icon-key"></span> Change Password', "Actions?req=mnu800"],
    ['<span class="ui-icon ui-icon-power"></span> Logout', "Actions?req=mnu900"]
];

// items structure
// each item is the array of one or more properties:
// [text, link, settings, subitems ...]
// use the builder to export errors free structure if you experience problems with the syntax

var MENU_ITEMS_ROLE_MC = [
    ['<span class="ui-icon ui-icon-home"></span> Home', "Actions?req=mnu100"],
    ['<span class="ui-icon ui-icon-pencil"></span> Actions', null,null,
        ['My Pendings - وظيفتي ريثما', "Actions?req=mnu302MP"],
        ['Search - بحث', "Actions?req=mnu302SL"]
    ],
    ['<span class="ui-icon ui-icon-document"></span> Reports', null, null,
        ['Upload Details', "Actions?req=rpt401"],
        ['Pending Allocation', "Actions?req=rpt402"],
        ['Allocation Details', "Actions?req=rpt403"],
        ['Pending Job', null, null,
            ['New - User wise', "Actions?req=rpt4041"],
            ['Notice for Verification', "Actions?req=rpt4042"],
            ['Notice to Fix Data Error', "Actions?req=rpt4043"]
        ],
        ['User Productivity', null, null,
            ['Detail', "Actions?req=rpt4071"],
            ['Summary', "Actions?req=rpt4072"]
        ],
        ['Bulletin Summary', "Actions?req=rpt406"],
        ['Params List', null, null,
            ['Branches - افرع',   "Actions?req=rpt405BR"],
            ['Newspaper - الجريدة',  "Actions?req=rpt405NP"],
            ['Notice Types - إشعار نوع', "Actions?req=rpt405NT"]
        ]
    ],
    ['<span class="ui-icon ui-icon-key"></span> Change Password', "Actions?req=mnu800"],
    ['<span class="ui-icon ui-icon-power"></span> Logout', "Actions?req=mnu900"]
];

// items structure
// each item is the array of one or more properties:
// [text, link, settings, subitems ...]
// use the builder to export errors free structure if you experience problems with the syntax

var MENU_ITEMS_ROLE_S = [
    ['<img src="images/home_icon.png" alt=" " border="0" align="baseline" /> Home', "Actions?req=mnu100"],
    ['Actions', null,null,
        ['Upload Bulletins - تحميل', "Actions?req=mnu303UP"],
        ['Work Allocation - توزيع العمل', "Actions?req=mnu304N"],
        ['My Pendings - وظيفتي ريثما', "Actions?req=mnu302MP"],
        ['Search - بحث', "Actions?req=mnu302SL"]
    ],
    ['Reports', null, null,
        ['Upload Details', "Actions?req=rpt401"],
        ['Pending Allocation', "Actions?req=rpt402"],
        ['Allocation Details', "Actions?req=rpt403"],
        ['Pending Job', null, null,
            ['New - User wise', "Actions?req=rpt4041"],
            ['Notice for Verification', "Actions?req=rpt4042"],
            ['Notice to Fix Data Error', "Actions?req=rpt4043"]
        ],
        ['User Productivity', null, null,
            ['Detail', "Actions?req=rpt4071"],
            ['Summary', "Actions?req=rpt4072"]
        ],
        ['Bulletin Summary', "Actions?req=rpt406"],
        ['Params List', null, null,
            ['Branches - افرع',   "Actions?req=rpt405BR"],
            ['Newspaper - الجريدة',  "Actions?req=rpt405NP"],
            ['Notice Types - إشعار نوع', "Actions?req=rpt405NT"]
        ]
    ],
    ['<img src="images/key.png" alt=" " border="0" align="baseline" /> Change Password', "Actions?req=mnu800"],
    ['<img src="images/logout.png" alt=" " border="0" align="baseline" /> Logout', "Actions?req=mnu900"]
];


var MENU_ITEMS_VIEW = [
    ['<img src="images/home_icon.png" alt=" " border="0" align="baseline" /> Home', "Actions?req=mnu100"],
    ['Actions', null,null,
        ['Search - بحث', "Actions?req=mnu302SL"]
    ],
    ['Reports', null, null,
        ['Upload Details', "Actions?req=rpt401"],
        ['Pending Allocation', "Actions?req=rpt402"],
        ['Allocation Details', "Actions?req=rpt403"],
        ['Pending Job', null, null,
            ['New - User wise', "Actions?req=rpt4041"],
            ['Notice for Verification', "Actions?req=rpt4042"],
            ['Notice to Fix Data Error', "Actions?req=rpt4043"]
        ],
        ['User Productivity', null, null,
            ['Detail', "Actions?req=rpt4071"],
            ['Summary', "Actions?req=rpt4072"]
        ],
        ['Bulletin Summary', "Actions?req=rpt406"],
        ['Params List', null, null,
            ['Branches - افرع',   "Actions?req=rpt405BR"],
            ['Newspaper - الجريدة',  "Actions?req=rpt405NP"],
            ['Notice Types - إشعار نوع', "Actions?req=rpt405NT"]
        ]
    ],
    ['<img src="images/key.png" alt=" " border="0" align="baseline" /> Change Password', "Actions?req=mnu800"],
    ['<img src="images/logout.png" alt=" " border="0" align="baseline" /> Logout', "Actions?req=mnu900"]
];

var MENU_ITEMS_MR = [
    ['<img src="images/home_icon.png" alt=" " border="0" align="baseline" /> Home', "Actions?req=mnu100"],
    ['Actions', null,null,
        ['Request', "Actions?req=mnu311R"],
        ['Search Ads', "Actions?req=mnu311S"],
        ['Translate', "Actions?req=mnu311T"],
        ['Translate Verifiy', "Actions?req=mnu311V"],
        ['Report Generate', "Actions?req=mnu311G"]
    ],
    ['Reports', null, null,
        ['Request list', "Actions?req=rpt411"]
    ],
    ['<img src="images/key.png" alt=" " border="0" align="baseline" /> Change Password', "Actions?req=mnu800"],
    ['<img src="images/logout.png" alt=" " border="0" align="baseline" /> Logout', "Actions?req=mnu900"]
];