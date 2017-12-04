clear all,clc;

path_imgDB = './database';%ͼƬĿ¼
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
   im = imresize(oriImg,[4,4]);%�Զ����С
   s = size(im);
   R = im(:,:,1);
   G = im(:,:,2);
   B = im(:,:,3);
   R = reshape(R,[s(1),s(2)]);
   G = reshape(G,[s(1),s(2)]);
   B = reshape(B,[s(1),s(2)]);
   pic=cat(3,R,G,B)

   imdb.data(:,:,:,i) = im2double(pic)
   tx = textread('./label.txt')%labelsĿ¼
   imdb.labels(i) = tx(i)
end
save('dataimdb.mat','imdb');
