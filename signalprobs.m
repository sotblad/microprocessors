function s=signalprobs(input1sp, input2sp, input3sp, varargin)
  sp2AND(input1sp, input2sp)
  sp2OR(input1sp, input2sp)
  
  % �� �������� ����������� ������ �� ������������ ��� �� (�)
  sp2XOR(input1sp, input2sp)
  sp2NAND(input1sp, input2sp)
  sp2NOR(input1sp, input2sp)
  
  % �� �������� ����������� ������ �� ������� ��'��������� ��� �� (�)
  sp3AND(input1sp, input2sp, input3sp)
  sp3OR(input1sp, input2sp, input3sp)
  sp3XOR(input1sp, input2sp, input3sp)
  sp3NAND(input1sp, input2sp, input3sp)
  sp3NOR(input1sp, input2sp, input3sp)
  
  % �� �������� ����������� ������ �� ������� ��'��������� ��� �� (�)
  %% �������: ������ �� ������� ���������� ��� ����� �������� ���� ������
  spAND = spAND(0.3,0.2,0.7,0.4,0.25)
  spOR = spOR(0.3,0.2,0.7,0.4,0.25)
  spXOR = spXOR(0.3,0.2,0.7,0.4,0.25)
  spNAND = spNAND(0.3,0.2,0.7,0.4,0.25)
  spNOR = spNOR(0.3,0.2,0.7,0.4,0.25)
  
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
% 1 1 1:1
%% signal probability calculator for a 3-input XOR gate
%% input1sp: signal probability of first input signal
%% input2sp: signal probability of second input signal
%% input3sp: signal probability of second input signal
%%        s: output signal probability
function s=sp3XOR(input1sp, input2sp, input3sp)
  printf("XOR Gate for input probabilities (%f %f %f):\n",input1sp,input2sp,input3sp)
  s = (1-input1sp)*(1-input2sp)*input3sp + (1-input1sp)*input2sp*(1-input3sp) + input1sp*(1-input2sp)*(1-input3sp) + input1sp*input2sp*input3sp;
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