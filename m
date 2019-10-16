Return-Path: <SRS0=72Nf=YJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B6FA372A
	for <selinux@archiver.kernel.org>; Wed, 16 Oct 2019 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A63F218DE
	for <selinux@archiver.kernel.org>; Wed, 16 Oct 2019 18:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ijqJgXv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390931AbfJPS21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:28:27 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:24275 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfJPS20 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Oct 2019 14:28:26 -0400
X-EEMSG-check-017: 37591962|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,304,1566864000"; 
   d="scan'208";a="37591962"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Oct 2019 18:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571250500; x=1602786500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RYGBe/KCV8I1HyOnUw+tkuNq5yqaXVie6V6ltP1jtm8=;
  b=ijqJgXv0/Y6GGj38Jcf2Uw+DuHhTFXOlUfP4B3JXiEJeV6xO7tBUJX9k
   p5fv6BaFZ9MhMxdPdlz53ucI4yDqCWlwDcAlZ33r8euTEz6chVUDNwA2e
   jChkxRdjmZrd2z6z4JXvEHjE7xOJ06I3KcoJyB0iHS0vKNvFumg/MmuEx
   NKAIe5+t7zRvEo9+gBgIn+4sLZdjjKmdqXZllkxhDIGXZw7TTVWWuTIWx
   iTAQgIxDsqzmYofDq2zHflvCoHRTCHBpvMVGuebFQ+HTFygkm1mLLfLru
   6Nc/f148o+mNSO/n+h19TF1PZ4DstRmkxl6Wo6gpU/FU9VJ/drlfetbHd
   A==;
X-IronPort-AV: E=Sophos;i="5.67,304,1566864000"; 
   d="scan'208";a="29056212"
IronPort-PHdr: =?us-ascii?q?9a23=3Azyr+cRFOKCeG+bLL/k2HK51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zp8+wAkXT6L1XgUPTWs2DsrQY0rGQ7P2rADZZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrwjctsYajZZ8Jqos1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMODAj8GHTl8d+kqRVrhy8rBB72oLZYIWYOP94c6jAf90VWH?=
 =?us-ascii?q?BBU95RWSJfH42yYYgBAe0OMuhXtITxu1gDoAGiCQS2GO/j1jlFjWL2060g1O?=
 =?us-ascii?q?QhFBnL0hE8H90QqHTUrMv6NKEPWu6oyanH1zHDb/dI1jb99YPFdQshruyXXb?=
 =?us-ascii?q?9rbcrQyVUgFwPCjlmKr4zlJCma2v4Cs2ic8eptTOSigHMkpQFpujWj28ghh4?=
 =?us-ascii?q?bTio8V11zI7zt1zYkrKdGiVUJ2Z8OvHoFKuCGALYR2R9svQ2RvuCkn1LILoY?=
 =?us-ascii?q?W7fC0WyJQ/wB7fduCHf5CI4h39UOaRJi91hG5/d7Klhhay7FOgxvfgVsi0zF?=
 =?us-ascii?q?lKri1FnsPKtn8RzBzc9tKLSv58/kelwTqP1gbT5f9YIU0siKbWJJEszqQwm5?=
 =?us-ascii?q?YOq0jPACD7lFvsgKOLbkkk//Kn6+XjYrXovJ+cMIp0hxnlMqszgcyyGvg4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj/VbjT7lQgf02lbfZvIjAJcsHvq65HxNV0oE75hanFTimzd?=
 =?us-ascii?q?AYkGIfLF1fZRKHi5HlO1TJIPD/F/ewnU6gnytsx/DDJrfhGInCLmDfkLf9er?=
 =?us-ascii?q?Zw81VcxxQ3zdBe4ZJUF74ALentWk/+qtPYFAU1Mw+qzOb9DtVyyIceVXiIAq?=
 =?us-ascii?q?+DP6OB+WOPs/kiJ+iKeZ89pjnwMb4m6uTogHt/nkUSLoez2p5CU2y1BvRrJQ?=
 =?us-ascii?q?2iZHPohtoQWTMRshEWUP3hiFrEVyVaIXm1QfRvtXkAFIu6ANKbFciWi7ub0X?=
 =?us-ascii?q?L+Q8xb?=
X-IPAS-Result: =?us-ascii?q?A2AgCACwTqdd/wHyM5BmHgELHINvLIFAMiqTWgEBAQEBA?=
 =?us-ascii?q?QaLLpEvCQEBAQEBAQEBARsZAQIBAYRAgn0kOBMCDAEBAQQBAQEBAQUDAQFsh?=
 =?us-ascii?q?TmCOimDFgsBRoFRgmM/glMlr2wzhU2DMYFIgTSHNYRZGHiBB4RhhA2BBIUfB?=
 =?us-ascii?q?K1NgiyCMZJeDBuZQql9IoFYKwgCGAghD4MnUBAUkDIlAzCBBgEBjWyCVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Oct 2019 18:28:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9GISJu2007494;
        Wed, 16 Oct 2019 14:28:19 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 11/10] selinux: fix support multiple selinuxfs instances
Date:   Wed, 16 Oct 2019 14:28:15 -0400
Message-Id: <20191016182815.3188-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When I rebased the "selinux: support multiple selinuxfs instances"
patch, I misunderstood the vfs get_tree_keyed() interface and thought
it eliminated the need for our own custom get_tree() implementation.
However, it turns out that we cannot use get_tree_keyed() because we
are already using sb->s_fs_info to store per-instance data and
get_tree_keyed() uses it for the key.  The resulting behavior was
that a unique superblock was being created for every selinuxfs mount,
even within the same selinux namespace, which is not desirable.
Restore the old logic adapted for the relevant vfs changes.

This should likely be squashed into the original commit before final
upstreaming.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/selinuxfs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 1ba4d874fc86..6bb0c1611e6f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2102,9 +2102,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	return ret;
 }
 
+static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
+{
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
+	return (current_selinux_ns == fsi->ns);
+}
+
 static int sel_get_tree(struct fs_context *fc)
 {
-	return get_tree_keyed(fc, sel_fill_super, current_selinux_ns);
+	struct super_block *sb;
+	int err;
+
+	sb = sget_fc(fc, selinuxfs_compare, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		err = sel_fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	fc->root = dget(sb->s_root);
+	return 0;
 }
 
 static const struct fs_context_operations sel_context_ops = {
-- 
2.21.0

