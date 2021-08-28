import os
import glob
from PIL import Image

import datetime
today = datetime.date.today()
print(today.strftime('%Y%m%d'))

outrec = ''
otdd = open('tmp_RefLink.cpp', 'w')

Mold='pv'							#型 デフォルトは縦
#指定フォルダのjpegファイル一覧を取得
files = glob.glob('./*.JPG')
 
#ファイル一覧をループ
for f in files:
  img = Image.open(f)
#  print(img.width)
#  print(img.height)
  
  if img.width >= img.height:
    Mold='ps'								#型を横型に設定する
  imgname = os.path.basename(f)
  imgname = imgname.replace('.JPG', '')		#拡張子を削除する

# 2021.03.26  画面のサイズ情報を追加する
#  outrec = today.strftime('%Y%m%d')+"_" + imgname	+","+ Mold+","+"■■,　　　　　　　\n"
#  otdd.write(outrec)
  outrec = today.strftime('%Y%m%d')+"_" + imgname	+","+ Mold+","+"■■,　　　　　　　"
  otdd.write(outrec)

  orijinal_width=img.width
  orijinal_height=img.height
  outrec = "," +  str(orijinal_width) +","+str(orijinal_height)
  otdd.write(outrec)

  rate = 100 / img.height					#指定高さからリサイズレートを算出
  wsize = int(img.width * rate)				#リサイズレートから幅を算出
  outrec = "," +  str(wsize) +",100"
  otdd.write(outrec)

  rate = 720 / img.width					#指定幅からリサイズレートを算出
  hsize = int(img.height * rate)			#リサイズレートから高さを算出
  outrec = ",720," +  str(hsize)
  otdd.write(outrec)

  outrec = "\n"
  otdd.write(outrec)


#----------------------------------------------------#
otdd.close()

