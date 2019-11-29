%Die Funktion sucht einen zufälligen Nachbarn eines Knoten im Graphen
%In: graph: ein Graph, num: die Nummer eines Knoten im Graph
%Out: idx: die Nummer eines benachbarten Knoten 


function idx = randomwalkfun(graph,num)
            
        nei=neighbors(graph,num);
        
        len=length(nei);
        
        %choose a random number as index
        idx=randi([1 len]);
        
        %take the node with that index from the neighbor List
        idx=nei(idx,1);
        
end