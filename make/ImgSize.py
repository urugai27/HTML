#2021.03.28			縮小しない場合はそのままの画像を展開する   
#2021.08.29			イメージファイルの格納アドレスを絶対アドレスからカレントディレクトリへ変更
import re			#2021.08.29 		正規表現にマッチした文字列を新しい文字列に置換する
import os
import glob
from PIL import Image

import datetime
today = datetime.date.today()
print(today.strftime('%Y%m%d'))
 
#wsize=2000 #デフォルトは幅2000px		#cf2 の1Mサイズ以下に抑えるため変更 2021.06.25
wsize=1500 #デフォルトは幅1500px
#指定フォルダのjpegファイル一覧を取得
files = glob.glob('./*.JPG')
 
#ファイル一覧をループ
for f in files:
  img = Image.open(f)
  #指定幅以下の画像はそのままのサイズ１で縮小
  if wsize < img.width:
     rate = wsize / img.width					#指定幅からリサイズレートを算出
     hsize = int(img.height * rate)				#リサイズレートから高さを算出
     img_resize = img.resize((wsize, hsize))
  else:
     wsize=img.width		
     hsize=img.height		
     img_resize = img.resize((wsize, hsize))
  #新しいファイル名を作成
  imgdir = os.path.dirname(f)
  imgname = os.path.basename(f)
#  imgdir = 'C:/Users/ATHUSHI/Desktop/HTML/image'
#  imgdir = 'E:/HTML/image'
#  2021.08.29 実行中のファイルの場所（パス）を取得する 	
#  print('getcwd:      ', os.getcwd())
  makedir = os.getcwd()
  pattern = re.compile(r'make')			#正規表現パターン
  htmldir = pattern.sub('',makedir)		#make を nullにする
#  print('htmldir:      ', htmldir)
  imgdir = htmldir  + "image"
#  newfname = imgdir + "/20210312_" + imgname
  newfname = imgdir + "/"+ today.strftime('%Y%m%d')+"_" + imgname
  print(newfname)
  #リサイズ画像を指定ファイル名で保存
  img_resize.save(newfname)
  