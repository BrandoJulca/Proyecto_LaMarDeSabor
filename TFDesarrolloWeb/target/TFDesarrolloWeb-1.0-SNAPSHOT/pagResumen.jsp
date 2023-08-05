<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="beans.*,java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/adminlte.min.css" rel="stylesheet" type="text/css"/>
    </head>
                    <style>
    body {
                background-color: rgb(255, 249, 244);
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

        body {
                background-color: rgb(255, 249, 244);
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
        .content {
                width: 100%;
                max-width: 1200px;
                margin: 20px;
            }
            
            .content img {
                width: 100%;
                height: auto;
            }
            
            .buttons {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            
            .buttons a {
                display: inline-block;
                padding: 20px 80px;
                font-size: 20px;
                background-color: brown;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                cursor: pointer;
            }
            
            .buttons a:not(:last-child) {
                margin-right: 30px;
            }
            
            .content ul {
                list-style-type: none;
                padding: 0;
            }     
            
            .content a {
        color: white;          /* Set text color to white */
        text-decoration: none; /* Remove underline */
        font-size: 20px;
    }
    
            .content a:hover {
        color: black;          /* Set text color to white */
        text-decoration: none; /* Remove underline */
    
    }
    

    .button-link {
        display: inline-block;
        position: relative;
        padding: 15px 30px;
        background-color: #9f4b2f;
        color: white;
        text-decoration: none;
        font-weight: bold;
        border-radius: 50px;
    }
    
    .btn-large:hover {
        background-color: #ffffff;
        color: #9f4b2f;
    }
    
.button-link:hover {
        background-color: #ffffff;
        color: #9f4b2f;
    }
    
    .button-link:before {
        content: '';
        position: absolute;
        top: -10px;
        left: -10px;
        width: 20px;
        height: 20px;
        background-color: #9f4b2f;
        border-radius: 50%;
    }

    .button-link:after {
        content: '';
        position: absolute;
        top: -10px;
        right: -10px;
        width: 20px;
        height: 20px;
        background-color: #9f4b2f;
        border-radius: 50%;
    }
    
    table{
        background-color: white;
         width: 150%;
         color:   white;
    }
    
  .content td {
    color: black;
    font-style: italic;
    font-family: arial;
    font-size: 20px;
    text-align: center;
 border: 1px solid black;
}

.content th {
    color: black;
    font-family: "Nombre de la fuente", sans-serif;
    font-size: 20px;
     text-align: center;
      border: 1px solid black;
}

.content h2 {
    color: #9f4b2f;
    font-family: "Nombre de la fuente", sans-serif;
    font-size: 20px;
     text-align: center;

}

.img{
    width: 90px; 
    height: 90px;
}

    
</style>
    <body>
       <%
         String nomc=(String)request.getAttribute("cli");
         String factura =(String)request.getAttribute("factura");
         double tot=(double)request.getAttribute("total");


        %>    
    <center class="content">
          <ul>
                <li><img src="fotos/background.jpg" alt=""/></li>
            </ul>    
<br>
        <table class="content">
            <tr><td>Factura Generada<td><%=factura%>
            <tr><td>Cliente<td><%=nomc%>
            <tr><td>Total pago<td><%=tot%>
        </table>
        <h2 class="content">¡Gracias por su compra, su pedido llegará en breves momentos!</h2>
        <br>
        <button class="button-link" onclick="printPage()">Imprimir Página</button>
        
        <h2><a href="pagCategoria.jsp" class="button-link">Volver</a></h2>
    </center> 
        <script>
        function printPage() {
            window.print();
        }
    </script>
       </body>
</html>
