%Erstellt ein Ranking aller Knoten anhand der Centralitäts Werte.

clearvars;

cd '/Users/User/Documents/Studium/BA/Auswertungsplots/';

load ('Centrality'); 

load('finallist');

load('summedupeccentricty');

all=zeros(1,213);

%Inverse nehmen,um Eccentricity als Centralitäts Wert verwenden zu können
for i=1:213
    sumupecc(1,i)=1/sumupecc(1,i);
end
%Degree
deg=centlist(1,:);
%Closeness
clos=centlist(2,:);
%Betweenness (shortest path)
bet=centlist(3,:);
%Eigenvector
eig=centlist(5,:);

%sortiert aufsteigend nach Wert
[degsort(2,:),degsort(1,:)]=sort(deg);
degsort(3,:)=zeros;



[clossort(2,:),clossort(1,:)]=sort(clos);
clossort(3,:)=zeros;

[betsort(2,:),betsort(1,:)]=sort(bet);
betsort(3,:)=zeros;

[eigsort(2,:),eigsort(1,:)]=sort(eig);
eigsort(3,:)=zeros;

%Random Walk Betweenness
[randbetsort(2,:),randbetsort(1,:)]=sort(randwalkbetcompletelist);
randbetsort(3,:)=zeros;

%Eccentricity
[eccsort(2,:),eccsort(1,:)]=sort(sumupecc);
eccsort(3,:)=zeros;

%erstellt ein Ranking für jeden Knoten. Der Knoten mit dem niederigsten Wert
%kriegt 1, der nächste 2 usw.

for i=1:213
    degsort(3,i)=degsort(3,i)+i;
    clossort(3,i)=clossort(3,i)+i;
    betsort(3,i)=betsort(3,i)+i;
    eigsort(3,i)=eigsort(3,i)+i;
    randbetsort(3,i)=randbetsort(3,i)+i;
    eccsort(3,i)=eccsort(3,i)+i;
    
end


degn=degsort(1,:);
closn=clossort(1,:);
betn=betsort(1,:);
eign=eigsort(1,:);
randbetn=randbetsort(1,:);
eccn=eccsort(1,:);

%sucht für jeden Knoten den Ranking Wert und addiert für die Measures
for j=1:213
  hold=degn==j; 
  sum=degsort(3,hold);
  
   hold=closn==j;
   sum=sum+clossort(3,hold);
   
   hold=betn==j;
   sum=sum+betsort(3,hold);
   
    hold=eign==j;
   sum=sum+eigsort(3,hold);
   
    hold=randbetn==j;
   sum=sum+randbetsort(3,hold);
   
    hold=find(eccn==j);
   sum=sum+eccsort(3,hold);
   
   all(1,j)=sum;
end

%erstellt ein Ranking für alle Knoten vom niederigsten zum höchsten
[allsort(2,:),allsort(1,:)]=sort(all);

%plot(allsort(1,:));