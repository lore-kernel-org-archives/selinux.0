Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBGKpDIi027625
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 15:51:13 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBGKnUNH008571
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 20:49:30 GMT
Subject: Re: Tomcat policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nick-lists@austin.rr.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103224127.32688.49.camel@hawaii.grays-systems.com>
References: <1103224127.32688.49.camel@hawaii.grays-systems.com>
Content-Type: text/plain
Message-Id: <1103229973.1463.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Dec 2004 15:46:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-16 at 14:08, Nick Gray wrote:
> So why can't I use tomcat_t to label directories?

Because you have defined it as a domain, not a file type.  Domains are
for processes, and are also applied to the /proc/pid entries of that
process.  You aren't supposed to use them for other files, and the
filesystem associate permission check enforces the restriction.

You do need to label the entrypoint program for the daemon with
tomcat_exec_t.

> I think I understand how to protect the daemon from the system, how do I
> protect the system from the daemon.

Under targeted policy, the "system" (i.e. unconfined processes) can do
whatever it wants to the daemon.  By defining a domain for tomcat, you
are merely controlling what it can do to the system, and isolating it
from other confined domains.  The daemon (if you have set it up properly
to run in the tomcat_t domain) can only do what you allow tomcat_t to do
in the policy, nothing else.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
