Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhOlT013919
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:24 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfgUg029625
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:42 GMT
Message-Id: <20061117224331.877832000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:44 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 02/13] NetLabel: convert the unlabeled accept flag to use RCU
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

Currently the NetLabel unlabeled packet accept flag is an atomic type and it
is checked for every non-NetLabel packet which comes into the system but rarely
ever changed.  This patch changes this flag to a normal integer and protects it
with RCU locking.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/netlabel/netlabel_unlabeled.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

Index: net-2.6.20_netlabel-base-work/net/netlabel/netlabel_unlabeled.c
===================================================================
--- net-2.6.20_netlabel-base-work.orig/net/netlabel/netlabel_unlabeled.c
+++ net-2.6.20_netlabel-base-work/net/netlabel/netlabel_unlabeled.c
@@ -47,7 +47,8 @@
 #include "netlabel_unlabeled.h"
 
 /* Accept unlabeled packets flag */
-static atomic_t netlabel_unlabel_accept_flg = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(netlabel_unlabel_acceptflg_lock);
+static u8 netlabel_unlabel_acceptflg = 0;
 
 /* NetLabel Generic NETLINK CIPSOv4 family */
 static struct genl_family netlbl_unlabel_gnl_family = {
@@ -82,8 +83,12 @@ static void netlbl_unlabel_acceptflg_set
 	struct audit_buffer *audit_buf;
 	u8 old_val;
 
-	old_val = atomic_read(&netlabel_unlabel_accept_flg);
-	atomic_set(&netlabel_unlabel_accept_flg, value);
+	rcu_read_lock();
+	old_val = netlabel_unlabel_acceptflg;
+	spin_lock(&netlabel_unlabel_acceptflg_lock);
+	netlabel_unlabel_acceptflg = value;
+	spin_unlock(&netlabel_unlabel_acceptflg_lock);
+	rcu_read_unlock();
 
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_ALLOW,
 					      audit_info);
@@ -148,9 +153,11 @@ static int netlbl_unlabel_list(struct sk
 		goto list_failure;
 	}
 
+	rcu_read_lock();
 	ret_val = nla_put_u8(ans_skb,
 			     NLBL_UNLABEL_A_ACPTFLG,
-			     atomic_read(&netlabel_unlabel_accept_flg));
+			     netlabel_unlabel_acceptflg);
+	rcu_read_unlock();
 	if (ret_val != 0)
 		goto list_failure;
 
@@ -236,10 +243,17 @@ int netlbl_unlabel_genl_init(void)
  */
 int netlbl_unlabel_getattr(struct netlbl_lsm_secattr *secattr)
 {
-	if (atomic_read(&netlabel_unlabel_accept_flg) == 1)
-		return netlbl_secattr_init(secattr);
+	int ret_val;
+
+	rcu_read_lock();
+	if (netlabel_unlabel_acceptflg == 1) {
+		netlbl_secattr_init(secattr);
+		ret_val = 0;
+	} else
+		ret_val = -ENOMSG;
+	rcu_read_unlock();
 
-	return -ENOMSG;
+	return ret_val;
 }
 
 /**

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
