function varargout=SAIDutil(command,varargin)
%SAIDUTIL Execute intermediate calls to private function under Simulink for SAID toolbox.
%
%  Synopsis
%
%    varargout=SAIDutil(command,varargin)
%
%  command  = Function called.
%  varargin = All the input parameters for the function in command.
%  
%  varargout = All the output parameters for the function in command.
%


n_par=nargout;
if n_par==0
   feval(command,varargin{:});
else
   varargout=cell(1,n_par);
   [varargout{:}]=feval(command,varargin{:});
end

command=command;
