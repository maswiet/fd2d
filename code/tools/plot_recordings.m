function plot_recordings(u,t)

%==========================================================================
%- plot recordings, ordered according to distance from the first source ---
%==========================================================================

%- read input -------------------------------------------------------------

path(path,'../../input/');
input_parameters;

fid=fopen([source_path 'source_locations'],'r');
src_x=fscanf(fid,'%g',1);
src_z=fscanf(fid,'%g',1);
fclose(fid);

%- make distance vector and sort ------------------------------------------

d=sqrt((rec_x-src_x).^2+(rec_z-src_z).^2);
[dummy,idx]=sort(d);

%- plot recordings with ascending distance from the first source ----------

figure
set(gca,'FontSize',20)
hold on

for k=1:length(rec_x)
    
    m=max(abs(u(idx(k),:)));
    if mod(k,2)
        plot(t,0.75*(k-1)+u(idx(k),:)/m,'k','LineWidth',1)
    else
        plot(t,0.75*(k-1)+u(idx(k),:)/m,'b','LineWidth',1)
    end
    
    if (max(rec_x)<=1000)
        text(min(t)-(t(end)-t(1))/6,0.75*(k-1)+0.3,['x=' num2str(rec_x(idx(k))) ' m, z=' num2str(rec_z(idx(k))) ' m'],'FontSize',14)
    else
        text(min(t)-(t(end)-t(1))/6,0.75*(k-1)+0.3,['x=' num2str(rec_x(idx(k))/1000) ' km, z=' num2str(rec_z(idx(k))/1000) ' km'],'FontSize',14)
    end
    
end

xlabel('time [s]','FontSize',20);
ylabel('normalised traces','FontSize',20);
axis([min(t)-(t(end)-t(1))/5 max(t)+(t(end)-t(1))/10 -1.5 0.75*length(rec_x)+1])