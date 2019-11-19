Return-Path: <SRS0=SKFz=ZL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30AC432C0
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41822409
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574188871;
	bh=3m7sna6+G+TQL2w+vr9AGbmik1zbuRAz/wJpe/P3i6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fV2g2syMgyp5phOcTdLNFIF8g/QReCLLWOUulqzALAdxBirfZA99Ot/TNSTPyXIiW
	 PCF3e3NaB9hqvVQ8ESb8ysWPpphS1nvSDCDDvIX6yl4rrvdro/tJfc+HvOKxNxrjoI
	 Y7/DrNqdKPB8oiPhdPQotqiehMvwR0dVw5dWkcYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKSSlH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfKSSlG (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 19 Nov 2019 13:41:06 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E6422409;
        Tue, 19 Nov 2019 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574188866;
        bh=3m7sna6+G+TQL2w+vr9AGbmik1zbuRAz/wJpe/P3i6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAGrncSLLMav3KH009Hn91MYEcG3QZYlOy9gCkO4ViFtZqwknzcxVMH9HxMmYruN/
         ljeSnoc6en8McivZisV03omqYhbqL1Vl5IljpFmCWETsqtOdyAdV8bBlnPxvQdgFTV
         u7c/poT6uNg7/5ubDDfOsEf1lRvIUA5ytm8UVzyk=
From:   Will Deacon <will@kernel.org>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: [RFC PATCH 2/2] selinux: Propagate RCU walk status from 'security_inode_follow_link()'
Date:   Tue, 19 Nov 2019 18:40:57 +0000
Message-Id: <20191119184057.14961-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119184057.14961-1-will@kernel.org>
References: <20191119184057.14961-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

'selinux_inode_follow_link()' can be called as part of an RCU path walk,
and is passed a 'bool rcu' parameter to indicate whether or not it is
being called from within an RCU read-side critical section.

Unfortunately, this knowledge is not propagated further and, instead,
'avc_has_perm()' unconditionally passes a flags argument of '0' to both
'avc_has_perm_noaudit()' and 'avc_audit()' which may block.

Introduce 'avc_has_perm_flags()' which can be used safely from within an
RCU read-side critical section.

Signed-off-by: Will Deacon <will@kernel.org>
---
 security/selinux/avc.c         | 12 +++++++-----
 security/selinux/hooks.c       |  5 +++--
 security/selinux/include/avc.h | 12 ++++++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9c183c899e92..7d99dadd24d0 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1177,11 +1177,12 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 }
 
 /**
- * avc_has_perm - Check permissions and perform any appropriate auditing.
+ * avc_has_perm_flags - Check permissions and perform any appropriate auditing.
  * @ssid: source security identifier
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
+ * @flags: AVC_STRICT, AVC_NONBLOCKING, or 0
  * @auditdata: auxiliary audit data
  *
  * Check the AVC to determine whether the @requested permissions are granted
@@ -1192,17 +1193,18 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
  * permissions are granted, -%EACCES if any permissions are denied, or
  * another -errno upon other errors.
  */
-int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
-		 u32 requested, struct common_audit_data *auditdata)
+int avc_has_perm_flags(struct selinux_state *state, u32 ssid, u32 tsid,
+		       u16 tclass, u32 requested, unsigned int flags,
+		       struct common_audit_data *auditdata)
 {
 	struct av_decision avd;
 	int rc, rc2;
 
-	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, flags,
 				  &avd);
 
 	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
-			auditdata, 0);
+			auditdata, flags);
 	if (rc2)
 		return rc2;
 	return rc;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99e677f..0c09f59a2740 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3008,8 +3008,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm(&selinux_state,
-			    sid, isec->sid, isec->sclass, FILE__READ, &ad);
+	return avc_has_perm_flags(&selinux_state, sid, isec->sid, isec->sclass,
+				  rcu ? AVC_NONBLOCKING : 0,
+				  FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 7be0e1e90e8b..0450e1b88182 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -149,10 +149,14 @@ int avc_has_perm_noaudit(struct selinux_state *state,
 			 unsigned flags,
 			 struct av_decision *avd);
 
-int avc_has_perm(struct selinux_state *state,
-		 u32 ssid, u32 tsid,
-		 u16 tclass, u32 requested,
-		 struct common_audit_data *auditdata);
+int avc_has_perm_flags(struct selinux_state *state,
+		       u32 ssid, u32 tsid,
+		       u16 tclass, u32 requested,
+		       unsigned flags,
+		       struct common_audit_data *auditdata);
+
+#define avc_has_perm(state, ssid, tsid, tclass, requested, auditdata) \
+	avc_has_perm_flags(state, ssid, tsid, tclass, requested, 0, auditdata)
 
 int avc_has_extended_perms(struct selinux_state *state,
 			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
-- 
2.24.0.432.g9d3f5f5b63-goog

