Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F84C6FA99
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCJStY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Mar 2023 13:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCJStX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Mar 2023 13:49:23 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0D780E26
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 10:49:21 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id y3so4243925qvn.4
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678474160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq7UJu81hbGRRwTy/JNhmgGk9ndVWdk/bFym2iSxWCM=;
        b=WVjqtsyzVrdTSyt9xUHfYThgrKa17c5SiPYGMqf1Xq9+09fxFUYtlPzi3fLVJy9qtr
         g89UZF6GsVGHZp0zb5JodfUra8lRevoE+RwuB+HSPPEFwZq1TlkBLAMr8b1FeBWjHsSD
         1rXlKgOyLABegbhoiXOoptBNNkNPdO75rgDN2VCRAkVgbg448gOY/Ebahb77szYKX8By
         I6ApJGx0s6mA79r31aUd8ScQOaLKVLr6nsR4aB35xSo/pnm7teHzuYCTIWgA0Ua35C9O
         cAZAPGIYW5VuBephz8U705rsYceN9gx96NO9TMmgCJZ5C01iUFh51HFBMAkbpTEoU+Uz
         DOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678474160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq7UJu81hbGRRwTy/JNhmgGk9ndVWdk/bFym2iSxWCM=;
        b=JgsU6noO1Mz6e6oW6EET/D8FFrbidvsyVHbBr7T0d1Wi6Wlb53KsMH+PzqOWXMP1Vb
         6RjUeeDnR4C5BMv0lHkKOesXFMnmovOzGYlrAuzKH66kKj8N3UMvNjU93iD3+zvLE8U1
         VPrK/AqcrJ9mAG0cQudPEBx9Cvlc1EI2vo7B7jeVYD4Wt0/5ARbt750hp2RLWvzzg1P7
         MZrvJFROXx+3gR9FfyAvoVNqwuITb6CBXVTIauRZFFofTwXej1vagO89djQirqdSVNL8
         s2jQ/scqNP1ByW3cSDSfhgjApZia8+lObW0x/XqSoydeoa/2gjXBPSz4AZiWp9pCEkmG
         VdwQ==
X-Gm-Message-State: AO0yUKUZkvYoItsUUnJRC7fiO5p5YLE+NntfA4a9sDR4moZr10rCnbe5
        ZA9mcjaW8lHa4GhzDmvTnw9NGOSmi3I=
X-Google-Smtp-Source: AK7set9Sa9/gXwth8vgZCZuVlrt5c1VJXr1KXNvI01O0I3pYxlx1TkwoiNkypC2exe11nNeduvqr0Q==
X-Received: by 2002:a05:6214:1cc8:b0:572:5a3a:f55 with SMTP id g8-20020a0562141cc800b005725a3a0f55mr40366158qvd.33.1678474160046;
        Fri, 10 Mar 2023 10:49:20 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id r16-20020a05620a299000b0073df51b5127sm315342qkp.43.2023.03.10.10.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Mar 2023 10:49:19 -0800 (PST)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, omosnace@redhat.com,
        torvalds@linux-foundation.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] selinux: cache access vector decisions in the inode security blob
Date:   Fri, 10 Mar 2023 13:41:46 -0500
Message-Id: <20230310184145.7791-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I think Linus suggested this a long long time ago but I never got around
to trying it. Better late than never. Compute the access vector decision
when the inode security blob is initialized and cache it in the blob. In
selinux_inode_permission and in inode_has_perm, use this cached decision
unless invalidated.

NB This is relative to "selinux: stop passing selinux_state pointers
and their offspring" which is not yet merged. It doesn't technically
depend on it but would conflict significantly otherwise.

