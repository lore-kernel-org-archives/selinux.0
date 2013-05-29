Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4THapnU001355
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2013 13:36:52 -0400
Subject: [PATCH v3 0/2] Fix the SELinux dynamic network access controls
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: omoris@redhat.com, pwouters@redhat.com
Date: Wed, 29 May 2013 13:36:18 -0400
Message-ID: <20130529173336.31888.29695.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Take #3 ... two changes here: the first is a simple reordering of the
two patches and the second is stripping the SELinux patch (2/2 in this
patchset) of everything but the bare bones changes needed to fix the
problem in the 3.10-rcX tree.

Enjoy.

---

Paul Moore (2):
      xfrm: force a garbage collection after deleting a policy
      selinux: fix the labeled xfrm/IPsec reference count handling

 include/net/xfrm.h      |    5 +++++
 net/key/af_key.c        |    4 ++++
 net/xfrm/xfrm_policy.c  |    3 ++-
 net/xfrm/xfrm_user.c    |    2 ++
 security/selinux/xfrm.c |   34 ++++++++++++++--------------------
 5 files changed, 27 insertions(+), 21 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
