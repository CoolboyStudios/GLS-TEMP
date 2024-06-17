<%for(int i=1; i < 16; i++) { 
    String id = AppUtils.formatNumber(i, "00"); %>
    <tr id="NRow<%=id%>" style="display:none">
        <td class="Right">
            <input class="arabic" type="text" 
                    style="width:90%"
                    id="TxtTEXT<%=id%>" name="TxtTEXT<%=id%>">
        </td>
        <td class="Right arabic">
            <label id="lblTEXT<%=id%>">Text<%=id%></label>
        </td>
    </tr> 
<%}%>

<script type="text/javascript">
   
var fldLblArr = [
    [ "\u0631\u0642\u0645 \u0627\u0644\u0631\u062e\u0635\u0629", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0646\u0648\u0639 \u0627\u0644\u0631\u062e\u0635\u0629", "\u0627\u0644\u0634\u0643\u0644 \u0627\u0644\u0642\u0627\u0646\u0648\u0646\u064a \u0627\u0644\u062c\u062f\u064a\u062f", "\u0631\u0623\u0633 \u0627\u0644\u0645\u0627\u0644 \u0627\u0644\u062c\u062f\u064a\u062f", "\u0627\u0644\u0645\u062f\u0629 (\u0623\u064a\u0627\u0645)" ],
    [ "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0627\u0644\u0634\u0643\u0644 \u0627\u0644\u0642\u0627\u0646\u0648\u0646\u064a", "\u0631\u0642\u0645 \u0627\u0644\u062a\u0633\u062c\u064a\u0644", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0642\u0631\u0627\u0631", "\u0627\u0644\u0639\u0646\u0648\u0627\u0646 " ],
    [ "\u0627\u0633\u0645 \u0627\u0644\u0645\u0646\u0630\u0631", "\u0627\u0633\u0645 \u0627\u0644\u0645\u0646\u0630\u0631 \u0627\u0644\u064a\u0647", "\u0639\u0646\u0648\u0627\u0646 \u0627\u0644\u0645\u0646\u0630\u0631 \u0627\u0644\u064a\u0647 " ],
    [ "\u0631\u0642\u0645 \u0627\u0644\u0642\u0631\u0627\u0631-\u0627\u0644\u0645\u0631\u062c\u0639", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0642\u0631\u0627\u0631", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a \u0639\u0644\u064a\u0647", "\u0628\u064a\u0627\u0646 \u0627\u0644\u0639\u0642\u0627\u0631 \u0627\u0644\u0645\u0633\u062a\u0623\u062c\u0631", "\u0631\u0642\u0645 \u0627\u0644\u0642\u0636\u064a\u0629", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0642\u0636\u064a\u0629 " ],
    [ "\u0627\u0633\u0645 \u0627\u0644\u0645\u0639\u0644\u0646", "\u0627\u0633\u0645 \u0627\u0644\u0645\u0639\u0644\u0646 \u0639\u0646\u0647", "\u0627\u0644\u062c\u0646\u0633\u064a\u0629", "\u0627\u0644\u0648\u0638\u064a\u0641\u0629", "\u0631\u0642\u0645 \u0627\u0644\u062c\u0648\u0627\u0632 " ],
    [ "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0642\u0631\u0627\u0631", "\u0627\u0633\u0645 \u0627\u0644\u0645\u0635\u0641\u064a", "\u0639\u0646\u0648\u0627\u0646 \u0627\u0644\u0645\u0635\u0641\u064a", "\u0647\u0627\u062a\u0641 \u0627\u0644\u0645\u0635\u0641\u064a", "\u0641\u0627\u0643\u0633 \u0627\u0644\u0645\u0635\u0641\u064a " ],
    [ "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a \u0639\u0644\u064a\u0647", "\u0645\u0645\u062b\u0644 \u0627\u0644\u0645\u062f\u0639\u064a", "\u0631\u0642\u0645 \u0627\u0644\u062f\u0639\u0648\u0649", "\u0646\u0648\u0639 \u0627\u0644\u062f\u0639\u0648\u0649", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062d\u0643\u0645\u0629", "\u062f\u0631\u062c\u0629 \u0627\u0644\u0645\u062d\u0643\u0645\u0629 " ],
    [ "\u0631\u0642\u0645 \u0627\u0644\u0642\u0631\u0627\u0631-\u0627\u0644\u0645\u0631\u062c\u0639", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062d\u0627\u0644\u064a", "\u0631\u0642\u0645 \u0627\u0644\u062c\u0648\u0627\u0632", "\u062c\u0647\u0629 \u0627\u0644\u062c\u0648\u0627\u0632", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u062c\u0648\u0627\u0632", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062c\u062f\u064a\u062f", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u0627\u062c\u0639\u0629", "\u0627\u0644\u0639\u0646\u0648\u0627\u0646"],
    [ "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0627\u0644\u0645\u062f\u0629 (\u0623\u064a\u0627\u0645)", "\u0631\u0642\u0645 \u0627\u0644\u062a\u0633\u062c\u064a\u0644", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0627\u0644\u063a\u0627\u0621", "\u0627\u0644\u0639\u0646\u0648\u0627\u0646", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a " ],
    [ "\u0631\u0642\u0645 \u0627\u0644\u0631\u062e\u0635\u0629", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062a\u0646\u0627\u0632\u0644", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062a\u0646\u0627\u0632\u0644 \u0627\u0644\u064a\u0647 " ],
    [ "\u0631\u0642\u0645 \u0627\u0644\u0631\u062e\u0635\u0629", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639", "\u0627\u0633\u0645 \u0627\u0635\u062d\u0627\u0628 \u0627\u0644\u062a\u0631\u0627\u062e\u064a\u0635\u00a0 " ],
    [ "\u0631\u0642\u0645 \u0627\u0644\u0631\u062e\u0635\u0629", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a \u0627\u0644\u062c\u062f\u064a\u062f", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639 " ],
    [ "\u0631\u0642\u0645 \u0627\u0644\u0631\u062e\u0635\u0629", "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0627\u0633\u0645 \u0627\u0644\u0634\u0631\u064a\u0643 \u0627\u0644\u062c\u062f\u064a\u062f", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639 " ],
    [ "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0631\u0642\u0645 \u0627\u0644\u062a\u0633\u062c\u064a\u0644", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062a\u0646\u0627\u0632\u0644", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062a\u0646\u0627\u0632\u0644 \u0627\u0644\u064a\u0647 " ],
    [ "\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u062a\u062c\u0627\u0631\u064a", "\u0627\u0644\u0634\u0643\u0644 \u0627\u0644\u0642\u0627\u0646\u0648\u0646\u064a", "\u0627\u0644\u0634\u0643\u0644 \u0627\u0644\u0642\u0627\u0646\u0648\u0646\u064a \u0627\u0644\u062c\u062f\u064a\u062f", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639 " ],
    [ "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a", "\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u0639\u064a \u0639\u0644\u064a\u0647", "\u0631\u0642\u0645 \u0627\u0644\u0642\u0636\u064a\u0629", "\u0646\u0648\u0639 \u0627\u0644\u0642\u0636\u064a\u0629", "\u062c\u0647\u0629 \u0627\u0644\u0645\u0631\u062c\u0639", "\u062a\u0641\u0627\u0635\u064a\u0644 \u0627\u0644\u0645\u0628\u064a\u0648\u0639", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u0645\u0632\u0627\u062f " ],
    [ "\u0646\u0648\u0639 \u0627\u0644\u0642\u0636\u064a\u0629", "\u0627\u0633\u0645 \u0627\u0644\u0645\u0637\u0648\u0631", "\u0631\u0642\u0645 \u0627\u0644\u0645\u0634\u0631\u0648\u0639", "\u0627\u0633\u0645 \u0627\u0644\u0645\u0634\u0631\u0648\u0639", "\u0627\u0644\u0645\u0646\u0637\u0642\u0629", "\u0631\u0642\u0645 \u0627\u0644\u0642\u0637\u0639\u0629 " ],
    [ "\u0627\u0633\u0645 \u0627\u0644\u0645\u0639\u0644\u0646 \u0639\u0646\u0647", "\u0627\u0644\u062c\u0646\u0633\u064a\u0629", "\u0631\u0642\u0645 \u0627\u0644\u062c\u0648\u0627\u0632", "\u0627\u0644\u0648\u0636\u0639 \u0627\u0644\u062d\u0627\u0644\u064a \u0644\u0644\u0627\u0642\u0627\u0645\u0629", "\u062a\u0627\u0631\u064a\u062e \u0627\u0644\u062e\u0631\u0648\u062c " ],
    [ ],
    [ "\u0627\u0633\u0645 \u0627\u0644\u0645\u0646\u0630\u0631", "\u0627\u0633\u0645 \u0627\u0644\u0645\u0646\u0630\u0631 \u0627\u0644\u064a\u0647", "\u0639\u0646\u0648\u0627\u0646 \u0627\u0644\u0645\u0646\u0630\u0631 \u0627\u0644\u064a\u0647 " ],
    [ "\u0631\u0642\u0645\u0020\u0627\u0644\u0639\u062f\u062f\u0020", "\u0631\u0642\u0645\u0020\u0627\u0644\u0642\u0636\u064a\u0629\u0020", "\u0627\u0633\u0645\u0020\u0627\u0644\u0645\u062f\u0639\u064a\u0020", "\u0627\u0633\u0645\u0020\u0627\u0644\u0645\u062f\u0639\u064a\u0020\u0639\u0644\u064a\u0647\u0020", "\u0646\u0648\u0639\u0020\u0627\u0644\u0627\u0634\u0639\u0627\u0631\u0020", "\u0627\u0644\u0645\u062d\u0643\u0645\u0647\u0020", "\u0631\u0642\u0645\u0020\u0627\u0644\u0631\u062e\u0635\u0629\u0020", "\u0627\u0644\u0627\u0633\u0645\u0020\u0627\u0644\u062a\u062c\u0627\u0631\u064a\u0020"],
    [ "\u062a\u0627\u0631\u064a\u062e\u0020\u0627\u0644\u0646\u0634\u0631","\u0627\u0644\u0645\u0639\u0644\u0646\u0020","\u0627\u0633\u0645\u0020\u0627\u0644\u0645\u062a\u0648\u0641\u064a","\u062a\u0627\u0631\u064a\u062e\u0020\u0627\u0644\u0648\u0641\u0627\u0629","\u0631\u0642\u0645\u0020\u0627\u0644\u0645\u0644\u0641\u0020"]
];
/////////////////////////////////////////////////////////////////////////
// using the below website, conver the string to Unicode
//  https://checkserp.com/encode/unicode/
/////////////////////////////////////////////////////////////////////////
    function funSetLable(ptype) {
        
        var ids = "";
        for( var i=1; i <= 15; i++) {  
            if (i<10) ids = "0"; else ids = "";
            ids = ids + (i);
            document.getElementById("NRow"+ids).style.display = 'none';
        }
        if (ptype===0) return;

        var flds = fldLblArr[ptype-51].length;
        for( var i=1; i <= flds; i++) {    
            if (i<10) ids = "0"; else ids = "";
            ids = ids + (i);
            document.getElementById("NRow"+ids).style.display = '';
            var cap = fldLblArr[ptype-51][i-1];
            $("#lblTEXT"+ids).text(cap);
        }
        document.getElementById("TxtTEXTSEQ").value = flds;
    }
</script>

