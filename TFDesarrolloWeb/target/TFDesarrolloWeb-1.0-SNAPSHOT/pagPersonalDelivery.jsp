<%@page import="dao.Negocio"%>
<%@page import="beans.Personal_Delivery"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/adminlte.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    <center>
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
         font-family: "Nombre de la fuente", sans-serif;
     text-align: center;
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
    }
</style>
        <%
           Negocio obj=new Negocio(); 
         %>   
      <center class="content">
            <ul>
                <li><img src="fotos/background.jpg" alt=""/></li>
            </ul>  
         <h2 class="text-black">Personal Delivery</h2>   
        <table class="table table-hover">
            <thead>
                <tr class="text-white bg-gray-dark"><th>Códido_Repartidor<th>Nombre_Repartidor<th>DNI_PD<th>RUC_PD<th>Estado del pedido
            </thead>
            <%
               for(Personal_Delivery x:obj.DelPD()){
               out.print("<tr><td>"+x.getCodPD()+
               "<td>"+x.getNomPD()+
               "<td>"+x.getDNI_PD()+
               "<td>"+x.getRUC_PD()+
               "<td>"+x.getEstado());
                } 
             %>   
        </table>
<h2><a href="Inicio.html" class="button-link">Volver</a></h2>
    </center>
    </body>
</html>
