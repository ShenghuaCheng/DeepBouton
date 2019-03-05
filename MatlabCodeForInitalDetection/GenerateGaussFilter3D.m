function gaussTemplate3D = GenerateGaussFilter3D(thetaGauss)
s = 2 * round(2 * thetaGauss) + 1;
gaussTemplate3D = zeros(s, s, s);
f = @(x) 1/(sqrt(2*pi) * thetaGauss) * exp(-1/2 * norm(x)^2 / thetaGauss^2);
for i = 1 : s
    for j = 1 : s
        for l = 1 : s
            tempVar = [i - (s+1)/2 j - (s+1)/2 l - (s+1)/2] * 2;
            gaussTemplate3D(i, j, l) = f(tempVar);
        end
    end
end
gaussTemplate3D = gaussTemplate3D / sum(gaussTemplate3D(:));

end
