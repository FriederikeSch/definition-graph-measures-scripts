%The script calculates the expected global clustering coefficient 
%for a given degree distribution if all connections in the graph 
%where drawn randomly. The applied formula is found in:
%Newman, M.E.J.(2010). "Introduction to Networks". p.263.
%
%In: PartList, graph.mat files, HouseList.mat
clearvars;

cd '/Users/User/Documents/Studium/BA/StartingPackage Graph Theory Kopie/Scripts/Basic Scripts/seenHousegraph';

PartList={1002,1003,1012,1023,1081,1089,1093,1119,1122,1155,1162,1171,1181,1184,1208,1299,1336,1359,1364,1373,1374,1449,1529,1540,1582,1600,1661,1737,1784,1809,1817,1820,1821,1882,1896,1906,1909,1934,1944,1961,1996,1997,2006,2011,2044,2051,2086,2098,2121,2147,2151,2179,2228,2251,2358,2366,2450,2462,2574,2607,2623,2637,2639,2653,2654,2702,2705,2719,2760,2769,2809,2853,2858,2907,2916,2950,2959,2973,2978,3023,3034,3048,3093,3116,3133,3226,3229,3236,3251,3299,3309,3377,3395,3421,3430,3439,3450,3506,3525,3571,3593,3618,3668,3686,3693,3717,3743,3755,3807,3826,3854,3856,3918,3949,3961,3983,4058,4059,4060,4069,4087,4104,4134,4157,4225,4253,4272,4302,4305,4340,4372,4376,4444,4470,4489,4502,4510,4519,4554,4588,4619,4662,4759,4772,4831,4911,4948,4951,4964,4991,5030,5092,5104,5149,5190,5231,5235,5239,5253,5287,5304,5311,5324,5346,5370,5387,5424,5432,5452,5507,5579,5582,5583,5602,5625,5648,5667,5696,5699,5706,5746,5771,5823,5961,5978,5979,5984,5998,6077,6122,6212,6225,6237,6316,6348,6387,6393,6398,6406,6430,6465,6468,6503,6525,6543,6569,6588,6594,6844,6845,6876,6937,6971,6976,7018,7021,7037,7084,7104,7177,7205,7320,7324,7350,7395,7399,7478,7498,7509,7514,7527,7535,7537,7545,7561,7583,7639,7666,7670,7868,7913,7942,7953,7998,8039,8041,8045,8070,8072,8099,8174,8195,8215,8216,8220,8222,8235,8258,8261,8283,8365,8429,8437,8457,8466,8517,8547,8551,8552,8556,8559,8580,8665,8699,8753,8765,8804,8834,8864,8869,8896,8936,8954,9017,9057,9061,9139,9288,9303,9308,9311,9327,9364,9378,9412,9430,9434,9437,9448,9471,9474,9475,9533,9559,9657,9680,9717,9748,9751,9848,9961,9994};
%PartList={1002};

Number = length(PartList);

degreelist=zeros(1,213);
counter=zeros(1,213);
load('HouseList');
assortlist=zeros(1,312);

for ii = 1:Number
    
    
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
   
        for i=1:length(nodes)
            %trägt für jeden Knoten den Degree ein
            degreeofnodes(1,i)=degree(graphy,i);
        end

        
        
     for j=1:max(degreeofnodes)
        hold= find(degreeofnodes==j);
        
        % wie speichert wie viele Knoten einen Degree von j haben
        dist(1,j)=length(hold);
        
        dist(1,j)=dist(1,j)/213;
        dist(1,j)=dist(1,j)*j;
        
        distsqrd=dist(1,j)*(j^2);
        distthree=dist(1,j)*(j^3);
    end
 
mom=sum(dist);
secmom=sum(distsqrd);
thirdmom=sum(distthree);

 c=1/213*(((secmom-mom)^2)/thirdmom);
 assortlist(1,ii)=c;
    end
end

ew=sum(assortlist)/312;
       

 