import xlrd
import xlwt

font0 = xlwt.Font()
font0.name = 'Times New Roman'
font0.colour_index = 2
font0.bold = True

style0 = xlwt.XFStyle()
style0.font = font0

style1 = xlwt.XFStyle()
style1.num_format_str = 'General'

wb = xlwt.Workbook()
ws = wb.add_sheet('Жанр')

wd = xlwt.Workbook()
wt = wd.add_sheet('Жанр')


rd = xlrd.open_workbook('actor.xls', formatting_info=True)
sheet1 = rd.sheet_by_index(0)

rb = xlrd.open_workbook('actor_full.xls', formatting_info=True)
sheet = rb.sheet_by_index(0)
act_list = []
for iter in sheet.col_values(0):
    act_list.append(iter)

dict_genre = {}

print(act_list)


set_list = set(act_list)
for inx, el in enumerate(set_list):
    dict_genre.update({el:inx+1})

print(dict_genre)
new_list = []
for inx, element in enumerate(sheet1.col_values(0)):
    for el in dict_genre:
        if element == el:
            tuple_now = (element, dict_genre[el])
            ws.write(inx, 0, element)
            ws.write(inx, 1, dict_genre[el])
            wb.save('actors_type.xls')
    new_list.append(tuple_now)

for inx, element in enumerate((sheet1.col_values(1))):
    for el in dict_genre:
        if element == el:
            tuple_now = (element, dict_genre[el])
            ws.write(inx, 2, element)
            ws.write(inx, 3, dict_genre[el])
            wb.save('actors_type.xls')
    new_list.append(tuple_now)
print(new_list)

for inx, el in enumerate(list(dict_genre.items())):
    print(f'{el[0]}, {el[1]}')
    wt.write(inx, 0, el[0])
    wt.write(inx, 1, el[1])
    wd.save('actors_all.xls')



# for inx, el in enumerate(act_list):
#     ws.write(inx, 0, str(el))
#     wb.save('genre.xls')



