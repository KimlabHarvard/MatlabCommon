function h = oxfordHeliumUI
    h = figure;
    set(h,'MenuBar','none','Units','Normalized');
    set(h,'Position',[0.0 0.8 0.18 0.16]);
    
    btn = uicontrol(... % Button for updating selected plot
        'Parent', h, ...
        'Units','normalized',...
        'Position',[0.05 0.05 0.9 0.3],...
        'String','UPDATE',...
        'BackgroundColor',[1 0.6 0.6],...
        'FontSize',20,...
        'Callback', @updateHeliumLevel);
    txt = uicontrol('Style','text',...
        'Units','normalized',...
        'Position',[0.05 0.45 0.35 0.5],...
        'String',sprintf('Helium\nLevel:'),...
        'FontSize',25);
    value = uicontrol('Style','text',...
        'Units','normalized',...
        'Position',[0.4 0.45 0.55 0.5],...
        'String',sprintf('%g%%',returnHeliumLevel),...
        'FontSize',50);
    function updateHeliumLevel(source,callbackdata)
        set(value,'String',sprintf('%g%%\n',returnHeliumLevel))
    end
    
end