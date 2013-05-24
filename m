Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4OIGHaN026695
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2013 14:16:18 -0400
Subject: [PATCH v2 0/2] Fix the SELinux dynamic network access controls
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: omoris@redhat.com, pwouters@redhat.com
Date: Fri, 24 May 2013 14:16:16 -0400
Message-ID: <20130524181430.24022.15997.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A bump to v2 to incorporate Sergei's minor comment on the previous
patchset.  I've also gone ahead and dropped the "RFC" from the
patchset as I didn't see any significant comments/concerns from
anyone.

---

Paul Moore (2):
      selinux: fix the labeled xfrm/IPsec reference count handling
      xfrm: force a garbage collection after deleting a policy


 include/linux/security.h        |   26 ++-
 include/net/xfrm.h              |    5 +
 net/key/af_key.c                |    4 
 net/xfrm/xfrm_policy.c          |    3 
 net/xfrm/xfrm_user.c            |    2 
 security/capability.c           |   15 +-
 security/security.c             |   13 -
 security/selinux/hooks.c        |    5 -
 security/selinux/include/xfrm.h |    8 +
 security/selinux/xfrm.c         |  384 ++++++++++++++++++---------------------
 10 files changed, 230 insertions(+), 235 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
