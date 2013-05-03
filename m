Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r43D7KkM000821
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2013 09:07:20 -0400
From: Chris PeBenito <cpebenito@tresys.com>
To: <selinux@tycho.nsa.gov>
CC: Chris PeBenito <cpebenito@tresys.com>
Subject: [PATCH 1/1] Add SELinux policy capability for always checking packet and peer classes.
Date: Fri, 3 May 2013 09:05:39 -0400
Message-ID: <1367586339-12509-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the packet class in SELinux is not checked if there are no
SECMARK rules in the security or mangle netfilter tables.  Some systems
prefer that packets are always checked, for example, to protect the system
should the netfilter rules fail to load or if the nefilter rules
were maliciously flushed.

Add the always_check_network policy capability which, when enabled, treats
SECMARK as enabled, even if there are no netfilter SECMARK rules and
treats peer labeling as enabled, even if there is no Netlabel or
labeled IPSEC configuration.

Includes definition of "redhat1" SELinux policy capability, which
exists in the SELinux userpace library, to keep ordering correct.

The SELinux userpace portion of this was merged last year, but this kernel
change fell on the floor.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 security/selinux/hooks.c            | 26 +++++++++++++++++++++-----
 security/selinux/include/security.h |  3 +++
 security/selinux/selinuxfs.c        |  4 +++-
 security/selinux/ss/services.c      |  3 +++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5c6f2cd..31df7ab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -138,12 +138,28 @@ static struct kmem_cache *sel_inode_cache;
  * This function checks the SECMARK reference counter to see if any SECMARK
  * targets are currently configured, if the reference counter is greater than
  * zero SECMARK is considered to be enabled.  Returns true (1) if SECMARK is
- * enabled, false (0) if SECMARK is disabled.
+ * enabled, false (0) if SECMARK is disabled.  If the always_check_network
+ * policy capability is enabled, SECMARK is always considered enabled.
  *
  */
 static int selinux_secmark_enabled(void)
 {
-	return (atomic_read(&selinux_secmark_refcount) > 0);
+	return (selinux_policycap_alwaysnetwork || atomic_read(&selinux_secmark_refcount));
+}
+
+/**
+ * selinux_peerlbl_enabled - Check to see if peer labeling is currently enabled
+ *
+ * Description:
+ * This function checks if NetLabel or labeled IPSEC is enabled.  Returns true
+ * (1) if any are enabled or false (0) if neither are enabled.  If the
+ * always_check_network policy capability is enabled, peer labeling
+ * is always considered enabled.
+ *
+ */
+static int selinux_peerlbl_enabled(void)
+{
+	return (selinux_policycap_alwaysnetwork || netlbl_enabled() || selinux_xfrm_enabled());
 }
 
 /*
@@ -4177,7 +4193,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		return selinux_sock_rcv_skb_compat(sk, skb, family);
 
 	secmark_active = selinux_secmark_enabled();
-	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
+	peerlbl_active = selinux_peerlbl_enabled();
 	if (!secmark_active && !peerlbl_active)
 		return 0;
 
@@ -4559,7 +4575,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb, int ifindex,
 
 	secmark_active = selinux_secmark_enabled();
 	netlbl_active = netlbl_enabled();
-	peerlbl_active = netlbl_active || selinux_xfrm_enabled();
+	peerlbl_active = selinux_peerlbl_enabled();
 	if (!secmark_active && !peerlbl_active)
 		return NF_ACCEPT;
 
@@ -4711,7 +4727,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 		return NF_ACCEPT;
 #endif
 	secmark_active = selinux_secmark_enabled();
-	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
+	peerlbl_active = selinux_peerlbl_enabled();
 	if (!secmark_active && !peerlbl_active)
 		return NF_ACCEPT;
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 6d38851..376a1d7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -68,12 +68,15 @@ extern int selinux_enabled;
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_REDHAT1,
+	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
 
 extern int selinux_policycap_netpeer;
 extern int selinux_policycap_openperm;
+extern int selinux_policycap_alwaysnetwork;
 
 /*
  * type_datum properties
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ff42773..5122aff 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -44,7 +44,9 @@
 /* Policy capability filenames */
 static char *policycap_names[] = {
 	"network_peer_controls",
-	"open_perms"
+	"open_perms",
+	"redhat1",
+	"always_check_network"
 };
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b4feecc..4cee8a7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -72,6 +72,7 @@
 
 int selinux_policycap_netpeer;
 int selinux_policycap_openperm;
+int selinux_policycap_alwaysnetwork;
 
 static DEFINE_RWLOCK(policy_rwlock);
 
@@ -1812,6 +1813,8 @@ static void security_load_policycaps(void)
 						  POLICYDB_CAPABILITY_NETPEER);
 	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_OPENPERM);
+	selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
+						  POLICYDB_CAPABILITY_ALWAYSNETWORK);
 }
 
 static int security_preserve_bools(struct policydb *p);
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
