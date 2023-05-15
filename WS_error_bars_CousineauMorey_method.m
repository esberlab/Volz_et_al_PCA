%% WS error bars calculated by the Cousineau-Morey method

% Based on the following:
% Cousineau, D. (2005). Confidence intervals in withinsubject designs: A simpler solution to loftus and masson’s method. Tutorials in Quantitative Methods for
% Psychology, 1, 42–45. doi:10.20982/tqmp.01.1.p042

% Cousineau, D., & O’Brien, F. (2014). Error bars in within-subject designs: A comment on baguley (2012). Behavior Research Methods, 46, 1149–1159. doi:10.3758/
% s13428-013-0441-z

% O’Brien, F., & Cousineau, D. (2014). Representing error bars in within-subject designs in typical software packages. The Quantitative Methods for Psychology, 10, 56–
% 67

% O'Brien, F., & Cousineau, D. (2015). Erratum to "Representing Error bars in within-subject designs in typical
% software packages". The Quantitative Methods for Psychology, 11 (2), 126-126. 

% Morey, R. D. (2008). Confidence intervals from normalized data: A correction to cousineau (2005). Tutorials in
% Quantitative Methods for Psychology, 4, 61–64. doi:10.20982/tqmp.04.2.p061

%% To input data, just copy & paste on matlab's workspace a matrix with the following format:

% subject 1   "WS-factor1-level1/WS-factor2-level1"   "WS-factor1-level1/WS-factor2-level2" ... 
% or (it doesn't matter which)
% subject   "WS-factor1-level1/WS-factor2-level1"   "WS-factor1-level2/WS-factor2-level1" ... 
%
% example (but grab only the matrix; that is: don't include the subject column
% 	    A-	    A-	    A-	    A-	    A-	    A-	    A-	    A-	    AB+	    AB+	    AB+	    AB+	    AB+	    AB+	    AB+	    AB+	    B-	    B-	    B-	    B-	    B-	    B-	    B-	    B-
%   Rat	1	    2	    3	    4	    5	    6	    7	    8	    1	    2	    3	    4	    5	    6	    7	    8	    1	    2	    3	    4	    5	    6	    7	    8
%   1	3.1625	2.7375	2.4875	2.65	1.7	    2.0375	1.9875	1.9625	3.0625	4.2125	4.875	4.6125	2.9125	2.175	1.925	1.8375	4.575	3.3875	4.2625	4.375	2.9625	2.8375	3.0875	3.4375
%   3	2.15	3.4625	2.775	3.8375	2.5882	2.7375	2.8875	2.45	4.6875	5.7125	7.075	5.75	5.863	5.825	7.0375	5.8625	4.0125	3.5	    4.1375	2.5125	2.114	2.35	2.725	1.725
%   5	5.075	7.6625	4.775	6.85	6.4125	4.5375	3.55	4.0375	8.7	    10.187	10.525	11.012	10.912	11.462	12.062	11.112	6.725	7.55	4.775	3.8	    4.1	    3.375	3.837	2.25
%   7	2.325	2.5375	2.275	1.8625	2.3375	1.775	1.9   	1.4	    4.9125	6.2625	5.525	5.475	6.1875	4.1125	3.8875	4.2625	5.2875	5.6125	3.175	2.5125	2.175	2.2	    1.737	1.5125
%   11	1.45	1.775	2.5625	1.725	2.5375	2.9	    1.9875	2.325	3.1625	3.8125	5.15	5.3375	4.7625	5.925	5.125	4.875	2.7	    3.2875	4.4125	3.4875	2.9625	2.925	2.525	2.45
 
J = size(X,2) ;

Y = X - repmat(mean(X'),size(X,2),1)' + mean(mean(X))  ;
 
Z = sqrt(J/(J-1)) * ( Y - repmat(mean(Y), size(Y,1), 1) ) + repmat(mean(Y), size(Y,1), 1) ;

SE = nanstd(Z,0,1)/sqrt(size(Z,1)) ; % standard errors  

