import smtplib
from string import Template
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from fetchemail import *


fetch_email(1)

temp ="""
Dear ${PERSON_NAME}, 

This is a test message. 
Have a great weekend! 

Yours Truly"""
message = Template(temp).substitute(PERSON_NAME="a")


# sign up a gmail, with third-party app access granted
#https://support.google.com/accounts/answer/3466521?hl=en

default_email=""
default_password=""
server = smtplib.SMTP('smtp.gmail.com', 587)

def autoSentWarning(To,text):

    server.starttls()
    server.login(default_email, default_password)
    msg = MIMEMultipart()
    msg['From']=default_email
    msg['To']=To
    msg['Subject']='Auto Warning'
    msg.attach(MIMEText(text, 'plain'))
    server.send_message(msg)
    server.quit()

autoSentWarning("sample@gmail.com","good")







