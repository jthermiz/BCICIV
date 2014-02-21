function savefig(fig, num)
% SAVEFIG - Saves a figure to PNG
%   
    hgexport(fig, sprintf('fig%d.png', num), hgexport('factorystyle'), 'Format', 'png');
end