Subject: [PATCH] selinux:  drop remapping of netlink classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 01 Oct 2009 14:48:23 -0400
Message-Id: <1254422903.30591.123.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Drop remapping of netlink classes and bypass of permission checking
based on netlink message type for policy version < 18.  This removes
compatibility code introduced when the original single netlink
security class used for all netlink sockets was split into
finer-grained netlink classes based on netlink protocol and when
permission checking was added based on netlink message type in Linux
2.6.8.  The only known distribution that shipped with SELinux and
policy < 18 was Fedora Core 2, which was EOL'd on 2005-04-11.

Given that the remapping code was never updated to address the
addition of newer netlink classes, that the corresponding userland
support was dropped in 2005, and that the assumptions made by the
remapping code about the fixed ordering among netlink classes in the
policy may be violated in the future due to the dynamic class/perm
discovery support, we should drop this compatibility code now.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---
This patch is relative to the v5 patches for dynamic class/perm discovery and
generating flask headers during kernel build.

 security/selinux/hooks.c       |    6 +-----
 security/selinux/ss/services.c |   25 -------------------------
 2 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a985d0b..a29d661 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -91,7 +91,6 @@
 
 #define NUM_SEL_MNT_OPTS 5
 
-extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 extern struct security_operations *security_ops;
 
@@ -4714,10 +4713,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	if (err)
 		return err;
 
-	if (policydb_loaded_version >= POLICYDB_VERSION_NLCLASS)
-		err = selinux_nlmsg_perm(sk, skb);
-
-	return err;
+	return selinux_nlmsg_perm(sk, skb);
 }
 
 static int selinux_netlink_recv(struct sk_buff *skb, int capability)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e19baa8..f270e37 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -65,7 +65,6 @@
 #include "audit.h"
 
 extern void selnl_notify_policyload(u32 seqno);
-unsigned int policydb_loaded_version;
 
 int selinux_policycap_netpeer;
 int selinux_policycap_openperm;
@@ -617,17 +616,6 @@ static int context_struct_compute_av(struct context *scontext,
 	unsigned int i, j;
 
 	/*
-	 * Remap extended Netlink classes for old policy versions.
-	 * Do this here rather than socket_type_to_security_class()
-	 * in case a newer policy version is loaded, allowing sockets
-	 * to remain in the correct class.
-	 */
-	if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
-		if (tclass >= unmap_class(SECCLASS_NETLINK_ROUTE_SOCKET) &&
-		    tclass <= unmap_class(SECCLASS_NETLINK_DNRT_SOCKET))
-			tclass = unmap_class(SECCLASS_NETLINK_SOCKET);
-
-	/*
 	 * Initialize the access vectors to the default values.
 	 */
 	avd->allowed = 0;
@@ -761,17 +749,6 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 	tclass = unmap_class(orig_tclass);
 
-	/*
-	 * Remap extended Netlink classes for old policy versions.
-	 * Do this here rather than socket_type_to_security_class()
-	 * in case a newer policy version is loaded, allowing sockets
-	 * to remain in the correct class.
-	 */
-	if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
-		if (tclass >= unmap_class(SECCLASS_NETLINK_ROUTE_SOCKET) &&
-		    tclass <= unmap_class(SECCLASS_NETLINK_DNRT_SOCKET))
-			tclass = unmap_class(SECCLASS_NETLINK_SOCKET);
-
 	if (!tclass || tclass > policydb.p_classes.nprim) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n",
 			__func__, tclass);
@@ -1766,7 +1743,6 @@ int security_load_policy(void *data, size_t len)
 			return -EINVAL;
 		}
 		security_load_policycaps();
-		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
 		selinux_complete_init();
@@ -1829,7 +1805,6 @@ int security_load_policy(void *data, size_t len)
 	current_mapping = map;
 	current_mapping_size = map_size;
 	seqno = ++latest_granting;
-	policydb_loaded_version = policydb.policyvers;
 	write_unlock_irq(&policy_rwlock);
 
 	/* Free the old policydb and SID table. */
-- 
1.6.2.5


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
