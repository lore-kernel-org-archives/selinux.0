Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhMWO013872
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:22 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfgUg029627
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:42 GMT
Message-Id: <20061117224331.250734000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:43 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 01/13] NetLabel: use gfp_t instead of int where it makes sense
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

There were a few places in the NetLabel code where the int type was being used
instead of the gfp_t type, this patch corrects this mistake.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/netlabel.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: net-2.6.20_netlabel-base-work/include/net/netlabel.h
===================================================================
--- net-2.6.20_netlabel-base-work.orig/include/net/netlabel.h
+++ net-2.6.20_netlabel-base-work/include/net/netlabel.h
@@ -205,7 +205,7 @@ static inline void netlbl_secattr_destro
  * pointer on success, or NULL on failure.
  *
  */
-static inline struct netlbl_lsm_secattr *netlbl_secattr_alloc(int flags)
+static inline struct netlbl_lsm_secattr *netlbl_secattr_alloc(gfp_t flags)
 {
 	return kzalloc(sizeof(struct netlbl_lsm_secattr), flags);
 }

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
