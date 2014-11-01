function [ Xi ] = projection(Ai,Bi,AB)

	Xi = (Ai*Ai + AB*AB - Bi*Bi)/(2*AB);

end