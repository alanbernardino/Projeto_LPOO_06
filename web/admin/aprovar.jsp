<%@page import="br.com.fatecpg.piadas.web.Piada"%>
<%@page import="br.com.fatecpg.piadas.web.Usuario"%>
<%
    String path = request.getContextPath();
    if (request.getParameter("id") != null) {
        long id = Long.parseLong(request.getParameter("id"));
        if (request.getParameter("aprovacao") != null) {
            String avaliacao = request.getParameter("aprovacao");
            boolean rejeitada = false;

            if (avaliacao.equalsIgnoreCase("aprovada")) {
                rejeitada = false;
            } else if (avaliacao.equalsIgnoreCase("desaprovada")) {
                rejeitada = true;
            } else {
%>
<script>
    alert("Erro ao processar solicitação");
    window.location.href = '<%= request.getParameter("from") != null ? path + "/piada/piadas.jsp" : "pendentes.jsp"%>';
</script>
<%
    }

    Usuario avaliador = null;

    try {
        avaliador = (Usuario) session.getAttribute("usuario");

        if (avaliador != null) {
            if (avaliador.getTipo().equalsIgnoreCase("ADMIN")) {
                if (Piada.aprovar(id, rejeitada)) {
%>
<script>
    alert("Piada avaliada com êxito");
    window.location.href = '<%= request.getParameter("from") != null ? path + "/piada/piadas.jsp" : "pendentes.jsp"%>';
</script>
<%
} else {
%>
<script>
    alert("Erro ao avaliar piada");
    window.location.href = '<%= request.getParameter("from") != null ? path + "/piada/piadas.jsp" : "pendentes.jsp"%>';
</script>
<%
        }
    }
} else {
%>
<script>
    alert("Você não tem permissão para acessar este recurso");
    window.location.href = '<%= request.getParameter("from") != null ? path + "/piada/piadas.jsp" : "pendentes.jsp"%>';
</script>
<%
    }

} catch (Exception e) {
%>
<script>
    alert("Erro ao processar solicitação");
    window.location.href = '<%= request.getParameter("from") != null ? path + "/piada/piadas.jsp" : "pendentes.jsp"%>';
</script>
<%
            }
        }
    }
%>