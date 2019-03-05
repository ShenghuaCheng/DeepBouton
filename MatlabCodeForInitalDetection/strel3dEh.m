function se=strel3dEh(sesize)
sw=(sesize-1)/2; 
[y,x,z]=meshgrid(-sw(1):sw(1),-sw(2):sw(2),-sw(3):sw(3)); 
m=x.^2/sw(1)^2 + y.^2/sw(2)^2 + z.^2/sw(3)^2; 
b=(m <= 1); 
se=strel('arbitrary',b);
end



