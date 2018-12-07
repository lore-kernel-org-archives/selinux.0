Return-Path: <SRS0=Nhvc=OQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA5C07E85
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17DD2054F
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 16:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17DD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLGQUu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:20:50 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:57681 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLGQUu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Dec 2018 11:20:50 -0500
X-EEMSG-check-008: 656454024|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="656454024"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Dec 2018 16:20:49 +0000
X-IronPort-AV: E=Sophos;i="5.56,326,1539648000"; 
   d="scan'208";a="21443156"
IronPort-PHdr: =?us-ascii?q?9a23=3AeK16Rh1Q3ZvhxuZhsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseISL/ad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb5Q6o0WT?=
 =?us-ascii?q?C/5Kl1ThHmhjoMOzog/G3JlsB8iaRWqw+jqRNi2Y7ZeIGbOuRjcK3Tft0UQm?=
 =?us-ascii?q?VOUMlKWiBdAY6xdZcDAvAdMepEqYT2ulsArQG5BQmpHO7h1yNIiWHu3a06ze?=
 =?us-ascii?q?shFxzN0hElH90UtHTUqMv6NacPWu2y16nH0C7DYuhK2Tb99IfIchchreuKXb?=
 =?us-ascii?q?Jra8Xd00YvFwTbjliJr4HuIjCb1vwVvmSG4OdtWvijhm46pw1rvDSiydkghp?=
 =?us-ascii?q?PUio8T11vK7z92wJwvKt29UEN7ZNmkH4ZOuCyCLIt2R98iQ3lvuCYn1r0KoZ?=
 =?us-ascii?q?67czYOyJQg3xPfd+aIc5KJ4hL+T+adOyt4hXJ5d7K/gBa+606gxfHnVsaoyl?=
 =?us-ascii?q?pKqytFkt3UunAM0Rzc9NSHR+Ng8kqu1juDzQDe5vxeLUwqmqfXNYQtzqMomp?=
 =?us-ascii?q?oWq0vDHyv2mEvsjK+Rc0Up4vOo5Pn8Yrj9up+dN5N7igH5Mqg0nMy/Gv43Ph?=
 =?us-ascii?q?IBX2ic5+SwzKfj8lHhQLVWkv02lbHUv4vfJcQYuq65HgFU0oc95Ba5FDqm39?=
 =?us-ascii?q?EYkmMGLFJBYh6Ik4/pO1TWKvDiEfi/m0iskCtsx/3eJr3uGIjNLnzYnbf5Z7?=
 =?us-ascii?q?l99kpcxBM2zdBY4JJUEK8OLOjvVU/2sdzSFgU5PBCsw+b7FNV90ZsTWXmRDa?=
 =?us-ascii?q?+dMaPSt0KI5+00LumSa48apiz9J+Im5/Hwl385n0ESfa2z0ZsQcnC4EacuH0?=
 =?us-ascii?q?LMenfog9EcAU8UsQckCu/nkluPVXhUfXnhcbg742QAFI++DYrFDruoibiF0T?=
 =?us-ascii?q?bzSoZafUhaG1uMFjHubIzCVPASPnHBavR9myAJAODyA7Qq0guj4Uqgk7c=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3AAD6nApc/wHyM5BjHQEBBQEHBQGBUQgBCwGBWimBN?=
 =?us-ascii?q?TMnjBOMEU0BAQEBAQaCMYgWDo4vgXogGAGEQIMdIjQJDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II2JIMQCwFGgQJPglYMP4FqAwgNplczhUCCQw2CHIdzRYNqF3iBB4ERgl2DD?=
 =?us-ascii?q?IgFAokTD4cVUI8yLgmOHIMkCxiBXIg9hx+KFYR6i1I4gVUrCAIYCCEPgyeCJ?=
 =?us-ascii?q?xcSjikhAzCBBQEBimUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Dec 2018 16:20:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB7GKmjc002344;
        Fri, 7 Dec 2018 11:20:48 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bmktuwien@gmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH v2 1/2] selinux: avoid silent denials in permissive mode under RCU walk
