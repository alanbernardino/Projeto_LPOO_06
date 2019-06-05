<%@page import="br.com.fatecpg.piadas.web.Avaliacao"%>
<%@page import="br.com.fatecpg.piadas.web.Avaliada"%>
<%@page import="br.com.fatecpg.piadas.web.Piada"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Listar piadas - PIADAS</title>
    </head>
    <body>
        <%@include file="../WEB-INF/header.jspf"%>

        <%            
            ArrayList<Piada> piadas = new ArrayList<Piada>();
            ArrayList<Avaliada> avaliadas = new ArrayList<Avaliada>();
            Usuario avaliador = null;
            try {
                avaliador = (Usuario) session.getAttribute("usuario");
                piadas = Piada.getPiadasAprovadas();
                avaliadas = Avaliada.getAvaliadas();
            } catch (Exception e) {
                %>
                <script>
                    alert("Erro ao processar solicitação");
                </script>
                <%
            }
            if (avaliador != null) {

        %>

        <main role="main" class="container">
            <div class="card mt-5"> 
                <div class="card-body">
                    <h1 class="text text-center">PIADAS</h1>
                    <table id="listaPiadas" class="table table-striped table-bordered">

                        <thead>

                            <tr>
                                <td colspan="7" class="text text-left">
                                    <a href="adicionar.jsp" class="btn btn-outline-primary float-right" data-toggle="tooltip" title="Adicionar piada"><i class="fas fa-plus"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">Id</th>
                                <th scope="col">Piada</th>
                                <th scope="col">Autor</th>
                                <th scope="col">Sua avaliação</th>
                                <th scope="col"><span class="text text-success"><i class="fas fa-thumbs-up"></i></span></th>
                                <th scope="col"><span class="text text-danger"><i class="fas fa-thumbs-down"></i></span></th>
                                        <%                                if (avaliador.getTipo().equalsIgnoreCase("ADMIN")) {
                                        %>
                                <th scope="col">Rejeitar</th>
                                    <%
                                        }
                                    %>
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
                                    <%
                                        Avaliacao avaliacao = Avaliacao.getAvaliacoes(piada.getId());
                                        Avaliada piadaAvaliada = Avaliada.getAvaliada(piada.getId(), avaliador.getId());
                                        if (piadaAvaliada != null) {
                                            if (piadaAvaliada.getAvaliacao()) {
                                    %>
                                    <span class="btn btn-success" data-toggle="tooltip" title="Gostei"><i class="fas fa-thumbs-up"></i></span>
                                        <%
                                        } else {
                                        %>
                                    <span class="btn btn-danger" data-toggle="tooltip" title="Não gostei"><i class="fas fa-thumbs-down"></i></span>
                                        <%
                                            }
                                        } else {
                                        %>
                                    <div class="btn-group" role="group" aria-label="Avaliacao">
                                        <a href="avaliar.jsp?id=<%= piada.getId()%>&avaliacao=like" class="btn btn-outline-success" data-toggle="tooltip" title="Gostei"><i class="fas fa-thumbs-up"></i></a>
                                        <a href="avaliar.jsp?id=<%= piada.getId()%>&avaliacao=dislike" class="btn btn-outline-danger" data-toggle="tooltip" title="Não gostei"><i class="fas fa-thumbs-down"></i></a>
                                    </div>
                                    <%
                                        }
                                    %>            
                                </td>
                                <% if (avaliacao != null) {%>
                                <td><%= avaliacao.getLikes()%></td>
                                <td><%= avaliacao.getDislikes()%></td>
                                <%} else {%>
                                <td> 0 </td>
                                <td> 0 </td>
                                <%}
                                    if (avaliador.getTipo().equalsIgnoreCase("ADMIN")) {
                                %>
                                <td class="text text-center">
                                    <a href="<%= path%>/admin/aprovar.jsp?id=<%= piada.getId()%>&aprovacao=desaprovada&from=piadas" class="btn btn-outline-danger" data-toggle="tooltip" title="Desaprovar"><i class="fas fa-trash-alt"></i></a>
                                </td>
                                <%
                                    }
                                %>
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
        <%
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