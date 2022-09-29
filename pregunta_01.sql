-- 
--  La tabla `tbl1` tiene la siguiente estructura:
-- 
--    K0  CHAR(1)
--    K1  INT
--    c12 FLOAT
--    c13 INT
--    c14 DATE
--    c15 FLOAT
--    c16 CHAR(4)
--
--  Escriba una consulta en SQL que devuelva la suma del campo c12.
-- 
--  Rta/
--     SUM(c12)
--  0  15137.63
--
--  >>> Escriba su codigo a partir de este punto <<<
--
import sqlite3

with open('/work/Pandas/SQL/tbl1.csv') as file:
    data= file.readlines()

data1 = [row.replace("\n", "") for row in data]
data1 = [row.split(",") for row in data1]
data1 = [tuple(line) for line in data1]
x=',?'*7

conn=sqlite3.connect(':memory:')
cur=conn.cursor()
conn.executescript(
'''
DROP TABLE IF EXISTS tabla1;

CREATE TABLE tabla1 (K0  CHAR(1),
K1  INT,
c12 FLOAT,
c13 INT,
c14 DATE,
c15 FLOAT,
c16 CHAR(4));
'''
)

cur.executemany("INSERT INTO tabla1 VALUES ({})".format(x[1:]), data1)
conn.commit()
cur.execute('SELECT SUM(c12)  FROM tabla1 ;').fetchmany()
