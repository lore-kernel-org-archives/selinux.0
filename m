Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85600C48BDF
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDF4613D8
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 15:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhFJPxL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhFJPxL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 11:53:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129BC061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 08:51:14 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrMxd-006dDH-TU
        for selinux@vger.kernel.org; Thu, 10 Jun 2021 15:51:14 +0000
Date:   Thu, 10 Jun 2021 15:51:13 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
Message-ID: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[followup to dump_common_audit_data() changes from this winter; in vfs.git#work.audit]
Does anybody have objections to the below?

From 663a40ab49308b5acaba8a335190fce66e17d969 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 16 Jan 2021 15:40:54 -0500
Subject: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking

dump_common_audit_data() is safe to use under rcu_read_lock() now;
no need for AVC_NONBLOCKING and games around it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/selinux/avc.c         | 28 ++++++++--------------------
 security/selinux/hooks.c       | 13 ++-----------
 security/selinux/include/avc.h |  4 ----
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ad451cf9375e..9c3d2a29616a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -758,7 +758,11 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 	}
 }
 
-/* This is the slow part of avc audit with big stack footprint */
+/*
+ * This is the slow part of avc audit with big stack footprint.
+ * Note that it is non-blocking and can be called from under
+ * rcu_read_lock().
+ */
 noinline int slow_avc_audit(struct selinux_state *state,
 			    u32 ssid, u32 tsid, u16 tclass,
 			    u32 requested, u32 audited, u32 denied, int result,
@@ -825,7 +829,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
  * @ssid,@tsid,@tclass : identifier of an AVC entry
  * @seqno : sequence number when decision was made
  * @xpd: extended_perms_decision to be added to the node
- * @flags: the AVC_* flags, e.g. AVC_NONBLOCKING, AVC_EXTENDED_PERMS, or 0.
+ * @flags: the AVC_* flags, e.g. AVC_EXTENDED_PERMS, or 0.
  *
  * if a valid AVC entry doesn't exist,this function returns -ENOENT.
  * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
@@ -844,21 +848,6 @@ static int avc_update_node(struct selinux_avc *avc,
 	struct hlist_head *head;
 	spinlock_t *lock;
 
-	/*
-	 * If we are in a non-blocking code path, e.g. VFS RCU walk,
-	 * then we must not add permissions to a cache entry
-	 * because we will not audit the denial.  Otherwise,
-	 * during the subsequent blocking retry (e.g. VFS ref walk), we
-	 * will find the permissions already granted in the cache entry
-	 * and won't audit anything at all, leading to silent denials in
-	 * permissive mode that only appear when in enforcing mode.
-	 *
-	 * See the corresponding handling of MAY_NOT_BLOCK in avc_audit()
-	 * and selinux_inode_permission().
-	 */
-	if (flags & AVC_NONBLOCKING)
-		return 0;
-
 	node = avc_alloc_node(avc);
 	if (!node) {
 		rc = -ENOMEM;
@@ -1119,7 +1108,7 @@ int avc_has_extended_perms(struct selinux_state *state,
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @flags:  AVC_STRICT, AVC_NONBLOCKING, or 0
+ * @flags:  AVC_STRICT or 0
  * @avd: access vector decisions
  *
  * Check the AVC to determine whether the @requested permissions are granted
@@ -1204,8 +1193,7 @@ int avc_has_perm_flags(struct selinux_state *state,
 	struct av_decision avd;
 	int rc, rc2;
 
-	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
-				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
 				  &avd);
 
 	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eaea837d89d1..f22ad1229471 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3164,17 +3164,13 @@ static noinline int audit_inode_permission(struct inode *inode,
 {
 	struct common_audit_data ad;
 	struct inode_security_struct *isec = selinux_inode(inode);
-	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
 	ad.u.inode = inode;
 
-	rc = slow_avc_audit(&selinux_state,
+	return slow_avc_audit(&selinux_state,
 			    current_sid(), isec->sid, isec->sclass, perms,
 			    audited, denied, result, &ad);
-	if (rc)
-		return rc;
-	return 0;
 }
 
 static int selinux_inode_permission(struct inode *inode, int mask)
@@ -3209,8 +3205,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 		return PTR_ERR(isec);
 
 	rc = avc_has_perm_noaudit(&selinux_state,
-				  sid, isec->sid, isec->sclass, perms,
-				  no_block ? AVC_NONBLOCKING : 0,
+				  sid, isec->sid, isec->sclass, perms, 0,
 				  &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
@@ -3218,10 +3213,6 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (likely(!audited))
 		return rc;
 
-	/* fall back to ref-walk if we have to generate audit */
-	if (no_block)
-		return -ECHILD;
-
 	rc2 = audit_inode_permission(inode, perms, audited, denied, rc);
 	if (rc2)
 		return rc2;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index cf4cc3ef959b..c3bbfc8e8b46 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -134,9 +134,6 @@ static inline int avc_audit(struct selinux_state *state,
 	audited = avc_audit_required(requested, avd, result, 0, &denied);
 	if (likely(!audited))
 		return 0;
-	/* fall back to ref-walk if we have to generate audit */
-	if (flags & MAY_NOT_BLOCK)
-		return -ECHILD;
 	return slow_avc_audit(state, ssid, tsid, tclass,
 			      requested, audited, denied, result,
 			      a);
@@ -144,7 +141,6 @@ static inline int avc_audit(struct selinux_state *state,
 
 #define AVC_STRICT 1 /* Ignore permissive mode. */
 #define AVC_EXTENDED_PERMS 2	/* update extended permissions */
-#define AVC_NONBLOCKING    4	/* non blocking */
 int avc_has_perm_noaudit(struct selinux_state *state,
 			 u32 ssid, u32 tsid,
 			 u16 tclass, u32 requested,
-- 
2.11.0

