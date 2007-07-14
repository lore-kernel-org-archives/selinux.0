Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6E3HNGj009430
	for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2007 23:17:23 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6E3HMvb017568
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 03:17:22 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070714031651.566974004@hp.com>
References: <20070714030401.888612123@hp.com>
Date: Fri, 13 Jul 2007 23:04:03 -0400
To: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] NetLabel: enable dynamic activation/deactivation of NetLabel/SELinux enforcement
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Create a new NetLabel KAPI interface, netlbl_enabled(), which reports on the
current runtime status of NetLabel based on the existing configuration.  LSMs
that make use of NetLabel, i.e. SELinux, can use this new function to determine
if they should perform NetLabel access checks.  This patch changes the
NetLabel/SELinux glue code such that SELinux only enforces NetLabel related
access checks when netlbl_enabled() returns true.

At present NetLabel is considered to be enabled when there is at least one
labeled protocol configuration present.  The result is that by default NetLabel
is considered to be disabled, however, as soon as an administrator configured
a CIPSO DOI definition NetLabel is enabled and SELinux starts enforcing
NetLabel related access controls - including unlabeled packet controls.

This patch should resolve the issue reported by Michal Piotrowski here:

 * http://lkml.org/lkml/2007/7/12/362

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/netlabel.h           |    6 +++
 net/netlabel/netlabel_cipso_v4.c |    5 +++
 net/netlabel/netlabel_kapi.c     |   21 ++++++++++++
 net/netlabel/netlabel_mgmt.c     |   65 +++++++++++++++++++++++++++++++++++++++
 net/netlabel/netlabel_mgmt.h     |    5 +++
 security/selinux/netlabel.c      |   21 ++++++++++--
 6 files changed, 120 insertions(+), 3 deletions(-)

Index: linux-2.6_netmsg_part_deux/include/net/netlabel.h
===================================================================
--- linux-2.6_netmsg_part_deux.orig/include/net/netlabel.h
+++ linux-2.6_netmsg_part_deux/include/net/netlabel.h
@@ -332,6 +332,7 @@ static inline int netlbl_secattr_catmap_
  */
 
 #ifdef CONFIG_NETLABEL
