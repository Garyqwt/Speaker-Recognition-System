function Frame = Frame_Blocking( data, ov, M ) % N = Frame Length % Frame overlap
Frame(:,1) = data(1:1:ov,1);                   
for j = 2:1:floor((length(data)+M-ov)/(ov-1))
    A = j*ov-M-(j-1);
    B = (j+1)*ov-M-j;
    Frame(:,j) = data(A:1:B,1);
end
end