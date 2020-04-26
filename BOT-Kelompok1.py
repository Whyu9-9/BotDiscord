import discord
import mysql.connector
import time
import datetime

TOKEN = 'NjkwMjMwMTMxMTYzNTI5MjI2.XnOt-w.Mqt5Loh3o1vsPz_zDB6kt47LXlY'
client = discord.Client()


db = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="Dragoncit1234",
    db="db_bot",
    auth_plugin="mysql_native_password")

ts = time.time()
timestamp = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')


@client.event
async def on_message(message):
    if message.author == client.user:
        return
    channel = message.channel
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Dragoncit1234",
        db="db_bot",
        auth_plugin="mysql_native_password")

    print('\nMessage ID: {0.id} \nSender: {0.author} \nMessage: {0.content} \nTime: %s \n'.format(message) % timestamp)
    sql = "INSERT into tb_inbox (id_inbox, chat_id, in_msg, flag, tgl, pengirim, type) VALUES (NULL,%s,%s,%s,%s,%s,%s)"
    val = ("{0.id}".format(message), "{0.content}".format(message), '0', timestamp, "{0.author.id}".format(message), "msg")
    cursor = db.cursor()
    cursor.execute(sql, val)
    db.commit()
    cursor.close()

    sql_select = "SELECT * FROM tb_inbox"
    cursor = db.cursor()
    cursor.execute(sql_select)
    flag_in = cursor.fetchall()

    sql_select = "SELECT id_inbox,chat_id,out_msg,flag,tgl,pengirim,type FROM tb_outbox"
    cursor = db.cursor()
    cursor.execute(sql_select)
    flag_out = cursor.fetchall()

    sql_select = "SELECT * FROM tb_inbox WHERE flag = '0' AND id_inbox NOT IN(SELECT id_inbox FROM tb_outbox);"
    cursor = db.cursor()
    cursor.execute(sql_select)
    insert = cursor.fetchall()


    if (len(flag_in) != len(flag_out)):
        for dataIn in insert:
            val = (dataIn[0], dataIn[1], dataIn[2] , dataIn[4], dataIn[5], dataIn[6])
            insert_outbox = "insert into tb_outbox (id_inbox,chat_id,out_msg,flag,tgl,pengirim,type) values(%s,%s,%s,'1',%s,%s,%s)"
            print("Insert Data Inbox ke Outbox dengan ID: %s" % (dataIn[0]))
            cursor = db.cursor()
            cursor.execute(insert_outbox, val)
            db.commit()
            cursor.close()

            await client.send_message(channel, dataIn[2])
            val2 = dataIn[0]
            cursor = db.cursor()
            cursor.execute("update tb_inbox set flag = '1' where id_inbox = %s " % val2)
            print("Flag Ter-update!")
            db.commit()
            cursor.close()
    db.close()


@client.event
async def on_ready():
    print('Logged in as')
    print(client.user.name)
    print(client.user.id)
    print('------')

client.run(TOKEN)

