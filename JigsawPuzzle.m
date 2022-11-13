A = imread("~/Documents/HW05_inputs/hw5_puzzle_pieces.jpg");
R = imread("~/Documents/HW05_inputs/hw5_puzzle_reference.jpg");
red = I2(:,:,1);
figure, imshow(A);

G = rgb2gray(A);

%Binarize the image 
BI = ~imbinarize(G, 0.9);
figure, imshow(BI);
C = imfill(BI, 'holes');
figure, imshow(C);

% Extract number of pixels and resize the reference image to maintain same
% aspect ratio and same number if pixels
numWhitePixels = sum(C(:));
[heightI,widthI,~] = size(R);
newHeight = 410;
newSize = [newHeight, NaN];
R1 = imresize(R,newSize);
G1 = rgb2gray(R1);

%Detect Edges to place the pieces
BE = edge(C, 'Canny');
figure;imshow(BE);
BE = ~BE;

%Binary labelling to crop the pieces
label = bwlabel(C);
max(max(label))

% crop each piece and store in a cell
M = cell(max(max(label)), 1);
for j = 1:max(max(label))
[row,col] = find(label==j);
len=max(row)-min(row)+1;
breadth=max(col)-min(col)+1;
target=uint8(zeros([len breadth]));
sy = min(col)-1;
sx = min(row)-1;
for i=1:size(row,1)
x=row(i,1) - sx;
y=col(i,1) - sy;
target(x,y) = G(row(i,1),col(i,1));
end
M{j} = target;
figure,imshow(target);
end

% crop binary label to use as a mask
props = regionprops(label, 'Image'); 

% Blocking matching
R2 = BlockMatching(M, R1, props);
figure;imshow(R2);