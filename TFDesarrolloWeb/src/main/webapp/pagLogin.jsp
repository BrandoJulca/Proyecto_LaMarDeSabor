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
        background-color: #9f4b2f;
         width: 150%;
         color:   white;
    }
    
  .content td {
    color: #9f4b2f;
    font-style: italic;
    font-family: arial;
    font-size: 20px;
    text-align: center;

}

.content th {
    color: #9f4b2f;
    font-family: "Nombre de la fuente", sans-serif;
    font-size: 20px;
     text-align: center;
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
         HttpSession ses=request.getSession();
         List<Compra> lista=(ArrayList<Compra>)ses.getAttribute("canasta");
        %>    
    <center>
        
  <%
         String msg="";
         if(request.getAttribute("dato")!=null)
          msg=(String)request.getAttribute("dato");
        %>
    <center class="content">
        <ul>
                <li><img src="fotos/background.jpg" alt=""/></li>
            </ul>    
<h2><a href="pagCompra.jsp" class="button-link">Carrito de Compra</a></h2>
<br>
<h2><a href="pagCategoria.jsp" class="button-link">Volver</a></h2>
<br>
        <form action="tienda" method="Post">
            <input type="hidden" name="opc" value="5">  
        <table class="table table-bordered">
            <tr><td rowspan="3">
                    <img src="imagen2/80.png" width="250" height="250">
                <td><br>Nombre de Usuario<td><br><input name="user" required>
            <tr><td><br>Contraseña  <td><br><input type="password" name="pas"  requerid>
            <tr><td><br>Iniciar Sesión <br><input type="submit"><td><%=msg%>        
        </table>
        </form>  
    <center>



    </center>
    </body>
</html>
