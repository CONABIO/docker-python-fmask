# Cloud Detection With Landsat Imagery

First of all we need to create the docker image from the Docker file:

```
docker build -t python-fmask .
```
Once the image is created we can use it to download and process the scenes. We can start with a simple example. To download the landsat scene, we change the working directory. Once in the desired directory:

```
docker run -v $(pwd):/data python-fmask gsutil cp gs://earthengine-public/landsat/L7/026/046/LE70260462013004ASN00.tar.bz /data
```

After extracting the zip file, we move into the created directory and we perform the following commands to create an image with the detected shadows and clouds:

```
docker run -v $(pwd):/data python-fmask gdal_merge.py -separate -of HFA -co COMPRESSED=YES -o ref.img L*_B[1,2,3,4,5,7].TIF
docker run -v $(pwd):/data python-fmask gdal_merge.py -separate -of HFA -co COMPRESSED=YES -o thermal.img L*_B6_VCID_?.TIF
docker run -v $(pwd):/data python-fmask fmask_usgsLandsatSaturationMask.py -i ref.img -m *_MTL.txt -o saturationmask.img
docker run -v $(pwd):/data python-fmask fmask_usgsLandsatTOA.py -i ref.img -m *_MTL.txt -o toa.img
docker run -v $(pwd):/data python-fmask fmask_usgsLandsatStacked.py -t thermal.img -a toa.img -m *_MTL.txt -s saturationmask.img -o cloud.img
```
The cloud and shadow mask will be found in the current working directory under the name cloud.img.
