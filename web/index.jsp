<%@page import="dominio.Version"%>
<%@page import="org.apache.el.lang.FunctionMapperImpl.Function"%>
<%@page import="dominio.Comentario"%>
<%@page import="dominio.Juego"%>
<%@page import="dominio.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style2.css">
        <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js' type='text/javascript'> </script> 
        <script src="http://jdwebfiles.webcindario.com/Easy%20slider/easy-slider.js"></script> 
        <title>La Mejor Tienda de Juegos Online</title>
    </head>
    <body>
        <div id="contenedor">
            <jsp:include page="plantillas/header.jsp"></jsp:include>
            <div id="fondotransparente">
            
                <%-- SLIDER --%>
            <div id="sliderContainer"> 
                <a href="#siguiente" class="next" title="Siguiente"></a> 
                <a href="#anterior" class="prev" title="Anterior"></a> 
                <div id="slider"> <div class="slidesContainer" style="width: 2700px;"> 
                        <div class="slide">
                            <img src="http://progapli2013.comule.com/slider/Juegos1.jpg" alt="Imagen 01">
                        </div> 
                        <div class="slide">
                            <img src="http://progapli2013.comule.com/slider/Juegos2.jpg" alt="Imagen 02">
                        </div> 
                        <div class="slide">
                            <img src="http://progapli2013.comule.com/slider/Juegos3.jpg" alt="Imagen 01">
                        </div>
                        <div class="slide">
                            <img src="http://progapli2013.comule.com/slider/Juegos4.jpg" alt="Imagen 01">
                        </div> 
                    </div> <!-- /slidesContainer --> 
                </div> <!-- /slider --> 
            </div>
                            
            <%-- SLIDER --%>
                
                <div  class='listaJuegos'>
            
                    
                <%
                    
                    String ruta = "http://progapli2013.comule.com/imagenes/juegos/";
                    if(request.getAttribute("listaJuegos")!= null){
                        ArrayList<Juego> juegos = (ArrayList<Juego>)request.getAttribute("listaJuegos");
                        int i=0;

                        while(i<juegos.size()){
                            Juego j = juegos.get(i);
                            out.write("<div>");
                            out.write("<div id = 'imgJuego'>");
                            out.write("<img class='imgJuego' src='" +ruta + j.getPortada() + "'>");
                            out.write("</div>");
                            out.write("<li>");
                            out.write(j.getNombre());
                            //out.write("<ul>");
                            out.write("</li>");
                            out.write("<li>");
                            String desc = j.getDescripcion();
                            if(desc.length()>200){
                                out.write(desc.substring(0, 200) + "...");
                            }else{
                                out.write(desc);
                            }
                            out.write("</li>");
                            out.write("<li>");        
                            out.write(Double.toString(j.getPrecio()));
                            out.write("</li>");
                            out.write("<li>");        
                            out.write("<a href='verInfoJuego?id=" + j.getId() + "'>Ver Info Juego</a>");
                            out.write("</div>");
                            i++;
                        }
                    }
                    if(request.getAttribute("infoJuego")!= null){

                       Juego ju = (Juego)request.getAttribute("infoJuego");
                       out.write("<ul>");
                           out.write("<li>");
                               out.write("Nombre del juego");
                           out.write("</li>");
                           out.write("<li>");
                               out.write(ju.getNombre());
                           out.write("</li>");
                           out.write("<li>");
                               out.write("Descripcion");
                           out.write("</li>");
                           out.write("<li>");
                               out.write(ju.getDescripcion());
                           out.write("</li>");
                           out.write("<li>");
                               out.write("Desarrollador");
                           out.write("</li>");
                           out.write("<li>");
                               out.write(ju.getDes().getNick());
                           out.write("</li>"); 
                           out.write("<li>");
                               out.write("Tamaño");
                           out.write("</li>");
                           out.write("<li>");
                               out.write(String.valueOf(ju.getSize()) + " Kb");
                           out.write("</li>");
                           out.write("<li>");
                           out.write("<li>");
                            out.write("Ultima version");
                           out.write("</li>");
                           
                           Version v = controladores.ControladorVersiones.getInstancia().ultimaVerAprobada(ju.getId());
                           
                           out.write("<li>");
                           if(session.getAttribute("usuario") != null && 
                                   controladores.ControladorCompras.getInstancia().comproJuego(
                                   controladores.ControladorUsuarios.getInstancia().find(String.valueOf(session.getAttribute("usuario"))).getId(), 
                                   ju.getId())){
                            out.write("<li>");
                                out.write("<a href='descargaJuego?id=" + v.getId_juego() + "'>" + v.getNro_version() + "</a>");
                            out.write("</li>");
                           } else{
                           out.write("<li>");
                           out.write(v.getNro_version());
                           
                           out.write("</li>");
                           }
                           
                           out.write("</li>");
                           
                           
                           ArrayList<Categoria> lstCat = (ArrayList<Categoria>)ju.getCategorias();
                           int i=0;
                           out.write("Categorias");
                           while(i<lstCat.size()){
                               out.write("<li>");
                                   out.write(lstCat.get(i).getNombre());
                               out.write("</li>");
                               i++;
                           }
                           out.write("</ul>");
                           
                           ArrayList<Comentario> lstCom = (ArrayList<Comentario>)ju.getComentarios();
                           i=0;
                           out.write("Comentarios");
                           out.write("<ul>");
                           while(i<lstCom.size()){
                                Comentario com = lstCom.get(i);
                               
                               if(com.getId_padre() == 0){
                               out.write("<li>");
                                    out.write("<a href = desplegarComentarios?idCP=" + com.getId() +  ">" + com.getTexto() + "</a>");
                                    
                                    out.write("</li>");
                               }
                               
                           
                            i++;
                           
                    }
                    out.write("</ul>");
                    }

                    if(request.getAttribute("comentariosHijo")!= null){
                                         ArrayList<Comentario> lstComH = (ArrayList<Comentario>) request.getAttribute("comentariosHijo");
                                            int f=0;
                                            while(f<lstComH.size()){
                                                 Comentario comH = lstComH.get(f);
                                                out.write("<li>");
                                                     out.write("<a href = desplegarComentarios?idCP=" + comH.getId() +  ">" + comH.getTexto() + "</a>");
                                                out.write("</li>");
                                                f++;
                                            }     
                                        }
                    
                %>

         
        </div>
    </div>
</div>
        
             <jsp:include page="plantillas/footer.jsp"></jsp:include>
    </body>
</html>
