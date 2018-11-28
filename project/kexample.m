normsqd = @(t) sum(t.*t,2); %squared l_2 norm of t
f1 = @(normt,a,d) ((2*pi*a^2).^(d/2)) * cos(a*sqrt(normt)) ...
   .* exp((1/2-a^2)*normt);
f = @(t,a,d) f1(normsqd(t),a,d);
abstol = 0; %absolute error tolerance
reltol = 0.01; %relative error tolerance
dvec = [1:10,10:10:100,150:50:300]'; %vector of dimensions
a = 1; %default value of a
a = 1; %default value of a again
cpuq = zeros(size(dvec)); %vector of answers
cputime=cpuq;
gputime=cpuq;
for i=1:size(dvec,1)
tic();
   cpuq(i) = cubLattice_g(@(x) f(x,a,dvec(i)),[-inf(1,dvec(i)); inf(1,dvec(i))], ...
      'normal',abstol,reltol);
cputime(i)=toc();
gpuDevice(1);
gpuq = zeros(size(dvec)); %vector of answers
tic();
   gpuq(i) = cubLattice_g_GPU1(@(x)f(x,a,dvec(i)),[-inf(1,dvec(i)); inf(1,dvec(i))], ...
      'normal',abstol,reltol);
gputime(i)=toc();
gpuDevice(1);
end

