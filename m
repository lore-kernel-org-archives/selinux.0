Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DB7C67839
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4A20849
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 15:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A4A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeLLPI6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:08:58 -0500
Received: from uhil19pa13.eemsg.mail.mil ([214.24.21.86]:4125 "EHLO
        uhil19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeLLPI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Dec 2018 10:08:58 -0500
X-EEMSG-check-008: 352552710|UHIL19PA13_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2018 15:08:31 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539648000"; 
   d="scan'208";a="18643991"
IronPort-PHdr: =?us-ascii?q?9a23=3AP7tBahKrW0JGkRxihdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfIvnxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9Qr4uWT?=
 =?us-ascii?q?Sm8qxlVhnmhikaPDI96W3blNB8gKddrRm8pRJw3pTUbZmVOvRgY63Tc9AUS2?=
 =?us-ascii?q?1DUcZfWCNPDZixY5cMAucbIepVtZXxq0cIoBCjBQesHuTvyjpQi3Hrwa01zf?=
 =?us-ascii?q?whEQHY0wwmAtkArXHUo8/xNKcWT++0zLTDwDLYb/xLwjfw85TIcxA9rvGMWr?=
 =?us-ascii?q?J8a8zRyVI1GA/fgVWQrpLlMiqT2+8QsGab9/JtWf+ghmMosQ18oiWjyt0yho?=
 =?us-ascii?q?TGmI4Z0E3I+CNky4gvP9K4UlR0Ydu8HZtVsCGVKpV5T9s5Q2FtpCY60roGuY?=
 =?us-ascii?q?OnfCQSyJQo2Rrfa/uffoiU+B3jTueRISpjhH5/ZLK+hwq98UinyuHmUMm7zE?=
 =?us-ascii?q?1KoTZfntnJt3AN0wTf6smBSvRj4keswSuD2g/c5+1eIU04iLDXJ4Auz7IujJ?=
 =?us-ascii?q?YfrFzPHirsl0X3iK+WeF8k+u+t6+n/ebXpu4ScOpRoigD+Lqsumsu/Df4+Mg?=
 =?us-ascii?q?gVRWeX4+u81Lr9/UHhWrVFkuU2krXFsJDdPckbuK+5AxVS0os46hewETGm0N?=
 =?us-ascii?q?UGnXUdKFJFeRSHj5XmOl3UJ/D4F/i/j06xkDdo3/rGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?J9609ayAouwtFT/pxUCqocL/3tRE/+qtjYAwQnMwy73ennEs9x1oAAVmKVBK?=
 =?us-ascii?q?+WLqfSvUWP5uI1LOmGfJUVtyrlK/g5+/7uimc0lkQYfamqwZsXdX65HvV4LE?=
 =?us-ascii?q?WfenfsjdIBHn0Lvgo6VuDllFqCUTtLbXaoQ608/i07CJ6hDYrbXoCimqGB3C?=
 =?us-ascii?q?OgE51OfG9GF1SMHW7td4WDXPcMcjydLtV9nTwDULirU5Uh2g22tA/m17pnKf?=
 =?us-ascii?q?LZ+jYGupLn1dh14fDTlB4p+DxqAMSSzXuNQ3t3nmwWXT822r5woUhnxleEy6?=
 =?us-ascii?q?h4jK8QKdsG/P5NUwEnJbbCwOFgTdP/QATMepGOUln1bM+hBGQKUt8pw9IIK3?=
 =?us-ascii?q?14EtGmgwGLizGmGJcJhreLA9oy6aua0H/vcZUug03a3bUs2gF1CvBEMner0+?=
 =?us-ascii?q?slrwU=3D?=
X-IPAS-Result: =?us-ascii?q?A2AlAQA1IxFc/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopgWgnmCZMAQEBAQEBBopWkCwgGAGEQAKCfCI3Bg0BAwEBAQEBAQIBbCiCN?=
 =?us-ascii?q?iSCYwYnCwFGEFFXGYJiP4F1DaZnM4ovh32EPxd4gQeOfwKJPYcGkEkJkUwLG?=
 =?us-ascii?q?JFGLJpvIoFWKwgCGAghD4MngicXjjshAzCBBQEBjHwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Dec 2018 15:08:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBCF8Q19028167;
        Wed, 12 Dec 2018 10:08:30 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bmktuwien@gmail.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link
Date:   Wed, 12 Dec 2018 10:10:56 -0500
Message-Id: <20181212151056.2938-2-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212151056.2938-1-sds@tycho.nsa.gov>
References: <20181212151056.2938-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit bda0be7ad9948 ("security: make inode_follow_link RCU-walk aware")
switched selinux_inode_follow_link() to use avc_has_perm_flags() and
pass down the MAY_NOT_BLOCK flag if called during RCU walk.  However,
the only test of MAY_NOT_BLOCK occurs during slow_avc_audit()
and only if passing an inode as audit data (LSM_AUDIT_DATA_INODE).  Since
selinux_inode_follow_link() passes a dentry directly, passing MAY_NOT_BLOCK
here serves no purpose.  Switch selinux_inode_follow_link() to use
avc_has_perm() and drop avc_has_perm_flags() since there are no other
users.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c         | 24 ++----------------------
 security/selinux/hooks.c       |  5 ++---
 security/selinux/include/avc.h |  5 -----
 3 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 5de18a6d5c3f..9b63d8ee1687 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -867,9 +867,8 @@ static int avc_update_node(struct selinux_avc *avc,
 	 * permissive mode that only appear when in enforcing mode.
 	 *
 	 * See the corresponding handling in slow_avc_audit(), and the
-	 * logic in selinux_inode_follow_link and selinux_inode_permission
-	 * for the VFS MAY_NOT_BLOCK flag, which is transliterated into
-	 * AVC_NONBLOCKING for avc_has_perm_noaudit().
+	 * logic in selinux_inode_permission for the MAY_NOT_BLOCK flag,
+	 * which is transliterated into AVC_NONBLOCKING.
 	 */
 	if (flags & AVC_NONBLOCKING)
 		return 0;
@@ -1209,25 +1208,6 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 	return rc;
 }
 
-int avc_has_perm_flags(struct selinux_state *state,
-		       u32 ssid, u32 tsid, u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata,
-		       int flags)
-{
-	struct av_decision avd;
-	int rc, rc2;
-
-	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
-				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
-				  &avd);
-
-	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
-			auditdata, flags);
-	if (rc2)
-		return rc2;
-	return rc;
-}
-
 u32 avc_policy_seqno(struct selinux_state *state)
 {
 	return state->avc->avc_cache.latest_notif;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9b05f84808d9..f012d2eb159e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3139,9 +3139,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm_flags(&selinux_state,
-				  sid, isec->sid, isec->sclass, FILE__READ, &ad,
-				  rcu ? MAY_NOT_BLOCK : 0);
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, isec->sclass, FILE__READ, &ad);
 }
 
 static noinline int audit_inode_permission(struct inode *inode,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 74ea50977c20..7be0e1e90e8b 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -153,11 +153,6 @@ int avc_has_perm(struct selinux_state *state,
 		 u32 ssid, u32 tsid,
 		 u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
-int avc_has_perm_flags(struct selinux_state *state,
-		       u32 ssid, u32 tsid,
-		       u16 tclass, u32 requested,
-		       struct common_audit_data *auditdata,
-		       int flags);
 
 int avc_has_extended_perms(struct selinux_state *state,
 			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
-- 
2.19.2

