
clc;clear;close all


%assign interval and some intial values to apply bracketting algorithms on
bnd_low = 0;
bnd_up = 2;
tol_lvl=1e-2;
iter_max=20;


%assign funciton to handle for easier manipulation
syms x
f = @(n) my_f(x);


%plot the function before applying the algorithm

fprintf('Given Function: f(x)= %s\n',f(x))
fprintf('Provided tolerance level and interval: %2.0E, [%3.2f,%3.2f]\n\n',tol_lvl,bnd_low,bnd_up)

n=linspace(bnd_low-5,bnd_up+5,100);
figure('Name', 'Given function and some points of interest');
plot(n,my_f(n),'-.'), grid
axis([bnd_low-5 bnd_up+5 -inf, inf])
xlabel('x');
l=legend(strcat('f = ',char(f(x))),'Location', 'best');
set(l, 'Interpreter', 'latex')
title('given function')



%applying the bisection algorithm on given function in given interval
bisectionM(x, f, bnd_low, bnd_up, tol_lvl, iter_max);



%applying the false position method on given function in given interval
fprintf("\n\n\n")
falsePositionM(x, f, bnd_low, bnd_up, tol_lvl, iter_max);



%applying the MODIFIED false position method on given function in given interval
%fprintf("\n\n\n")
%falsePositionModM(x, f, bnd_low, bnd_up, tol_lvl, iter_max);

