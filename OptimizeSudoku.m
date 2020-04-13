%% Integer Program to Solve Sudoku Puzzles
% Alexander Chang
% Optimization 2

function outputmatrix = OptimizeSudoku(M)
%% computing objective function 
f = zeros(729,1); % 9^3 total variables 

for i = 1:3
    for j = 1:3
        for k = 1:3
            for l = 1:3               
                m_index = M((i-1)*3+1:i*3,(j-1)*3+1:j*3);      
                if m_index(k,l)~=0
                    f(((i-1)*3+(j-1))*9*9 + ((k-1)*3+(l-1))*9 + m_index(k,l))=1;
                end
            end
        end
    end
end

%% constraint 1: each entry has 1 number
Aeq = [];
beq = [];
Aeqp = [];
beqp = [];
index = 0;

for i = 1:3
    for j = 1:3
        for k = 1:3
            for l = 1:3
                index = index + 1;
                start = ((i-1)*3+(j-1))*9*9 + ((k-1)*3+(l-1))*9 + 1;
                Aeqp(index, start:start+8) = 1;
                beqp(index, 1) = 1;
            end
        end
    end
end
Aeq = [Aeq; Aeqp];
beq = [beq; beqp];

%% constraint 2: every micro tic-tac-toe has every integer once
Aeqp = [];
beqp =[];
index = 0;

for i = 1:3
    for j = 1:3
        for m = 1:9 
            index = index + 1;
            for k = 1:3
                for l = 1:3
                    Aeqp(index, ((i-1)*3+(j-1))*9*9+((k-1)*3+(l-1))*9+m)=1;
                    beqp(index, 1) = 1;
                end
            end
        end
    end
end
Aeq = [Aeq; Aeqp];
beq = [beq; beqp];

%% constraint 3: every row has every integer once
Aeqp = [];
beqp = [];
index = 0;

for i = 1:3
    for k = 1:3
        for m = 1:9
            index = index + 1;
            for j = 1:3
                for l = 1:3
                    Aeqp(index, ((i-1)*3+(j-1))*9*9+((k-1)*3+(l-1))*9+m)=1;
                    beqp(index, 1) = 1;
                end
            end
        end
    end
end
Aeq = [Aeq; Aeqp];
beq = [beq; beqp];

%% constraint 4: every column has every integer once
Aeqp = [];
beqp = [];
index = 0;

for j = 1:3
    for l = 1:3
        for m = 1:9
            index = index + 1;
            for i = 1:3
                for k = 1:3
                    Aeqp(index, ((i-1)*3+(j-1))*9*9+((k-1)*3+(l-1))*9+m)=1;
                    beqp(index, 1) = 1;
                end
            end
        end
    end
end
Aeq = [Aeq; Aeqp];
beq = [beq; beqp];

%% Computation
lb = zeros(729,1);
ub = ones(729,1);
intcon = 1:729;
x = intlinprog(-f, intcon, [], [], Aeq, beq, lb, ub);

%% Output the solution matrix
outputmatrix = zeros(9,9);

for i = 1:3
    for j = 1:3
        for k = 1:3
            for l = 1:3
                for m = 1:9
                    if x(( (i-1)*3+(j-1) )*9*9 + ((k-1)*3+(l-1))*9 + m,1)~=0
                        outputmatrix((i-1)*3+k,(j-1)*3+l) = m;
                    end
                end
            end
        end
    end
end
disp(outputmatrix)


                
