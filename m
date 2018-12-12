Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4032FC65BAF
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 15:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466820849
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 15:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbeLLPIz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:08:55 -0500
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:4125 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeLLPIz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Dec 2018 10:08:55 -0500
X-EEMSG-check-008: 352552705|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2018 15:08:30 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539648000"; 
   d="scan'208";a="18643990"
IronPort-PHdr: =?us-ascii?q?9a23=3AUiu/4xRO06p7b3Hg3iN8kiCXi9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zbBWN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4KlxSB/slSwJKTg3/m/KgcB0la5Xvg6tqxl5zoXJYo+aKeB+c7vdc90EWG?=
 =?us-ascii?q?RPUMVfWStODY2zdIYDE+kMMPxEo4Tnu1cCsR2zDhSsCuP1zT9Ig2f707Am0+?=
 =?us-ascii?q?s/CQHG3BIvH9QTu3rJqdX6LqMSUeSrw6jI0D7OaOhW1irm6IXTbhAgoe2DXb?=
 =?us-ascii?q?J3ccbLz0kvDBnKgk+fqYziITOYz+IAuHWY4ep4Te+jlmEqpg5rrjWv28sgkJ?=
 =?us-ascii?q?fFi40Lxlze6Cl0xps+K8eiR05he9GkFYNdtySdN4RrXMwvW3pouCMmyr0evp?=
 =?us-ascii?q?67YTQKxIwnxxHBb/yHdJCF4g75W+aLIDd4mWlldKijhxey7Uegyur8WtOy0F?=
 =?us-ascii?q?lWtSpKjsPAtnUM1xzX8sSHS/198Vm92TuXygze5e5JLVo0mKbGMZIt3LE9mo?=
 =?us-ascii?q?QJvUjeBiP2nV/5jK6SdkUq4Oio7OHnb639ppCBLI95kR3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OX3OB9uim273j+lP5TK1QjvIqiqnZrIzaJcMDq66nAg9VyIEj5g2+Dji41t?=
 =?us-ascii?q?QYnGcHIEhBeBKGiYjpJl7PLOr/DfeljFSgiiprx/PeNL37HprNNmTDkKvmfb?=
 =?us-ascii?q?tl705cyQwzzc1Q5p5NBLEBO+/8VVHvtNPGCh80KBK0w+n5B9VnzI8eWnyAAr?=
 =?us-ascii?q?WfMKzMtV+E/OUvI/ODZIUNojbyN+Al5+LyjX8+gVISZqyp3ZgLaHClEPVmIl?=
 =?us-ascii?q?uWYXz3j9cOFGcFpAs+TOjwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5i1gLObwS?=
 =?us-ascii?q?e7GoZbZnhcBVCRFXfkboCEW/ALaCKIPMBtiCALVb+kS4U5zxGhqBf6y6Z7Lu?=
 =?us-ascii?q?rT4iAYrozs1Nx05+3ViBEz+id5D9qS026TVWF4hGAISCEs3KB5v0N9zk2P0a?=
 =?us-ascii?q?9ig/xXRpRv4KZSXwM7M4PM5/J1Bsq0WQ/beNqNDlG8TYaIGzY0G+ktzscObk?=
 =?us-ascii?q?A1INCrihTOzmL+GLMOv6CaD5wztKTH1j7+INgrmCWO77Uok1RzGpgHDmahnK?=
 =?us-ascii?q?MqslKLCg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CrAQA1IxFc/wHyM5BkHQEBBQEHBQGBVAUBCwGBWimBa?=
 =?us-ascii?q?CeYJkwBAQEBAQEGgjGIFw6QLCAYAYRAgn4iNwYNAQMBAQEBAQECAWwogjYkg?=
 =?us-ascii?q?xALAUaBAk+CVgw/gWoDCA2mZzOIBg2CHId9VYNqF3iBB4ERgl2DDIgFAokZD?=
 =?us-ascii?q?4cbUY9KLgmOJ4MlCxiBXIhDhyeKLoR/i24igVYrCAIYCCEPgyeCJxeOOyEDM?=
 =?us-ascii?q?IEFAQGMfAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Dec 2018 15:08:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBCF8Q18028167;
        Wed, 12 Dec 2018 10:08:28 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bmktuwien@gmail.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: avoid silent denials in permissive mode under RCU walk
Date:   Wed, 12 Dec 2018 10:10:55 -0500
Message-Id: <20181212151056.2938-1-sds@tycho.nsa.gov>
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

