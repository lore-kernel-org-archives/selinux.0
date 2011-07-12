Subject: Re: Sec context of unix domain sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Christian <martin.christian@secunet.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E1C7D08.8000007@secunet.com>
References: <4E11E53A.6080003@secunet.com>
	 <1310394094.3930.46.camel@moss-pluto>  <4E1C7D08.8000007@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jul 2011 13:23:28 -0400
Message-ID: <1310491408.309.24.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-07-12 at 18:57 +0200, Martin Christian wrote:
> Thanks Stephen for your extensive explanation.
> 
> Maybe you - or someone else on the list, of course - could help me with
> a unix socket problem. I'm still not sure whether your explanation (and
> documentation you referred to) is missing something or if our policy has
> a bug:
> 
> We developed a targeted policy for a system with 2 confined services:
> 
> * syslog is running in domain syslog_t and creates a unix domain socket
> in /dev/log.
> 
> * serva is running in domain serva_t and needs to send messages to
> syslog via the socket.
> 
> The rest of the system is unconfined with access to everything. Of
> course, there is a little bit more, but everything else is working just
> fine.
> 
> Now, I get the following AVC message:
> 
> [YYY] type=1400 audit(XXX): avc:  denied  { sendto } for
>   pid=1879 comm="serva" path="/dev/log"
>   scontext=system_u:object_r:serva_t:s1
>   tcontext=system_u:object_r:unconfined_t:s1
>   tclass=unix_dgram_socket
> 
> What I don't understand is, why tcontext is not syslog_t but unconfined_t?
> 
> I thought the following process applies:
> 1. syslog creates a listing socket with label syslog_t.
> 2. serva creates a socket for sending with label serva_t.
> 3. In order to send a message serva would require sendto permissions on
> syslog_t.
> 
> There is certainly some more in between these steps, but nothing that
> would make /dev/log labelled with unconfined_t, is it?

The socket is labeled when it is created.  So if it is created by a
process that runs in unconfined_t and then inherited by your syslog as
an open file descriptor, you would get the behavior you describe.  With
some init programs (e.g. systemd, Android init), we've had to instrument
the init program to properly label sockets because the init program
creates the socket and hands it to the service rather than having the
service daemon create the socket.

If that isn't your situation, then another possibility would be that
syslog is in fact running in unconfined_t due to a policy or labeling
error.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
