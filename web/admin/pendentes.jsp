<%@page import="br.com.fatecpg.piadas.web.Avaliada"%>
<%@page import="br.com.fatecpg.piadas.web.Piada"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Listar piadas pendentes - PIADAS</title>
    </head>
    <body>
        <%@include file="../WEB-INF/header.jspf"%>

        <%            ArrayList<Piada> piadas = new ArrayList<Piada>();
            Usuario avaliador = null;
            try {
                piadas = Piada.getPiadasPendentes();
                avaliador = (Usuario) session.getAttribute("usuario");
            } catch (Exception e) {
                response.sendRedirect(path + "/home.jsp");
            }
            if (avaliador != null) {
                if (avaliador.getTipo().equalsIgnoreCase("ADMIN")) {
        %>

        <main role="main" class="container">
            <div class="card mt-5"> 
                <div class="card-body">
                    <h1 class="text text-center">PIADAS PENDENTES</h1>
                    <table id="listaPiadas" class="table table-striped table-bordered">

                        <thead>

                            <tr>
                                <th scope="col">Id</th>
                                <th scope="col">Piada</th>
                                <th scope="col">Autor</th>
                                <th scope="col">Aprovar</th>
                            </tr>

                        </thead>

                        <tbody>

                            <%
                                if (piadas != null) {

                                    for (Piada piada : piadas) {
                                        int index = piadas.indexOf(piada);
                                        Usuario autor = Usuario.getUsuario(piada.getAutor());
                            %>
                            <tr>
                                <td class="text text-center"><%=index + 1%></td>
                                <td><%= piada.getTexto()%></td>
                                <td><%= autor.getNome()%></td>
                                <td class="text text-center">
                                    <div class="btn-group" role="group" aria-label="Avaliacao">
                                        <a href="aprovar.jsp?id=<%= piada.getId()%>&aprovacao=aprovada" class="btn btn-outline-primary" data-toggle="tooltip" title="Aprovar"><i class="fas fa-thumbs-up"></i></a>
                                        <a href="aprovar.jsp?id=<%= piada.getId()%>&aprovacao=desaprovada" class="btn btn-outline-secondary" data-toggle="tooltip" title="Desaprovar"><i class="fas fa-thumbs-down"></i></a>
                                    </div>
                                </td>
                            </tr>

                            <%
                                    }
                                }

                            %>

                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <%        } else {
        %>
        <div class="alert alert-danger text-center mt-5 p-5" role="alert">
            <h1 class="text text-center mt-4">Você não tem acesso a acessar este recurso.</h1>
        </div>
        <%
            }
        } else {
        %>
        <div class="alert alert-danger text-center mt-5 p-5" role="alert">
            <h1 class="text text-center mt-4">É necessário estar logado para acessar este recurso.</h1>
        </div>  
        <% }%>

        <%@include file="../WEB-INF/footer.jspf"%>


        <script>
            $(document).ready(function () {
                $('#listaPiadas').DataTable({
                    "language": {
                        "sEmptyTable": "Nenhuma piada encontrada",
                        "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ piadas",
                        "sInfoEmpty": "Mostrando 0 até 0 de 0 piadas",
                        "sInfoFiltered": "(Filtrados de _MAX_ piadas)",
                        "sInfoPostFix": "",
                        "sInfoThousands": ".",
                        "sLengthMenu": "_MENU_ piadas por página",
                        "sLoadingRecords": "Carregando...",
                        "sProcessing": "Processando...",
                        "sZeroRecords": "Nenhuma piada encontrada",
                        "sSearch": "Pesquisar",
                        "oPaginate": {
                            "sNext": "Próximo",
                            "sPrevious": "Anterior",
                            "sFirst": "Primeiro",
                            "sLast": "Último"
                        },
                        "oAria": {
                            "sSortAscending": ": Ordenar colunas de forma ascendente",
                            "sSortDescending": ": Ordenar colunas de forma descendente"
                        }
                    }
                });

                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>

    </body>
</html>