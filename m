From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070301193537.997427466@hp.com>
Date: Thu, 01 Mar 2007 14:35:22 -0500
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Subject: [RFC v2] SELinux: move security_skb_extlbl_sid() out of the security server
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As suggested, move the security_skb_extlbl_sid() function out of the security
server and into the SELinux hooks file.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c            |   36 +++++++++++++++++++++++++++++++-----
 security/selinux/include/security.h |    3 ---
 security/selinux/ss/services.c      |   27 ---------------------------
 3 files changed, 31 insertions(+), 35 deletions(-)

Index: net-2.6_future_2/security/selinux/hooks.c
===================================================================
--- net-2.6_future_2.orig/security/selinux/hooks.c
+++ net-2.6_future_2/security/selinux/hooks.c
@@ -3123,6 +3123,34 @@ static int selinux_parse_skb(struct sk_b
 	return ret;
 }
 
+/**
+ * selinux_skb_extlbl_sid - Determine the external label of a packet
+ * @skb: the packet
+ * @base_sid: the SELinux SID to use as a context for MLS only external labels
+ * @sid: the packet's SID
+ *
+ * Description:
+ * Check the various different forms of external packet labeling and determine
+ * the external SID for the packet.
+ *
+ */
+static void selinux_skb_extlbl_sid(struct sk_buff *skb,
+				   u32 base_sid,
+				   u32 *sid)
+{
+	u32 xfrm_sid;
+	u32 nlbl_sid;
+
+	selinux_skb_xfrm_sid(skb, &xfrm_sid);
+	if (selinux_netlbl_skbuff_getsid(skb,
+					 (xfrm_sid == SECSID_NULL ?
+					  base_sid : xfrm_sid),
+					 &nlbl_sid) != 0)
+		nlbl_sid = SECSID_NULL;
+
+	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
+}
+
 /* socket security operations */
 static int socket_has_perm(struct task_struct *task, struct socket *sock,
 			   u32 perms)
@@ -3664,9 +3692,7 @@ static int selinux_socket_getpeersec_dgr
 	if (sock && sock->sk->sk_family == PF_UNIX)
 		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
 	else if (skb)
-		security_skb_extlbl_sid(skb,
-					SECINITSID_UNLABELED,
-					&peer_secid);
+		selinux_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &peer_secid);
 
 	if (peer_secid == SECSID_NULL)
 		err = -EINVAL;
@@ -3727,7 +3753,7 @@ static int selinux_inet_conn_request(str
 	u32 newsid;
 	u32 peersid;
 
-	security_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &peersid);
+	selinux_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &peersid);
 	if (peersid == SECSID_NULL) {
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
@@ -3765,7 +3791,7 @@ static void selinux_inet_conn_establishe
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 
-	security_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &sksec->peer_sid);
+	selinux_skb_extlbl_sid(skb, SECINITSID_UNLABELED, &sksec->peer_sid);
 }
 
 static void selinux_req_classify_flow(const struct request_sock *req,
Index: net-2.6_future_2/security/selinux/include/security.h
===================================================================
--- net-2.6_future_2.orig/security/selinux/include/security.h
+++ net-2.6_future_2/security/selinux/include/security.h
@@ -34,7 +34,6 @@
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
 #endif
 
-struct sk_buff;
 struct netlbl_lsm_secattr;
 
 extern int selinux_enabled;
@@ -83,8 +82,6 @@ int security_netif_sid(char *name, u32 *
 int security_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
 
-void security_skb_extlbl_sid(struct sk_buff *skb, u32 base_sid, u32 *sid);
-
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass);
 
Index: net-2.6_future_2/security/selinux/ss/services.c
===================================================================
--- net-2.6_future_2.orig/security/selinux/ss/services.c
+++ net-2.6_future_2/security/selinux/ss/services.c
@@ -39,7 +39,6 @@
 #include <linux/sched.h>
 #include <linux/audit.h>
 #include <linux/mutex.h>
-#include <net/sock.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -2198,32 +2197,6 @@ void selinux_audit_set_callback(int (*ca
 	aurule_callback = callback;
 }
 
-/**
- * security_skb_extlbl_sid - Determine the external label of a packet
- * @skb: the packet
- * @base_sid: the SELinux SID to use as a context for MLS only external labels
- * @sid: the packet's SID
- *
- * Description:
- * Check the various different forms of external packet labeling and determine
- * the external SID for the packet.
- *
- */
-void security_skb_extlbl_sid(struct sk_buff *skb, u32 base_sid, u32 *sid)
-{
-	u32 xfrm_sid;
-	u32 nlbl_sid;
-
-	selinux_skb_xfrm_sid(skb, &xfrm_sid);
-	if (selinux_netlbl_skbuff_getsid(skb,
-					 (xfrm_sid == SECSID_NULL ?
-					  base_sid : xfrm_sid),
-					 &nlbl_sid) != 0)
-		nlbl_sid = SECSID_NULL;
-
-	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
-}
-
 #ifdef CONFIG_NETLABEL
 /*
  * NetLabel cache structure

--
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
