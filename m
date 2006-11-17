Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhPJS013931
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:25 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfiUg029638
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:44 GMT
Message-Id: <20061117224332.533289000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:45 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 03/13] NetLabel: change netlbl_secattr_init() to return void
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

The netlbl_secattr_init() function would always return 0 making it pointless
to have a return value.  This patch changes the function to return void.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/netlabel.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: net-2.6.20_netlabel-base-work/include/net/netlabel.h
===================================================================
--- net-2.6.20_netlabel-base-work.orig/include/net/netlabel.h
+++ net-2.6.20_netlabel-base-work/include/net/netlabel.h
@@ -169,14 +169,12 @@ static inline void netlbl_secattr_cache_
  * @secattr: the struct to initialize
  *
  * Description:
- * Initialize an already allocated netlbl_lsm_secattr struct.  Returns zero on
- * success, negative values on error.
+ * Initialize an already allocated netlbl_lsm_secattr struct.
  *
  */
-static inline int netlbl_secattr_init(struct netlbl_lsm_secattr *secattr)
+static inline void netlbl_secattr_init(struct netlbl_lsm_secattr *secattr)
 {
 	memset(secattr, 0, sizeof(*secattr));
-	return 0;
 }
 
 /**

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
