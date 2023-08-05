<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="beans.*,java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/adminlte.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
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
        border-collapse: collapse; /* Asegura que los bordes de las celdas se colapsen */
    }
    
  .content td {
    color: white;
    font-style: italic;
    font-family: arial;
    font-size: 20px;
    text-align: center;
    border: 1px solid white;
}

.content th {
    color: white;
    font-family: "Nombre de la fuente", sans-serif;
    font-size: 20px;
     text-align: center;
     border: 1px solid white;
}

.img{
    width: 90px; 
    height: 90px;
}

    
</style>
       <%
         HttpSession ses=request.getSession();
         List<Compra> lista=(ArrayList<Compra>)ses.getAttribute("canasta");
        %>    
    <center class="content">
         <ul>
                <li><img src="fotos/background.jpg" alt=""/></li>
            </ul>    
<h2><a href="pagCompra.jsp" class="button-link">Carrito de Compra</a></h2>
<br>
<h2><a href="pagCategoria.jsp" class="button-link">Volver</a></h2>
        <table class="content">
            <thead>
                <tr class="content">
                    <th> Codigo <th> Nombre del Platillo <th> Precio Unitario <th> Cantidad <th> Total <th> Platillo <th> Borrar Pedido        
            </thead>   
        <%  double sm=0;
           int indice=0;
           for(Compra x:lista){
             sm=sm+x.total();
            out.print("<tr><td>"+x.getCoda()+"<td>"+x.getNomart()+"<td>"+x.getPrecio()+"<td>"+
            x.getCantidad()+"<td>"+x.total());
            %>
            <td class="img"><img src="images/<%=x.getImagen()%>" width="90" height="90">
            <td><a href="tienda?opc=4&ind=<%=indice%>">Borrar Pedido</a>
                <%
                    indice++;
            } 
         %>   
            <tr><td colspan="4">Precio total a pagar<td><%=sm%>  
        </table>
            <h2><a href="pagCategoria.jsp" class="button-link">¿Seguir comprando?</a></h2>
            <br>
            <h2><a href="pagLogin.jsp" class="button-link">Comprar ahora</a></h2>
    </center> 
       </body>
</html>
