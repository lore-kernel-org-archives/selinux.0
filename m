From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: remove all unneeded AVC callback code
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Date: Thu, 19 Apr 2012 16:28:27 -0400
Message-ID: <20120419202827.7773.4313.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We do 2 things with the AVC callback code.

1) register a function when policy is reloaded
2) update a node to add permissions

These are unrelated, but we use some of the same callback stuff as if they
were related.  There was other callback stuff which was completely unused.
Split them and remove the other callback stuff.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/audit.h          |    6 ++++
 security/selinux/avc.c         |   60 ++++++++++------------------------------
 security/selinux/include/avc.h |   11 +------
 security/selinux/netif.c       |   13 ++++-----
 security/selinux/netnode.c     |   13 ++++-----
 security/selinux/netport.c     |   13 ++++-----
 security/selinux/ss/services.c |   15 +---------
 7 files changed, 42 insertions(+), 89 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 22f292a..417d4ef 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -718,6 +718,12 @@ extern int audit_enabled;
 #define audit_log_key(b, k) do { ; } while (0)
 #define audit_log_secctx(b,s) do { ; } while (0)
 #define audit_enabled 0
+
+static inline int audit_update_lsm_rules(void)
+{
+	return 0;
+}
+
 #endif
 #endif
 #endif
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 4d0d913..b5741c1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -65,8 +65,7 @@ struct avc_cache {
 };
 
 struct avc_callback_node {
-	int (*callback) (u32 event);
-	u32 events;
+	int (*callback) (void);
 	struct avc_callback_node *next;
 };
 
@@ -495,23 +494,18 @@ noinline int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
  * Returns %0 on success or -%ENOMEM if insufficient memory
  * exists to add the callback.
  */
-int __init avc_add_callback(int (*callback)(u32 event), u32 events)
+int __init avc_add_reset_callback(int (*callback)(void))
 {
 	struct avc_callback_node *c;
-	int rc = 0;
 
 	c = kmalloc(sizeof(*c), GFP_KERNEL);
-	if (!c) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!c)
+		return -ENOMEM;
 
 	c->callback = callback;
-	c->events = events;
 	c->next = avc_callbacks;
 	avc_callbacks = c;
-out:
-	return rc;
+	return 0;
 }
 
 static inline int avc_sidcmp(u32 x, u32 y)
@@ -520,8 +514,7 @@ static inline int avc_sidcmp(u32 x, u32 y)
 }
 
 /**
- * avc_update_node Update an AVC entry
- * @event : Updating event
+ * avc_grant_perm Update an AVC entry
  * @perms : Permission mask bits
  * @ssid,@tsid,@tclass : identifier of an AVC entry
  * @seqno : sequence number when decision was made
@@ -531,8 +524,7 @@ static inline int avc_sidcmp(u32 x, u32 y)
  * otherwise, this function updates the AVC entry. The original AVC-entry object
  * will release later by RCU.
  */
-static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
-			   u32 seqno)
+static int avc_grant_perm(u32 perms, u32 ssid, u32 tsid, u16 tclass, u32 seqno)
 {
 	int hvalue, rc = 0;
 	unsigned long flag;
@@ -577,27 +569,8 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
 
 	avc_node_populate(node, ssid, tsid, tclass, &orig->ae.avd);
 
-	switch (event) {
-	case AVC_CALLBACK_GRANT:
-		node->ae.avd.allowed |= perms;
-		break;
-	case AVC_CALLBACK_TRY_REVOKE:
-	case AVC_CALLBACK_REVOKE:
-		node->ae.avd.allowed &= ~perms;
-		break;
-	case AVC_CALLBACK_AUDITALLOW_ENABLE:
-		node->ae.avd.auditallow |= perms;
-		break;
-	case AVC_CALLBACK_AUDITALLOW_DISABLE:
-		node->ae.avd.auditallow &= ~perms;
-		break;
-	case AVC_CALLBACK_AUDITDENY_ENABLE:
-		node->ae.avd.auditdeny |= perms;
-		break;
-	case AVC_CALLBACK_AUDITDENY_DISABLE:
-		node->ae.avd.auditdeny &= ~perms;
-		break;
-	}
+	node->ae.avd.allowed |= perms;
+
 	avc_node_replace(node, orig);
 out_unlock:
 	spin_unlock_irqrestore(lock, flag);
@@ -646,13 +619,11 @@ int avc_ss_reset(u32 seqno)
 	avc_flush();
 
 	for (c = avc_callbacks; c; c = c->next) {
-		if (c->events & AVC_CALLBACK_RESET) {
-			tmprc = c->callback(AVC_CALLBACK_RESET);
-			/* save the first error encountered for the return
-			   value and continue processing the callbacks */
-			if (!rc)
-				rc = tmprc;
-		}
+		tmprc = c->callback();
+		/* save the first error encountered for the return
+		   value and continue processing the callbacks */
+		if (!rc)
+			rc = tmprc;
 	}
 
 	avc_latest_notif_update(seqno, 0);
@@ -689,8 +660,7 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
 	if (selinux_enforcing && !(avd->flags & AVD_FLAGS_PERMISSIVE))
 		return -EACCES;
 
-	avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
-				tsid, tclass, avd->seqno);
+	avc_grant_perm(requested, ssid, tsid, tclass, avd->seqno);
 	return 0;
 }
 
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 92d0ab5..82e98ec 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -161,16 +161,7 @@ static inline int avc_has_perm(u32 ssid, u32 tsid,
 
 u32 avc_policy_seqno(void);
 
-#define AVC_CALLBACK_GRANT		1
-#define AVC_CALLBACK_TRY_REVOKE		2
-#define AVC_CALLBACK_REVOKE		4
-#define AVC_CALLBACK_RESET		8
-#define AVC_CALLBACK_AUDITALLOW_ENABLE	16
-#define AVC_CALLBACK_AUDITALLOW_DISABLE	32
-#define AVC_CALLBACK_AUDITDENY_ENABLE	64
-#define AVC_CALLBACK_AUDITDENY_DISABLE	128
-
-int avc_add_callback(int (*callback)(u32 event), u32 events);
+int avc_add_reset_callback(int (*callback)(void));
 
 /* Exported to selinuxfs */
 int avc_get_hash_stats(char *page);
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 47a49d1..4515702 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -252,12 +252,11 @@ static void sel_netif_flush(void)
 	spin_unlock_bh(&sel_netif_lock);
 }
 
