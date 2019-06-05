package br.com.fatecpg.piadas.web;

import br.com.fatecpg.piadas.db.DatabaseConnector;
import java.util.ArrayList;

public class Piada {

    private long id;
    private String texto;
    private long autor;
    private boolean pendente;
    private boolean rejeitada;

    public static boolean adicionar(String texto, long autor) throws Exception {
        String sql = "INSERT INTO PIADA VALUES (DEFAULT, ?, ?, true, false)";
        Object parameters[] = {texto, autor};
        return DatabaseConnector.insertQuery(sql, parameters);
    }

    public static boolean aprovar(long piada, boolean rejeitada) throws Exception {
        String sql = "UPDATE PIADA SET REJEITADA = ?, PENDENTE = FALSE WHERE ID = ?";
        Object parameters[] = {rejeitada, piada};
        return DatabaseConnector.updateQuery(sql, parameters);
    }

    public static ArrayList<Piada> getPiadas() throws Exception {
        String sql = "SELECT * FROM PIADA";
        Object parameters[] = {};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Piada> piadas = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Piada piada = new Piada((long) row[0], (String) row[1], (long) row[2], (boolean) row[3], (boolean) row[4]);
                piadas.add(piada);
            }
            return piadas;
        }
    }

    public static ArrayList<Piada> getPiadasPendentes() throws Exception {
        String sql = "SELECT * FROM PIADA WHERE PENDENTE = TRUE AND REJEITADA = FALSE";
        Object parameters[] = {};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Piada> piadas = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Piada piada = new Piada((long) row[0], (String) row[1], (long) row[2], (boolean) row[3], (boolean) row[4]);
                piadas.add(piada);
            }
            return piadas;
        }
    }

    public static ArrayList<Piada> getPiadasAprovadas() throws Exception {
        String sql = "SELECT * FROM PIADA WHERE PENDENTE = FALSE AND REJEITADA = FALSE";
        Object parameters[] = {};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Piada> piadas = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Piada piada = new Piada((long) row[0], (String) row[1], (long) row[2], (boolean) row[3], (boolean) row[4]);
                piadas.add(piada);
            }
            return piadas;
        }
    }

    public static ArrayList<Piada> getPiadasPorAutor(long autor) throws Exception {
        String sql = "SELECT * FROM PIADA WHERE AUTOR = ?";
        Object parameters[] = {autor};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Piada> piadas = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Piada piada = new Piada((long) row[0], (String) row[1], (long) row[2], (boolean) row[3], (boolean) row[4]);
                piadas.add(piada);
            }
            return piadas;
        }
    }

    public Piada(long id, String texto, long autor, boolean pendente, boolean rejeitada) {
        this.id = id;
        this.texto = texto;
        this.autor = autor;
        this.pendente = pendente;
        this.rejeitada = rejeitada;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public long getAutor() {
        return autor;
    }

    public void setAutor(long autor) {
        this.autor = autor;
    }

    public boolean isPendente() {
        return pendente;
    }

    public void setPendente(boolean pendente) {
        this.pendente = pendente;
    }

    public boolean isRejeitada() {
        return rejeitada;
    }

    public void setRejeitada(boolean rejeitada) {
        this.rejeitada = rejeitada;
    }
}
