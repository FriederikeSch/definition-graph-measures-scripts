%Berechnet die RandomWalkBetweenness für alle Knoten für alle Participants.
%Berechnet dafür das Verhältnis an Strecken von A nach C für die durch B
%gehen für alle möglichen Strecken A-C.
%In: eine Walkmap erstell mit RandomWalk.mat, PartList und graph.mat files
%Out: randwaklbetnodelist eine vorläufige Liste mit der
%RandomWalkBetweenness für die Participant musss noch mit RandWalkCalc
%bearbeitet werden.

clearvars;
%clc;


cd '/Users/User/Documents/Studium/BA/StartingPackage Graph Theory Kopie/Scripts/Basic Scripts/seenHousegraph';

PartList={1002,1003,1012,1023,1081,1089,1093,1119,1122,1155,1162,1171,1181,1184,1208,1299,1336,1359,1364,1373,1374,1449,1529,1540,1582,1600,1661,1737,1784,1809,1817,1820,1821,1882,1896,1906,1909,1934,1944,1961,1996,1997,2006,2011,2044,2051,2086,2098,2121,2147,2151,2179,2228,2251,2358,2366,2450,2462,2574,2607,2623,2637,2639,2653,2654,2702,2705,2719,2760,2769,2809,2853,2858,2907,2916,2950,2959,2973,2978,3023,3034,3048,3093,3116,3133,3226,3229,3236,3251,3299,3309,3377,3395,3421,3430,3439,3450,3506,3525,3571,3593,3618,3668,3686,3693,3717,3743,3755,3807,3826,3854,3856,3918,3949,3961,3983,4058,4059,4060,4069,4087,4104,4134,4157,4225,4253,4272,4302,4305,4340,4372,4376,4444,4470,4489,4502,4510,4519,4554,4588,4619,4662,4759,4772,4831,4911,4948,4951,4964,4991,5030,5092,5104,5149,5190,5231,5235,5239,5253,5287,5304,5311,5324,5346,5370,5387,5424,5432,5452,5507,5579,5582,5583,5602,5625,5648,5667,5696,5699,5706,5746,5771,5823,5961,5978,5979,5984,5998,6077,6122,6212,6225,6237,6316,6348,6387,6393,6398,6406,6430,6465,6468,6503,6525,6543,6569,6588,6594,6844,6845,6876,6937,6971,6976,7018,7021,7037,7084,7104,7177,7205,7320,7324,7350,7395,7399,7478,7498,7509,7514,7527,7535,7537,7545,7561,7583,7639,7666,7670,7868,7913,7942,7953,7998,8039,8041,8045,8070,8072,8099,8174,8195,8215,8216,8220,8222,8235,8258,8261,8283,8365,8429,8437,8457,8466,8517,8547,8551,8552,8556,8559,8580,8665,8699,8753,8765,8804,8834,8864,8869,8896,8936,8954,9017,9057,9061,9139,9288,9303,9308,9311,9327,9364,9378,9412,9430,9434,9437,9448,9471,9474,9475,9533,9559,9657,9680,9717,9748,9751,9848,9961,9994};
% PartList={1002};

number = length(PartList);
load ('walkmap1000');
msg=('something is really really wrong');


%Enthält für jeden Paricipant eine Reihe. Die Spalten zeigen den Anteil von
%Strecken mit B zu denen ohne B für jeden Knoten in den Graphen. Die
%Spalten Indices entsprechen nicht den Knoten Indices. Wenn ein Knoten
%nicht besucht wurde wird -1 eingetragen. Das Array wird hinten mit 0
%aufgefüllt. 
randwalkbetnodelist=zeros(312,213);

hold=0;
count=0;

for ii = 1:number
   
    currentPart = cell2mat(PartList(ii));
    
    file = strcat(num2str(currentPart),'_Graph.mat');
 
    % check for missing files
    if exist(file)==0
        countMissingPart = countMissingPart+1;
        
        noFilePartList = [noFilePartList;currentPart];
        disp(strcat(file,' does not exist in folder'));
    %% main code   
    elseif exist(file)==2
    
        % analysis
        %load graph
        graphy = load(file);
        graphy= graphy.graphy;
        nodes=table2array(graphy.Nodes);
        l=numnodes(graphy);
        %nimmt den passenden Randomwalk für den Participant aus der Walkmap
        row=walkmap(ii,:);
         %row=h(ii,:);
        
         % b ist der Knoten für den geprüft wird ob er auf der Strecke A-C
         % liegt. Wird für jeden Knoten im Graph getan
         for b =1:length(nodes)
             
             betholdlist=zeros(1,l);
             h=1;
            
            %bind enthält alle Indices an denen b im RandomWalk besucht wird 
            bind=find(row==b);
            %wenn bind leer ist wird b nie besucht in diesem Fall kann
            %keine Betweenness für diesen Knoten berechnet werden
            if isempty(bind)
           
                randwalkbetnodelist(ii,b)=-1;
                
                
            else   
             
            %posc zählt die Strecken auf denen b zwischen A und C liegt
            %negc zählt die Strecken auf denen b nicht zwischen A und C
            %liegt
           % posc=0;
           % negc=0;
            %error(msg);
           count=count+1;
            % a ist der Startpunkt der Strecke
            for a=1:length(nodes)
                
                posc=0;
                negc=0;
                %betholdlist=[];
                
                %aind gibt alle Indices von a in der Walkmap an
                %disp(row);
                aind=find(row==a);
                %wenn aind leer ist wurde a nie besucht es gibt also auch
                %keine Strecke von A nach C nach der gesucht werden muss
                if isempty(aind)
                   % error(msg);
                   %disp(aind);
                   
                else   
                
                % c ist der Endpunkt der Strecke 
                for c=1:length(nodes)
                    %cind gibt alle Indices von c in der Walkmap an
                    cind=find(row==c);
                    %wenn c nie besucht wurde kann es auch keine Strecke
                    %von A nach C geben.
                    if isempty(cind)
                        %break;
                    else
                    
                    %auf der Suche nach Strecken von A nach C wird über C
                    %geloopt cpos ist die Position des ersten c in der
                    %Walkmap
                    cpos=cind(1,1);
                    %aposlast speichert die Position des letzten A
                    aposlast=0;
                    
                    
                    while not(isempty(cpos))
                    
                        
