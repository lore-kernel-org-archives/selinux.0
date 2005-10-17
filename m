To: SELinux@tycho.nsa.gov
Subject: logging question
From: Eric Moore <eemoore@fyndo.com>
Date: Mon, 17 Oct 2005 12:26:29 -0400
Message-ID: <m33bn0az4a.fsf@eemoore.bcluster.njit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have a debian unstable machine I'm trying to get selinux to work on.
I've gotten a policy to build, installed the userland tools, loaded
it, etc.  It's working, because I can swithc into enforcing mode, and
things break (presumably due to my havng screwed up the policy).  But
I never sdeem to get any logging messages of what was denied and why
(In or out of enforcing mode).  What's the best way for me to get
the kernel to log the appropriate messages somewhere?

Thanks.

-- 
Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
