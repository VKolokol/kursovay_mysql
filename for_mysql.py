from sshtunnel import SSHTunnelForwarder
from pymysql import connect

# import paramiko
# import pandas as pd
import xlrd

from openpyxl import load_workbook

rb = xlrd.open_workbook('films_db_edit.xls',formatting_info=True)
sheet = rb.sheet_by_index(0)
reviewers_records = []

# for rownum in range(100):
#        for_db = []
#        for el in sheet.row_values(rowx=rownum, start_colx=0, end_colx=None):
#             for_db.append(el)
#        reviewers_records.append(tuple(for_db))
# print(reviewers_records)




# for el in range(len(db)):
#    reviewers_records.append(db.popitem())
# print(reviewers_records)

#
ssh_user = 'vlad'
ssh_pass = 'qwe123'

user = 'root'
password = 'my8sql'

host = '192.168.1.7'


ssh_host='192.168.1.7'
server = SSHTunnelForwarder(
    (ssh_host, 22),
    ssh_username="vlad",
    ssh_password='qwe123',
    remote_bind_address=("127.0.0.1", 3306))

server.start()

with connect(user='root',
    password=password,
    host="127.0.0.1",
    port=server.local_bind_port,
    database='kinopoisk') as connection:
    # insert_reviewers_query = """
    # INSERT INTO films
    # (name, description, country, genres_type_id, creators_id)
    # VALUES (%s, %s, %s, %s, %s) """
    for inx, el in enumerate(sheet.col_values(5)):
        print(inx+1,el)
        update_query = """
        UPDATE
            films
        SET
            release_date = "%s"
        WHERE
            id = "%s"
        """
        val_tup = (int(el), inx+1)

        with connection.cursor() as cursor:
            cursor.execute(update_query,val_tup)
            connection.commit()



server.stop()
