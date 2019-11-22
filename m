Return-Path: <SRS0=8Pnr=ZO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66345C432C3
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 21:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB8E20708
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 21:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jr3HHBA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfKVVRE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:17:04 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:14172 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVVRE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Nov 2019 16:17:04 -0500
X-EEMSG-check-017: 53812507|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,231,1571702400"; 
   d="scan'208";a="53812507"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Nov 2019 21:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574457422; x=1605993422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oad1WjFA63/XkAMbCIJbj21bvxVzz1ip2aCIOd6Stpo=;
  b=jr3HHBA5+L48BGk/hTsrS54vAViyZznCcS9lc86o7oxuvU+4Bi7vnqYZ
   TtWj2u5Su6eIoNv8rIoABL6VCawoUQDHYyiA8BXYCVEjGSMHd6V0dX+TO
   02QGRguZa3azhsKC4FhRgIV9lVe01v4cAkDKrSxgQK33kiKt5ec5XNspG
   wPP2Ahcjmw4YTtfoo9alv1eKpSaM2me2MW7RQaOWiWaezXxIi6tMntfYu
   i0WKxb+qGxS8X/pJqaukCTx5CqDpf8MBLgdFPzrVoxXQ+wKtwwXXW1H/I
   +XsYMZc1rReRWYU/BjH6vZry4wRI9FeQJXQSwW26Hn2pgv9wiUCYNpB6U
   A==;
X-IronPort-AV: E=Sophos;i="5.69,231,1571702400"; 
   d="scan'208";a="30429861"
IronPort-PHdr: =?us-ascii?q?9a23=3AwEJqaBxz2n14IPLXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+wSIJqq85mqBkHD//Il1AaPAdyArasZ16GP7/2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi2ogjdudQajIRiJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlSkINyQ98GrKlMJ+iqxVqw+lqxBmw4PZZISZOfxjda3fYNwaX3?=
 =?us-ascii?q?JMUMZPWSJcDI2ybIwBAOUOM+tDs4XwpEEDoQekCAWwGO/izCJDiH/s3a091u?=
 =?us-ascii?q?QsCRzI3BA+ENIWsHTbstP1P7oPX+Cw1qbIyTHDYO1W2Dzg74XIaQ0uoeqXUL?=
 =?us-ascii?q?Jsccve1UkvFwTfglWWsozqJSmZ1usKs2iF9udtU/+khWAgqwF0uDevx8Esh5?=
 =?us-ascii?q?HVhoMbzVDI7z55z5gpKt2lUk57YMKkEZtWuiqHNIV2WtsvT3xntSs10LELuY?=
 =?us-ascii?q?O3cDIUxJko2RLTceGLfo6V6Rz5TumROy13hHd9dbK6gBa97Favx/XnVsmxzF?=
 =?us-ascii?q?ZKti1FksTQtnwV1xzc9MyHSvxl80e9wzmPzQHT6vxfIUwulKrbLZAhwrkrlp?=
 =?us-ascii?q?UNrUvPBDP2mUXqg6+WcUUo4O6o5Pj8Yrr6vJOcMo50igXmPqQvnMywH/g4Px?=
 =?us-ascii?q?ATU2WU9umwzr3u8VDjTLlUgfA6jLPVvI3CKcQevKG5AgtV0og56xa4CjeryM?=
 =?us-ascii?q?8YkmQcLF9eZBKGj5TmO1HJIPziC/e/mE6jnC1kx/DBIL3tGo/NIWTbkLf9Yb?=
 =?us-ascii?q?Z97FZRyBIpwtBC45JZEakBL+juWk/1rdDYCxg5Mwuuw+n5EtlyyoQeWWeXCK?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUf48apjL9K/kj5/7zgn40gkEdfaa30psNcny4HeppI1?=
 =?us-ascii?q?+fYXXyhtcNC2AKvhAxTL+itFrXSjNXZnCvT4oi6TwhToGrF4HOQsaqmrPS8j?=
 =?us-ascii?q?28G8htem1eCl2KWUztfoGAVuZEPDmeOed9gzcEUv6nUIZn2haw4lypg4F7J/?=
 =?us-ascii?q?bZr3VL/ano08J4sqiOxBw=3D?=
X-IPAS-Result: =?us-ascii?q?A2DIAgDvTthd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?IFtIBIqjS2GVAaLHoofhyQJAQEBAQEBAQEBGxwBAYRAglA4EwIQAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFQ4I7KYMbCwFGgVGCYz+CUyWxEzOFToMxgUiBNoc9hHN4gQeEY?=
 =?us-ascii?q?YUShSEEjRJEiU90lheCNYI3kw0MG5oXAS2qOCKBWCsIAhgIIQ+DJ1ARFIZUF?=
 =?us-ascii?q?45BIwMwkUUBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Nov 2019 21:17:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAMLGtGV221782;
        Fri, 22 Nov 2019 16:16:57 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: clean up selinux_inode_permission MAY_NOT_BLOCK tests
Date:   Fri, 22 Nov 2019 16:16:56 -0500
Message-Id: <20191122211656.3647-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Through a somewhat convoluted series of changes, we have ended up
with multiple unnecessary occurrences of (flags & MAY_NOT_BLOCK)
tests in selinux_inode_permission().  Clean it up and simplify.
No functional change.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
This patch is relative to the two patches I posted earlier today for
MAY_NOT_BLOCK / ref-walk handling.  Just a cleanup of something I
noticed while doing those two.

 security/selinux/hooks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fd34e25c016f..19591c825f5d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3037,7 +3037,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	const struct cred *cred = current_cred();
 	u32 perms;
 	bool from_access;
-	unsigned flags = mask & MAY_NOT_BLOCK;
+	bool no_block = mask & MAY_NOT_BLOCK;
 	struct inode_security_struct *isec;
 	u32 sid;
 	struct av_decision avd;
@@ -3059,13 +3059,13 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	sid = cred_sid(cred);
-	isec = inode_security_rcu(inode, flags & MAY_NOT_BLOCK);
+	isec = inode_security_rcu(inode, no_block);
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
 	rc = avc_has_perm_noaudit(&selinux_state,
 				  sid, isec->sid, isec->sclass, perms,
-				  (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
+				  no_block ? AVC_NONBLOCKING : 0,
 				  &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
@@ -3074,7 +3074,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 		return rc;
 
 	/* fall back to ref-walk if we have to generate audit */
-	if (flags & MAY_NOT_BLOCK)
+	if (no_block)
 		return -ECHILD;
 
 	rc2 = audit_inode_permission(inode, perms, audited, denied, rc);
-- 
2.23.0

