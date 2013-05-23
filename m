Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4NJ7ZJc020095
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2013 15:07:35 -0400
Subject: [RFC PATCH 0/2] Fix the SELinux dynamic network access controls
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: omoris@redhat.com, pwouters@redhat.com
Date: Thu, 23 May 2013 15:07:32 -0400
Message-ID: <20130523185659.19212.56853.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For some time now SELinux has had dynamic network access controls for
labeled networking: when labeled networking was configured, the
controls were active, when labeled networking wasn't configured the
controls were disabled.  The dynamic controls simplified security
policy and improved performance in the common case; life was good.

Unfortunately, there is a bit of a problem in that the labeled IPsec
portion of the dynamic network access controls is broken such that
it acts as a one way street.  Once you load a labeled IPsec
configuration into the kernel the SELinux network access controls
are enabled and stay enabled, even after the configuration is
removed.  Resolving this involves two fixes:

#1 - Fixing the SELinux labeled IPsec configuration detection so that
we track things on alloc/free and not alloc/delete. (patch 1/2)

#2 - Force a IPsec garbage collection when we delete a IPsec policy
so we don't have IPsec state lying unused and dormant for extended
periods of time. (patch 2/2)

I'm posting these patches as an RFC because I'm not 100% certain that
the core XFRM patches are "The Right Thing" so I'd like some
commentary from the netdev folks on that (patch 2/2).  I'm confident
that The SELinux patch is "The Right Thing", but as usual, comments
are welcome if you see something.  However, if everybody is happy
with both patches then merge away!

-Paul

---

Paul Moore (2):
      selinux: fix the labeled xfrm/IPsec reference count handling
      xfrm: force a garbage collection after deleting a policy


 include/linux/security.h        |   26 ++-
 include/net/xfrm.h              |    6 +
 net/key/af_key.c                |    4 
 net/xfrm/xfrm_policy.c          |    3 
 net/xfrm/xfrm_user.c            |    2 
 security/capability.c           |   15 +-
 security/security.c             |   13 -
 security/selinux/hooks.c        |    5 -
 security/selinux/include/xfrm.h |    8 +
 security/selinux/xfrm.c         |  384 ++++++++++++++++++---------------------
 10 files changed, 231 insertions(+), 235 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
