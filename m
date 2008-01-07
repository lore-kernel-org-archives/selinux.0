Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07HtBIp029995
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:55:11 -0500
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07HtAlk006745
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:55:10 GMT
Received: from g5t0006.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 4F92AC1DA
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:05 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by g5t0006.atlanta.hp.com (Postfix) with ESMTP id 33B0EC0AB
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:00 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 01/19] NetLabel: Remove unneeded RCU read locks
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:54:50 -0500
Message-ID: <20080107175449.13733.62872.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes some unneeded RCU read locks as we can treat the reads as
"safe" even without RCU.  It also converts the NetLabel configuration refcount
from a spinlock protected u32 into atomic_t to be more consistent with the rest
of the kernel.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 net/netlabel/netlabel_cipso_v4.c  |    5 ++-
 net/netlabel/netlabel_kapi.c      |    3 +-
 net/netlabel/netlabel_mgmt.c      |   63 ++-----------------------------------
 net/netlabel/netlabel_mgmt.h      |    7 ++--
 net/netlabel/netlabel_unlabeled.c |   22 ++-----------
 5 files changed, 15 insertions(+), 85 deletions(-)

diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
index ba0ca8d..becf91a 100644
--- a/net/netlabel/netlabel_cipso_v4.c
+++ b/net/netlabel/netlabel_cipso_v4.c
@@ -38,6 +38,7 @@
 #include <net/genetlink.h>
 #include <net/netlabel.h>
 #include <net/cipso_ipv4.h>
+#include <asm/atomic.h>
 
 #include "netlabel_user.h"
 #include "netlabel_cipso_v4.h"
@@ -421,7 +422,7 @@ static int netlbl_cipsov4_add(struct sk_buff *skb, struct genl_info *info)
 		break;
 	}
 	if (ret_val == 0)
-		netlbl_mgmt_protocount_inc();
+		atomic_inc(&netlabel_mgmt_protocount);
 
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_CIPSOV4_ADD,
 					      &audit_info);
@@ -698,7 +699,7 @@ static int netlbl_cipsov4_remove(struct sk_buff *skb, struct genl_info *info)
 				      &audit_info,
 				      netlbl_cipsov4_doi_free);
 	if (ret_val == 0)
-		netlbl_mgmt_protocount_dec();
+		atomic_dec(&netlabel_mgmt_protocount);
 
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_CIPSOV4_DEL,
 					      &audit_info);
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 4f50949..d3762ea 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -34,6 +34,7 @@
 #include <net/netlabel.h>
 #include <net/cipso_ipv4.h>
 #include <asm/bug.h>
+#include <asm/atomic.h>
 
 #include "netlabel_domainhash.h"
 #include "netlabel_unlabeled.h"
@@ -262,7 +263,7 @@ int netlbl_enabled(void)
 	/* At some point we probably want to expose this mechanism to the user
 	 * as well so that admins can toggle NetLabel regardless of the
 	 * configuration */