NB There is an obvious race here between the validation and a file
relabel (inode_post_setxattr/inode_setsecurity) although it isn't entirely
new to this change. Likely need to change reads/writes of
isec->initialized to use smp_load_acquire()/store_release(). Not sure
what the net effect on inode permission checking would be. Hence,
this is RFC-only.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c            | 45 ++++++++++++++++++---
 security/selinux/hooks.c          | 67 ++++++++++++++++++++++++++-----
 security/selinux/include/avc.h    |  7 ++++
 security/selinux/include/objsec.h |  2 +
 security/selinux/ss/services.c    |  3 +-
 5 files changed, 106 insertions(+), 18 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index c162e51fb43c..c74bdd76b38a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -357,6 +357,8 @@ static int avc_xperms_populate(struct avc_node *node,
 	struct avc_xperms_decision_node *dest_xpd;
 	struct avc_xperms_decision_node *src_xpd;
 
+	if (!src)
+		return 0;
 	if (src->xp.len == 0)
 		return 0;
 	dest = avc_xperms_alloc();
@@ -988,15 +990,17 @@ static noinline struct avc_node *avc_compute_av(u32 ssid, u32 tsid, u16 tclass,
 						struct av_decision *avd,
 						struct avc_xperms_node *xp_node)
 {
-	INIT_LIST_HEAD(&xp_node->xpd_head);
-	security_compute_av(ssid, tsid, tclass, avd, &xp_node->xp);
+	if (xp_node)
+		INIT_LIST_HEAD(&xp_node->xpd_head);
+	security_compute_av(ssid, tsid, tclass, avd,
+			xp_node ? &xp_node->xp : NULL);
 	return avc_insert(ssid, tsid, tclass, avd, xp_node);
 }
 
-static noinline int avc_denied(u32 ssid, u32 tsid,
-			       u16 tclass, u32 requested,
-			       u8 driver, u8 xperm, unsigned int flags,
-			       struct av_decision *avd)
+noinline int avc_denied(u32 ssid, u32 tsid,
+			u16 tclass, u32 requested,
+			u8 driver, u8 xperm, unsigned int flags,
+			struct av_decision *avd)
 {
 	if (flags & AVC_STRICT)
 		return -EACCES;
@@ -1121,6 +1125,35 @@ static noinline int avc_perm_nonode(u32 ssid, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * avc_get_avd - Get access vector decisions
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @avd: access vector decisions
+ *
+ * Get access vector decisions for the specified (@ssid, @tsid, @tclass)
+ * triple, fetching them from the access vector cache if present or
+ * calling the security server to compute them on a miss. Unlike
+ * avc_has_perm_noaudit(), this function does not check any
+ * requested permission; it just returns the entire decision vector.
+ */
+void avc_get_avd(u32 ssid, u32 tsid, u16 tclass, struct av_decision *avd)
+{
+	struct avc_node *node;
+
+	rcu_read_lock();
+	node = avc_lookup(ssid, tsid, tclass);
+	if (unlikely(!node)) {
+		rcu_read_unlock();
+		avc_compute_av(ssid, tsid, tclass, avd, NULL);
+		return;
+	}
+	memcpy(avd, &node->ae.avd, sizeof(*avd));
+	rcu_read_unlock();
+}
+
+
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
  * @ssid: source security identifier
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index db6d8b68b543..130f373e2c24 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -793,6 +793,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 
 		root_isec->sid = rootcontext_sid;
+		avc_get_avd(root_isec->task_sid, root_isec->sid,
+			root_isec->sclass, &root_isec->avd);
+		root_isec->avdsid = root_isec->sid;
 		root_isec->initialized = LABEL_INITIALIZED;
 	}
 
@@ -1517,8 +1520,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			isec->initialized = LABEL_INVALID;
 			goto out_unlock;
 		}
-		isec->initialized = LABEL_INITIALIZED;
 		isec->sid = sid;
+		avc_get_avd(task_sid, sid, sclass, &isec->avd);
+		isec->avdsid = sid;
+		isec->initialized = LABEL_INITIALIZED;
 	}
 
 out_unlock:
@@ -1611,7 +1616,9 @@ static int inode_has_perm(const struct cred *cred,
 			  struct common_audit_data *adp)
 {
 	struct inode_security_struct *isec;
-	u32 sid;
+	u32 sid, denied;
+	struct av_decision avd;
+	int rc, rc2;
 
 	validate_creds(cred);
 
@@ -1621,6 +1628,21 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = selinux_inode(inode);
 
+	if (sid == isec->task_sid && isec->sid == isec->avdsid &&
+		isec->avd.seqno == avc_policy_seqno()) {
+		memcpy(&avd, &isec->avd, sizeof(avd));
+		denied = perms & ~avd.allowed;
+		if (unlikely(denied))
+			rc = avc_denied(sid, isec->sid, isec->sclass,
+					perms, 0, 0, 0,	&avd);
+		else
+			rc = 0;
+		rc2 = avc_audit(sid, isec->sid, isec->sclass, perms, &avd, rc, adp);
+		if (rc2)
+			return rc2;
+		return rc;
+	}
+
 	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
 }
 
