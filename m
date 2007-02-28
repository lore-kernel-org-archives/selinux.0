From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070228202036.749692580@hp.com>
References: <20070228201419.115784233@hp.com>
Date: Wed, 28 Feb 2007 15:14:23 -0500
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [RFC 4/4] SELinux: rename selinux_netlabel.h to netlabel.h
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the beginning I named the file selinux_netlabel.h to avoid potential
namespace colisions.  However, over time I have realized that there are several
other similar cases of multiple header files with the same name so I'm changing
the name to something which better fits with existing naming conventions.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 security/selinux/hooks.c                    |    2 
 security/selinux/include/netlabel.h         |  121 ++++++++++++++++++++++++++++
 security/selinux/include/selinux_netlabel.h |  121 ----------------------------
 security/selinux/ss/services.c              |    2 
 4 files changed, 123 insertions(+), 123 deletions(-)

Index: net-2.6_future/security/selinux/hooks.c
===================================================================
--- net-2.6_future.orig/security/selinux/hooks.c
+++ net-2.6_future/security/selinux/hooks.c
@@ -77,7 +77,7 @@
 #include "objsec.h"
 #include "netif.h"
 #include "xfrm.h"
-#include "selinux_netlabel.h"
+#include "netlabel.h"
 
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
Index: net-2.6_future/security/selinux/include/netlabel.h
===================================================================
--- /dev/null
+++ net-2.6_future/security/selinux/include/netlabel.h
@@ -0,0 +1,121 @@
+/*
+ * SELinux interface to the NetLabel subsystem
+ *
+ * Author : Paul Moore <paul.moore@hp.com>
+ *
+ */
+
+/*
+ * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef _SELINUX_NETLABEL_H_
+#define _SELINUX_NETLABEL_H_
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/net.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+
+#include "avc.h"
+#include "objsec.h"
+
+#ifdef CONFIG_NETLABEL
+void selinux_netlbl_cache_invalidate(void);
+
+void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec,
+				      int family);
+void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
+				     int family);
+void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
+				      struct sk_security_struct *newssec);
+
+int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u32 base_sid, u32 *sid);
+
+void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock);
+int selinux_netlbl_socket_post_create(struct socket *sock);
+int selinux_netlbl_inode_permission(struct inode *inode, int mask);
+int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
+				struct sk_buff *skb,
+				struct avc_audit_data *ad);
+int selinux_netlbl_socket_setsockopt(struct socket *sock,
+				     int level,
+				     int optname);
+#else
+static inline void selinux_netlbl_cache_invalidate(void)
+{
+	return;
+}
+
+static inline void selinux_netlbl_sk_security_reset(
+	                                       struct sk_security_struct *ssec,
+					       int family)
+{
+	return;
+}
+static inline void selinux_netlbl_sk_security_init(
+	                                       struct sk_security_struct *ssec,
+					       int family)
+{
+	return;
+}
+static inline void selinux_netlbl_sk_security_clone(
+	                                    struct sk_security_struct *ssec,
+					    struct sk_security_struct *newssec)
+{
+	return;
+}
+
+static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
+					       u32 base_sid,
+					       u32 *sid)
+{
+	*sid = SECSID_NULL;
+	return 0;
+}
+
+static inline void selinux_netlbl_sock_graft(struct sock *sk,
+					     struct socket *sock)
+{
+	return;
+}
+static inline int selinux_netlbl_socket_post_create(struct socket *sock)
+{
+	return 0;
+}
+static inline int selinux_netlbl_inode_permission(struct inode *inode,
+						  int mask)
+{
+	return 0;
+}
+static inline int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
+					      struct sk_buff *skb,
+					      struct avc_audit_data *ad)
+{
+	return 0;
+}
+static inline int selinux_netlbl_socket_setsockopt(struct socket *sock,
+						   int level,
+						   int optname)
+{
+	return 0;
+}
+#endif /* CONFIG_NETLABEL */
+
+#endif
Index: net-2.6_future/security/selinux/include/selinux_netlabel.h
===================================================================
--- net-2.6_future.orig/security/selinux/include/selinux_netlabel.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * SELinux interface to the NetLabel subsystem
- *
- * Author : Paul Moore <paul.moore@hp.com>
- *
- */
-
-/*
- * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#ifndef _SELINUX_NETLABEL_H_
-#define _SELINUX_NETLABEL_H_
-
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/net.h>
-#include <linux/skbuff.h>
-#include <net/sock.h>
-
-#include "avc.h"
-#include "objsec.h"
-
-#ifdef CONFIG_NETLABEL
-void selinux_netlbl_cache_invalidate(void);
-
-void selinux_netlbl_sk_security_reset(struct sk_security_struct *ssec,
-				      int family);
-void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
-				     int family);
-void selinux_netlbl_sk_security_clone(struct sk_security_struct *ssec,
-				      struct sk_security_struct *newssec);
-
-int selinux_netlbl_skbuff_getsid(struct sk_buff *skb, u32 base_sid, u32 *sid);
-
-void selinux_netlbl_sock_graft(struct sock *sk, struct socket *sock);
-int selinux_netlbl_socket_post_create(struct socket *sock);
-int selinux_netlbl_inode_permission(struct inode *inode, int mask);
-int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
-				struct sk_buff *skb,
-				struct avc_audit_data *ad);
-int selinux_netlbl_socket_setsockopt(struct socket *sock,
-				     int level,
-				     int optname);
-#else
-static inline void selinux_netlbl_cache_invalidate(void)
-{
-	return;
-}
-
-static inline void selinux_netlbl_sk_security_reset(
-	                                       struct sk_security_struct *ssec,
-					       int family)
-{
-	return;
-}
-static inline void selinux_netlbl_sk_security_init(
-	                                       struct sk_security_struct *ssec,
-					       int family)
-{
-	return;
-}
-static inline void selinux_netlbl_sk_security_clone(
-	                                    struct sk_security_struct *ssec,
-					    struct sk_security_struct *newssec)
-{
-	return;
-}
-
-static inline int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
-					       u32 base_sid,
-					       u32 *sid)
-{
-	*sid = SECSID_NULL;
-	return 0;
-}
-
-static inline void selinux_netlbl_sock_graft(struct sock *sk,
-					     struct socket *sock)
-{
-	return;
-}
-static inline int selinux_netlbl_socket_post_create(struct socket *sock)
-{
-	return 0;
-}
-static inline int selinux_netlbl_inode_permission(struct inode *inode,
-						  int mask)
-{
-	return 0;
-}
-static inline int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
-					      struct sk_buff *skb,
-					      struct avc_audit_data *ad)
-{
-	return 0;
-}
-static inline int selinux_netlbl_socket_setsockopt(struct socket *sock,
-						   int level,
-						   int optname)
-{
-	return 0;
-}
-#endif /* CONFIG_NETLABEL */
-
-#endif
Index: net-2.6_future/security/selinux/ss/services.c
===================================================================
--- net-2.6_future.orig/security/selinux/ss/services.c
+++ net-2.6_future/security/selinux/ss/services.c
@@ -53,7 +53,7 @@
 #include "conditional.h"
 #include "mls.h"
 #include "objsec.h"
-#include "selinux_netlabel.h"
+#include "netlabel.h"
 #include "xfrm.h"
 #include "ebitmap.h"
 

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
