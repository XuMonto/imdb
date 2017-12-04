clear all,clc;

path_imgDB = './database';%图片目录
addpath(path_imgDB);
addpath tools;

imgFiles = dir(path_imgDB);
imgNamList = {imgFiles(~[imgFiles.isdir]).name};
clear imgFiles;
imgNamList = imgNamList';
numImg = length(imgNamList);

imdb.data = []
imdb.id = imgNamList
for i = 1:numImg
   oriImg = imread(imgNamList{i, 1}); 
   im = imresize(oriImg,[4,4]);%自定义大小
   s = size(im);
   R = im(:,:,1);
   G = im(:,:,2);
   B = im(:,:,3);
   R = reshape(R,[s(1),s(2)]);
   G = reshape(G,[s(1),s(2)]);
   B = reshape(B,[s(1),s(2)]);
   pic=cat(3,R,G,B)

   imdb.data(:,:,:,i) = im2double(pic)
   tx = textread('./label.txt')%labels目录
   imdb.labels(i) = tx(i)
end
save('dataimdb.mat','imdb');
