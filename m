Message-ID: <52E68747.5020006@tycho.nsa.gov>
Date: Mon, 27 Jan 2014 11:20:23 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ole Kliemann <ole@plastictree.net>, selinux@tycho.nsa.gov
Subject: Re: Strange context on unix_stream_socket
References: <20140125205944.GB2542@telmora.telvanni>
 <20140126122922.GA2837@telmora.telvanni>
 <20140126224640.GE2837@telmora.telvanni>
In-Reply-To: <20140126224640.GE2837@telmora.telvanni>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/26/2014 05:46 PM, Ole Kliemann wrote:
> On Sun, Jan 26, 2014 at 01:29:22PM +0100, Ole Kliemann wrote:
>> On Sat, Jan 25, 2014 at 09:59:44PM +0100, Ole Kliemann wrote:
>>> I'm having an odd problem:
>>>
>>> I am running my own MCS constrainted policy on Ubuntu 12.04. At 
>>> some point I have a process with context 
>>>
>>>     sub_t:s0:c20-s0:c20.c29
>>>
>>> From this process I try to access a jack daemon with mplayer. For 
>>> this purpose unix stream sockets are being used. I then get an 
>>> avc denial saying that
>>>
>>>     process sub_t:s0:c20-s0:c20.c29
>>>
>>> tried to access 
>>>
>>>     unix_stream_socket sub_t:s0
>>>
>>> which is prohibited by mcs constrain. The socket is on sockfs and 
>>> has no file associated with it.
>>>
>>> The problem is that under no circumstances the policy allows the 
>>> creation of anything with 'sub_t:s0'. 
>>>
>>> Using an auditallow rule like
>>>
>>>     auditallow any_type sub_t:unix_stream_socket { create relabelto relabelfrom };
>>>
>>> clearly shows that indeed no socket with a context like that is 
>>> created nor relabel to.  And yet it exists.
>>
>> With strace and GDB I managed to find out this much:
>>
>> mplayer open several sockets and listens on at least one of them. 
>> All these sockets have correct context. I determined the context 
>> using
>>
>>     'stat -L /proc/PID/fd/FD'
>>
>> I hope that is a valid method.
>>
>> It then accept a connection on a listening socket, probably 
>> coming from the jack daemon. As we know, the system call 
>> accepting a connection on a socket returns a new socket itself. 
>> At the point the system call returns, this new socket is found in 
>> /proc/PID/fd/ and has the offending context.
>>
>> Now I don't know much about these sockets. Process A listens on 
>> socket S0 and accepts the connection of process B. A new socket 
>> S1 appears. Who, in terms of policy, is the creating process for 
>> socket S1? How does the kernel determine the context of such a 
>> socket?
> 
> I have written my own little socket test program. Process P1 with 
> context TYPE1:RANGE1 creates a socket and listens on it. P2 with 
> context TYPE2:RANGE2 connects to this socket.
> 
> Process P1 accepts the connection. The socket created throught 
> accept() in P1 has actually the context TYPE1:RANGE2.
> 
> Is this expected behavior? 

Yes.  That was the behavior desired by the MLS/LSPP community, as they
want the socket to mirror the client level for multi-level servers, and
in the single-level server case, you are only allowed to connect at the
same level.
