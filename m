Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38DMIRb017420
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 09:22:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i38DJxUZ012614
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:20:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i38DJxmT012611
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:19:59 GMT
Subject: Policy backward compatibility
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>, selinux-dev@tresys.com
Content-Type: text/plain
Message-Id: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 09:21:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I wanted to raise the issue of policy backward compatibility for general
discussion, as this has been coming up in private discussions recently
as new enhancements have been made to SELinux.  When Tresys implemented
the conditional policy extensions (policy version 16), they included
compatibility code in the kernel and checkpolicy so that the kernel
would continue to accept the older policy version and so that
checkpolicy could continue to generate the older policy version.  James
Morris generalized this compatibility support and extended it when he
implemented support for ipv6 node labeling (policy version 17), so that
the kernel and checkpolicy could handle versions 17-15.  

There are at least three other possible enhancements that I know of that
will require further changes to the binary policy format (split netlink
classes, automatic user identity transitions, conditional support for
RBAC rules), plus we need to purge the initial SID and access vector
definitions at some point of obsolete symbols so that they are
consistent with the current implementation, which will likely require
another policy version change as existing initial SID and permission
values will be affected.

The concern is that the backward compatibility code is becoming
increasingly cumbersome, and providing safe behavior for compatibility
isn't always straightforward.  This kind of compatibility code also
seems inconsistent with typical kernel practice.  James has proposed
dropping the backward compatibility support, and requiring that every
installed kernel have a suitable binary policy installed, possibly
encoding the associated kernel release (e.g. output of uname -r) in the
binary policy pathname (and possibly doing likewise for the checkpolicy
program?).  

Thoughts?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
