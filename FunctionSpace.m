function [ function_space ] = FunctionSpace( domain )
%FUNCTIONSPACE Summary of this function goes here
%   Detailed explanation goes here
switch domain.type
    case 'Mesh'
        switch domain.element_name
            case 'Hexa8'
                function_space.basis_number = domain.node_number;
                function_space.evaluate_basis = @ (xi) Hexa8(xi);
                function_space.non_zero_basis = @ (element_id) domain.connectivity(element_id, :);
                function_space.type = ['Mesh ', 'isoparametric ', 'Hexa8'];
            case 'Line2'
                function_space.basis_number = domain.node_number;
                function_space.evaluate_basis = @ (xi) Line2(xi);
                function_space.non_zero_basis = @ (element_id) domain.connectivity(element_id, :);
                function_space.type = ['Mesh ', 'isoparametric ', 'Line2'];
        end
    case 'ScatterPoint' % TODO
    case 'NURBS' % TODO
end


% function_space.non_zero_basis_id();


end

function [shape_func, d_shape_func] = Hexa8(xi)
%*************************************************************************
% Compute shape function, derivatives, and determinant of hexahedron element
%*************************************************************************
% shape_func   : shape function value evaluated at xi
% d_shape_func : gradient of shape function evaluated at xi. d N_j / d xi_i
%%
  node = [-1 -1 -1;
           1 -1 -1;
           1  1 -1;
          -1  1 -1;
          -1 -1  1;
           1 -1  1;
           1  1  1;
          -1  1  1]; 
  
  shape_func = zeros(1,8);
  d_shape_func = zeros(3,8);
  
  for I = 1:8    
    temp = [1+xi(1)*node(I, 1) 1+xi(2)*node(I, 2) 1+xi(3)*node(I, 3)];
    
    shape_func(I) = 0.125 * temp(1) * temp(2) * temp(3);
    d_shape_func(1,I) = 0.125 * node(I, 1) * temp(2) * temp(3);
    d_shape_func(2,I) = 0.125 * node(I, 2) * temp(1) * temp(3);
    d_shape_func(3,I) = 0.125 * node(I, 3) * temp(1) * temp(2);
  end
      
end

function [shape_func, d_shape_func] = Line2(xi)
%*************************************************************************
% Compute shape function, derivatives, and determinant of line element
%*************************************************************************
% shape_func   : shape function value evaluated at xi
% d_shape_func : gradient of shape function evaluated at xi. d N_j / d xi_i
%%
  shape_func = ([1-xi,1+xi]/2);
  d_shape_func = [-1,1]/2;
end