-	return (netlbl_mgmt_protocount_value() > 0 ? 1 : 0);
+	return (atomic_read(&netlabel_mgmt_protocount) > 0);
 }
 
 /**
diff --git a/net/netlabel/netlabel_mgmt.c b/net/netlabel/netlabel_mgmt.c
index 9c41464..e2258dc 100644
--- a/net/netlabel/netlabel_mgmt.c
+++ b/net/netlabel/netlabel_mgmt.c
@@ -37,14 +37,14 @@
 #include <net/genetlink.h>
 #include <net/netlabel.h>
 #include <net/cipso_ipv4.h>
+#include <asm/atomic.h>
 
 #include "netlabel_domainhash.h"
 #include "netlabel_user.h"
 #include "netlabel_mgmt.h"
 
-/* NetLabel configured protocol count */
-static DEFINE_SPINLOCK(netlabel_mgmt_protocount_lock);
-static u32 netlabel_mgmt_protocount = 0;
+/* NetLabel configured protocol counter */
+atomic_t netlabel_mgmt_protocount = ATOMIC_INIT(0);
 
 /* Argument struct for netlbl_domhsh_walk() */
 struct netlbl_domhsh_walk_arg {
@@ -71,63 +71,6 @@ static const struct nla_policy netlbl_mgmt_genl_policy[NLBL_MGMT_A_MAX + 1] = {
 };
 
 /*
- * NetLabel Misc Management Functions
- */
-
-/**
- * netlbl_mgmt_protocount_inc - Increment the configured labeled protocol count
- *
- * Description:
- * Increment the number of labeled protocol configurations in the current
- * NetLabel configuration.  Keep track of this for use in determining if
- * NetLabel label enforcement should be active/enabled or not in the LSM.
- *
- */
-void netlbl_mgmt_protocount_inc(void)
-{
-	spin_lock(&netlabel_mgmt_protocount_lock);
-	netlabel_mgmt_protocount++;
-	spin_unlock(&netlabel_mgmt_protocount_lock);
-}
-
-/**
- * netlbl_mgmt_protocount_dec - Decrement the configured labeled protocol count
- *
- * Description:
- * Decrement the number of labeled protocol configurations in the current
- * NetLabel configuration.  Keep track of this for use in determining if
- * NetLabel label enforcement should be active/enabled or not in the LSM.
- *
- */
-void netlbl_mgmt_protocount_dec(void)
-{
-	spin_lock(&netlabel_mgmt_protocount_lock);
-	if (netlabel_mgmt_protocount > 0)
-		netlabel_mgmt_protocount--;
-	spin_unlock(&netlabel_mgmt_protocount_lock);
-}
-
-/**
- * netlbl_mgmt_protocount_value - Return the number of configured protocols
- *
- * Description:
- * Return the number of labeled protocols in the current NetLabel
- * configuration.  This value is useful in  determining if NetLabel label
- * enforcement should be active/enabled or not in the LSM.
- *
- */
-u32 netlbl_mgmt_protocount_value(void)
-{
-	u32 val;
-
-	rcu_read_lock();
-	val = netlabel_mgmt_protocount;
-	rcu_read_unlock();
-
-	return val;
-}
-
-/*
  * NetLabel Command Handlers
  */
 
diff --git a/net/netlabel/netlabel_mgmt.h b/net/netlabel/netlabel_mgmt.h
index ccb2b39..a43bff1 100644
--- a/net/netlabel/netlabel_mgmt.h
+++ b/net/netlabel/netlabel_mgmt.h
@@ -32,6 +32,7 @@
 #define _NETLABEL_MGMT_H
 
 #include <net/netlabel.h>
+#include <asm/atomic.h>
 
 /*
  * The following NetLabel payloads are supported by the management interface.
@@ -168,9 +169,7 @@ enum {
 /* NetLabel protocol functions */
 int netlbl_mgmt_genl_init(void);
 
-/* NetLabel misc management functions */
-void netlbl_mgmt_protocount_inc(void);
-void netlbl_mgmt_protocount_dec(void);
-u32 netlbl_mgmt_protocount_value(void);
+/* NetLabel configured protocol reference counter */
+extern atomic_t netlabel_mgmt_protocount;
 
 #endif
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 3482924..fd53c7a 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -29,7 +29,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/rcupdate.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/socket.h>
@@ -48,7 +47,6 @@
 #include "netlabel_unlabeled.h"
 
 /* Accept unlabeled packets flag */
-static DEFINE_SPINLOCK(netlabel_unlabel_acceptflg_lock);
 static u8 netlabel_unlabel_acceptflg = 0;
 
 /* NetLabel Generic NETLINK CIPSOv4 family */
@@ -84,11 +82,8 @@ static void netlbl_unlabel_acceptflg_set(u8 value,
 	struct audit_buffer *audit_buf;
 	u8 old_val;
 
-	spin_lock(&netlabel_unlabel_acceptflg_lock);
 	old_val = netlabel_unlabel_acceptflg;
 	netlabel_unlabel_acceptflg = value;
-	spin_unlock(&netlabel_unlabel_acceptflg_lock);
-
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_ALLOW,
 					      audit_info);
 	if (audit_buf != NULL) {
@@ -155,11 +150,9 @@ static int netlbl_unlabel_list(struct sk_buff *skb, struct genl_info *info)
 		goto list_failure;
 	}
 
-	rcu_read_lock();
 	ret_val = nla_put_u8(ans_skb,
 			     NLBL_UNLABEL_A_ACPTFLG,
 			     netlabel_unlabel_acceptflg);
-	rcu_read_unlock();
 	if (ret_val != 0)
 		goto list_failure;
 
@@ -245,17 +238,10 @@ int netlbl_unlabel_genl_init(void)
  */
 int netlbl_unlabel_getattr(struct netlbl_lsm_secattr *secattr)
 {
-	int ret_val;
-
-	rcu_read_lock();
-	if (netlabel_unlabel_acceptflg == 1) {
-		netlbl_secattr_init(secattr);
-		ret_val = 0;
-	} else
-		ret_val = -ENOMSG;
-	rcu_read_unlock();
-
-	return ret_val;
+	if (netlabel_unlabel_acceptflg == 0)
+		return -ENOMSG;
+	netlbl_secattr_init(secattr);
+	return 0;
 }
 
 /**


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
