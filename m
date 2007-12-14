Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBELt020028219
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 16:55:00 -0500
Received: from QMTA06.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBELsij8019496
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 21:54:57 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v8 00/18] Update to the labeled networking patches for
	2.6.25
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 14 Dec 2007 16:49:47 -0500
Message-ID: <20071214213548.10069.59135.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Another update to the labeled networking patchset, the lblnet-2.6_testing
git tree on infradead.org has been updated too for those of you who prefer to
get the changes that way.

With this version of the patchset I'm now considering the patches "feature
complete" for 2.6.25.  However, the push to get the features done in time has
meant that my testing has been, and continues to be, pretty light so please
don't consider this patch ready for inclusion anywhere yet.  I'm posting these
changes for people to review and test.

Since v7 there have been quite a few changes, although they have all been in
support of the big change - packet ingress/egress controls (formerly know as
"flow controls" to some SELinux folks).  This should allow SELinux (and other
LSMs) to provide packet level access control to all IP traffic entering and
leaving the system.  The two other big changes, the shift from skb->dev to
skb->iif and the SELinux network node caching mechanism, are in support of
these new controls although other aspects of the SELinux code benefit as
well (check out the patches).

Comments are always welcome and people willing to help test are even more
welcome.  I'll get some SELinux policy patches out next week to help enable
the new functionality and if everything is still looking okay I'll ping Andew
Morton to see if I can get the latest version of these patches included in the
-mm tree (previous versions are already included).

Thanks.

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
