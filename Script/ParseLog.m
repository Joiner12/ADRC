classdef ParseLog
    properties
        filepath = "This is a file path"
    end

    methods
        function obj = ParseLog(filepath_in)
            if nargin < 1
                fprintf('%s\n',...
                    datetime('now','format','yyyy-MM-dd HH:mm:SS'))
                    obj.filepath = (datetime('now','format','yyyy-MM-dd HH:mm:SS'));
            else
                obj.filepath = filepath_in;
            end
        end
    end

    
    methods(Static)
        function LogDataIn(filepath_in)
            if nargin < 1
                fprintf("no parameter in \n");
            else
                fprintf('file path is:%s\n',filepath_in);
            end
        end
    end
end