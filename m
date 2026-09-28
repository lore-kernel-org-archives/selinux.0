Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1144DD3D1
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617620; cv=none; b=WndF1GUr8Odi56ErGA4wpzsIvQKUUtjpFdG0rZqCAP/T2j++EHr2UkRfUfeAmI6G5BrIDfeQx1FMTNyHBo5MAycvJq5xs72qanqiKA1H874mstp5ecGK0PekM8KgTKL1JeJofuFku8FQS480T+xKlHasCmY1vUQA8bdfq0Yam0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617620; c=relaxed/simple;
	bh=R68eaTkZv69yX65drzLE0mqBwhEd9oMwTwKKBEPcpU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jg/N9mVBXypmNeCAWe3rOH99gBT0Y/3V4DbnXduyq00jRMNYlirrgQANQ4tiYotN8MvXuLxv9rIuCRwXB6scFrJQbTtrH2gR/p5mBnr6jMQ+sXqgWHLqnmLpQG1HWrMjEspnC9LCU69W/T6v0NeO4W/XLtizkrq4NNr0buM+dGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=efWTH28w; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="efWTH28w"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617616;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CHrlbchscoVQlbohccgoF2549iw0lBRWOiZ46hTHYJY=;
	b=efWTH28wnVwI7/h5zO9penW+tJmTSoJiUoUB2Xm/BtOG/58LJEYr0CKe/ICzw4UrM+4Q8e
	E7Q7/gj4zn/2MikJaTLDxpu8rLfbI9aGhUie15ggBiRpuDbc2KVK7hV9r8c46uBflfrtsN
	+KYw83qvPFbna6JdytBq4ksSIAIGEXuXWE234Ps+mMJT0Z98kuq/P9Mko1SmS4wVTnX0qo
	24MEU1/mQXQUwFOXsLnEZ6rhWBkoy4CCrw4A9XxbYJ+Yf9qE6X0RsZrDyI4PdsCUgtjkdA
	TJiIY993v2Ukp/Rwj+m/DJjkhs6NtdDWU+XaY+6O54KpOBe7BpIwNViJKvH6Fg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 02/32] selinux: drop event filtering from AVC callbacks
Date: Mon, 28 Sep 2026 19:46:12 +0200
Message-ID: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

All AVC callbacks are registered for AVC_CALLBACK_RESET only, and it is
the only event ever dispatched.  Drop the events mask, the event
argument and the redundant event checks in the callbacks.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c           | 23 +++++++++--------------
 security/selinux/hooks.c         | 28 +++++++++++-----------------
 security/selinux/include/audit.h |  7 +++----
 security/selinux/include/avc.h   |  4 +---
 security/selinux/ss/services.c   |  6 ++----
 5 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 936e116b01fb..9edbc324121e 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -78,8 +78,7 @@ struct avc_cache {
 };
 
 struct avc_callback_node {
-	int (*callback) (u32 event);
-	u32 events;
+	int (*callback)(void);
 	struct avc_callback_node *next;
 };
 
@@ -785,15 +784,14 @@ noinline int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
 }
 
 /**
- * avc_add_callback - Register a callback for security events.
+ * avc_add_callback - Register a callback for AVC resets.
  * @callback: callback function
- * @events: security events
  *
- * Register a callback function for events in the set @events.
+ * Register a callback function to be called on every AVC reset.
  * Returns %0 on success or -%ENOMEM if insufficient memory
  * exists to add the callback.
  */
-int __init avc_add_callback(int (*callback)(u32 event), u32 events)
+int __init avc_add_callback(int (*callback)(void))
 {
 	struct avc_callback_node *c;
 	int rc = 0;
@@ -805,7 +803,6 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
 	}
 
 	c->callback = callback;
-	c->events = events;
 	c->next = avc_callbacks;
 	avc_callbacks = c;
 out:
@@ -953,13 +950,11 @@ int avc_ss_reset(u32 seqno)
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
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 035aaf113d1d..9444c4d0b901 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -188,24 +188,19 @@ static int selinux_peerlbl_enabled(void)
 		netlbl_enabled() || selinux_xfrm_enabled());
 }
 
-static int selinux_netcache_avc_callback(u32 event)
+static int selinux_netcache_avc_callback(void)
 {
-	if (event == AVC_CALLBACK_RESET) {
-		sel_netif_flush();
-		sel_netnode_flush();
-		sel_netport_flush();
-		synchronize_net();
-	}
+	sel_netif_flush();
+	sel_netnode_flush();
+	sel_netport_flush();
+	synchronize_net();
 	return 0;
 }
 
-static int selinux_lsm_notifier_avc_callback(u32 event)
+static int selinux_lsm_notifier_avc_callback(void)
 {
-	if (event == AVC_CALLBACK_RESET) {
-		sel_ib_pkey_flush();
-		call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
-	}
-
+	sel_ib_pkey_flush();
+	call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
 	return 0;
 }
 
@@ -7886,14 +7881,13 @@ static __init int selinux_init(void)
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
 			   &selinux_lsmid);
 
-	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
+	if (avc_add_callback(selinux_netcache_avc_callback))
 		panic("SELinux: Unable to register AVC netcache callback\n");
 
-	if (avc_add_callback(selinux_lsm_notifier_avc_callback, AVC_CALLBACK_RESET))
+	if (avc_add_callback(selinux_lsm_notifier_avc_callback))
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
-	if (avc_add_callback(selinux_audit_rule_avc_callback,
-			     AVC_CALLBACK_RESET))
+	if (avc_add_callback(selinux_audit_rule_avc_callback))
 		panic("SELinux: Unable to register AVC audit callback\n");
 
 	if (selinux_enforcing_boot)
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 85a531ac737b..3103a5784ee2 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -16,13 +16,12 @@
 #include <linux/types.h>
 
 /**
- * selinux_audit_rule_avc_callback - update the audit LSM rules on AVC events.
- * @event: the AVC event
+ * selinux_audit_rule_avc_callback - update the audit LSM rules on AVC reset.
  *
- * Update any audit LSM rules based on the AVC event specified in @event.
+ * Update any audit LSM rules after the AVC has been reset.
  * Returns 0 on success, negative values otherwise.
  */
-int selinux_audit_rule_avc_callback(u32 event);
+int selinux_audit_rule_avc_callback(void);
 
 /**
  * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 0f788dfc66e9..8cfc4255be36 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -149,9 +149,7 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 
 u32 avc_policy_seqno(void);
 
-#define AVC_CALLBACK_RESET		8
-
-int avc_add_callback(int (*callback)(u32 event), u32 events);
+int avc_add_callback(int (*callback)(void));
 
 /* Exported to selinuxfs */
 int avc_get_hash_stats(char *page);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index da77ad769c83..3cfe9c7b28c6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3462,11 +3462,9 @@ struct selinux_audit_rule {
 	struct context au_ctxt;
 };
 
-int selinux_audit_rule_avc_callback(u32 event)
+int selinux_audit_rule_avc_callback(void)
 {
-	if (event == AVC_CALLBACK_RESET)
-		return audit_update_lsm_rules();
-	return 0;
+	return audit_update_lsm_rules();
 }
 
 void selinux_audit_rule_free(void *vrule)
-- 
2.55.0

