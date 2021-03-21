import requests
from bs4 import BeautifulSoup
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
ws = wb.add_sheet('описание к фильмам')

num = 0


def get_url(name):
    result = requests.get('https://ru.wikipedia.org/wiki/250_лучших_фильмов_по_версии_IMDb')
    result.raise_for_status()
    text = result.text
    soup = BeautifulSoup(text, "html.parser")
    soup.find_all(attrs={'title': name})
    for link in soup.find_all(attrs={'title': name}):
        return str(link.get('href'))


def data_table(desc, id_film):
    global num
    ws.write(num, 0, str(desc))
    wb.save('description.xls')
    ws.write(num, 1, id_film)
    wb.save('description.xls')
    num = num + 1


class HabrPythonNews:

    def __init__(self, urls):
        self.url = urls
        self.html = self.get_html(self.url)

    def get_html(self, site):
        try:
            result = requests.get(site)
            result.raise_for_status()
            return result.text
        except(requests.RequestException, ValueError):
            print('Server error')
            return False

    def get_python_news(self):
        soup = BeautifulSoup(self.html, 'html.parser')
        news_list = str(soup.find_all('div', class_='mw-parser-output'))
        return news_list


# mw-content-text > div.mw-parser-output

if __name__ == "__main__":
    rb = xlrd.open_workbook('films.xls', formatting_info=True)
    sheet = rb.sheet_by_index(0)

    for i in range(1, 101):
        act_list = []
        if i != 55:
            name = sheet.cell_value(i, 1)
            director = sheet.cell_value(i, 3)
            year = int(sheet.cell_value(i, 2))
            url = get_url(name)
            while url is None:
                for el in [' (фильм)', f' (фильм, {year})']:
                    url = get_url(name + el)
                    if url is not None:
                        break

            film_url = 'https://ru.wikipedia.org' + url
            actors = HabrPythonNews(film_url)
            urls = actors.get_python_news()
            soup = BeautifulSoup(urls, 'html.parser')
            if len(soup) == 1:
                data_table('Not data', i)
            else:
                text = soup.p
                data_table(text.text, i)
        else:
            data_table(
                'История первого министра финансов США Александра Гамильтона на фоне реальных исторических событий: '
                'Войны за независимость, основания и становления США.', i)
