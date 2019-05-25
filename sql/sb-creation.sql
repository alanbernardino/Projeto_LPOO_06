/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Alan_Bernardino
 * Created: 25/05/2019
 */

DROP TABLE USERS;
CREATE TABLE USERS(
    ID BIGINT NOT NULL PRIMARY KEY
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    ,ROLE VARCHAR (200) NOT NULL    
    ,NAME VARCHAR (200) NOT NULL    
    ,LOGIN VARCHAR (20) NOT NULL    
    ,PASSWORDHASH BIGINT NOT NULL
);

INSERT INTO USERS VALUES
(DEFAULT, 'PIADMIN', 'Piadministrador', 'piadmin', 12345678);
INSERT INTO USERS VALUES
(DEFAULT, 'BESTA', 'Piadista', 'besta', 12345678);