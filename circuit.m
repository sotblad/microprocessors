% Truth table:
% a b c | e | f : d
% ~~~~~~~~~~~~~~~~~
% 0 0 0 | 0 | 1 : 0
% 0 0 1 | 0 | 0 : 0
% 0 1 0 | 0 | 1 : 0
% 0 1 1 | 0 | 0 : 0
% 1 0 0 | 0 | 1 : 0
% 1 0 1 | 0 | 0 : 0
% 1 1 0 | 1 | 1 : 1
% 1 1 1 | 1 | 0 : 0

function s=circuit(a, b, c)
  e = sp2AND(a,b);
  f = spNOT(c);
  d = sp2AND(e,f);
  printf("Circuit output: %f\n", d);
  # 2.2
  switchingActivity = 2*d*(1-d);
  printf("~~~~~~~~~~~~~~~~~\nCircuit Switching Activity: %f\n", switchingActivity);
  # 2.3
  values = [10, 100, 4456];
  for i = values
    printf("~~~~~~~~~~~~~~~~~\nMonte Carlo for N=%d:\n", i);
    MonteCarlo(i);
   endfor
endfunction

function s=sp2AND(input1sp, input2sp)
  s = input1sp*input2sp;
endfunction

function s=spNOT(input1sp)
  s = 1-input1sp;
endfunction

function SwitchingActivity=MonteCarlo(N)
  Workload=[];

  MonteCarloSize=N;
  for i = 1:MonteCarloSize
      Workload=[Workload; round(mod(rand(),2)), round(mod(rand(),2)), round(mod(rand(),3))];
  end
  vectorsNumber=size(Workload, 1);
  gateInputsNumber=size(Workload, 2);
  gateOutput=0;

  switchesNumber=0;
  for i = 1:vectorsNumber    
      NewGateOutput=Workload(i,1) &  Workload(i,2);
      
      if (gateOutput==(NewGateOutput&(ifelse (Workload(i,3)==1, 0, 1))))
          continue;
      else
          gateOutput=NewGateOutput;
      end
      
      switchesNumber=switchesNumber+1;
  end
  switchesNumber
  vectorsNumber
  SwitchingActivity=switchesNumber/vectorsNumber
endfunction