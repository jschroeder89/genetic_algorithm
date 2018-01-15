function action2(src,event)
% This callback causes the line to "blink"

for id = 1:3                        % Repeat 3 times
    event.Peer.LineWidth = 3;       % Set line width to 3
    pause(0.2)                      % Pause 0.2 seconds
    event.Peer.LineWidth = 0.5;     % Set line width to 0.5
    pause(0.2)                      % Pause 0.2 seconds
end

end