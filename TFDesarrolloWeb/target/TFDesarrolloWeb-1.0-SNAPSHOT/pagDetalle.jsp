<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="beans.*,java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    
    table {
        background-color: #9f4b2f; /* Set table background color to #9f4b2f */
         width: 100%;
    }
    
  .content td {
    color: white;
    font-style: italic;
    font-family: sans-serif;
}

    
</style>
        <%
         Articulo ar=(Articulo)request.getAttribute("dato");
        %>    
    <center class="content" >
         <ul>
                <li><img src="fotos/background.jpg" alt=""/></li>
            </ul>    
<h2><a href="pagCompra.jsp" class="button-link">Carrito de Compra</a></h2>
<br>
<h2><a href="pagCategoria.jsp" class="button-link">Volver</a></h2>
        <form name="fr">
        <table border="1" cellpadding="15" cellspacing="15">
            <tr><td rowspan="5"><img src="images/<%=ar.getImagen()%>"
                                     width="300" height="300">
                <td>Nombre de Platillo <td><%=ar.getNomart()%>
            <tr><td>Precio<td><%=ar.getPrecio() %> 
            <tr><td>Cantidad Disponible<td><%=ar.getStk()%>
            <tr>
    <td>Cantidad de platillos a comprar</td>
    <td>
        <select name="cantidad">
            <% for (int i = 1; i <= ar.getStk(); i++) { %>
                <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>
    </td>
    <input type="hidden" name="opc" value="3">
    <input type="hidden" name="coda" value="<%= ar.getCoda() %>">
</tr>

            <tr><td><a href="#" onclick="valida()">
                        <h2 class="button-link">Realizar pedido de Platillo</h2>
                    </a>      
        </table>       
        </form> 
            <script>
                function valida(){
                  stk=<%=ar.getStk()%>;
                  can=Number(fr.cantidad.value);
                  if(can>stk){
                  alert("stock no disponible "); return;
                   }
                  fr.action="tienda";
                  fr.submit();
                }
            </script>    
    </center>
    </body>
</html>
