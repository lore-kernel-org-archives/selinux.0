Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5RKfj0I006539
 for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2014 16:41:46 -0400
Subject: [RFC PATCH] selinux: reduce the number of calls to
 synchronize_net() when flushing caches
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 27 Jun 2014 16:41:42 -0400
Message-ID: <20140627204142.4730.96332.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jaejyn Shin <flagon22bass@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When flushing the AVC, such as during a policy load, the various
network caches are also flushed, with each making a call to
synchronize_net() which has shown to be expensive in some cases.
This patch consolidates the network cache flushes into a single AVC
callback which only calls synchronize_net() once for each AVC cache
flush.

Reported-by: Jaejyn Shin <flagon22bass@gmail.com>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/hooks.c           |   14 ++++++++++++++
 security/selinux/include/netif.h   |    2 ++
 security/selinux/include/netnode.h |    2 ++
 security/selinux/include/netport.h |    2 ++
 security/selinux/netif.c           |   15 +--------------
 security/selinux/netnode.c         |   15 +--------------
 security/selinux/netport.c         |   15 +--------------
 7 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 336f0a0..39bc8c9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -161,6 +161,17 @@ static int selinux_peerlbl_enabled(void)
 	return (selinux_policycap_alwaysnetwork || netlbl_enabled() || selinux_xfrm_enabled());
 }
 
+static int selinux_netcache_avc_callback(u32 event)
+{
+	if (event == AVC_CALLBACK_RESET) {
+		sel_netif_flush();
+		sel_netnode_flush();
+		sel_netport_flush();
+		synchronize_net();
+	}
+	return 0;
+}
+
 /*
  * initialise the security for the init task
  */
@@ -5993,6 +6004,9 @@ static __init int selinux_init(void)
 	if (register_security(&selinux_ops))
 		panic("SELinux: Unable to register with kernel.\n");
 
+	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
+		panic("SELinux: Unable to register AVC netcache callback\n");
+
 	if (selinux_enforcing)
 		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
 	else
diff --git a/security/selinux/include/netif.h b/security/selinux/include/netif.h
index 43d5072..57c6eae 100644
--- a/security/selinux/include/netif.h
+++ b/security/selinux/include/netif.h
@@ -17,6 +17,8 @@
 #ifndef _SELINUX_NETIF_H_
 #define _SELINUX_NETIF_H_
 
+void sel_netif_flush(void);
+
 int sel_netif_sid(int ifindex, u32 *sid);
 
 #endif	/* _SELINUX_NETIF_H_ */
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index df7a5ed..937668d 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -27,6 +27,8 @@
 #ifndef _SELINUX_NETNODE_H
 #define _SELINUX_NETNODE_H
 
+void sel_netnode_flush(void);
+
 int sel_netnode_sid(void *addr, u16 family, u32 *sid);
 
 #endif
diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
index 4d965b8..d1ce896 100644
--- a/security/selinux/include/netport.h
+++ b/security/selinux/include/netport.h
@@ -26,6 +26,8 @@
 #ifndef _SELINUX_NETPORT_H
 #define _SELINUX_NETPORT_H
 
+void sel_netport_flush(void);
+
 int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
 
 #endif
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 694e9e4..3c3de4c 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -240,7 +240,7 @@ static void sel_netif_kill(int ifindex)
  * Remove all entries from the network interface table.
  *
  */
-static void sel_netif_flush(void)
+void sel_netif_flush(void)
 {
 	int idx;
 	struct sel_netif *netif;
@@ -252,15 +252,6 @@ static void sel_netif_flush(void)
 	spin_unlock_bh(&sel_netif_lock);
 }
 
-static int sel_netif_avc_callback(u32 event)
-{
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netif_flush();
-		synchronize_net();
-	}
-	return 0;
-}
-
 static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
 					     unsigned long event, void *ptr)
 {
@@ -291,10 +282,6 @@ static __init int sel_netif_init(void)
 
 	register_netdevice_notifier(&sel_netif_netdev_notifier);
 
-	err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET);
-	if (err)
-		panic("avc_add_callback() failed, error %d\n", err);
-
 	return err;
 }
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 03a72c3..ddf3152 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -283,7 +283,7 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)
  * Remove all entries from the network address table.
  *
  */
-static void sel_netnode_flush(void)
+void sel_netnode_flush(void)
 {
 	unsigned int idx;
 	struct sel_netnode *node, *node_tmp;
@@ -300,15 +300,6 @@ static void sel_netnode_flush(void)
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
-static int sel_netnode_avc_callback(u32 event)
-{
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netnode_flush();
-		synchronize_net();
-	}
-	return 0;
-}
-
 static __init int sel_netnode_init(void)
 {
 	int iter;
@@ -322,10 +313,6 @@ static __init int sel_netnode_init(void)
 		sel_netnode_hash[iter].size = 0;
 	}
 
-	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET);
-	if (ret != 0)
-		panic("avc_add_callback() failed, error %d\n", ret);
-
 	return ret;
 }
 
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index d353797..73ac678 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -217,7 +217,7 @@ int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
  * Remove all entries from the network address table.
  *
  */
-static void sel_netport_flush(void)
+void sel_netport_flush(void)
 {
 	unsigned int idx;
 	struct sel_netport *port, *port_tmp;
@@ -234,15 +234,6 @@ static void sel_netport_flush(void)
 	spin_unlock_bh(&sel_netport_lock);
 }
 
-static int sel_netport_avc_callback(u32 event)
-{
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netport_flush();
-		synchronize_net();
-	}
-	return 0;
-}
-
 static __init int sel_netport_init(void)
 {
 	int iter;
@@ -256,10 +247,6 @@ static __init int sel_netport_init(void)
 		sel_netport_hash[iter].size = 0;
 	}
 
-	ret = avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET);
-	if (ret != 0)
-		panic("avc_add_callback() failed, error %d\n", ret);
-
 	return ret;
 }
 
