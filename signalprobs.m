%%%
%%%
%%% τρέχετε το πρόγραμμα ως:
%%% signalprobs(input1sp,input2sp)
%%%
%%% Παραδείγματα:
%%% >> signalprobs(0.5,0.5)
%%% AND Gate for input probabilities (0.500000 0.500000):
%%% ans =  0.25000
%%% OR Gate for input probabilities (0.500000 0.500000):
%%% ans =  0.75000
%%% XOR Gate for input probabilities (0.500000 0.500000):
%%% NAND Gate for input probabilities (0.500000 0.500000):
%%% NOR Gate for input probabilities (0.500000 0.500000):
%%%
%%%
%%% >> signalprobs(0,0)
%%% AND Gate for input probabilities (0.00000 0.00000):
%%% ans =  0
%%% OR Gate for input probabilities (0.00000 0.00000):
%%% ans =  0
%%% XOR Gate for input probabilities (0.00000 0.00000):
%%% NAND Gate for input probabilities (0.00000 0.00000):
%%% NOR Gate for input probabilities (0.00000 0.00000):
%%%
%%% >> signalprobs(1,1)
%%% AND Gate for input probabilities (1.00000 1.00000):
%%% ans =  1
%%% OR Gate for input probabilities (1.00000 1.00000):
%%% ans =  1
%%% XOR Gate for input probabilities (1.00000 1.00000):
%%% NAND Gate for input probabilities (1.00000 1.00000):
%%% NOR Gate for input probabilities (1.00000 1.00000):
%%%
%%%
%%%
%%% Οι συναρτήσεις που υπολογίζουν τα signal probabilities 
%%% AND και OR πυλών δύο εισόδων έχουν ήδη υλοποιηθεί παρακάτω.
%%% Οι συναρτήσεις που υπολογίζουν τα signal probabilities 
%%% XOR, NAND και NOR πυλών δύο εισόδων είναι ημιτελής.
%%% (α) Σας ζητείτε να συμπληρώσετε τις υπόλοιπες ημιτελής συναρτήσεις για τον υπολογισμό
%%% των signal probabilities XOR,NAND και NOR 2 εισόδων πυλών.
%%% (β) γράψτε συναρτήσεις για τον υπολογισμό των signal probabilities 
%%% AND, OR, XOR, NAND, NOR πυλών 3 εισόδων
%%% (γ) γράψτε συναρτήσεις για τον υπολογισμό των signal probabilities 
%%% AND, OR, XOR, NAND, NOR πυλών Ν εισόδων


function s=signalprobs(input1sp, input2sp, input3sp)
  sp2AND(input1sp, input2sp)
  sp2OR(input1sp, input2sp)
  
  % Οι παρακάτω συναρτήσεις πρέπει να ολοκληρωθούν για το (α)
  sp2XOR(input1sp, input2sp)
  sp2NAND(input1sp, input2sp)
  sp2NOR(input1sp, input2sp)
  
  % Οι παρακάτω συναρτήσεις πρέπει να γραφούν εξ'ολοκλήρου για το (β)
  sp3AND(input1sp, input2sp, input3sp)
  sp3OR(input1sp, input2sp, input3sp)
  sp3XOR(input1sp, input2sp, input3sp)
  sp3NAND(input1sp, input2sp, input3sp)
  sp3NOR(input1sp, input2sp, input3sp)
  
  % Οι παρακάτω συναρτήσεις πρέπει να γραφούν εξ'ολοκλήρου για το (γ)
  %% προσοχή: πρέπει να παίζουν ανεξάρτητα του πόσες εισόδους τους δίνετε
  spAND = spAND(0.5,0.5)
  spOR = spOR(0.5,0.5)
  spXOR = spXOR(0.5,0.5)
  spNAND = spNAND(0.5,0.5)
  spNOR = spNOR(0.5,0.5)
  
  switchingActivity(spAND)
  switchingActivity(spOR)
  switchingActivity(spXOR)
  switchingActivity(spNAND)
  switchingActivity(spNOR)
  
end
%

