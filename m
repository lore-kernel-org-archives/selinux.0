Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2BEb7Rb025594
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2004 09:37:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2BEai0F014292
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2004 14:36:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i2BEahgZ014289 for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2004 14:36:43 GMT
Subject: Re: client and server identification
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: liliping <llp@ercist.iscas.ac.cn>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <006b01c4071b$040d52f0$3b00a8c0@llp>
References: <006b01c4071b$040d52f0$3b00a8c0@llp>
Content-Type: text/plain
Message-Id: <1079015791.5752.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 11 Mar 2004 09:36:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-10 at 22:43, liliping wrote:
> Look section 5.2.2 of "The Flask Security Architecture: System Support
> for Diverse Security Policies".
>  
> How does selinux  implement "client and server identification" based
> on LSM? Is it necessary?

Prior to the overhaul of SELinux for integration into mainline 2.6, this
was provided by the extended socket call API and labeled networking; see
the historical versions page if you want to see that code.  In the
current code, peer identification is only supported for Unix (local)
domain stream socket connections via getpeercon(3).

In Flask, client identification was more critical since the operating
system services were provided as userspace servers on the microkernel,
so even the filesystem code needed that service to identify its
clients.  In SELinux, the in-kernel services have direct access to the
current process' identification, so the client identification service is
only crucial to userspace object managers such as security-enhanced X
and security-enhanced dbus-daemon.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
