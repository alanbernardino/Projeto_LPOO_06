package br.com.fatecpg.piadas.web;

import br.com.fatecpg.piadas.db.DatabaseConnector;
import java.util.ArrayList;

public class Avaliada {

    private long id;
    private long avaliador;
    private boolean avaliacao;

    public static ArrayList<Avaliada> getAvaliadas() throws Exception {
        String sql = "SELECT * FROM AVALIADA";
        Object parameters[] = {};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Avaliada> avaliadas = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Avaliada avaliada = new Avaliada((long) row[0], (long) row[1], (boolean) row[2]);
                avaliadas.add(avaliada);
            }
            return avaliadas;
        }
    }

    public static Avaliada getAvaliada(long piada, long avaliador) throws Exception {
        String sql = "SELECT * FROM AVALIADA WHERE ID = ? AND AVALIADOR = ?";
        Object parameters[] = {piada, avaliador};
        ArrayList<Object[]> list = DatabaseConnector.getQuery(sql, parameters);
        ArrayList<Avaliada> avaliadas = new ArrayList<>();
        if (list.isEmpty()) {
            return null;
        } else {
            for (Object row[] : list) {
                Avaliada avaliada = new Avaliada((long) row[0], (long) row[1], (boolean) row[2]);
                return avaliada;
            }
        }
        return null;
    }

    public static boolean avaliar(long id, long avaliador, boolean avaliacao) throws Exception {
        String sql = "INSERT INTO AVALIADA VALUES (?, ?, ?)";
        Object parameters[] = {id, avaliador, avaliacao};
        return DatabaseConnector.insertQuery(sql, parameters);
    }

    public Avaliada(long id, long avaliador, boolean avaliacao) {
        this.id = id;
        this.avaliador = avaliador;
        this.avaliacao = avaliacao;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getAvaliador() {
        return avaliador;
    }

    public void setAvaliador(long avaliador) {
        this.avaliador = avaliador;
    }

    public boolean getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(boolean avaliacao) {
        this.avaliacao = avaliacao;
    }

}
