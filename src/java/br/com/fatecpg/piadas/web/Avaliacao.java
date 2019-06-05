package br.com.fatecpg.piadas.web;

import br.com.fatecpg.piadas.db.DatabaseConnector;
import java.util.ArrayList;

public class Avaliacao {

    private int likes;
    private int dislikes;

    public static Avaliacao getAvaliacoes(long piada) throws Exception {
        String sql = "SELECT AVALIACAO FROM AVALIADA WHERE ID = ?";
        Object parameters[] = {piada};
        ArrayList<Object[]> avaliacoes = DatabaseConnector.getQuery(sql, parameters);
        int like = 0;
        int dislike = 0;
        if (avaliacoes.isEmpty()) {
            return null;
        } else {
            for (Object row[] : avaliacoes) {
                if ((boolean) row[0] == true) {
                    like++;
                } else {
                    dislike++;
                }
            }
            return new Avaliacao(like, dislike);
        }
    }

    public Avaliacao(int likes, int dislikes) {
        this.likes = likes;
        this.dislikes = dislikes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

}
