#2021.03.28			縮小しない場合はそのままの画像を展開する   
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
  #指定幅以下の画像はそのままのサイズ１で縮小
  if wsize < img.width:
  #指定幅からリサイズレートを算出
     rate = wsize / img.width
  #リサイズレートから高さを算出
     hsize = int(img.height * rate)
  else:
     wsize=img.width
     hsize=img.height
  #リサイズ実行
  img_resize = img.resize((wsize, hsize))
  #新しいファイル名を作成
  imgdir = os.path.dirname(f)
  imgname = os.path.basename(f)
  imgdir = 'C:/Users/ATHUSHI/Desktop/HTML/Reimage'
#  newfname = imgdir + "/20210312_" + imgname
  newfname = imgdir + "/"+ today.strftime('%Y%m%d')+"_" + imgname
  print(newfname)
  #リサイズ画像を指定ファイル名で保存
  img_resize.save(newfname)
  