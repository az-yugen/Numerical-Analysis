function R = bisectionM(x, f, bnd_low, bnd_up, Es, k_max)

fprintf('\n***INITIATING BISECTION METHOD***\n\n')

tic % start counting time

% rename some variables
L=bnd_low;
U=bnd_up;

% initializing some parameters
k=1;
Ea=[];
R=[];


% form table header in output showing each values at each iteration
disp('iter    L          R          U          f(L)       f(R)       f(U)       test      Ea')
figure('Name', 'Iterations'); hold on


% undergo bisection until termination criteria are met, and root is found, hopefully.
while k<k_max

    R_old=R;
    R=(L+U)/2;
    
    if(R~=0)
        Ea=abs((R-R_old)/R)*100;
    end
    
    test=subs(f,L)*subs(f,R);
    
    % form table in output showing each values at each iteration
    fprintf('%3i %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f %10.4f\n',...
        k,L,R,U,subs(f,L),subs(f,R),subs(f,U), test, Ea)
    
    if(test<0)
        U=R;
    elseif(test>0)
        L=R;
    else
        Ea=0;
    end
    if(Ea<Es)
        fprintf('prespecified percent tolerance passed: %2.4E\n',Ea);
        break;
    end
    if(k>=k_max)
        fprintf('max iterations reached: %3i\n',k_max);
        break;
    end
    

    
    %plot x, f values at each iteration
    itr_Z(k+1) = R; %#ok<AGROW>
    itr_f(k+1)=subs(f,R); %#ok<AGROW>

    subplot(2,1,1)
    line([k k+1], [itr_Z(k),itr_Z(k+1)]),
    ylabel('x'),legend('x_k'),xlim([0,k])
    subplot(2,1,2)
    line([k k+1], [itr_f(k), itr_f(k+1)]),
    ylabel('f(x)'),legend('f(x_k)'),xlim([0,k])
    %draw iteration plot as its iterating; disable to improve performance
    %drawnow; 
    
    k=k+1;
    
end

fprintf('\n***PROCESS FINISHED***\n')
fprintf("time elapsed: %g seconds.\n", toc) % stop counting time



%display results
fprintf('\nRoot estimated: x= %10.4f\n',R)
fprintf('where: f(x) = %10.10f\n',subs(f,R))





%plot found solution by the algorithm
figure('Name', 'Solution via Bisection Method');
hold on
title('Root via Bisection Method')
axis([bnd_low bnd_up -2 2]);
xlabel('x'), grid, legend
fplot(subs(f), 'DisplayName', 'f') %plot f
plot(R,subs(f,R),'Marker','diamond', 'Color', 'k'); %plot root point
text(R,subs(f,R)+0.2,num2str(R,4),'Color', 'k') %plot root value
hold off
l=legend('f', 'root');
set(l, 'Interpreter', 'latex')


