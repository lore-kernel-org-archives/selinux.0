Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0UFDCE2026419
 for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2014 10:13:12 -0500
References: <20140125205944.GB2542@telmora.telvanni>
 <20140126122922.GA2837@telmora.telvanni>
 <20140126224640.GE2837@telmora.telvanni> <52E68747.5020006@tycho.nsa.gov>
 <20140128171259.GC2501@telmora.telvanni> <52E7E74E.7020901@tycho.nsa.gov>
Message-ID: <1391094621.17775.YahooMailNeo@web87901.mail.ir2.yahoo.com>
Date: Thu, 30 Jan 2014 15:10:21 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Strange context on unix_stream_socket
To: Stephen Smalley <sds@tycho.nsa.gov>, Ole Kliemann <ole@plastictree.net>
In-Reply-To: <52E7E74E.7020901@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Out of idle curiosity would a range_transition rule resolve this problem ?

range_transition source target : unix_stream_socket s0;



----- Original Message -----
> From: Stephen Smalley <sds@tycho.nsa.gov>
> To: Ole Kliemann <ole@plastictree.net>
> Cc: selinux@tycho.nsa.gov
> Sent: Tuesday, 28 January 2014, 17:22
> Subject: Re: Strange context on unix_stream_socket
> 
> On 01/28/2014 12:12 PM, Ole Kliemann wrote:
>>  On Mon, Jan 27, 2014 at 11:20:23AM -0500, Stephen Smalley wrote:
>>>  On 01/26/2014 05:46 PM, Ole Kliemann wrote:
>>>>  I have written my own little socket test program. Process P1 with 
>>>>  context TYPE1:RANGE1 creates a socket and listens on it. P2 with 
>>>>  context TYPE2:RANGE2 connects to this socket.
>>>> 
>>>>  Process P1 accepts the connection. The socket created throught 
>>>>  accept() in P1 has actually the context TYPE1:RANGE2.
>>>> 
>>>>  Is this expected behavior? 
>>> 
>>>  Yes.  That was the behavior desired by the MLS/LSPP community, as they
>>>  want the socket to mirror the client level for multi-level servers, and
>>>  in the single-level server case, you are only allowed to connect at the
>>>  same level.
>> 
>>  Thank you for the clarification.
>> 
>>  Is there no way to control this? To state more precisly: I can 
>>  very well _connect_ to everything the policy allows me to, I then 
>>  just cannot use this connection. That's a bit weird.
>> 
>>  Although I admit, the problems arise from my specific situation 
>>  where I have one realm the consist of only one type but is 
>>  separated by MLS and another realm that is MLS-ignorant and uses 
>>  TE. All vectors running between the two realms are also only 
>>  controll by TE. When I now use sockets between the MLS and 
>>  non-MLS realm these connections should only be controlled by TE,
>>  but as a result of above mentioned labeling behavior, MLS 
>>  suddenly gets in the way.
>> 
>>  I can imagine, in an MLS-only environment this behavior makes 
>>  more sense; specificly in the case of multi-level servers. All 
>>  the more desirable it would be if the policy was to make such 
>>  labeling decisions at the discretion of the policy writer.
> 
> Yes, in prior implementations we allowed it to be configurable as a
> transition on the listening socket security context and the incoming
> packet security context.  That would be preferable IMHO, but is not
> possible today without kernel code changes.
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
