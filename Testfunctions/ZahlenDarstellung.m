% IEEE-Standard 754
format long
fprintf('Zahlendarstellung beim Datentyp ''double''\n');
fprintf('Größte normalisierte Gleitpunktzahl (2-2^(1-53))*2^1023\n');
disp(realmax)
fprintf('Kleinste positive normalisierte Gleitpunktzahl 2^(-1022)\n');
disp(realmin)
fprintf('\nUmstellen des Ausgabeformat mit ''format hex''\n');
format hex
fprintf('Größte normalisierte Gleitpunktzahl (2-2^(1-53))*2^1023\n');
disp(realmax)
disp(num2bin(quantizer('double'),realmax))
fprintf('Kleinste positive normalisierte Gleitpunktzahl 2^(-1022)\n');
disp(realmin)
disp(num2bin(quantizer('double'),realmin))


format long
fprintf('\n\nZahlendarstellung beim Datentyp ''single''\n');
fprintf('Größte normalisierte Gleitpunktzahl (2-2^(1-23))*2^127\n');
disp(realmax('single'))
fprintf('Kleinste positive normalisierte Gleitpunktzahl 2^(-126)\n');
disp(realmin('single'))
fprintf('\nUmstellen des Ausgabeformat mit ''format hex''\n');
format hex
fprintf('Größte normalisierte Gleitpunktzahl (2-2^(1-53))*2^1023\n');
disp(realmax('single'))
disp(num2bin(quantizer('single'),realmax('single')))
fprintf('Kleinste positive normalisierte Gleitpunktzahl 2^(-1022)\n');
disp(realmin('single'))
disp(num2bin(quantizer('single'),realmin('single')))

format long
a = hex2num('44f056a610c7aae1');
b = hex2num('44f056a610c7aae2');
fprintf('\nDifferenz zwischen b=''44f056a610c7aae2'' und a=''44f056a610c7aae1'':%d',b-a);

% Größe der Mantisse
p = 53;
e = floor(log2(a));
fprintf('\nDer Exponent ist %d und damit die Differenz 2^(%d-%d+1) :%d ',e,e,p,2^(e-p+1));

a = hex2num('44b056a610c7aaee');
b = hex2num('44b056a610c7aaef');
fprintf('\nDifferenz zwischen b=''44b056a610c7aaef'' und a=''44b056a610c7aaee'':%d',b-a);

% Größe der Mantisse
p = 53;
e = floor(log2(a));
fprintf('\nDer Exponent ist %d und damit die Differenz 2^(%d-%d+1) :%d ',e,e,p,2^(e-p+1));

fprintf('\n\nDie Maschinengenauigkeit beim Datentyp ''double'' ist %g', eps);
fprintf('\nDie Maschinengenauigkeit in MATLAB ist 2^(1-p) %g', 2^(1-p));

fprintf('\n');




