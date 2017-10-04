clear all

fileID=fopen('MatrixMultiplyTimers.txt');
data=textscan(fileID,'%f %f');
fclose(fileID);

n=data{1};
time=data{2};

loglog(n,time)
title('log(computation time) versus log(matrix size)')
xlabel('logarithm of matrix size log(n)')
ylabel('logarithm of computation time log(second)')
saveas(gcf,'MatrixMultiplyTimers.pdf')