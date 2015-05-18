1;

clear all;
close all;
clc;

x = linspace(0, 2*pi, 100);
dvc = 50;
delta = 0.05;
N = 100:10000;

%Dimensao VC
function k = mh (N, dvc)
  if N <= dvc
    k = 2^N;
  else
    k = N^dvc + 1;
  end
end

%Original VC-bound
function e = vc(N, dvc, delta)
    e = sqrt ((8/N) * log ((4 * mh (N, dvc)) / delta));
end

%Redemacher bound
function e = rm(N, dvc, delta)
  e = sqrt ((2 * log (2 * N * mh (N, dvc))) / N) + sqrt ((2/N) * log (1/delta)) + (1/N);
end

%Parrondo and Van der Broek bound (interactively method - pag. 57 of the text book)
function e = pvb(N, dvc, delta)
    e_prev = vc(N, dvc, delta);
    e_next = sqrt((1/N) * (2*e_prev + log((6 * mh(2*N, dvc)) / delta)));
    
    while(abs(e_prev - e_next) > 0.01)
        e_prev = e_next;
        e_next = sqrt((1/N) * (2*e_prev + log((6 * mh(2*N, dvc)) / delta)));
    endwhile
    e = e_next;
end  

%Devroye bound (interactively method - pag. 57 of the text book)
%ln((4 * mh(N^2)) / delta) = ln(4) + ln(mh(N^2)) - ln(delta) = ln(N^(2*dvc) + 1) +ln(4) - ln(delta) = ...
% 2*dvc*ln(N) + ln((1/N^(2*dvc)) + 1) + ln(4) - ln(delta) = 2*dvc*ln(N) + ln(4) - ln(delta)
function e = dve(N, dvc, delta)
    e_prev = vc(N, dvc, delta);
    e_next = sqrt((1/(2*N)) * (4*e_prev*(1 + e_prev) + 2*dvc*log(N) + log(4) - log(delta)));
   
    while(abs(e_prev - e_next) > 0.01)
        disp(abs(e_prev - e_next));
        e_prev = e_next;
        e_next = sqrt((1/(2*N)) * (4*e_prev*(1 + e_prev) + 2*dvc*log(N) + log(4) - log(delta)));
    endwhile
    e = e_next;
end   
 
%Gera o grafico
h = figure(1);
plot(N , arrayfun(@vc, N, dvc, delta) , 'r');
grid on;
hold on;
plot(N , arrayfun(@rm, N, dvc, delta) , 'g');
plot(N , arrayfun(@pvb, N, dvc, delta) , 'b');
plot(N , arrayfun(@dve, N, dvc, delta) , 'k');
hold off;

title('Bounds comparison');
xlabel('N');
ylabel('epsilon');
legend('VC-Bound', 'Redemacher', 'Parrondo and Van der Broek', 'Devroye');

set(h,'PaperUnits','inches');
set(h,'PaperOrientation','portrait');
set(h,'PaperSize',[16,9]);
set(h,'PaperPosition',[0,0,16,9]);

print(h,'-dpng','-color','2-20.png',"-FHelvetica:10");

