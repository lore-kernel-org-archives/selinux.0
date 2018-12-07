Return-Path: <SRS0=Nhvc=OQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC2C64EB1
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7D020868
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 16:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7D020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGQUw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:20:52 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:57681 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLGQUw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Dec 2018 11:20:52 -0500
X-EEMSG-check-008: 656454074|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="656454074"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Dec 2018 16:20:51 +0000
X-IronPort-AV: E=Sophos;i="5.56,326,1539648000"; 
   d="scan'208";a="21443159"
IronPort-PHdr: =?us-ascii?q?9a23=3AAS2RWBRuMKhsO0bB7cH6enafCdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYB2N2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4KlxSB/slSwJKTg3/m/KgcB0la5Xvg6tqxl5zoXJYo+aKeB+c7vdc90EWG?=
 =?us-ascii?q?RPUMVfWStDDYOyYIQBAPEMMfpbooTnu1cDtweyCRWqCejyyjFInHj23agi3u?=
 =?us-ascii?q?o8DQHJwhQgH9IQv3TSsd77KaISXvqxzKnM0zrCb+5d1DDm6IfVaRAsuu2MXL?=
 =?us-ascii?q?JsfsrRzkkjDQXFjk6KpoD/MDOV0foNvnGd4uF9Vuyvk3Yqpxx+rzWg3Mship?=
 =?us-ascii?q?TFipgLxl3L6yl12ps5KNulQ0Bhe9GkCoFftySCOotzRcMtXn9ntT4hyr0DpZ?=
 =?us-ascii?q?67ZC8KyIk7xxLHa/yIbYyI4hX7WeaNOzh4nnNleK+khxqo7UihyvHzVsmz0F?=
 =?us-ascii?q?pQqCpKjsLMuWwX2xzW68iHTuNx/kan2TmRywDe8vxILE87mKbBK5Mt36Q8mo?=
 =?us-ascii?q?QcvEjdBCP6hV36jKqMeUUl/uio5f7nYrLjppKELI97lxr+P78yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eSnzrLv50L5QLJUjvEuiKnWrIjaJdgHpq6+GwJayYMj6xWjDze73t?=
 =?us-ascii?q?UYnGcILFRedRKIiojmIVDOIPTiAfijhFSslS9hx+raMb35HpXNMn/Dna/5fb?=
 =?us-ascii?q?ln9k5czBE+zchF6JJJDrENOffzWkj2tNzCEBA1KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/fwgI+2NZI8TpTb8JOMo5+DhjXAng18RZ6qp0oUNaHC+APtmJ1?=
 =?us-ascii?q?+VYX32gtcOQi82uV8lQejrjkCSeSBcamz0XK8m4Dw/ToW8AtTtXIeo1Yed0T?=
 =?us-ascii?q?+7E5seXWVPDlSBAD+8bImfc+sdYyKVZMl6m3oLUqb3GNxp7g2nqAKvk+kvFe?=
 =?us-ascii?q?HT4CBN8Mi72Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AlAAD6nApc/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopgTUzJ4wTjBFNAQEBAQEGilWOL4F6IBgBhEACgxsiNAkNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkgmMGJwsBRhBRVxmCYj+BdQ2mVzOFQIRsh3OELxd4gQeOfwKJN4cAk?=
 =?us-ascii?q?DAJkUALGJE4LJo1OIFVKwgCGAghD4MngicXEo4pIQMwgQUBAYplAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Dec 2018 16:20:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB7GKmjd002344;
        Fri, 7 Dec 2018 11:20:51 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bmktuwien@gmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH v2 2/2] selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link
Date:   Fri,  7 Dec 2018 11:23:22 -0500
Message-Id: <20181207162322.20486-2-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207162322.20486-1-sds@tycho.nsa.gov>
References: <20181207162322.20486-1-sds@tycho.nsa.gov>
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
This patch should wait on confirmation from the vfs folks that we really
only need to return ECHILD in the LSM_AUDIT_DATA_INODE case and not the
LSM_AUDIT_DATA_DENTRY case.

 security/selinux/avc.c         | 19 -------------------
 security/selinux/hooks.c       |  5 ++---
 security/selinux/include/avc.h |  5 -----
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 5de18a6d5c3f..a89b306d8069 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1209,25 +1209,6 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
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

