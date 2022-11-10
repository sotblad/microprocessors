function runMCOR4()
  A = [];
  B = [];
  C = [];
  D = [];
  A = [A; MCOR4(10)];
  printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
  B = [B; MCOR4(20)];
  printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
  C = [C; MCOR4(30)];
  printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
  D = [D; MCOR4(4456)];
  silent_functions(1)
  for i = 1:3
    A = [A; MCOR4(10)];
    B = [B; MCOR4(20)];
    C = [C; MCOR4(30)];
    D = [D; MCOR4(4456)];
  endfor
  silent_functions(0)
  x = [10, 20, 30, 4456];
  y = [mean(A), mean(B), mean(C), mean(D)];
  plot(x,y);
endfunction
