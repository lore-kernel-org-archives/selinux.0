From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 01/13] SELinux: netif.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:22 -0400
Message-Id: <1208554714617-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes netif.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
location of { around structs and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/netif.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 013d311..d2b36bd 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -8,7 +8,7 @@
  *
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
- *                    Paul Moore <paul.moore@hp.com>
+ *		      Paul Moore <paul.moore@hp.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2,
@@ -31,8 +31,7 @@
 #define SEL_NETIF_HASH_SIZE	64
 #define SEL_NETIF_HASH_MAX	1024
 
-struct sel_netif
-{
+struct sel_netif {
 	struct list_head list;
 	struct netif_security_struct nsec;
 	struct rcu_head rcu_head;
@@ -92,10 +91,10 @@ static inline struct sel_netif *sel_netif_find(int ifindex)
 static int sel_netif_insert(struct sel_netif *netif)
 {
 	int idx;
-	
+
 	if (sel_netif_total >= SEL_NETIF_HASH_MAX)
 		return -ENOSPC;
-	
+
 	idx = sel_netif_hashfn(netif->nsec.ifindex);
 	list_add_rcu(&netif->list, &sel_netif_hash[idx]);
 	sel_netif_total++;
@@ -267,7 +266,7 @@ static void sel_netif_flush(void)
 }
 
 static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,
-                                  u16 class, u32 perms, u32 *retained)
+				  u16 class, u32 perms, u32 *retained)
 {
 	if (event == AVC_CALLBACK_RESET) {
 		sel_netif_flush();
@@ -277,7 +276,7 @@ static int sel_netif_avc_callback(u32 event, u32 ssid, u32 tsid,
 }
 
 static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
-                                             unsigned long event, void *ptr)
+					     unsigned long event, void *ptr)
 {
 	struct net_device *dev = ptr;
 
@@ -297,7 +296,7 @@ static struct notifier_block sel_netif_netdev_notifier = {
 static __init int sel_netif_init(void)
 {
 	int i, err;
-	
+
 	if (!selinux_enabled)
 		return 0;
 
@@ -305,9 +304,9 @@ static __init int sel_netif_init(void)
 		INIT_LIST_HEAD(&sel_netif_hash[i]);
 
 	register_netdevice_notifier(&sel_netif_netdev_notifier);
-	
+
 	err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET,
-	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
 	if (err)
 		panic("avc_add_callback() failed, error %d\n", err);
 
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
