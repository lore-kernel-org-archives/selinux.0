Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23856
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 09:23:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA14624
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:23:52 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA14620
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:23:51 GMT
Date: Mon, 3 Dec 2001 09:23:22 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Krumviede <pwk@acm.org>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: use of ps in ipsec shutdown
In-Reply-To: <136698191.1007117073@localhost>
Message-ID: <Pine.GSO.4.33.0112030911410.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 30 Nov 2001, Paul Krumviede wrote:

> i noticed that the supplied policy left some processes in the
> initrc_t domain, such as _plutorun and _plutoload. i also noticed
> that the ipsec startup script invokes logger, and that whack,
> running in the initrc_t domain, was being denied permission
> to connect to the socket set up by pluto. so i labeled the
> /usr/local/sbin/ipsec script, whack, _plutoload, _plutoread
> and whack as ipsec_exec_t types, and allowed ipsec_t
> to execute shells, bin_t and sbin_t things (the latter in part
> because the default label of things in /usr/local/lib/ipsec
> is sbin_t). this seems to have fixed all the things decribed
> above (although i'm open to suggestions as to alternative
> approaches).

The problem with this approach is that it increases the risk that
malicious code will be able to execute in the ipsec_t domain and
thus gain access to a PF_KEY socket.  The ipsec_t domain should only
be granted execute access to the ipsec_exec_t type, and this type
should only be assigned to code that legitimately needs to access
PF_KEY sockets.  Any other code should be run in a different domain.

> i also noticed that _startklips wanted (limited) access
> to /proc/sys/net/ipsec/icmp, so i gave some sysctl
> access.

We can modify the module to bind a distinct type to /proc/sys/net/ipsec if
desired.

> i later noticed a number of avc denials at shutdown
> when ps, apparently run out of _realsetup, is attempting
> to read some of the process information. for example, i see
>
> avc:  denied  { getattr } for  pid=2358 exe=/bin/ps path=/1 dev=00:03
> ino=65538
>    scontext=system_u:system_r:ipsec_t
>    tcontext=system_u:system_r:init_t
>    tclass=dir

This is probably happening because the script is now running in ipsec_t,
which isn't a good idea anyway.  But this is a common problem when ps
scans /proc, because only a subset of /proc will be accessible to most
domains.  It is ok to deny these accesses, because this process only
truly needs to access the /proc/PID entries for processes within the
ipsec_t domain in order to shut down those processes.  You can suppress
the audit messages via auditdeny rule, as mentioned by Mark.

> i'd be happy to share the changed/new policy files when i
> have them working (or earlier if anybody so desires).

Yes, please do.  But I don't want to grant the ipsec_t domain execute
access to any other types in the example policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
