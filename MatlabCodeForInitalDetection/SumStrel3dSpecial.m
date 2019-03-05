function wj = SumStrel3dSpecial(sesize)
sw=(sesize-1)/2; 
ses2=ceil(sesize/2);            % ceil sesize to handle odd diameters
[y,x,z]=meshgrid(-sw:sw,-sw:sw,-sw:sw); 
m=sqrt(x.^2 + y.^2 + z.^2); 
b=(m <= m(ses2,ses2,sesize)); 
b(ses2,ses2,ses2) = 0;
wj = sum(b(:));

end

