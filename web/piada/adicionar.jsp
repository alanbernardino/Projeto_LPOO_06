<%@page import="br.com.fatecpg.piadas.web.Piada"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Adicionar piada - PIADAS</title>
    </head>
    <body>
        <%@include file="../WEB-INF/header.jspf"%>
        <%    Usuario autor = null;
            try {
                autor = (Usuario) session.getAttribute("usuario");
            } catch (Exception e) {
        %>
        <script>
            alert("Erro ao processar solicitação");
        </script>
        <%
            }
            if (autor != null) {
        %>

        <div role="main" class="container">
            <div class="card mt-5"> 
                <div class="card-body">
                    <h1 class="text text-center ">ADICIONAR PIADA</h1>
                    <form method="post" action="#">
                        <table class="table table-center table-light table-hover m-auto">
                            <tr class="text text-center">
                                <td><label for="piada">Digite sua piada:</label></td>
                                <td><textarea class="form-control" id="piada" name="piada" rows="3" required></textarea></td>
                            </tr>
                            <tr class="text text-center">
                                <td colspan="2">
                                    <a href="piadas.jsp" class="btn btn-danger m-3">Cancelar <i class="fas fa-times"></i></a>
                                    <button name="adicionar" type="submit" class="btn btn-primary">Adicionar <i class="fas fa-plus"></i></button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
            <%        if (request.getParameter("adicionar") != null) {
                    try {
                        String texto = request.getParameter("piada");

                        if (Piada.adicionar(texto, autor.getId())) {
            %>
            <script>
                alert("Piada adicionada com êxito \nSerá necessário aguardar aprovação");
                window.location.href = 'piadas.jsp';
            </script>
            <%
            } else {
            %>
            <script>
                alert("Erro ao adicionar piada");
                window.location.href = 'piadas.jsp';
            </script>
            <%
                }

            } catch (Exception e) { %>
            <div class="alert alert-danger text-center m-5 p-5" role="alert">
                <h1 class="text text-center mt-5">Erro ao carregar a página!</h1>
            </div>  
            <%
                    }
                }
            } else {
            %>
            <div class="alert alert-danger text-center mt-5 p-5" role="alert">
                <h1 class="text text-center mt-4">É necessário estar logado para acessar este recurso.</h1>
            </div>  
            <% }%>
        </div>


        <%@include file="../WEB-INF/footer.jspf"%>

    </body>
</html>