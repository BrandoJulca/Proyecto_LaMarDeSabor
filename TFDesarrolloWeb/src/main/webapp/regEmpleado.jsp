<%@page import="dao.Negocio"%>
<%@page import="beans.Empleados"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link rel="stylesheet" href="css/bootstrapValidator.css">

<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrapValidator.js"></script>

<title>Registrar nuevo Empleado</title>
</head>

<body>
    <%
        Negocio obj=new Negocio();
        %>
<div class="container">
<h1>Registra Empleado</h1>
	<form action="control" id="id_form"> 
			<input type="hidden" name="opc" value="1">	
			<div class="form-group">
				<label class="control-label" for="id_nombre">Nombres</label>
				<input class="form-control" type="text" id="id_nombre" name="nombre" placeholder="Ingrese el nombre">
			</div>
			<div class="form-group">
				<label class="control-label" for="id_apellido">Apellidos</label>
				<input class="form-control" type="text" id="id_apellido" name="apellido" placeholder="Ingrese el apellido">
			</div>
			<div class="form-group">
				<label class="control-label" for="id_edad">DNI</label>
				<input class="form-control" type="text" id="id_edad" name="DNI" placeholder="Ingrese DNI">
			</div>
                        			<div class="form-group">
				<label class="control-label" for="id_edad">RUC</label>
				<input class="form-control" type="text" id="id_edad" name="RUC" placeholder="Ingrese RUC">
			</div>
                        			<div class="form-group">
				<label class="control-label" for="id_edad">Area Laboral</label>
                                <select name="cbArea">
                                    <%
               for(Empleados x:obj.LisEM()){
               out.print("<option value="+x.getCodEmp()+">"+x.getAreaEmp());
                } 
             %>
                                </select>
                        </div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary">Registrar Empleado</button>
			</div>
	</form>
</div>


<script type="text/javascript">
$(document).ready(function() {
    $('#id_form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	nombre: {
                validators: {
                    notEmpty: {
                        message: 'El nombre es un campo obligatorio'
                    },
              regexp:{
            	  regexp: /^[A-Za-z ñÑ]+$/,
            	  
					 message: 'Solo letras o espacios'
            	  
              }
                }
            },
        	apellido: {
                validators: {
                    notEmpty: {
                        message: 'El apellido es un campo obligatorio'
 },
              regexp:{
            	  regexp: /^[A-Za-z ñÑ]+$/,
            	  
					 message: 'Solo letras o espacios'
            	  
              }
                }
            },
        	DNI: {
                validators: {
                    notEmpty: {
                        message: 'El DNI es un campo obligatorio'
                    }
                }
            },
              RUC: {
                validators: {
                    notEmpty: {
                        message: 'El RUC es un campo obligatorio'
                    }
                }
            },
                    	Area: {
                validators: {
                    notEmpty: {
                        message: 'El área laboral es un campo obligatorio'
                    }
                }
            }
        }   
    });

    // Validate the form manually
    $('#validateBtn').click(function() {
        $('#id_form').bootstrapValidator('validate');
    });
});
</script>

</body>
</html>


