<%@page import="java.util.ArrayList"%>
<%@page import="br.com.fatecpg.piadas.web.Piada"%>
<%@page import="br.com.fatecpg.piadas.web.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Perfil - PIADAS</title>
    </head>
    <body>
        <%@include file="/WEB-INF/header.jspf"%>
        <%    
            Usuario usuarioPerfil = null;
            int piadasPendentes = 0;
            int piadasAprovadas = 0;
            int piadasPendentesDeAprovacao = 0;
            ArrayList<Piada> piadas = new ArrayList<Piada>();
            try {
                usuarioPerfil = (Usuario) session.getAttribute("usuario");
            } catch (Exception e) {
                response.sendRedirect(path + "/home.jsp");
            }
            if (usuarioPerfil != null) {
                if (!usuarioPerfil.getTipo().equalsIgnoreCase("ADMIN")) {
                    piadas = Piada.getPiadasPorAutor(usuarioPerfil.getId());
                    for (Piada piada : piadas) {
                        if (piada.isPendente() && !piada.isRejeitada()) {
                            piadasPendentes++;
                        } else if (!piada.isPendente() && !piada.isRejeitada()) {
                            piadasAprovadas++;
                        }
                    }
                }
        %>
        <main role="main" class="container">
            <div class="card mt-5" style="width: auto;">
                <div class="card-body">
                    <h1 class="card-title">Perfil</h1>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><h4>ID: <span class="badge badge-info"> <%= usuarioPerfil.getId()%> </span></h4></li>
                    <li class="list-group-item"><h4>USUÁRIO: <span class="badge badge-info"> <%= usuarioPerfil.getLogin()%></span></h4></li>
                    <li class="list-group-item"><h4>NOME: <span class="badge badge-info"> <%= usuarioPerfil.getNome()%></span></h4></li>
                    <li class="list-group-item"><h4>TIPO: <span class="badge badge-info"> <%= usuarioPerfil.getTipo()%></span></h4></li>
                        <%
                            if (!usuarioPerfil.getTipo().equalsIgnoreCase("ADMIN")) {
                        %>
                    <li class="list-group-item"><h4>SUAS PIADAS APROVADAS: <span class="badge badge-info"><%= piadasAprovadas%></span></h4></li>
                    <li class="list-group-item"><h4>SUAS PIADAS PENDENTES <span class="badge badge-info"><%= piadasPendentes%></span></h4></li>
                            <%}%>
                </ul>
            </div>   
        </div>

    </main>
    <%
    } else {
    %>
    <div class="alert alert-danger text-center mt-5 p-5" role="alert">
        <h1 class="text text-center mt-4">É necessário estar logado para acessar este recurso.</h1>
    </div>  
    <% }%>
    <%@include file="/WEB-INF/footer.jspf"%>
</body>
</html>