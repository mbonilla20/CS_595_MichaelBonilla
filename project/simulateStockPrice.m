function finalStockPrice = simulateStockPrice(S,r,d,v,T,dT)
        t = 0;
        while t < T
            t = t + dT;
            dr = (r - d - v*v/2)*dT;
            pert = v*sqrt( dT )*randn();
            S = S*exp(dr + pert);
        end
        finalStockPrice = S;
end