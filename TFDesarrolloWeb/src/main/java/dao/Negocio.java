package dao;
import java.util.*;
import beans.*;
import java.sql.*;
import util.MySQLConexion;
import Itienda.InterTienda;

public class Negocio implements InterTienda{
  @Override
    public List<Categoria> lisCat() {
        List<Categoria> lis = new ArrayList();
        Connection cn = MySQLConexion.getConexion();
        try {
            String sql = "Select idcategoria,descripcion,imagen from categorias";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categoria p = new Categoria();
                p.setCodc(rs.getString(1));
                p.setNomc(rs.getString(2));
                p.setImagen(rs.getString(3));
                lis.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lis;
    }

    @Override
    public List<Articulo> lisArt(String id) {
        List<Articulo> lis = new ArrayList();
        Connection cn = MySQLConexion.getConexion();
        try {
            String sql = "Select idArticulo,descripcion,PrecioUnidad,imagen,Stock from Articulos where idCategoria=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);//asignar el dato
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Articulo p = new Articulo();
                p.setCoda(rs.getString(1));
                p.setNomart(rs.getString(2));
                p.setPrecio(rs.getDouble(3));
                p.setImagen(rs.getString(4));
                p.setStk(rs.getInt(5));
                lis.add(p);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lis;
    }

    @Override
    public Articulo busArt(String id) {
        Articulo p = null;//parte como si no existiera
        Connection cn = MySQLConexion.getConexion();
        try {
            String sql = "Select idArticulo,descripcion,PrecioUnidad,imagen,Stock from Articulos where idArticulo=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, id);//asignar el dato
            ResultSet rs = st.executeQuery();
            if(rs.next()) { //si lo lee recien se crea la clase articulos
                p = new Articulo();
                p.setCoda(rs.getString(1));
                p.setNomart(rs.getString(2));
                p.setPrecio(rs.getDouble(3));
                p.setImagen(rs.getString(4));
                p.setStk(rs.getInt(5));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return p;
    }

    @Override
    public Cliente busCli(String usr, String pwd) {
        Cliente p = null;//parte como si no existiera
        Connection cn = MySQLConexion.getConexion();
        try {
            String sql = "Select apellidos,nombres from clientes where idcliente=? and password=?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, usr);//asignar el dato
            st.setString(2, pwd);
            ResultSet rs = st.executeQuery();
            if(rs.next()) { //si lo lee recien se crea la clase articulos
                p = new Cliente();
                p.setCodc(usr);
                p.setApe(rs.getString(1));
                p.setNom(rs.getString(2));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return p;
    }

    @Override
    public String grabaFac(String codc, List<Compra> lista) {
    String fac="";
    double smtot=0;
    for(Compra x:lista) smtot += x.total();
    Connection cn=MySQLConexion.getConexion();
    String sql="{call spfactura(?,?)}";
    try{
    CallableStatement st1=cn.prepareCall(sql);
    st1.setString(1,codc);
    st1.setDouble(2, smtot);
    ResultSet rs=st1.executeQuery();
    rs.next();
    fac=rs.getString(1); //lee la factura devuelta
    //grabar el detalle
    String sql2="{call spdetalle(?,?,?)}";
    CallableStatement st2=cn.prepareCall(sql2);
    for(Compra  x:lista){//recorriendo cada item
      st2.setString(1,fac);
      st2.setString(2, x.getCoda());
      st2.setInt(3, x.getCantidad());
      st2.executeUpdate();
    }
    }catch(Exception ex ){
        ex.printStackTrace();
    }
    return fac;  
    
    }  
    
    
 public List<Personal_Delivery> DelPD(){
    List<Personal_Delivery> DelPD=new ArrayList();
    Connection cn=MySQLConexion.getConexion();
    try{
     String sql="Select CodPD, NomPD, DNI_PD, RUC_PD, Estado from personal_delivery";   
     PreparedStatement st=cn.prepareStatement(sql);
     ResultSet rs=st.executeQuery();
     while(rs.next()){
       Personal_Delivery p=new Personal_Delivery();
       p.setCodPD(rs.getInt(1));
       p.setNomPD(rs.getString(2));
       p.setDNI_PD(rs.getInt(3));
       p.setRUC_PD(rs.getString(4));
       p.setEstado(rs.getString(5));
       DelPD.add(p);
     }
    }catch(Exception ex){
      ex.printStackTrace();
    }
    return DelPD;   
   } 
 
  
 public List<Empleados> LisEM(){
    List<Empleados> LisEM=new ArrayList();
    Connection cn=MySQLConexion.getConexion();
    try{
     String sql="Select CodEmp, NomEmp, DNI_Emp, RUC_Emp, AreaEmp from empleados";   
     PreparedStatement st=cn.prepareStatement(sql);
     ResultSet rs=st.executeQuery();
     while(rs.next()){
       Empleados p=new Empleados();
       p.setCodEmp(rs.getInt(1));
       p.setNomEmp(rs.getString(2));
       p.setDNI_Emp(rs.getInt(3));
       p.setRUC_Emp(rs.getString(4));
       p.setAreaEmp(rs.getString(5));
       LisEM.add(p);
     }
    }catch(Exception ex){
      ex.printStackTrace();
    }
    return LisEM;   
   } 
 
    public void adicionE(Empleados e) {
        Connection cn=MySQLConexion.getConexion();
        String sql="{call spardicion(?,?,?,?,?)}";
        try{
            CallableStatement st=cn.prepareCall(sql);
            st.setInt(1, e.getCodEmp());
            st.setString(2,e.getNomEmp());
            st.setInt(3,e.getDNI_Emp());
            st.setString(4,e.getRUC_Emp());
            st.setString(5,e.getAreaEmp());
            st.executeUpdate();
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }
    
}
