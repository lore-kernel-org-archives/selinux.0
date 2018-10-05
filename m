Return-Path: <SRS0=ExXx=MR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABB1C00449
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C20320834
	for <selinux@archiver.kernel.org>; Fri,  5 Oct 2018 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C20320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJEVFa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:05:30 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:58863 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVFa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Oct 2018 17:05:30 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 17:05:26 EDT
X-EEMSG-check-008: 632997575|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="632997575"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Oct 2018 13:56:58 +0000
X-IronPort-AV: E=Sophos;i="5.54,344,1534809600"; 
   d="scan'208";a="16565611"
IronPort-PHdr: =?us-ascii?q?9a23=3Ay92kRRak9mAbaa6sAKGXRTP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMiybnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?us9adrTALjhjkBOTA37WrbjtV8gLxHrB6koRF03ozab5yPNPdmfq3TY84US2?=
 =?us-ascii?q?RCUMhWVSNBDJixY5cTA+cbIepVtZXxq0cIoBCjBQesHuTvyjpQi3Hyx6I61v?=
 =?us-ascii?q?ouERrb1wE+Bd0OqmjUo8vvNKwPVu21zqfJwinZYPNMxTfx9pPFcgwhoP6QXb?=
 =?us-ascii?q?JwdtDdyU80FwzflFmQpovlPy2M2+kLrmOV7PJgWPqyh2MopAx9uDiiyto2ho?=
 =?us-ascii?q?XXiY8Z1ErI+Th/zY0oP9O3UlR7bsShEJZIsiGaMJZ5Td06TmFzvSY61qUGuZ?=
 =?us-ascii?q?mmfCgW0JgnxwDQa/iAc4WQ/hLsTvyRITZlhHJ+Yr6/mxaz/lSgyu37TMW01k?=
 =?us-ascii?q?pFrjFZndXWs3AN1hjT5tCGSvt74EihxS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEjfzmErsja+Wcksk+vKv6+TierjmpJGdOJNuhQHkLqQihNeyAfg4Mw?=
 =?us-ascii?q?cSX2ib/v6w1Lv4/ULjWrlKgfo2krfBvJDAOcsbvrK5AxNS0os78BawETOm0N?=
 =?us-ascii?q?UenXkaI1NIYwyHj4f3NFHUOvz4Dumwg06qkDh1w/DKJLrhAo/CLiuLrLC0Zr?=
 =?us-ascii?q?t56khB2CItwt1FoZFZELcMJLT0QECimsbfC0obOgm52K7MAc9h25lWDWCQCa?=
 =?us-ascii?q?aDLPn6rU6D5uVpJfKFIoASpmCueLAe+/fygCphyhcmdq6z0M5SMii1?=
X-IPAS-Result: =?us-ascii?q?A2CGAACbbLdb/wHyM5BjHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VsqgWUomC9MAQEBAQEBBoIth3eNb4F6IBgBhEAChCwhNgsNAQMBAQEBAQECA?=
 =?us-ascii?q?WwogjYkgmAGgQlRVxmCYj+BdQ2lXoR3hRyHE4QegRCBB4ESgl0HhXmFCwKBK?=
 =?us-ascii?q?AGcOQYDkDsLF490ly8HKoFVKwgCGCmBaIFOgiYXEY4jIzB7AQGNTwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Oct 2018 13:56:58 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w95Duv8p003745
        for <selinux@vger.kernel.org>; Fri, 5 Oct 2018 09:56:58 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] checkpolicy: Add option to sort ocontexts when creating a binary policy
Date:   Fri,  5 Oct 2018 09:57:20 -0400
Message-Id: <20181005135720.13943-3-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005135720.13943-1-jwcart2@tycho.nsa.gov>
References: <20181005135720.13943-1-jwcart2@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an option, specified by "-S" or "--sort", to sort the ocontexts
before writing out the binary policy.

Binary policies created by semanage and secilc are always sorted, so
this option allows checkpolicy to be consistent with those. It has
not been made the default to maintain backwards compatibility for
anyone who might be depending on the unsorted behavior of checkpolicy.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/checkpolicy.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 12c4c405..14dc91a3 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -111,9 +111,9 @@ unsigned int policyvers = POLICYDB_VERSION_MAX;
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
-	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M]"
-	     "[-c policyvers (%d-%d)] [-o output_file] [-t target_platform (selinux,xen)]"
-	     "[input_file]\n",
+	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
+	     "[-c policyvers (%d-%d)] [-o output_file] [-S] "
+	     "[-t target_platform (selinux,xen)] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
 }
@@ -394,7 +394,7 @@ int main(int argc, char **argv)
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
-	unsigned int binary = 0, debug = 0, cil = 0, conf = 0;
+	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
@@ -418,11 +418,12 @@ int main(int argc, char **argv)
 		{"mls", no_argument, NULL, 'M'},
 		{"cil", no_argument, NULL, 'C'},
 		{"conf",no_argument, NULL, 'F'},
+		{"sort", no_argument, NULL, 'S'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFVc:h", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:h", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -462,6 +463,9 @@ int main(int argc, char **argv)
 				break;
 			}
 			usage(argv[0]);
+		case 'S':
+			sort = 1;
+			break;
 		case 'M':
 			mlspol = 1;
 			break;
@@ -637,6 +641,14 @@ int main(int argc, char **argv)
 				policy_file_init(&pf);
 				pf.type = PF_USE_STDIO;
 				pf.fp = outfp;
+				if (sort) {
+					ret = policydb_sort_ocontexts(&policydb);
+					if (ret) {
+						fprintf(stderr, "%s:  error sorting ocontexts\n",
+						argv[0]);
+						exit(1);
+					}
+				}
 				ret = policydb_write(&policydb, &pf);
 			} else {
 				ret = sepol_kernel_policydb_to_conf(outfp, policydbp);
-- 
2.17.1

