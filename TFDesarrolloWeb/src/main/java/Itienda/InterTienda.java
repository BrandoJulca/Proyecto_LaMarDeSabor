
package Itienda;
import beans.*;
import java.util.*;
public interface InterTienda {
 List<Categoria> lisCat();
 List<Articulo> lisArt(String id);
 Articulo busArt(String id);
 Cliente  busCli(String usr,String pwd);
 String grabaFac(String codc,List<Compra> lista);
}
