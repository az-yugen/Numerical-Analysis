clc;clear;close all

% Change Numerical Format to decimal (short) or rational (rat) representation
format short

% GIVEN MATRICES
fprintf("GIVEN MATRICES\n");
A= [8 2 -2;10 2 4;12 2 2]             % Coefficient Matrix A
B= [-2;4;6]                           % equation RHS Column Matrix B


% INITIALIZING SOME VARIABLES
n = length(B);                        % Matrix Size n
%X=zeros(n,1);                         % Zero Matrix in size nx1 to store solutions
Aug=[A B];                            % Concatenating A and B to form Augmented Matrix
fprintf("\nMatrix Size: n= %i\n", n);
fprintf("\nResulting Augmented Matrix\n"); Aug
d_max=10;




% INITIATING MAIN LOOP. OUTER LOOP TO FIND MULTIPLE SAMPLES OF SOLUTION
% WITH SLIGHT PERTURBATION IN INITIAL CONDITION

for d=1:d_max                          % running algorithm d_max times with small changes as a check for ill conditionness
    
    
    % ADDING PERTURBATION TO SYSTEM TO CHECK FOR ILL-CONDITIONNESS
    fprintf("\n\n\n\n\n***DELTA PERTURBATION LEVEL %i OF TOTAL %i***\n\n", d, d_max);
    
    for b=1:n
        delta(b,1) = rand/10;             % generating random normalized delta perturbation values at each d iteration
        B_d{d}(b,1) = B(b,1)+delta(b,1);  % modifying set B with them.
    end
    
    Aug_d{d} = [A B_d{d}];
    
    fprintf("where perturbation matrix:"); delta
    fprintf("modified augmented matrix: "); Aug_d{1,d}
    
    
    
    % FORWARD ELIMINATION LOOP
    fprintf("\n\n\n\n\n***INITIATING FORWARD ELIMINATION STAGE***\n");
    for k=1:n-1                           % for each kth column from 1 to n-1.

        fprintf("\n\n\n     ELIMINATION LEVEL %i of %i: \n", k, n-1);
        for i=k+1:n                       % for each ith row from (k+1)th column till n. i.e. start from 2nd row till last
            factor = Aug_d{d}(i,k)/Aug_d{d}(k,k);   % determine the factor for each ith row. i.e. a_(i,k) divided by pivot element
            fprintf("\nelimination factor for level %i,row %i: %s", k, i, strtrim(rats(factor)));
            fprintf("\nAugmented Matrix after row elimination:\n");
            Aug_d{d}(i,:) = Aug_d{d}(i,:) - factor*Aug_d{d}(k,:)    % undergo elimination in each entry in ith row
        end

    end

    % FINAL RESULTING AUGMENTED MATRIX AFTER ELIMINATION
    fprintf("\n\n\n***END OF ELIMINATION STAGE. RESULTING AUGMENTED MATRIX IN UPPER TRIANGULAR FORM***\n");
    Aug_d{1,d}




    % BACKWARD SUBSTITUTION LOOP
    fprintf("\n\n\n\n\n***INITIATING BACKWARD SUBSTITUTION STAGE***\n");

    X{d}(n,1)= Aug_d{d}(n, n+1)/Aug_d{d}(n,n);
    fprintf("\n solution %i: %4.4f", n, X{d}(n,1));   % nth solution                          

    for k=n-1:-1:1                        % for each (n-1)th row backward to 1.
        X{d}(k,1) = (Aug_d{d}(k, n+1)-Aug_d{d}(k,k+1:n)*X{d}(k+1:n))/Aug_d{d}(k,k);    % undergo back substitution
        fprintf("\n solution %i: %4.4f", k, X{d}(k,1));
    end


    % FINAL SOLUTION MATRIX
    fprintf("\n\n***END OF SUBSTITUTION STAGE. RESULTING SOLUTION***\n");
    X{1,d}
end


fprintf("\n\n\n***END OF ALL DELTA PERTURBATION SAMPLES***\n\n\n\n\n\n\n");







% FINDING AVERAGE SOLUTION FROM ALL DELTA PERTURBATION SAMPLES

X_d=zeros(n,1);                           % initializing average nx1 solution matrix

for m=1:d
    for r=1:n
        X_d(r,1)=X_d(r,1)+X{1,m}(r,1);    %find mean of each solution across d samples
    end
end

X_m=X_d./d;

fprintf("\n\nRESULTING MEAN SOLUTION\n"); X_m




