from datetime import datetime,timedelta


def timer(time):
    if isinstance(time,datetime): futuretime=time
    elif isinstance(time,timedelta): futuretime=datetime.now()+time
    else: return
    def check():
        return datetime.now()<futuretime
    return check



