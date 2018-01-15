classdef pReLU < dagnn.ElementWise
  properties
    useShortCircuit = true
    leak = 0
    opts = {}
  end

  methods
     function params = initParams(obj)
          params{1} = -rand/100;
     end
    function outputs = forward(obj, inputs, params)
      outputs{1} = vl_nnrelu(inputs{1}, [], ...
                             'leak', params{1}, obj.opts{:}) ;
                         %Previously it is obj.leak
    end

    function [derInputs, derParams] = backward(obj, inputs, params, derOutputs)
      [derInputs{1},d] = vl_nnrelu(inputs{1}, derOutputs{1}, ...
                               'leak', params{1}, ...
                               obj.opts{:}) ;
                            
      derParams = {d} ;%d
    end


    
    function obj = pReLU(varargin)
      obj.load(varargin) ;
    end
  end
end
