function [success] = sendmsg(message,ipaddress,port)
%SENDMSG Sends string to client
%success is true if client responded and false otherwise

if nargin==1
    tcpipClient = tcpip('127.0.0.1',55001,'NetworkRole','Client');
else 
    if nargin==2
        tcpipClient = tcpip(ipaddress,55001,'NetworkRole','Client');
    else
        tcpipClient = tcpip(ipaddress,port,'NetworkRole','Client');
    end
end

set(tcpipClient,'Timeout',30);
exception = MException('instrument:fopen:opfailed','Unsuccessful open: Connection refused: connect');
try
    fopen(tcpipClient);
    fwrite(tcpipClient,message);
    fclose(tcpipClient);
    success = true;
catch exception
    success = false;
end
end