% 2-input AND gate truth table
% 0 0:0
% 0 1:0
% 1 0:0
% 1 1:1
%% signal probability calculator for a 2-input AND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2AND(input1sp, input2sp)
  printf("AND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp*input2sp;
  endfunction


% 2-input OR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:1
%% signal probability calculator for a 2-input OR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2OR(input1sp, input2sp)
  printf("OR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1-(1-input1sp)*(1-input2sp);
endfunction


% 2-input XOR gate truth table
% 0 0:0
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2XOR(input1sp, input2sp)
  printf("XOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = input1sp*input2sp*((1/input1sp) + (1/input2sp) - 2);
endfunction


% 2-input NAND gate truth table
% 0 0:1
% 0 1:1
% 1 0:1
% 1 1:0
%% signal probability calculator for a 2-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NAND(input1sp, input2sp)
  printf("NAND Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = 1 - (input1sp*input2sp);
endfunction


% 2-input NOR gate truth table
% 0 0:1
% 0 1:0
% 1 0:0
% 1 1:0
%% signal probability calculator for a 2-input NOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%%        s: output signal probability
function s=sp2NOR(input1sp, input2sp)
  printf("NOR Gate for input probabilities (%f %f):\n",input1sp,input2sp)
  s = (1-input1sp)*(1-input2sp);
endfunction


% 3-input AND gate truth table
% 0 0 0:0
% 0 0 1:0
% 0 1 0:0
% 0 1 1:0
% 1 0 0:0
% 1 0 1:0
% 1 1 0:0
% 1 1 1:1
%% signal probability calculator for a 3-input AND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=sp3AND(input1sp, input2sp, input3sp)
  printf("AND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = input1sp*input2sp*input3sp;
endfunction


% 3-input OR gate truth table
% 0 0 0:0
% 0 0 1:1
% 0 1 0:1
% 0 1 1:1
% 1 0 0:1
% 1 0 1:1
% 1 1 0:1
% 1 1 1:1
%% signal probability calculator for a 3-input OR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=sp3OR(input1sp, input2sp, input3sp)
  printf("OR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = 1-(1-input1sp)*(1-input2sp)*(1-input3sp);
endfunction


% 3-input XOR gate truth table
% 0 0 0:0
% 0 0 1:1
% 0 1 0:1
% 0 1 1:0
% 1 0 0:1
% 1 0 1:0
% 1 1 0:0
% 1 1 1:0
%% signal probability calculator for a 3-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=sp3XOR(input1sp, input2sp, input3sp)
  printf("XOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = (1-input1sp)*(input2sp+input3sp-(2*input2sp*input3sp)) + (input1sp-(input1sp*input2sp))*(1-input3sp);
endfunction


% 3-input NAND gate truth table
% 0 0 0:1
% 0 0 1:1
% 0 1 0:1
% 0 1 1:1
% 1 0 0:1
% 1 0 1:1
% 1 1 0:1
% 1 1 1:0
%% signal probability calculator for a 3-input NAND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=sp3NAND(input1sp, input2sp, input3sp)
  printf("NAND Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = 1 - (input1sp*input2sp*input3sp);
endfunction


% 3-input NOR gate truth table
% 0 0 0:1
% 0 0 1:0
% 0 1 0:0
% 0 1 1:0
% 1 0 0:0
% 1 0 1:0
% 1 1 0:0
% 1 1 1:0
%% signal probability calculator for a 3-input NOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=sp3NOR(input1sp, input2sp, input3sp)
  printf("NOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = (1-input1sp)*(1-input2sp)*(1-input3sp);
endfunction


% N-input AND gate
%% signal probability calculator for a 3-input AND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=spAND(varargin)
  printf("AND Gate for input probabilities:\n")
  s = varargin{1,1};
  for i = 2:nargin
    s *= varargin{1,i};
  end
endfunction


% N-input OR gate
%% signal probability calculator for a 3-input OR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=spOR(varargin)
  printf("OR Gate for input probabilities:\n")
  s = (1-varargin{1,1});
  for i = 2:nargin
    s *= (1-varargin{1,i});
  end
  s = 1 - s;
endfunction


% N-input XOR gate
%% signal probability calculator for a 3-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=spXOR(varargin)
  printf("XOR Gate for input probabilities:\n")
 % s = ((2^nargin)-1)/(2^nargin)
  s = 1;
endfunction


% N-input NAND gate
%% signal probability calculator for a 3-input NAND gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=spNAND(varargin)
  printf("NAND Gate for input probabilities:\n")
  s = varargin{1,1};
  for i = 2:nargin
    s *= varargin{1,i};
  end
  s = 1 - s;
endfunction


% N-input NOR gate
%% signal probability calculator for a 3-input NOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=spNOR(varargin)
  printf("NOR Gate for input probabilities:\n")
  s = 1-varargin{1,1};
  for i = 2:nargin
    s *= 1-varargin{1,i};
  end
endfunction

function s=switchingActivity(sp)
  printf("Switching activity for signal probability %f\n", sp)
  s = 2*sp*(1-sp);
endfunction