-static int sel_netif_avc_callback(u32 event)
+static int sel_netif_avc_callback(void)
 {
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netif_flush();
-		synchronize_net();
-	}
+	sel_netif_flush();
+	synchronize_net();
+
 	return 0;
 }
 
@@ -291,9 +290,9 @@ static __init int sel_netif_init(void)
 
 	register_netdevice_notifier(&sel_netif_netdev_notifier);
 
-	err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET);
+	err = avc_add_reset_callback(sel_netif_avc_callback);
 	if (err)
-		panic("avc_add_callback() failed, error %d\n", err);
+		panic("avc_add_reset_callback() failed, error %d\n", err);
 
 	return err;
 }
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 28f911c..e984d6f 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -297,12 +297,11 @@ static void sel_netnode_flush(void)
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
-static int sel_netnode_avc_callback(u32 event)
+static int sel_netnode_avc_callback(void)
 {
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netnode_flush();
-		synchronize_net();
-	}
+	sel_netnode_flush();
+	synchronize_net();
+
 	return 0;
 }
 
@@ -319,9 +318,9 @@ static __init int sel_netnode_init(void)
 		sel_netnode_hash[iter].size = 0;
 	}
 
-	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET);
+	ret = avc_add_reset_callback(sel_netnode_avc_callback);
 	if (ret != 0)
-		panic("avc_add_callback() failed, error %d\n", ret);
+		panic("avc_add_reset_callback() failed, error %d\n", ret);
 
 	return ret;
 }
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index d353797..ee62c6a 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -234,12 +234,11 @@ static void sel_netport_flush(void)
 	spin_unlock_bh(&sel_netport_lock);
 }
 
-static int sel_netport_avc_callback(u32 event)
+static int sel_netport_avc_callback(void)
 {
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netport_flush();
-		synchronize_net();
-	}
+	sel_netport_flush();
+	synchronize_net();
+
 	return 0;
 }
 
@@ -256,9 +255,9 @@ static __init int sel_netport_init(void)
 		sel_netport_hash[iter].size = 0;
 	}
 
-	ret = avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET);
+	ret = avc_add_reset_callback(sel_netport_avc_callback);
 	if (ret != 0)
-		panic("avc_add_callback() failed, error %d\n", ret);
+		panic("avc_add_reset_callback() failed, error %d\n", ret);
 
 	return ret;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 789e6d1..d12eaf8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3045,24 +3045,13 @@ out:
 	return match;
 }
 
-static int (*aurule_callback)(void) = audit_update_lsm_rules;
-
-static int aurule_avc_callback(u32 event)
-{
-	int err = 0;
-
-	if (event == AVC_CALLBACK_RESET && aurule_callback)
-		err = aurule_callback();
-	return err;
-}
-
 static int __init aurule_init(void)
 {
 	int err;
 
-	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET);
+	err = avc_add_reset_callback(audit_update_lsm_rules);
 	if (err)
-		panic("avc_add_callback() failed, error %d\n", err);
+		panic("avc_add_reset_callback() failed, error %d\n", err);
 
 	return err;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
