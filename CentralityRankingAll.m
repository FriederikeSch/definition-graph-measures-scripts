% Builds a Ranking of all nodes according to their centrality scores.
%
% In: Centrality, finnallist, summedeueccentricity
% Out: allsort: a sorted list of all nodes and their ranking score

clearvars;

cd '/Users/User/Documents/Studium/BA/Auswertungsplots/';

%a list of Degree, Closeness, Shortest Path Betweenness and Eigenvector Centrality
load ('Centrality'); 

% holds Random Walk Betweenness
load('finallist');

% holds Eccentricity scores
load('summedupeccentricty');

all=zeros(1,213);

% take inverse to calculate eccentricity as centrality measure 
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

% sorts ascending to value 

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

% creates the node ranking the node with the lowest score get one point the next one two and so on

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

% searches for the ranking value in each measure for each node and adds them
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

%builds the ranking by sorting the nodes 
[allsort(2,:),allsort(1,:)]=sort(all);

%plot(allsort(1,:));
