! pip install mecab_python-0.996_ko_0.9.2_msvc-cp36-cp36m-win_amd64.whl

import MeCab
m = MeCab.Tagger()
OUTPUT = m.parse('Mecab 설치를 확인합니다.')
print(OUTPUT)

!pip install JPype1-1.0.2-cp36-cp36m-win_amd64.whl
! pip install konlpy

from konlpy.tag import Kkma
K = Kkma()
out = K.nouns('코엔엘파이 설치를 확인합니다')
print(out)

from konlpy.tag import Mecab
m = Mecab()

m.nouns('메켑이 설치되었는지 확인')
