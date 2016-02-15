# Cloud detection

To download a landsat scene:

```
docker run -v $(pwd):/data python-fmask/v5 gsutil -cp gs://earthengine-public/landsat/L7/026/047/LE70260472009233EDC00.tar.bz /data
```

To perfom the image detection:

```
docker run -v $(pwd):/data python-fmask/v5 gdal_merge.py -separate -of HFA -co COMPRESSED=YES -o ref.img L*_B[1,2,3,4,5,7].TIF
docker run -v $(pwd):/data python-fmask/v5 gdal_merge.py -separate -of HFA -co COMPRESSED=YES -o thermal.img L*_B6_VCID_?.TIF
docker run -v $(pwd):/data python-fmask/v5 fmask_usgsLandsatSaturationMask.py -i ref.img -m *_MTL.txt -o saturationmask.img
docker run -v $(pwd):/data python-fmask/v5 fmask_usgsLandsatTOA.py -i ref.img -m *_MTL.txt -o toa.img
docker run -v $(pwd):/data python-fmask/v5 fmask_usgsLandsatStacked.py -t thermal.img -a toa.img -m *_MTL.txt -s saturationmask.img -o cloud.img
```