+int netlbl_enabled(void);
 int netlbl_sock_setattr(struct sock *sk,
 			const struct netlbl_lsm_secattr *secattr);
 int netlbl_sock_getattr(struct sock *sk,
@@ -340,6 +341,11 @@ int netlbl_skbuff_getattr(const struct s
 			  struct netlbl_lsm_secattr *secattr);
 void netlbl_skbuff_err(struct sk_buff *skb, int error);
 #else
+int netlbl_enabled(void)
+{
+	return 0;
+}
+
 static inline int netlbl_sock_setattr(struct sock *sk,
 				     const struct netlbl_lsm_secattr *secattr)
 {
Index: linux-2.6_netmsg_part_deux/net/netlabel/netlabel_cipso_v4.c
===================================================================
--- linux-2.6_netmsg_part_deux.orig/net/netlabel/netlabel_cipso_v4.c
+++ linux-2.6_netmsg_part_deux/net/netlabel/netlabel_cipso_v4.c
@@ -41,6 +41,7 @@
 
 #include "netlabel_user.h"
 #include "netlabel_cipso_v4.h"
+#include "netlabel_mgmt.h"
 
 /* Argument struct for cipso_v4_doi_walk() */
 struct netlbl_cipsov4_doiwalk_arg {
@@ -419,6 +420,8 @@ static int netlbl_cipsov4_add(struct sk_
 		ret_val = netlbl_cipsov4_add_pass(info);
 		break;
 	}
+	if (ret_val == 0)
+		netlbl_mgmt_protocount_inc();
 
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_CIPSOV4_ADD,
 					      &audit_info);
@@ -694,6 +697,8 @@ static int netlbl_cipsov4_remove(struct 
 	ret_val = cipso_v4_doi_remove(doi,
 				      &audit_info,
 				      netlbl_cipsov4_doi_free);
+	if (ret_val == 0)
+		netlbl_mgmt_protocount_dec();
 
 	audit_buf = netlbl_audit_start_common(AUDIT_MAC_CIPSOV4_DEL,
 					      &audit_info);
Index: linux-2.6_netmsg_part_deux/net/netlabel/netlabel_kapi.c
===================================================================
--- linux-2.6_netmsg_part_deux.orig/net/netlabel/netlabel_kapi.c
+++ linux-2.6_netmsg_part_deux/net/netlabel/netlabel_kapi.c
@@ -38,6 +38,7 @@
 #include "netlabel_domainhash.h"
 #include "netlabel_unlabeled.h"
 #include "netlabel_user.h"
+#include "netlabel_mgmt.h"
 
 /*
  * Security Attribute Functions
@@ -245,6 +246,26 @@ int netlbl_secattr_catmap_setrng(struct 
  */
 
 /**
+ * netlbl_enabled - Determine if the NetLabel subsystem is enabled
+ *
+ * Description:
+ * The LSM can use this function to determine if it should use NetLabel
+ * security attributes in it's enforcement mechanism.  Currently, NetLabel is
+ * considered to be enabled when it's configuration contains a valid setup for
+ * at least one labeled protocol (i.e. NetLabel can understand incoming
+ * labeled packets of at least one type); otherwise NetLabel is considered to
+ * be disabled.
+ *
+ */
+int netlbl_enabled(void)
+{
+	/* XXX - at some point we probably want to expose this mechanism to
+	 * the user as well so that admins can toggle NetLabel regardless of
+	 * the configuration */
+	return (netlbl_mgmt_protocount_value() > 0 ? 1 : 0);
+}
+
+/**
  * netlbl_socket_setattr - Label a socket using the correct protocol
  * @sk: the socket to label
  * @secattr: the security attributes
Index: linux-2.6_netmsg_part_deux/net/netlabel/netlabel_mgmt.c
===================================================================
--- linux-2.6_netmsg_part_deux.orig/net/netlabel/netlabel_mgmt.c
+++ linux-2.6_netmsg_part_deux/net/netlabel/netlabel_mgmt.c
@@ -42,6 +42,10 @@
 #include "netlabel_user.h"
 #include "netlabel_mgmt.h"
 
+/* NetLabel configured protocol count */
+static DEFINE_SPINLOCK(netlabel_mgmt_protocount_lock);
+static u32 netlabel_mgmt_protocount = 0;
+
 /* Argument struct for netlbl_domhsh_walk() */
 struct netlbl_domhsh_walk_arg {
 	struct netlink_callback *nl_cb;
@@ -67,6 +71,67 @@ static const struct nla_policy netlbl_mg
 };
 
 /*
+ * NetLabel Misc Managment Functions
+ */
+
+/**
+ * netlbl_mgmt_protocount_inc - Increment the configured labeled protocol count
+ *
+ * Description:
+ * Increment the number of labeled protocol configurations in the current
+ * NetLabel configuration.  Keep track of this for use in determining if
+ * NetLabel label enforcement should be active/enabled or not in the LSM.
+ *
+ */
+void netlbl_mgmt_protocount_inc(void)
+{
+	rcu_read_lock();
+	spin_lock(&netlabel_mgmt_protocount_lock);
+	netlabel_mgmt_protocount++;
+	spin_unlock(&netlabel_mgmt_protocount_lock);
+	rcu_read_unlock();
+}
+
+/**
+ * netlbl_mgmt_protocount_dec - Decrement the configured labeled protocol count
+ *
+ * Description:
+ * Decrement the number of labeled protocol configurations in the current
+ * NetLabel configuration.  Keep track of this for use in determining if
+ * NetLabel label enforcement should be active/enabled or not in the LSM.
+ *
+ */
+void netlbl_mgmt_protocount_dec(void)
+{
+	rcu_read_lock();
+	spin_lock(&netlabel_mgmt_protocount_lock);
+	if (netlabel_mgmt_protocount > 0)
+		netlabel_mgmt_protocount--;
+	spin_unlock(&netlabel_mgmt_protocount_lock);
+	rcu_read_unlock();
+}
+
+/**
+ * netlbl_mgmt_protocount_value - Return the number of configured protocols
+ *
+ * Description:
+ * Return the number of labeled protocols in the current NetLabel
+ * configuration.  This value is useful in  determining if NetLabel label
+ * enforcement should be active/enabled or not in the LSM.
+ *
+ */
+u32 netlbl_mgmt_protocount_value(void)
+{
+	u32 val;
+
+	rcu_read_lock();
+	val = netlabel_mgmt_protocount;
+	rcu_read_unlock();
+
+	return val;
+}
+
+/*
  * NetLabel Command Handlers
  */
 
Index: linux-2.6_netmsg_part_deux/net/netlabel/netlabel_mgmt.h
===================================================================
--- linux-2.6_netmsg_part_deux.orig/net/netlabel/netlabel_mgmt.h
+++ linux-2.6_netmsg_part_deux/net/netlabel/netlabel_mgmt.h
@@ -168,4 +168,9 @@ enum {
 /* NetLabel protocol functions */
 int netlbl_mgmt_genl_init(void);
 
+/* NetLabel misc management functions */
+void netlbl_mgmt_protocount_inc(void);
+void netlbl_mgmt_protocount_dec(void);
+u32 netlbl_mgmt_protocount_value(void);
+
 #endif
Index: linux-2.6_netmsg_part_deux/security/selinux/netlabel.c
===================================================================
--- linux-2.6_netmsg_part_deux.orig/security/selinux/netlabel.c
+++ linux-2.6_netmsg_part_deux/security/selinux/netlabel.c
@@ -155,6 +155,11 @@ int selinux_netlbl_skbuff_getsid(struct 
 	int rc;
 	struct netlbl_lsm_secattr secattr;
 
+	if (!netlbl_enabled()) {
+		*sid = SECSID_NULL;
+		return 0;
+	}
+
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, &secattr);
 	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
@@ -295,12 +300,22 @@ int selinux_netlbl_sock_rcv_skb(struct s
 	int rc;
 	u32 nlbl_sid;
 	u32 perm;
+	struct netlbl_lsm_secattr secattr;
+
+	if (!netlbl_enabled())
+		return 0;
 
-	rc = selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);
+	netlbl_secattr_init(&secattr);
+	rc = netlbl_skbuff_getattr(skb, &secattr);
+	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
+		rc = security_netlbl_secattr_to_sid(&secattr,
+						    SECINITSID_NETMSG,
+						    &nlbl_sid);
+	else
+		nlbl_sid = SECINITSID_UNLABELED;
+	netlbl_secattr_destroy(&secattr);
 	if (rc != 0)
 		return rc;
-	if (nlbl_sid == SECSID_NULL)
-		nlbl_sid = SECINITSID_UNLABELED;
 
 	switch (sksec->sclass) {
 	case SECCLASS_UDP_SOCKET:

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
