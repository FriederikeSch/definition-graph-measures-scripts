%Die Funktion berechent für zwei beliebige Punkte (A,C) im Graphen ob 
%ein weiterer Punkt B auf zwischen ihnen liegt.
%
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

function [posc,negc,aposlast]= countbfun(aind,bind,cpos,aposlast,posc,negc)
%Fehlermeldung
msg='something is really wrong';

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

end