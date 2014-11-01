function stateDiff = getStateSim(state1,state2,LocationMatrix)
State1=state1(4:end);
State2=state2(4:end);

if(state1==state2)
    stateDiff=1;
else
    if(LocationMatrix{State1,State2}==1)
    stateDiff=0.5
    
    else
        stateDiff=0;
    end
end