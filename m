Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15440
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 13:45:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24853
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 18:44:32 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzband.ncsc.mil  with ESMTP id SAA24849
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 18:44:31 GMT
Received: from [10.0.1.17] (goedel.xiat.org [10.0.1.17])
	(authenticated)
	by khaipur.xiat.org (8.11.6/8.11.6) with ESMTP id fAUIj8M32537
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 10:45:08 -0800
Date: Fri, 30 Nov 2001 10:44:33 -0800
From: Paul Krumviede <pwk@acm.org>
To: selinux <selinux@tycho.nsa.gov>
Subject: use of ps in ipsec shutdown
Message-ID: <136698191.1007117073@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i've been experimenting with the freeswan-1.91 ipsec implementation
in some of the more recent selinux releases, including the latest 2.4.14
one, and, after making some changes to the supplied ipsec policy,
have come across something i don't yet know how to handle.

i noticed that the supplied policy left some processes in the
initrc_t domain, such as _plutorun and _plutoload. i also noticed
that the ipsec startup script invokes logger, and that whack,
running in the initrc_t domain, was being denied permission
to connect to the socket set up by pluto. so i labeled the
/usr/local/sbin/ipsec script, whack, _plutoload, _plutoread
and whack as ipsec_exec_t types, and allowed ipsec_t
to execute shells, bin_t and sbin_t things (the latter in part
because the default label of things in /usr/local/lib/ipsec
is sbin_t). this seems to have fixed all the things decribed
above (although i'm open to suggestions as to alternative
approaches).

i also noticed that _startklips wanted (limited) access
to /proc/sys/net/ipsec/icmp, so i gave some sysctl
access.

i later noticed a number of avc denials at shutdown
when ps, apparently run out of _realsetup, is attempting
to read some of the process information. for example, i see

avc:  denied  { getattr } for  pid=2358 exe=/bin/ps path=/1 dev=00:03 
ino=65538
   scontext=system_u:system_r:ipsec_t
   tcontext=system_u:system_r:init_t
   tclass=dir
avc:  denied  { search } for  pid=2358 exe=/bin/ps path=/1 dev=00:03 
ino=65538
   scontext=system_u:system_r:ipsec_t
   tcontext=system_u:system_r:init_t
   tclass=dir
avc:  denied  { read } for  pid=2358 exe=/bin/ps path=/1/stat dev=00:03 
ino=65547
   scontext=system_u:system_r:ipsec_t
   tcontext=system_u:system_r:init_t
   tclass=file

and this repeats for a few other processes with different
tcontexts (e.g., kernel_t and pump_t). running ps (/bin/ps
and /usr/local/selinux/bin/ps) as a user from a shell doesn't
have this problem, and i don't understand the the difference.
before the changes mentioned above, this shutdown behavior
wasn't happening.

i'd appreciate suggestions as to how to address this behavior
at shutdown.

i'd be happy to share the changed/new policy files when i
have them working (or earlier if anybody so desires).

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
