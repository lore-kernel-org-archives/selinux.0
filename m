Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2UIngRb014631
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 13:49:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2UInfOl027019
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 18:49:41 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i2UInekH027012 for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 18:49:40 GMT
Date: Tue, 30 Mar 2004 13:49:37 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Andreas Schuldei <andreas@schuldei.org>
cc: selinux@tycho.nsa.gov
Subject: Re: IPv6 support available
In-Reply-To: <20040330180008.GD3867@lukas.schuldei.com>
Message-ID: <Xine.LNX.4.44.0403301334400.21570-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 30 Mar 2004, Andreas Schuldei wrote:

> this is what i have waited for for some time. could you give a
> short overview of what features there are, now?

There are no new permissions or classes, IPv6 is managed along with IPv4 
(e.g. a TCP socket refers to both protocols).

You can now provide IPv6 nodes with contexts, e.g.

nodecon ::1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff system_u:object_r:node_lo_t

In standard policy, the IPv4 loopback address has the same type, so they
can be treated equivalently by security policy.  You can, of course,
specify different security contexts for IPv4 and IPv6 nodes if you want
e.g. system_u:object_r:node_ipv6_lo_t

Logging has been extended to handle IPv6 addresses.

The checkpolicy tool now has generic policy version compatibility.  It can
read and write any version from 15 to 17, and the kernel will also be able
to load any of these policy versions.  The checkpoliy '-c' parameter takes 
a policy version argument to be used, and it recognises IPv6 addresses in 
debug mode.



- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
