Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCJhLRb010648
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 14:43:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCJgYYV013068
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 19:42:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBCJgYBN013064
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 19:42:34 GMT
Subject: Re: newrules script
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Mark Shakespeare <mshakes@llnl.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5.2.1.1.2.20031212111623.00a9ab70@popcorn.llnl.gov>
References: <5.2.1.1.2.20031212111623.00a9ab70@popcorn.llnl.gov>
Content-Type: text/plain
Message-Id: <1071258191.14716.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Dec 2003 14:43:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-12 at 14:23, Mark Shakespeare wrote:
> The script " newrules.pl " is no longer bundled in the current
> releases of SE-Linux.  Is there a reason for this?
> 
> I have 2.6.0-test11 running on Fedora Core.
> Was hoping to run " newrules.pl " to sort out some misc avc errors....

Based on discussion on the list, it was renamed to 'audit2allow' and
moved into policycoreutils.  Should be installed in /usr/bin.  A patch
by Yuichi Nakamura was also merged into it to add a -l option to only
use avc messages after the last load_policy.

Naturally, you should carefully review any rules generated in this
manner before adding them to your policy, as noted in the selinux-doc
README.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
