normsqd = @(t) sum(t.*t,2); %squared l_2 norm of t
f1 = @(normt,a,d) ((2*pi*a^2).^(d/2)) * cos(a*sqrt(normt)) ...
   .* exp((1/2-a^2)*normt);
f = @(t,a,d) f1(normsqd(t),a,d);
abstol = 0; %absolute error tolerance
reltol = 0.01; %relative error tolerance
dvec = 250; %vector of dimensions
a = 1; %default value of a
a = 1; %default value of a again
cpuq = zeros(size(dvec)); %vector of answers
tic();
for d = dvec
   cpuq(d) = cubLattice_g(@(x) f(x,a,d),[-inf(1,d); inf(1,d)], ...
      'normal',abstol,reltol);
end
cputime=toc();

gpuq = zeros(size(dvec)); %vector of answers
tic();
for d = dvec
   gpuq(d) = cubLattice_g_GPU1(@(x) f(x,a,d),[-inf(1,d); inf(1,d)], ...
      'normal',abstol,reltol);
end
gputime=toc();


