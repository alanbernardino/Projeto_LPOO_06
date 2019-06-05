<%@page import="br.com.fatecpg.piadas.web.Usuario"%>
<%@page import="br.com.fatecpg.piadas.web.Avaliada"%>
<%
    if (request.getParameter("id") != null) {
        long id = Long.parseLong(request.getParameter("id"));
        if (request.getParameter("avaliacao") != null) {
            String preAvaliacao = request.getParameter("avaliacao");
            boolean avaliacao = false;

            if (preAvaliacao.equalsIgnoreCase("like")) {
                avaliacao = true;
            } else if (preAvaliacao.equalsIgnoreCase("dislike")) {
                avaliacao = false;
            } else {
%>
<script>
    alert("Erro ao processar solicitação");
    window.location.href = 'piadas.jsp';
</script>
<%
    }

    Usuario avaliador = null;

    try {
        avaliador = (Usuario) session.getAttribute("usuario");

        if (avaliador != null) {
            if (Avaliada.avaliar(id, avaliador.getId(), avaliacao)) {
%>
<script>
    alert("Piada avaliada com êxito");
    window.location.href = 'piadas.jsp';
</script>
<%
} else {
%>
<script>
    alert("Erro ao avaliar piada");
    window.location.href = 'piadas.jsp';
</script>
<%
        }
    }

} catch (Exception e) {
%>
<script>
    alert("Erro ao processar solicitação");
    window.location.href = 'piadas.jsp';
</script>
<%
            }
        }
    }
%>