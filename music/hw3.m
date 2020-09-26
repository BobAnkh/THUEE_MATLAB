ep_0=8.854e-12;
u_0=4*pi*1e-7;
ep_r=ones(1,101);
ep_r(60:101)=4;
c=3e8;
dz=0.3;
dt=0.5*dz/c;
H_last=zeros(1,100);
H_next=zeros(1,100);
E_last=zeros(1,101);
E_next=zeros(1,101);
for n=1:300
    H_next=H_last-dt/u_0/dz*(E_last(2:101)-E_last(1:100));
    E_next(2:100)=E_last(2:100)-dt/dz/ep_0./ep_r(2:100).*(H_next(2:100)-H_next(1:99));
    E_next(31)=E_next(31)+exp(-((n-30)/15)^2);
    %plot(E_next);axis([0 110 -2 2]);
    plot(H_next);axis([0 110 -8e-3 8e-3]);
    getframe;
    H_last=H_next;
    E_last=E_next;
end
