import csv
import datetime
from dateutil.relativedelta import relativedelta

def extractHalfYear(date,table,semester):

    date = datetime.datetime.strptime(date, '%d/%m/%Y').date()
    date_increment = date + relativedelta(days=+30, months=+5)
    table = csv.reader(open('C://Users//Public//'+table+'.csv') ,delimiter=',')

    index = next(table).index('date')
    
    if semester == 1:
        wr = csv.writer(open('C://Users//Public//'+table+'primosemestre.csv',       
        mode='w', newline=''), delimiter=',')

    else:
    
        wr = csv.writer(open('C://Users//Public//'+table+'secondosemestre.csv', mode='w', newline=''), delimiter=',')
    
    for row in table:
    
        if row[index] >= date and row[index] <= date_increment: wr.writerow(row)
            
        elif row[i] > date_increment: break
