function [ variable ] = Variable( name, dim, varargin )
%VARIABLE Summary of this function goes here
%   Detailed explanation goes here
variable.name = name;
variable.dim = dim;
variable.reset_data = @(N) zeros(N, 1);

if(isempty(varargin))
    variable.data = [];
    variable.data_number = 0;
else
    variable.data = variable.reset_data(variable.dim * varargin{1});
    variable.data_number = size(variable.data, 1);
end

end

