Message-ID: <4518275B.9040609@hp.com>
Date: Mon, 25 Sep 2006 15:00:43 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com
Subject: Re: Labeled networking packets
References: <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil>	 <1159202108.4252.4.camel@localhost.localdomain>	 <1159207486.15305.60.camel@moss-spartans.epoch.ncsc.mil>	 <1159208755.3169.47.camel@twoface.columbia.tresys.com> <1159209686.4741.46.camel@localhost.localdomain>
In-Reply-To: <1159209686.4741.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Mon, 2006-09-25 at 14:25 -0400, Joshua Brindle wrote:
> 
>>On Mon, 2006-09-25 at 14:04 -0400, Stephen Smalley wrote:
> 
> 
> <snip>
> 
>>>>The remote socket is probably good enough, though, and as Josh points
>>>>out policy can enforce that the socket type matches the current process
>>>>domain type (or at least a domain type).
>>>
>>>It doesn't need to do that, and setsockcreatecon() wouldn't exist if we
>>>always wanted that relationship to be fixed.
>>>
>>
>>what was the use case behind adding setsockcreatecon? For guards its
>>helpful so that you don't have to alternate ipc mechanisms in the
>>pipeline but for client server relationships.. not sure. 
> 
> xinetd was one - it allows the creation of sockets with the "correct"
> label (e.g., telnetd_t) so that all processes spawned by xinetd to have
> to have permissions on all xinetd sockets.

I belive that the SELinux/xinetd (at least the initial version, not sure
if it has changed) patch did not use setsockcreatecon() to set the
socket's context.  The kernel was tasked with setting the context of the
accept()'d TCP socket to match the context of the connection.  The idea
being that xinetd would accept() the incoming connection, do a
getpeercon() to fetch a context, call setexeccon() with that context,
and finally spawn the server daemon.

> Any time sockets are going to be created by one process and passed to
> another it is useful to have setsockcreatecon.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