%// der nachfolgende Teil kann auch als Funktion alleine stehen (siehe countbfun)
% die Laufzeit wird aber durch den Funktionsaufruf stark verlängert
% der Funktionsaufruf ist: 
%[posc,negc,aposlast]=countbfun(aind,bind,cpos,aposlast,posc,negc);
 
%die Funktion sucht für eine Kombination aus A,B und C
%alle Strecken von A nach C raus und notiert in posc und negc 
%wo B auf dem Weg lag

%In: aind: Eine Indexliste von allen Positionen an denen A im RandomWalk
%besucht wird
%    bind: Eine Indexliste von allen Positionen an denen B im RandomWalk
%    besucht wird
%    cpos: Die Position von C von der die Suche nach einem vorhergehenden A
%    gestartet wird
%    aposlast: Die Position des letzten A in einer Strecke
%    posc: Zähler wie viele Strecken auf denen B vorkommt, schon gefunden
%    wurden
%    negc: Zähler auf wie vielen Strecken auf denen B nicht vorkommt, schon
%    gefunden wurden
%
%Out: posc:Zähler wie viele Strecken auf denen B vorkommt, schon gefunden
%     wurden
%     negc: Zähler auf wie vielen Strecken auf denen B nicht vorkommt, schon
%     gefunden wurden
%     aposlast: Wenn ein neues A gefunden wurde die Position dieses A sonst
%     das letzte gefundene A

                                      
                   
% function [posc,negc,aposlast]= countbfun(aind,bind,cpos,aposlast,posc,negc)
%Fehlermeldung
%msg='something is really wrong';

%Erstellt ein logisches Array von aind das alle Indices in aind die
%kleinergleich sind cpos auf wahr setzt (findet alle A die kleinergleich C sind)
posa=aind<=cpos;
% nimmt den maximalen Wert aus aind der kleinergleich cpos ist und speichert ihn in apos 
%(findet das nächste A das kleinergleich C ist)
[apos,~]=max(aind(posa));

% wenn apos nicht leer ist wurde ein A vor C gefunden Wenn die Position von A
% nicht größer ist handelt es sich um ein A das schon gesehen wurde (dieser
% Fall sollte eigentlich nicht eintreten können)
if not(isempty(apos)) && apos>aposlast

  % es wird das größte B gesucht das kleinergleich C ist
  posb=bind<=cpos;
  [bpos,~]=max(bind(posb));
    
  % wenn ein b gefunden wurde (bpos ist nicht leer) und dieses B größer als
  % A ist also zwischen A und C liegt wird der positiv Counter um eins
  % erhöht und die Strecke als gezählt markiert in dem aposlast auf A
  % gesetzt wird.
  if not(isempty(bpos)) && apos<=bpos
      posc=posc+1;
      aposlast=apos;
  % wenn kein b gefunden wurde oder wenn das b das gefunden wurde nicht
  % zwischen A und C liegt wurde trotzdem eine Strecke A-C gefunden. Der
  % negativ Counter wird hochgesetzt und die Strecke mit aposlast als
  % gezählt markiert.
  elseif isempty(bpos) || apos>bpos
  
      negc=negc+1;
      aposlast=apos;
     % error(msg);

  else
      error(msg);
      
  end
  
%wenn apos leer ist gibt es kein A vor C. Da über C geloopt wird muss
%nichts getan werden
elseif isempty(apos) || apos<=aposlast
%disp('elseif');
else
  
   error(msg); 
end

%end

%// Ende der Funktion
                   
                   
                   
                   
                    % findet das nächst größere A 
                    hold=aind(find(aind>aposlast,1));
                    
                    % wenn es kein A mehr gibt kann auch keine Strecke mehr
                    % entstehen und der Durchgang endet
                    if isempty(hold)
                        break;
                    end
                    
                    % Die Position nächsten C wird auf die Höhe des
                    % nächsten A geschoben. Die C die vor dem nächsten A
                    % liegen können keine Strecke bilden und werden
                    % übersprungen. Wenn kein weiteres C mehr gefunden
                    % werden kann bleibt cpos leer und die Abbruchbedingung
                    % der while Schleife ist erfüllt
                    cpos=cind(find(cind>=hold,1));
                    
                    
                    end 
                    
                    
                    allc=negc+posc;
                    
                    if allc==0
                        betholdlist(1,h)=0;
                        h=h+1;
                    else
                    bethold=posc/allc;
                 
                    betholdlist(1,h)=bethold;
                    h=h+1;
                    end
                    end
                end   
                end
            end
            
            %Zählt alle Strecken zusammen und berechnet den Anteil von
            %Strecken mit B zu denen ohne B und trägt den Wert in die Liste
            %ein
            
            
            
           % negc=negc+posc;   
           % bet=posc/negc;
           summ=sum(betholdlist);
           
            randwalkbetnodelist(ii,b)=summ;
            end
         end   
    end  
 end

        
        
        