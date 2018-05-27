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
        CC(i,j) = {corrcoef(B(:,:,i),B(:,:,j))};
    end
end

for i = 1:p
    for j = 1:p
        if i == j
            CCM(i,j) = 1;
        elseif i > j
            CCM(i,j) = NaN;
        else
            CCM(i,j) = CC{i,j}(1,2);
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
            OptimumIndexFactor(1,t) = {[i1 j1 k1]};
            OptimumIndexFactor(2,t) = {(StD(1,i)+StD(1,j)+StD(1,k))/abs(CCM(i,j)+CCM(i,k)+CCM(j,k))};
            t = t+1;
        end
    end
end

OptimumIndexFactor = OptimumIndexFactor';
OptimumIndexFactor = sortrows(OptimumIndexFactor,2,'descend');