Date:   Fri,  7 Dec 2018 11:23:21 -0500
Message-Id: <20181207162322.20486-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
results in no audit messages at all if in permissive mode because the
cache is updated during the rcu walk and thus no denial occurs on
the subsequent ref walk.  Fix this by not updating the cache when
performing a non-blocking permission check.  This only affects search
and symlink read checks during rcu walk.

Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
Reported-by: BMK <bmktuwien@gmail.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 moves the test of AVC_NONBLOCKING inside of avc_update_node(),
adds a comment explaining the rationale, and updates some kerneldoc
comments. I still have some doubts however about the naming
(AVC_NONBLOCKING) since this isn't really about blocking AFAICT.

 security/selinux/avc.c         | 23 +++++++++++++++++++++--
 security/selinux/hooks.c       |  4 +++-
 security/selinux/include/avc.h |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 635e5c1e3e48..5de18a6d5c3f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -838,6 +838,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
  * @ssid,@tsid,@tclass : identifier of an AVC entry
  * @seqno : sequence number when decision was made
  * @xpd: extended_perms_decision to be added to the node
+ * @flags: the AVC_* flags, e.g. AVC_NONBLOCKING, AVC_EXTENDED_PERMS, or 0.
  *
  * if a valid AVC entry doesn't exist,this function returns -ENOENT.
  * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
@@ -856,6 +857,23 @@ static int avc_update_node(struct selinux_avc *avc,
 	struct hlist_head *head;
 	spinlock_t *lock;
 
+	/*
+	 * If we are in a non-blocking code path, e.g. VFS RCU walk,
+	 * then we must not add permissions to a cache entry
+	 * because we cannot safely audit the denial.  Otherwise,
+	 * during the subsequent blocking retry (e.g. VFS ref walk), we
+	 * will find the permissions already granted in the cache entry
+	 * and won't audit anything at all, leading to silent denials in
+	 * permissive mode that only appear when in enforcing mode.
+	 *
+	 * See the corresponding handling in slow_avc_audit(), and the
+	 * logic in selinux_inode_follow_link and selinux_inode_permission
+	 * for the VFS MAY_NOT_BLOCK flag, which is transliterated into
+	 * AVC_NONBLOCKING for avc_has_perm_noaudit().
+	 */
+	if (flags & AVC_NONBLOCKING)
+		return 0;
+
 	node = avc_alloc_node(avc);
 	if (!node) {
 		rc = -ENOMEM;
@@ -1115,7 +1133,7 @@ int avc_has_extended_perms(struct selinux_state *state,
  * @tsid: target security identifier
  * @tclass: target security class
  * @requested: requested permissions, interpreted based on @tclass
- * @flags:  AVC_STRICT or 0
+ * @flags:  AVC_STRICT, AVC_NONBLOCKING, or 0
  * @avd: access vector decisions
  *
  * Check the AVC to determine whether the @requested permissions are granted
@@ -1199,7 +1217,8 @@ int avc_has_perm_flags(struct selinux_state *state,
 	struct av_decision avd;
 	int rc, rc2;
 
-	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
+				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
 				  &avd);
 
 	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce012d9ec51..9b05f84808d9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3196,7 +3196,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 		return PTR_ERR(isec);
 
 	rc = avc_has_perm_noaudit(&selinux_state,
-				  sid, isec->sid, isec->sclass, perms, 0, &avd);
+				  sid, isec->sid, isec->sclass, perms,
+				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
+				  &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
 				     &denied);
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index ef899bcfd2cb..74ea50977c20 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -142,6 +142,7 @@ static inline int avc_audit(struct selinux_state *state,
 
 #define AVC_STRICT 1 /* Ignore permissive mode. */
 #define AVC_EXTENDED_PERMS 2	/* update extended permissions */
+#define AVC_NONBLOCKING    4	/* non blocking */
 int avc_has_perm_noaudit(struct selinux_state *state,
 			 u32 ssid, u32 tsid,
 			 u16 tclass, u32 requested,
-- 
2.19.2

