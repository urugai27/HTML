#2025.01.09			画面のデータのサイズが500KB以下の小さいサイズは縮小しない
#2021.03.28			縮小しない場合はそのままの画像を展開する   
#2021.08.29			イメージファイルの格納アドレスを絶対アドレスからカレントディレクトリへ変更
import re			#2021.08.29 		正規表現にマッチした文字列を新しい文字列に置換する
import os
import glob
from PIL import Image

import datetime
today = datetime.date.today()
print(today.strftime('%Y%m%d'))
 
wsize=300 #デフォルトは幅300px
#指定フォルダのjpegファイル一覧を取得
files = glob.glob('./*.JPG')
 
#ファイル一覧をループ
for f in files:
  img = Image.open(f)
#2025.01.09  画面のデータのサイズが500KB以下の小さいサイズは縮小しない
  file_size = os.path.getsize(f)
  file_size_KB = int(file_size / 1024)
  print(str(file_size_KB))
  
  #指定幅以下の画像はそのままのサイズ１で縮小
#  if wsize < img.width:
  if wsize < img.width and file_size_KB >= 500:   #2025.01.09 条件を追加
  #指定幅からリサイズレートを算出
     rate = wsize / img.width
  #リサイズレートから高さを算出
     hsize = int(img.height * rate)
  else:
     rate = 1.8									#パッケージを使うとサイズが小さくなるので１．３倍
     wsize= int(img.width * rate)	
     hsize = int(img.height * rate)	

  #リサイズ実行
  img_resize = img.resize((wsize, hsize))
  #新しいファイル名を作成
  imgdir = os.path.dirname(f)
  imgname = os.path.basename(f)
#  imgdir = 'C:/Users/ATHUSHI/Desktop/HTML/Reimage'
#  2021.08.29 実行中のファイルの場所（パス）を取得する 	
  makedir = os.getcwd()
  pattern = re.compile(r'make')			#正規表現パターン
  htmldir = pattern.sub('',makedir)		#make を nullにする
  imgdir = htmldir  + "Reimage"
#  newfname = imgdir + "/20210312_" + imgname
  newfname = imgdir + "/"+ today.strftime('%Y%m%d')+"_" + imgname
  print(newfname)
  #リサイズ画像を指定ファイル名で保存
  img_resize.save(newfname)
  