Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA14110
	for <selinux@tycho.nsa.gov>; Wed, 11 Dec 2002 04:18:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBB9IqI06875
	for <selinux@tycho.nsa.gov>; Wed, 11 Dec 2002 09:18:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBB9Iof06871 for <selinux@tycho.nsa.gov>; Wed, 11 Dec 2002 09:18:51 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux (in) Clusters
Date: Wed, 11 Dec 2002 10:18:30 +0100
References: <200212110059.AAA14517@jazzswing.ncsc.mil>
In-Reply-To: <200212110059.AAA14517@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212111018.30892.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Dec 2002 02:01, Subba Rao wrote:
> I haven't decided which cluster to build yet (HPC or HA cluster). Has
> anyone deployed SELinux in a Cluster environment? My main question would be
> would the MPI libraries in a cluster work on SELinux?

For a typical HA cluster you just have two servers, one is running the service 
and the other is in standby mode.

For this the SE Linux policy would be quite simple, you just need to write 
policy for the HA program that allows it to do whatever network/serial 
operations are necessary for the "heartbeat" and then have it transition to 
initrc_t whenever it executes etc_t type files (so that /etc/init.d/ scripts 
are run in the right context for daemon start and stop).

Putting SE Linux on such a cluster would only take about an hour longer than 
doing it without SE Linux if you know how to use SE Linux (and that's a 
conservative estimate - I'm sure I could do the SE part in much less than an 
hour).

If you have an application that's cluster aware and does it's own network 
communication then it's even easier, it may not be necessary to do anything 
special at all.


Mosix however is a totally different issue.  Mosix and similar process 
migration technologies would require matching (if not identical) policies on 
all machines, mechanisms for migrating security context when migrating 
context, and some modifications to allow permission checking on files that 
were opened before process migration.

Pete and Steve, any comments on what it would take to get SE OpenMosix going?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
