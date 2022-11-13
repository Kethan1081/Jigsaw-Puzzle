function R2 = BlockMatchng(M, R1, props)
    R2 = R1;
    [rows, columns]  =size(R1);
    for j = 1:max(max(label))
        t = M{j};
        mask = uint8(props(j).Image);
        e = uint8(~edge(props(j).Image, 'Canny'));
        s1=0;
        s2=0;
        mse = intmax;
        [r,c] = size(t);
        for i = 1: rows-r
            for k = 1: columns-c
                img = imcrop(G1, [k,i,c-1,r-1]);
    
                err = immse(t, bsxfun(@times, img, uint8(mask)));
                if err < mse
                    mse = err;
                    s1 = i;
                    s2 = k;
                end
            end
        end
        for i = 0:r-1
            for k = 0:c-1
                G2(s1+i, s2+k) = G2(s1+i, s2+k) * e(i+1,k+1);
    %             R2(s1+i, s2+k, 1) = R2(s1+i, s2+k, 1) * e(i+1,k+1);
                if e(i+1, k+1) == 0
                    R2(s1+i, s2+k, 1) = 255;
                end
                R2(s1+i, s2+k, 2) = R2(s1+i, s2+k, 2) * e(i+1,k+1);
                R2(s1+i, s2+k, 3) = R2(s1+i, s2+k, 3) * e(i+1,k+1);
            end
        end
    
    end
end
