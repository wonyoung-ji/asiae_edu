
# 1. 데이터 수집
# 필요한 모듈 import 하기
import requests
from bs4 import BeautifulSoup as bs

# 텍스트 추출할 url 할당
url="https://www.forbes.com/sites/adrianbridgwater/2019/04/15/what-drove-the-ai-renaissance/#4b1692361f25"
html=requests.get(url).text
soup=bs(html,'html.parser')

# 텍스트 추출
body=soup.find('div',{'class':'article-body fs-article fs-responsive-text current-article'})    # 클래스 = 추출할 정보를 지닌 contents의 카테고리.
for words in body.find_all('p'):     # 기사의 본문은 p 태그 아래에 있음
    print(words.text)                # 태그까지 달려 나온 words를 글자만 추출하기 위해 .text 붙여줌

# 다른 방법
# body = soup.find("div", class_='article-body fs-article fs-responsive-text current-article')
# p_tag = body.find_all('p')
# content = ''
# for i in p_tag:
#     content += i.text
# print (content)




# 2. 토큰화
# 2.1 word_tokenize = 마침표, 구두점(. , ! ?)으로 구분하여 토큰화
! pip install nltk
import nltk
nltk.download('punkt')
from nltk.tokenize import word_tokenize
token1 = word_tokenize(content)
print(token1[:30])

# 2.2 WordPunctTokenizer(): 알파벳이 아닌 문자를 구분하여 토큰화
import nltk
from nltk.tokenize import WordPunctTokenizer
token2 = WordPunctTokenizer().tokenize(content)
print(token2[:20])
# 특수기호까지 나눠줌, present-day가 present, - , day로 나뉘어 출력

# 2.3 TreebankWordTokenizer(): 정규표현식에 기반한 토큰화
import nltk
from nltk.tokenize import TreebankWordTokenizer
token3 = TreebankWordTokenizer().tokenize(content)
print(token3[:30])
# 하이픈, ' 를 붙여줌




# 3. 품사부착(=pos-tagging)
from nltk import pos_tag
nltk.download('averaged_perceptron_tagger')
taggedToken = pos_tag(token1)
print(taggedToken[:20])




# 4. 개체명인식(=Named Entity Recognition)
nltk.download('words')
nltk.download('maxent_ne_chunker')

import nltk
nltk.download('punkt')
from nltk.tokenize import word_tokenize

# 토큰화
token1 = word_tokenize('Barack Obama likes fried chicken very much')
print('token:',token1)
# 태깅
taggedToken = pos_tag(token1)
print('pos-tag:',taggedToken)
# NER
from nltk import ne_chunk
neToken = ne_chunk(taggedToken)
print(neToken)