function Write2Swc(A,name)
[m,n]=size(A);  
fid=fopen(name,'wt');
for i=1:m     
    for j=1:n        
        if j==n           
            fprintf(fid,'%g\n',A(i,j));       
        else
            fprintf(fid,'%g\t',A(i,j));
        end
    end
end
fclose(fid);
