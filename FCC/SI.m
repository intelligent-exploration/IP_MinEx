s = size(A);
p = s(3);

for i = 1:p
    StD(1,i) = std2(A(:,:,i));
    Mean(1,i) = mean2(A(:,:,i));
end

for i = 1:p
    B(:,:,i) = A(:,:,i)-Mean(1,i);
end

for i = 1:p-1
    for j = i+1:p
        Cov(i,j) = {cov(B(:,:,i),B(:,:,j))};
    end
end

for i = 1:p
    for j = 1:p
        if i == j
            CovM(i,j) = std2(A(:,:,i))^2;
        elseif i > j
            CovM(i,j) = NaN;
        else
            CovM(i,j) = Cov{i,j}(1,2);
        end
    end
end

t = 1;

for i = 1:p-2
    for j = i+1:p-1
        for k = j+1:p
            i1 = num2str(i);
            j1 = num2str(j);
            k1 = num2str(k);
            SheffiledIndex(1,t) = {[i1 j1 k1]};
            C = [CovM(i,i),CovM(i,j),CovM(i,k);CovM(i,j),CovM(j,j),CovM(j,k);CovM(i,k),CovM(j,k),CovM(k,k)];
            SheffiledIndex(2,t) = {det(C)};
            t = t+1;
        end
    end
end

SheffiledIndex = SheffiledIndex';
SheffiledIndex = sortrows(SheffiledIndex,2,'descend');