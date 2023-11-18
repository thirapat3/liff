<%-- 
    Document   : index
    Created on : Nov 14, 2023, 12:10:18 PM
    Author     : User
--%>

<%@page import="liff.CustomerWork, liff.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0,viewport-fit=cover">
        
        <title>จ.ดีจริง หมูสด</title>
        <link rel="stylesheet" href="css/style.css" media="all">
        
        <style>
            table, th, td {
                
                border: 0px solid black;
                border-collapse: collapse;
                text-align: center;
                
            }
           
            th {
                text-align: center;
                height:30px
            
            }
            
            tr:nth-child(even) {
                background-color: #D6EEEE;
            }
            
            #myTable tr.header, #myTable tr:hover {
              background-color: #f1f1f1;
            }
                
            <%-- 
            th, td {
                background-color: #96D4D4;
            }
            --%>
            
            
            
             body {
            font-family: Arial, sans-serif;
        }

        /* Styles for the overlay background */
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            align-items: center;
            justify-content: center;
        }

        /* Styles for the dialog box */
        .dialog-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        /* Styles for the close button */
        .close-button {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        </style>
        
    </head>
    
    
    <body>
        

        
       
        <%  
            
           // out.println("<td contenteditable='true'>"+(i+1)+" </td> ");
            String userId =  request.getParameter("userId");
            Network_Cus_Info_Point network_Cus_Info_Point = new Network_Cus_Info_Point();
            network_Cus_Info_Point = CustomerWork.getCusPointList(userId);
            
            
            out.println("<p id=userId><b>รหัสสมาชิก: "+network_Cus_Info_Point.getCus_ID()+"</b> </p> ");
            out.println("<p id=cusName><b>ชื่อสมาชิก: "+network_Cus_Info_Point.getCus_Name()+"</b> </p> ");
            out.println("<p id=displayName><b>เบอร์โทรศัพท์: "+network_Cus_Info_Point.getCus_Phone()+"</b> </p> ");
            
            String strDouble = String.format("%,d\n",network_Cus_Info_Point.getCus_Point()); 
            out.println("<p id=cusPhone><b>คะแนนสะสม: "+strDouble+"</b> </p> ");
            
            out.println("<br>"); 
            
            StringBuffer[][] cus_VoucherList = null ;
            
            cus_VoucherList = CustomerWork.getVoucherList(network_Cus_Info_Point.getCus_ID());
            
            out.println("<p id=userId><b>คูปองส่วนลด </b> </p> ");
            
                out.println("<table style=width: 100% >");
                                   
                            out.println("<tr>");
                            out.println("<th style = width:8% >ลำดับที่</th>");
                            out.println("<th  >เลขที่คูปอง</th>");
                            out.println("<th style = width:10% >มูลค่า</th>");
                            out.println("<th  >วันหมดอายุ</th>");
                                       //   + "<th>จำนวนในคลังสินค้า</th>"
                            out.println("</tr>");

                                    if(cus_VoucherList!= null){

                                        for(int i = 0; i <cus_VoucherList.length ;i++){
                                            out.println("<tr style = height:40px >");
                                                out.println("<td style=text-align:center>"+ (i+1) +" </td> ");
                                                out.println("<td style=text-align:center>" + cus_VoucherList[i][0].toString().trim() + "</td>");
                                                out.println("<td style=text-align:center>" + cus_VoucherList[i][1].toString().trim() + "</td>");
                                                out.println("<td style=text-align:center>" + cus_VoucherList[i][2].toString().trim() +" "+ "</td>");
                                                out.println("<td style=text-align:center>"
                                                        + "<form action=testPopUp.jsp?userId="+cus_VoucherList[i][0].toString().trim()+" method=post>"
                                                        + "<input type=hidden name=voucherId value="+cus_VoucherList[i][0].toString().trim()+">"
                                                        + "<button type=submit>..</button></form>");      
                                                     //   +"<button onclick=displayBarcode("+cus_VoucherList[i][0].toString().trim()+" )></button>"); 
                                              //  out.println("<td style='text-align:center;'>");        
                                              //          out.println("<button onclick='displayBarcode(\"" + cus_VoucherList[i][0].toString().trim() + "\")'>Display Barcode</button>");                
                                                 out.println("</td>");
                                                        
                                            out.println("</tr>");
                                        }
                                        
                                        
                                        
                                    } else {
                                        out.println("<tr style = height:40px >");
                                                out.println("<td>"+""+"</td>");
                                                out.println("<td>" + "" + "</td>");
                                                out.println("<td>" + "" + "</td>");
                                                out.println("<td>" + "" + "</td>");
                                        out.println("</tr>");
                                    } 
                                    
                                    

                            out.println("</table>");



                        
        %>
        
                
        <!-- Button to open the dialog -->
 <!--<button onclick="openDialog()">Open Dialog</button> -->
<!-- The overlay and dialog box -->

<!--
<div class="overlay" id="overlay">
    <div class="dialog-box">
        <p>เลขที่คูปอง</p>
        <button class="close-button" onclick="closeDialog()">Close</button>
    </div>
</div>
-->

        <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.6/dist/JsBarcode.all.min.js"></script>
  
  
        <script>
        
            function openDialog() {
                 document.getElementById('overlay').style.display = 'flex';
            }

            function closeDialog() {
                document.getElementById('overlay').style.display = 'none';
            }
        
        

        </script>

    </body>
</html>
