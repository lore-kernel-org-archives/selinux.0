Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEDEC04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D9D2081C
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D9D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeLDUjf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:39:35 -0500
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:37732 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLDUjf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 15:39:35 -0500
X-EEMSG-check-008: 799673733|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="799673733"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 20:39:33 +0000
X-IronPort-AV: E=Sophos;i="5.56,315,1539648000"; 
   d="scan'208";a="18422573"
IronPort-PHdr: =?us-ascii?q?9a23=3AY6nnPhEynm8EK1/QyYPrnp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zo8mwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B8kr5XrBenqhdiwYDbfZuVOeJ+cK3DYN0US2?=
 =?us-ascii?q?lPUMFeWCJOGY6wc4gCAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiGLq3aIky+?=
 =?us-ascii?q?QhER/J3Ao9FNwTtXTbttH1NKMMXuG10aLFyi7DYO5N2Trm9IjJcgwuofGLXb?=
 =?us-ascii?q?5qd8rR0lMgGxnKjlWXt4zoJjWY3fkOvWiD9+dsSO2ihmE9pwxxvzSj3Nkgh4?=
 =?us-ascii?q?bXio4P11zJ8zhyzpwvKt2iUkF7ZMapEJ5Xty6HKYR7WtgiQ2R0uCYizb0GpI?=
 =?us-ascii?q?K7cDAKyJs5wx7fbOSKc5SS7RL5VeaRPCx4iGh5eLO/mxmy8U+gxvf6Vsaoy1?=
 =?us-ascii?q?ZFsjBJktzNtnAJzxDT686HReVh/kq5xDqC2A/e5vtELEwpj6bXNZEszqAqmp?=
 =?us-ascii?q?YOqUjDGzX5mETyjK+YbEUk/e2o5vz8Yrr7vZ+RLJN0iwHiPaQuncyzG+I4Mh?=
 =?us-ascii?q?MUUGSB9uS806Pj8VXjQLpWlv02jrXZsJfCKMsAo665ABNV0pst6ha+ETim1s?=
 =?us-ascii?q?8VnXYCLF1feRKHi5LlNE3JIPD9Ff2/mUijkC93x/DaOb3sGo3NIWLekLflZr?=
 =?us-ascii?q?t981RTyBc3zdxG4pJUDbYBIOjtVUPrqNPYCRo5ORSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?+CLqzStV6I5uQyI+iDf4IVpjn9JOY/5/L0jn82h0Udfa+30psTcny4Ge5mI0?=
 =?us-ascii?q?rKKUbr18wMFWYMoxoWUuPnkhuBXCRVanL0WLgztR8hD4fzNpvOXoCghvS62S?=
 =?us-ascii?q?6/GpBHLjRdBkukDWbjd4LCXewFLi2VPJkywXQ/SbG9Rtp5hlmVvwjgxu8idL?=
 =?us-ascii?q?LZ?=
X-IPAS-Result: =?us-ascii?q?A2BeAACO5AZc/wHyM5BkHQEBBQEHBQGBUQgBCwGBWimBN?=
 =?us-ascii?q?TMnjBKMDlIGikYOjiqBeiAYAYRAgwwiNAkNAQMBAQEBAQECAWwogjYkgxALA?=
 =?us-ascii?q?UaBAk+CYj+BagMIDaYRM4VAgkcNghyHb4QvF3iBB4ERhWmCd4UOAokND4cTU?=
 =?us-ascii?q?I8cLgmOE4MjCxiBW4g2hxQBigmEcYtDOIFVKwgCGAghD4MngicXjjshAzCBB?=
 =?us-ascii?q?QEBimEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2018 20:39:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4KdWgi006307;
        Tue, 4 Dec 2018 15:39:32 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bmktuwien@gmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC][PATCH] selinux: avoid silent denials in permissive mode under RCU walk
Date:   Tue,  4 Dec 2018 15:42:09 -0500
Message-Id: <20181204204209.21542-1-sds@tycho.nsa.gov>
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
 security/selinux/avc.c         | 9 ++++++---
 security/selinux/hooks.c       | 4 +++-
 security/selinux/include/avc.h | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 635e5c1e3e48..f0e7bc0dc442 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct selinux_state *state,
 	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
 		return -EACCES;
 
-	avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
-			xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
+	if (!(flags & AVC_NONBLOCKING))
+		avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested,
+				driver, xperm, ssid, tsid, tclass, avd->seqno,
+				NULL, flags);
 	return 0;
 }
 
@@ -1199,7 +1201,8 @@ int avc_has_perm_flags(struct selinux_state *state,
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

