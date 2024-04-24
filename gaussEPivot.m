clc;clear;close all

% Change Numerical Format to decimal (short) or rational (rat) representation
format short

% GIVEN MATRICES
fprintf("GIVEN MATRICES\n");
A= [8 2 -2;10 2 4;12 2 2]             % Coefficient Matrix A
B= [-2;4;6]                           % equation RHS Column Matrix B


% INITIALIZING SOME VARIABLES
n = length(B);                        % Matrix Size n
X=zeros(n,1);                         % Zero Matrix in size nx1 to store solutions
Aug=[A B];                            % Concatenating A and B to form Augmented Matrix
fprintf("\nMatrix Size: n= %i\n", n);
fprintf("\nResulting Augmented Matrix\n"); Aug






% FORWARD ELIMINATION LOOP
fprintf("\n\n\n\n\n***INITIATING FORWARD ELIMINATION STAGE***\n");
for k=1:n-1                           % for each kth column from 1 to n-1.
    
    
    % PARTIAL PIVOTING:
    fprintf("\n\n\n     PARTIAL PIVOTING LEVEL %i of %i: \n", k, n-1);
    [big, p] = max(abs(Aug(k:n,k)));   % finding max entry at kth column. big = max entry, p = which row it is at
    fprintf("\n bigger entry is  %4.4f of  row %i: \n", big, p+k-1);
    L = Aug(k,:);                     % storing row to be replaced in L
    Aug(k,:) = Aug(p+k-1,:);          % replacing row L with B
    Aug(p+k-1,:) = L;                 % placing stored row L where it should be
    fprintf("\nresulting augmented matrix after exchange:"); Aug
    
    
    fprintf("\n\n\n     ELIMINATION LEVEL %i of %i: \n", k, n-1);
    for i=k+1:n                       % for each ith row from (k+1)th column till n. i.e. start from 2nd row till last
        factor = Aug(i,k)/Aug(k,k);   % determine the factor for each ith row. i.e. a_(i,k) divided by pivot element
        fprintf("\nelimination factor for level %i,row %i: %s", k, i, strtrim(rats(factor)));
        fprintf("\nAugmented Matrix after row elimination:\n");
        Aug(i,:) = Aug(i,:) - factor*Aug(k,:)    % undergo elimination in each entry in ith row
    end
    
    
end

% FINAL RESULTING AUGMENTED MATRIX AFTER ELIMINATION
fprintf("\n\n\n***END OF ELIMINATION STAGE. RESULTING AUGMENTED MATRIX IN UPPER TRIANGULAR FORM***\n");
Aug







% BACKWARD SUBSTITUTION LOOP
fprintf("\n\n\n\n\n***INITIATING BACKWARD SUBSTITUTION STAGE***\n");

X(n)= Aug(n, n+1)/Aug(n,n);
fprintf("\n solution %i: %4.4f", n, X(n,1));   % nth solution
%X(n,1)                                

for k=n-1:-1:1                        % for each (n-1)th row backward to 1.
    X(k) = (Aug(k, n+1)-Aug(k,k+1:n)*X(k+1:n))/Aug(k,k);    % undergo back substitution
    fprintf("\n solution %i: %4.4f", k, X(k,1));
end


% FINAL SOLUTION MATRIX
fprintf("\n\n***END OF SUBSTITUTION STAGE. RESULTING SOLUTION***\n");
X




