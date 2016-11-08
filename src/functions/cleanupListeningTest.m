function cleanupListeningTest(clearAll)
%CLEANUPLISTENINGTEST Summary of this function goes here
%   Detailed explanation goes here

evalin('base', 'close all;');
evalin('base', 'clear variables;');

clearTestConfig = false;

if nargin == 1
    clearTestConfig = clearAll;
end

evalin('base', 'clear calibrationGUI;');
evalin('base', 'clear enrollGUI;');
evalin('base', 'clear listeningGUI;');

if clearTestConfig
    evalin('base', 'clear TestConfig;');
end

evalin('base', 'clc;');

end

