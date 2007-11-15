Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFGsBq3012751
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 11:54:11 -0500
Received: from palrel13.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAFGsAm4008761
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 16:54:10 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v7 00/13] Labeled networking patches for 2.6.25
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 15 Nov 2007 11:28:38 -0500
Message-ID: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a relatively minor update to the previous, "v6", patchset which the
main difference being an attempt at cleaning up all of the compatibility
code in the SELinux networking hooks.  The patches might look a bit ugly
but I believe the resulting code is much cleaner than in "v6" and should be
easier to understand/maintain in the long run.  I also took the opportunity
to update the SELinux compat_net code to make better use of the socket's
security struct which allows us to do away with the spinlock in
sock_rcv_skb() and cleanup some of that code.

I've updated the git tree last night with these bits backed against Linus'
latest which includes the ebitmap patch needed with "v6".  The git tree can
be found here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

There have also been a few small bugfixes to the static_label branch of
netlabel_tools.  For those of you who are playing with this code I recommend
you update to r50 to get the latest bits.

As usual, if you have any comments/bug-reports/questions let me know.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
