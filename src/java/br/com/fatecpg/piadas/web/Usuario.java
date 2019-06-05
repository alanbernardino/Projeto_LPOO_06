package br.com.fatecpg.piadas.web;

import br.com.fatecpg.piadas.db.DatabaseConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Usuario {

    private long id;
    private String tipo;
    private String nome;
    private String login;
    private String senha;

    public static ArrayList<Usuario> getUsuarios() throws Exception {
        String sql = "SELECT * FROM USUARIO";
        Object parameters[] = {};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Usuario> usuarios = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Usuario usuario = new Usuario((long) row[0], (String) row[1], (String) row[2], (String) row[3], (String) row[4]);
                usuarios.add(usuario);
            }
            return usuarios;
        }
    }

    public static Usuario getUsuario(long id) throws Exception {
        String sql = "SELECT * FROM USUARIO WHERE ID = ?";
        Object parameters[] = {id};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                return new Usuario((long) row[0], (String) row[1], (String) row[2], (String) row[3], (String) row[4]);
            }
        }
        return null;
    }

    public static Usuario logar(String login, String senha) throws Exception {
        String sql = "SELECT * FROM USUARIO WHERE LOGIN = ? AND SENHA = ?";
        Object parameters[] = {login, senha.hashCode()};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);

        if (list.isEmpty()) {
            return null;
        } else {
            Object row[] = list.get(0);
            Usuario usuario = new Usuario((long) row[0], (String) row[1], (String) row[2], (String) row[3], (String) row[4]);
            return usuario;
        }
    }

    public static boolean cadastrar(String nome, String login, String senha) throws Exception {
        Connection connection = DatabaseConnector.getConnection();

        String sql = "INSERT INTO USUARIO (NOME, LOGIN, SENHAHASH) VALUES (?, ?, ?, MD5(?));";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        statement.setString(2, login);
        statement.setString(3, senha);
        ResultSet results = statement.executeQuery();

        return true;
    }

    public Usuario(long id, String tipo, String nome, String login, String senha) {
        this.id = id;
        this.tipo = tipo;
        this.nome = nome;
        this.login = login;
        this.senha = senha;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }
}
