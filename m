Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA03727
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 07:54:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id MAA16809
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 12:52:36 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id MAA16805
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 12:52:35 GMT
Date: Tue, 16 Jan 2001 07:53:14 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Jan Petranek <jan@petranek.de>
cc: selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root 
In-Reply-To: <01011516091701.13938@linux16>
Message-ID: <Pine.SOL.3.95.1010116073832.3967B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Mon, 15 Jan 2001, Jan Petranek wrote:

> did You consider the possibility of an malicious root attacks? In most
> Linuxdistributions, the priviliged user can read & manipulate all of the user's
> data. 

In SELinux, the root user has no special privileges with respect to the
mandatory access controls.  Neither the Unix superuser identity nor the
Linux capabilities override the mandatory access controls.  Hence,
a root process can be confined like any other process.  Furthermore,
in contrast to typical multi-level secure systems, there are no
"trusted subjects" in SELinux that are authorized to violate the
mandatory access control policy.  As I explained in the thread about
how SELinux compares with the Linux-Privs project, there is no
need for a mechanism to override the SELinux mandatory access
controls because the security policy can be configured as
needed to support fine-grained privileges for processes wtith
respect to the mandatory controls.

System processes and setuid programs can be placed into very
fine-grained protection domains in SELinux that are granted
only those privileges that they truly require.  The example
security policy configuration provides a number of examples
of how to do this for various system daemons and programs.
The example security policy configuration also shows how to
ensure that the legitimate administrator domain can be protected
from various threats, including the threat of executing
untrustworthy code.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
