Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D1C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D65B217D7
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 15:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="H1U3rkeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfEXP6E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 11:58:04 -0400
Received: from usfb19pa11.eemsg.mail.mil ([214.24.26.82]:21895 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389385AbfEXP6D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 11:58:03 -0400
X-EEMSG-check-017: 143629588|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 15:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558713475; x=1590249475;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=du7yCsmG6yBpy4cAPemwW9NNVItcxqSr7Y9Ku7b2YBo=;
  b=H1U3rkeAqGjaDF9bAZ0VFMvTFVgyCTGQX1dOGgd49UeOorCk2JDfD2lz
   utyziKy4uQHxfrkm/F5M+aMW21HM9zT61k1fdpjvpY6pPc07pxDV1dcbX
   R1cSqEFrVOiScYBJVFEYSC6FC73JY3pRsIGha7pGO6KCouD2PlO+nCkUj
   3gLt4pY2tib+Q6hhsrs1LLb9utnIhmI6N2F+QSVFCU5T7ujiq+AVn22G+
   Og0Lvt2xvT5HL6hPzsTE/AmCY2awEERXPp5Qfq97nqfgNsxC57pXwpJgE
   jiq5+drqyYosttu1VxyroBSIqdOGF67gLNqFGZPW42DSOzw4ygViOExQH
   w==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="24074576"
IronPort-PHdr: =?us-ascii?q?9a23=3AjnqV7hUMQtZT01UUa5lPaTh+K+nV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxKHt8tkgFKBZ4jH8fUM07OQ7/m5HzVZv93Q7jgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrsAndrNQajZZjJ6o+zh?=
 =?us-ascii?q?bEo2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfp6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZAo2ycZYBAeQCM+hfoIbzqEADoQe9CAS2GO/i0CNEimPw0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4EtwKqnvUqcv6NLwPWu2r1qbI1ynDYO1M2Tzg74XIcB4gru2WUr?=
 =?us-ascii?q?Jqbcrd11IiFx/Fj1qMqYzlOCmZ1uIWs2eB9eZgWuWvi3A+pgx3vzOhxd8sh5?=
 =?us-ascii?q?HUio8axV3I7yV0zJsvKdGmR0N3f8SoHIZWuiqHLYV5WNkiTHttuCsiz70Gvo?=
 =?us-ascii?q?O0czYSxZQ8wh7fd+SHc4+V4hL/TOqRISl3hHZieL+nmxa961KgyuzhVsmvyl?=
 =?us-ascii?q?pKsipEncXMtnAKzRDT7NSISuBh8Uu73DaP1gTT5vlFIUAyi6XbN4YszqM/m5?=
 =?us-ascii?q?ccq0jOHjL6lF/ogKKZaEko4PWk5/ziYrr8p5+cM4F0ihv5MqQrgsG/A+o5PR?=
 =?us-ascii?q?QUUGiB5eSwyqbu/VH5QbpWjv02lbPVsJbBJcsBvKK5DAhV0pg75xalEzimyM?=
 =?us-ascii?q?gYnWUALF9dYxKIkYzpO1DIIPDlAvaymEqskDh1yPDcJLHhAYvCLmLFkLj/eb?=
 =?us-ascii?q?Zx8UlcyBA8zYMX25UBEbwFIfTuSmfvu9HCSBw0KQq5x6DgEtou+JkZXDetC6?=
 =?us-ascii?q?qUK+v5uEWU6/hnd+uTb4YPpGzVN+ku5/moi2Qw31AaY//6jtMsdHmkE6E+cA?=
 =?us-ascii?q?2ian32j4JETDYH?=
X-IPAS-Result: =?us-ascii?q?A2AqAwATFOhc/wHyM5BlHgEGBwaBVAYLAYFmKoE6ATIoj?=
 =?us-ascii?q?Q6KEEwBAQEDBoIziFCRBQkBAQEBAQEBAQEbGQECAQGHASM3Bg4BAwEBAQQBA?=
 =?us-ascii?q?QEBAwEBbCiCOimDFQsBgheCYz+BdxSnDjOFR4MvgUaBNIZ9hFaBD4EHgRGCX?=
 =?us-ascii?q?QdshRGFFQSBLQGnGQYDgg+FXY0pDBuWQAGkYiKBVysIAhgpgWiBTpBuIwMwg?=
 =?us-ascii?q?QYBAY4FAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 May 2019 15:57:52 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4OFvqw3003274
        for <selinux@vger.kernel.org>; Fri, 24 May 2019 11:57:52 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: Add option to optimize policydb when writing kernel policy
Date:   Fri, 24 May 2019 11:58:36 -0400
Message-Id: <20190524155836.25326-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the command-line option 'O' to checkpolicy to cause kernel policies
to be optimized by calling sepol_policydb_optimize() before being written
out.

This option can be used on conf files and binary kernel policies, but
not when converting to a conf file to CIL.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/checkpolicy.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index e0a00f7c..319bc393 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -394,7 +394,7 @@ int main(int argc, char **argv)
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
-	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0;
+	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
@@ -419,11 +419,12 @@ int main(int argc, char **argv)
 		{"cil", no_argument, NULL, 'C'},
 		{"conf",no_argument, NULL, 'F'},
 		{"sort", no_argument, NULL, 'S'},
+		{"optimize", no_argument, NULL, 'O'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:h", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:Oh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -466,6 +467,9 @@ int main(int argc, char **argv)
 		case 'S':
 			sort = 1;
 			break;
+		case 'O':
+			optimize = 1;
+			break;
 		case 'M':
 			mlspol = 1;
 			break;
@@ -625,6 +629,15 @@ int main(int argc, char **argv)
 	if (policydb_load_isids(&policydb, &sidtab))
 		exit(1);
 
+	if (optimize && policydbp->policy_type == POLICY_KERN) {
+		sepol_policydb_t *spdb = (sepol_policydb_t *)policydbp;
+		ret = sepol_policydb_optimize(spdb);
+		if (ret) {
+			fprintf(stderr, "%s:  error optimizing policy\n", argv[0]);
+			exit(1);
+		}
+	}
+
 	if (outfile) {
 		outfp = fopen(outfile, "w");
 		if (!outfp) {
-- 
2.20.1

