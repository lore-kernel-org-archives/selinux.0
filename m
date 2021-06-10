Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912DFC47094
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A1F613CB
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 15:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFJPyD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhFJPyA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 11:54:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA3EC061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 08:52:04 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrMyQ-006dED-5Z
        for selinux@vger.kernel.org; Thu, 10 Jun 2021 15:52:02 +0000
Date:   Thu, 10 Jun 2021 15:52:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] kill unused 'flags' argument in avc_has_perm_flags() and
 avc_audit()
Message-ID: <YMI1IpLMGuFvw4kd@zeniv-ca.linux.org.uk>
References: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From 565799de3ee0a295842a07a5f9a459db5e793beb Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 16 Jan 2021 15:57:49 -0500
Subject: [PATCH 2/2] kill unused 'flags' argument in avc_has_perm_flags() and
 avc_audit()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/selinux/avc.c         | 7 +++----
 security/selinux/hooks.c       | 5 ++---
 security/selinux/include/avc.h | 7 ++-----
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9c3d2a29616a..10b71a0efc50 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1179,7 +1179,7 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 				  &avd);
 
 	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
-			auditdata, 0);
+			auditdata);
 	if (rc2)
 		return rc2;
 	return rc;
@@ -1187,8 +1187,7 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 
 int avc_has_perm_flags(struct selinux_state *state,
 		       u32 ssid, u32 tsid, u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata,
-		       int flags)
+		       struct common_audit_data *auditdata)
 {
 	struct av_decision avd;
 	int rc, rc2;
@@ -1197,7 +1196,7 @@ int avc_has_perm_flags(struct selinux_state *state,
 				  &avd);
 
 	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
-			auditdata, flags);
+			auditdata);
 	if (rc2)
 		return rc2;
 	return rc;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f22ad1229471..2ae55348bd1c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1676,7 +1676,7 @@ static int cred_has_capability(const struct cred *cred,
 				  sid, sid, sclass, av, 0, &avd);
 	if (!(opts & CAP_OPT_NOAUDIT)) {
 		int rc2 = avc_audit(&selinux_state,
-				    sid, sid, sclass, av, &avd, rc, &ad, 0);
+				    sid, sid, sclass, av, &avd, rc, &ad);
 		if (rc2)
 			return rc2;
 	}
@@ -3154,8 +3154,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 		return PTR_ERR(isec);
 
 	return avc_has_perm_flags(&selinux_state,
-				  sid, isec->sid, isec->sclass, FILE__READ, &ad,
-				  rcu ? MAY_NOT_BLOCK : 0);
+				  sid, isec->sid, isec->sclass, FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index c3bbfc8e8b46..098f31c415e2 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -111,7 +111,6 @@ int slow_avc_audit(struct selinux_state *state,
  * @avd: access vector decisions
  * @result: result from avc_has_perm_noaudit
  * @a:  auxiliary audit data
- * @flags: VFS walk flags
  *
  * Audit the granting or denial of permissions in accordance
  * with the policy.  This function is typically called by
@@ -127,8 +126,7 @@ static inline int avc_audit(struct selinux_state *state,
 			    u16 tclass, u32 requested,
 			    struct av_decision *avd,
 			    int result,
-			    struct common_audit_data *a,
-			    int flags)
+			    struct common_audit_data *a)
 {
 	u32 audited, denied;
 	audited = avc_audit_required(requested, avd, result, 0, &denied);
@@ -154,8 +152,7 @@ int avc_has_perm(struct selinux_state *state,
 int avc_has_perm_flags(struct selinux_state *state,
 		       u32 ssid, u32 tsid,
 		       u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata,
-		       int flags);
+		       struct common_audit_data *auditdata);
 
 int avc_has_extended_perms(struct selinux_state *state,
 			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
-- 
2.11.0

