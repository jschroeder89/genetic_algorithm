%%
clc;
close all;
clear all;

%%
Gen = [2.3 3.0 1.6 -2.5 0.6 0.8 1.9;
    -2.8 3.0 0.5 2.4 2.3 -1.7 -1.9;
    3.0458 5.6387 2.4957 -2.7573 4.9273 -1.5867 1.2875] %Test Generation

%%Testing
Gen_coded = binary_coding(Gen, 3, -3, 3, -3); %coding
Gen_decoded = binary_decoding(Gen_coded, 3, -3, 3, -3); %decoding
g = binary2gray('0100');
b = gray2binary(g);
fitness_prop(Gen)