@@ -2851,6 +2873,8 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
+		avc_get_avd(tsec->sid, newsid, isec->sclass, &isec->avd);
+		isec->avdsid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
@@ -2912,20 +2936,20 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 			return rc;
 	}
 
-	isec->initialized = LABEL_INITIALIZED;
 	/*
 	 * Now that we've initialized security, check whether we're
 	 * allowed to actually create this type of anonymous inode.
 	 */
+	rc = avc_has_perm_noaudit(tsec->sid, isec->sid, isec->sclass,
+				FILE__CREATE, 0, &isec->avd);
+
+	isec->initialized = LABEL_INITIALIZED;
 
 	ad.type = LSM_AUDIT_DATA_ANONINODE;
 	ad.u.anonclass = name ? (const char *)name->name : "?";
-
-	return avc_has_perm(tsec->sid,
-			    isec->sid,
-			    isec->sclass,
-			    FILE__CREATE,
-			    &ad);
+	avc_audit(tsec->sid, isec->sid, isec->sclass, FILE__CREATE, &isec->avd,
+		rc, &ad);
+	return rc;
 }
 
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
@@ -3041,8 +3065,19 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0,
-				  &avd);
+	if (sid == isec->task_sid && isec->sid == isec->avdsid &&
+		isec->avd.seqno == avc_policy_seqno()) {
+		memcpy(&avd, &isec->avd, sizeof(avd));
+		denied = perms & ~avd.allowed;
+		if (unlikely(denied))
+			rc = avc_denied(sid, isec->sid, isec->sclass,
+					perms, 0, 0, 0,	&avd);
+		else
+			rc = 0;
+	} else {
+		rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms,
+					0, &avd);
+	}
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
 				     &denied);
@@ -3247,6 +3282,8 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	avc_get_avd(isec->task_sid, newsid, isec->sclass, &isec->avd);
+	isec->avdsid = newsid;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 }
@@ -3406,6 +3443,8 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	avc_get_avd(isec->task_sid, newsid, isec->sclass, &isec->avd);
+	isec->avdsid = newsid;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 	return 0;
@@ -4162,6 +4201,8 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = sid;
+	avc_get_avd(isec->task_sid, sid, isec->sclass, &isec->avd);
+	isec->avdsid = sid;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 }
@@ -4534,6 +4575,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 
 	isec->sclass = sclass;
 	isec->sid = sid;
+	avc_get_avd(isec->task_sid, sid, sclass, &isec->avd);
+	isec->avdsid = sid;
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
@@ -4827,6 +4870,8 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	newisec = inode_security_novalidate(SOCK_INODE(newsock));
 	newisec->sclass = sclass;
 	newisec->sid = sid;
+	avc_get_avd(newisec->task_sid, sid, sclass, &newisec->avd);
+	newisec->avdsid = sid;
 	newisec->initialized = LABEL_INITIALIZED;
 
 	return 0;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 9301222c8e55..14fc5ed1a156 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -141,6 +141,13 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 			 unsigned flags,
 			 struct av_decision *avd);
 
+void avc_get_avd(u32 ssid, u32 tsid, u16 tclass, struct av_decision *avd);
+
+int avc_denied(u32 ssid, u32 tsid,
+	u16 tclass, u32 requested,
+	u8 driver, u8 xperm, unsigned int flags,
+	struct av_decision *avd);
+
 int avc_has_perm(u32 ssid, u32 tsid,
 		 u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2953132408bf..da95a75e6c77 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -50,6 +50,8 @@ struct inode_security_struct {
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
 	unsigned char initialized;	/* initialization flag */
+	u32 avdsid;		/* SID when avd was computed */
+	struct av_decision avd; /* access vector decisions */
 	spinlock_t lock;
 };
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f14d1ffe54c5..7353c027c389 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1107,7 +1107,8 @@ void security_compute_av(u32 ssid,
 	rcu_read_lock();
 	policy = rcu_dereference(selinux_state.policy);
 	avd_init(policy, avd);
-	xperms->len = 0;
+	if (xperms)
+		xperms->len = 0;
 	if (!selinux_initialized())
 		goto allow;
 
-- 
2.39.2

