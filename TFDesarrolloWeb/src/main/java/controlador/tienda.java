package controlador;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.*;
import dao.Negocio;
import java.util.*;
import javax.servlet.http.HttpSession;
public class tienda extends HttpServlet {
    Negocio obj=new Negocio();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
      int op=Integer.parseInt(request.getParameter("opc"));
      if(op==1)listaArticulo(request, response);
      if(op==2)detalleArticulo(request, response);
      if(op==3)carrito(request, response);
      if(op==4)borraItem(request, response);
      if(op==5)login(request, response);
      if(op==6)grabaFac(request, response);
    }
    
      protected void listaArticulo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cod=request.getParameter("id");
        request.setAttribute("dato",obj.lisArt(cod));
        String pag="/pagArticulo.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }
    protected void detalleArticulo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String cod=request.getParameter("id");
        request.setAttribute("dato",obj.busArt(cod));
        String pag="/pagDetalle.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }  
     protected void carrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       String cod=request.getParameter("coda");
       int can=Integer.parseInt(request.getParameter("cantidad"));
       Articulo ar=obj.busArt(cod);
       HttpSession  ses=request.getSession();
       List<Compra> lista;
       Compra cp=new Compra();
       cp.setCantidad(can);
       cp.setCoda(cod);
       cp.setImagen(ar.getImagen());
       cp.setNomart(ar.getNomart());
       cp.setPrecio(ar.getPrecio());
       if(ses.getAttribute("canasta")==null)
           lista=new ArrayList();
       else
           lista=(ArrayList<Compra>)ses.getAttribute("canasta");
       lista.add(cp);
        ses.setAttribute("canasta",lista);
        String pag="/pagCompra.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }    
//borra un item
     protected void borraItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       int ind=Integer.parseInt(request.getParameter("ind"));
       HttpSession  ses=request.getSession();
       List<Compra> lista =(ArrayList<Compra>)ses.getAttribute("canasta");
         lista.remove(ind);
       ses.setAttribute("canasta",lista);
        String pag="/pagCompra.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession  ses=request.getSession();
        String usr=request.getParameter("user").trim();
        String pwd=request.getParameter("pas").trim();
        Cliente cli=obj.busCli(usr,pwd);
        String pag="";
        if(cli==null){
             pag="/pagLogin.jsp";
            request.setAttribute("dato","Usuario o clave no existe");
        } else {
             pag="/pagConfirma.jsp";
            ses.setAttribute("cli", cli);
        }
        request.getRequestDispatcher(pag).forward(request,response);
    } 
protected void grabaFac(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession  ses=request.getSession();
       List<Compra> lista =(ArrayList<Compra>)ses.getAttribute("canasta");
       Cliente cli=(Cliente)ses.getAttribute("cli");
       String fac=obj.grabaFac(cli.getCodc(), lista);
       double sm=0;
       for(Compra x:lista)  sm+=x.total();
       request.setAttribute("factura", fac);
       request.setAttribute("cli", cli.getApe()+","+cli.getNom());
       request.setAttribute("total", sm);
       ses.setAttribute("canasta", null);
       ses.setAttribute("cli", null);
       String pag="/pagResumen.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }    
protected void cancela(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession  ses=request.getSession();
       List<Compra> lista =(ArrayList<Compra>)ses.getAttribute("canasta");
       Cliente cli=(Cliente)ses.getAttribute("cli");
       ses.setAttribute("canasta", null);
       ses.setAttribute("cli", null);
       String pag="/pagCategoria.jsp";
        request.getRequestDispatcher(pag).forward(request, response);
    }   
    protected void adicionE(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Empleados e = new Empleados();
        e.setCodEmp(Integer.parseInt(request.getParameter("Codigo")));
        e.setNomEmp(request.getParameter("Nombre"));
        e.setDNI_Emp(Integer.parseInt(request.getParameter("DNI")));
        e.setRUC_Emp(request.getParameter("RUC"));
        e.setAreaEmp(request.getParameter("cbArea"));
        obj.adicionE(e);
        String pag = "/PagEmpleado.jps";
        request.getRequestDispatcher(pag).forward(request, response);
    }

}
