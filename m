Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D6C43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE821B68
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="KTpqH93i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395544AbfBNTOt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:14:49 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:62844 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388100AbfBNTOt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 14:14:49 -0500
X-EEMSG-check-017: 234382616|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 19:14:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550171663; x=1581707663;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pU7rrdwKZHyS2DNwgI6EswakgsYcNoutyQBg8XFVYHo=;
  b=KTpqH93iZ8h1sF2XbsWyCV9EAxOlCwiq/3sIs4ut98ItYLNwGvp4zQ4U
   9GUEzQqFXn0CZ+vDWir7JVQm9AnBVQJSr7UN3hLEX1hpuh8ETMbR1gBiq
   02hQXFrbSe7+YOW7RCO/BqF5/lbWLflCXCw05v0+bQA/9isrCZG63ADC4
   ZO7X/k8kQqLKINEtEZcv6Jn3GCrp9QctL10/eI/NeQGipm5WpPiUHrwav
   cR3U87zhFn123IBSKYVkrdgeEZBkWkgp6azyhxZAZaVpxHa9KJNO6ucVV
   vkr91SnGxQIwnnVPpNiCpjM+TrlBY8iha9NMCAdzij0wx3DpO9iZpSiTo
   w==;
X-IronPort-AV: E=Sophos;i="5.58,369,1544486400"; 
   d="scan'208";a="20567574"
IronPort-PHdr: =?us-ascii?q?9a23=3ANNUU5BM5svUDlSAFeHAl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfT8rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr86Qz?=
 =?us-ascii?q?Si67pgRgHuhikJKjU19HjbhtJsgK5eph+quh5xzJPOYIyNNPRwYL7Tc90ZS2?=
 =?us-ascii?q?RGUclfWDdMDp+/YoYVE+YMJ/pUo5X7qlATrRW+Hw6sBOb3xzFVmn/5w7U60+?=
 =?us-ascii?q?Q/HgHAwQcuAtcOv27QrNXxKqgTUf2+wa7TzTredPNbwiv96YjUfRAhpvGAR7?=
 =?us-ascii?q?RwcdHLxkU1GAPFiUuQpJXjMjiI1eoNq3CW4/dvWO+gkWIqqxx9riKxysojlI?=
 =?us-ascii?q?XFnJ8Zx1bZ/itj2ok1P8e3SEtjbN6hF5tfqj+VOpNtQsMnX2FooCE6yqAauZ?=
 =?us-ascii?q?KjfCgF1pAnxxnHZvybaYeI+BPjVPuKITtimHJkeK6whxa18US6zO3zStK030?=
 =?us-ascii?q?pQoipAk9nMsmgB1x3V6seZVvtw5lqt1DmA2gzJ6uxIPFo4mbTUJpI/2LI8i4?=
 =?us-ascii?q?IfsUHZES/3nEX2grWWdkIh+uWw8OTof67mq4SAN450lg7+MqMulta5AeQjKA?=
 =?us-ascii?q?cCRWeb+eOi1LH75032XK1KjuEqkqneqJ3aPtoUpqq4Aw9Tz4Yi5A2yDymp0N?=
 =?us-ascii?q?sGh3kLNlFFdwydj4jvJV7OJOr0DfClg1SjiD1r3ezJPqX9ApXRKXjOiK/hcq?=
 =?us-ascii?q?xg605Y0wcz1cpQ549QCr0YJfLzXUjxtMbGARMjLwO0xOPnW51B0dYGUH+LKr?=
 =?us-ascii?q?eQLaeXtFiP/O9pKO6JN6EPvzOoEOQo//7jizcCnFYZeaS4lc8MZGuQAuVtI0?=
 =?us-ascii?q?LfZ2HlxNgGDzFZ7UIFUOX2hQjaAnZobHGoUvd5vGk2?=
X-IPAS-Result: =?us-ascii?q?A2A4AAATvWVc/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VkpgWonjCCLcU0BAQEBAQaKbY5bgXsgGAGEQINlIjQJDQEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II6KYMVCwFGgVGCYz2BZg2sADOFRIR0iAOEQRd4gQePBAKQQIEGkWgJkkgMG?=
 =?us-ascii?q?ZJyAZ4YOIFWKwgCGAghD4MngigXjjwhAzCBBQEBj1UBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2019 19:14:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1EJELmG025526;
        Thu, 14 Feb 2019 14:14:22 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] scripts/selinux: add basic mls support to mdp
Date:   Thu, 14 Feb 2019 14:14:17 -0500
Message-Id: <20190214191417.1469-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add basic MLS support to mdp.  Usage:
scripts/selinux/mdp/mdp -m policy.conf file_contexts
checkpolicy -M -o policy policy.conf

Then install the resulting policy and file_contexts as usual.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 28 deletions(-)

diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 073fe7537f6c..4672ee5cc1bd 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -97,8 +97,19 @@ int main(int argc, char *argv[])
 
 	/* NOW PRINT OUT MLS STUFF */
 	if (mls) {
-		printf("MLS not yet implemented\n");
-		exit(1);
+		fprintf(fout, "sensitivity s0;\n");
+		fprintf(fout, "dominance { s0 }\n");
+		fprintf(fout, "category c0;\n");
+		fprintf(fout, "category c1;\n");
+		fprintf(fout, "level s0:c0.c1;\n\n");
+		for (i = 0; secclass_map[i].name; i++) {
+			struct security_class_mapping *map = &secclass_map[i];
+
+			fprintf(fout, "mlsconstrain %s {\n", map->name);
+			for (j = 0; map->perms[j]; j++)
+				fprintf(fout, "\t%s\n", map->perms[j]);
+			fprintf(fout, "} (l1 eq l2 and h1 eq h2);\n\n");
+		}
 	}
 
 	/* types, roles, and allows */
@@ -108,34 +119,92 @@ int main(int argc, char *argv[])
 	for (i = 0; secclass_map[i].name; i++)
 		fprintf(fout, "allow base_t base_t:%s *;\n",
 			secclass_map[i].name);
-	fprintf(fout, "user user_u roles { base_r };\n");
-	fprintf(fout, "\n");
+	fprintf(fout, "user user_u roles { base_r }");
+	if (mls)
+		fprintf(fout, " level s0 range s0 - s0:c0.c1");
+	fprintf(fout, ";\n");
 
 	/* default sids */
-	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
+	for (i = 1; i < initial_sid_to_string_len; i++) {
+		fprintf(fout, "sid %s user_u:base_r:base_t",
+			initial_sid_to_string[i]);
+		if (mls)
+			fprintf(fout, ":s0");
+		fprintf(fout, "\n");
+	}
 	fprintf(fout, "\n");
 
-	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
-
-	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
-
-	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
-
-	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
+	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+
+	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+
+	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, ";\n");
+
+	fprintf(fout, "genfscon proc / user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, "\n");
 
 	fclose(fout);
 
@@ -144,8 +213,14 @@ int main(int argc, char *argv[])
 		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
 		usage(argv[0]);
 	}
-	fprintf(fout, "/ user_u:base_r:base_t\n");
-	fprintf(fout, "/.* user_u:base_r:base_t\n");
+	fprintf(fout, "/ user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, "\n");
+	fprintf(fout, "/.* user_u:base_r:base_t");
+	if (mls)
+		fprintf(fout, ":s0");
+	fprintf(fout, "\n");
 	fclose(fout);
 
 	return 0;
-- 
2.20.1

