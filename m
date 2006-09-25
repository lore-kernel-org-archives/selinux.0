Message-ID: <4518302F.4070804@hp.com>
Date: Mon, 25 Sep 2006 15:38:23 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com
Subject: Re: Labeled networking packets
References: <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>	 <1159202108.4252.4.camel@localhost.localdomain>	 <1159207486.15305.60.camel@moss-spartans.epoch.ncsc.mil>	 <1159208755.3169.47.camel@twoface.columbia.tresys.com>	 <1159209686.4741.46.camel@localhost.localdomain>  <4518275B.9040609@hp.com> <1159212339.16246.12.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159212339.16246.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-09-25 at 15:00 -0400, Paul Moore wrote:
> 
>>Karl MacMillan wrote:
>>
>>>On Mon, 2006-09-25 at 14:25 -0400, Joshua Brindle wrote:
>>>
>>>
>>>>On Mon, 2006-09-25 at 14:04 -0400, Stephen Smalley wrote:
>>>
>>>
>>><snip>
>>>
>>>>>>The remote socket is probably good enough, though, and as Josh points
>>>>>>out policy can enforce that the socket type matches the current process
>>>>>>domain type (or at least a domain type).
>>>>>
>>>>>It doesn't need to do that, and setsockcreatecon() wouldn't exist if we
>>>>>always wanted that relationship to be fixed.
>>>>>
>>>>
>>>>what was the use case behind adding setsockcreatecon? For guards its
>>>>helpful so that you don't have to alternate ipc mechanisms in the
>>>>pipeline but for client server relationships.. not sure. 
>>>
>>>xinetd was one - it allows the creation of sockets with the "correct"
>>>label (e.g., telnetd_t) so that all processes spawned by xinetd to have
>>>to have permissions on all xinetd sockets.
>>
>>I belive that the SELinux/xinetd (at least the initial version, not sure
>>if it has changed) patch did not use setsockcreatecon() to set the
>>socket's context.  The kernel was tasked with setting the context of the
>>accept()'d TCP socket to match the context of the connection.  The idea
>>being that xinetd would accept() the incoming connection, do a
>>getpeercon() to fetch a context, call setexeccon() with that context,
>>and finally spawn the server daemon.
> 
> But that doesn't deal with the TE aspect of the socket context, right?
> So you end up with the sockets being left in xinetd_t.

That depends on the underlying labeling protocol.  Steve Grubb's xinetd
patch simply takes the output of getpeercon() and feeds it back into
setexeccon().  In the case of NetLabel, the context returned by
getpeercon is the concatenation of the parent socket's TE context and
the MLS label of the remote socket.  So for NetLabel, yes, the spawned
server process will run in the xinetd_t domain, or whatever domain
xinetd was running in when the connection was established.  With labeled
IPsec this will obviously be different.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
