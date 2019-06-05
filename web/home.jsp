<html>
    <head>
        <title>Página Inicial - PIADAS</title>
        <style>
            #logo {
                max-width:70%;
                max-height:70%;
                position:absolute;
                top:10%; left:0; right:0; bottom:0;
                margin:auto;
            }
        </style>
    </head>
    <body>
        <%@include file="WEB-INF/header.jspf"%>

        <main role="main" class="container">
            <img src="<%= path%>/resources/imagens/logo.png" class="img-fluid mt-5" id="logo"/>
        </main>

        <%@include file="WEB-INF/footer.jspf"%>
    </body>
</html>