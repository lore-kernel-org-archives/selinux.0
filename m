Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39708C0044C
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62532054F
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 14:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62532054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeJaXRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:17:49 -0400
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:64457 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbeJaXRt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Oct 2018 19:17:49 -0400
X-EEMSG-check-008: 638988879|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,447,1534809600"; 
   d="scan'208";a="638988879"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Oct 2018 14:19:33 +0000
X-IronPort-AV: E=Sophos;i="5.54,447,1534809600"; 
   d="scan'208";a="17398250"
IronPort-PHdr: =?us-ascii?q?9a23=3AwPKTKxMSNvzzmL2HCasl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfT6rarrMEGX3/hxlliBBdydt6obzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlKiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr86Qz?=
 =?us-ascii?q?Si67pgRgHuhikJKjU19HjbhtJsgK5eph+quh5xzJPOYIyNNPRwYL7Tc90ZS2?=
 =?us-ascii?q?RGXMlRWTdMDp+gY4YVE+YMJ/pUo5X7qlATrRW+Hw6sBOb3xzFVmn/5w7U60+?=
 =?us-ascii?q?Q/HgHAwQcuAtcOv27QrNXxKqgTUf2+wa7TzTredPNbwiv96YjUfRAhpvGAR7?=
 =?us-ascii?q?RwcdHLxkU1GAPFiUuQpJXjMjiI1eoNq3CW4/dvWO+gkWIqqxx9riKxysojlI?=
 =?us-ascii?q?XFnJ8Zx1bZ/itj2ok1P8e3SEtjbN6hF5tfqj+VOpNtQsMnX2FooCE6yqAauZ?=
 =?us-ascii?q?KjfCgF1pAnxxnHZvybaYeI+BPjVPuKITtimHJkeK6whxa18US6zO3zStK030?=
 =?us-ascii?q?pQoipAk9nMsmgB1x3V6seZVvtw5lqt1DmA2gzJ6uxIPFo4mbTUJpI/2LI8i4?=
 =?us-ascii?q?IfsUHZES/3nEX2grWWdkIh+uWw8OTof67mq4SAN450lg7+MqMulta5AeQjKA?=
 =?us-ascii?q?cCRWeb+eOi1LH75032XK1KjuEqkqneqJ3aPtoUpqq4Aw9Tz4Yi5A2yDymp0N?=
 =?us-ascii?q?sGh3kLNlFFdwydj4jvJV7OJOr0DfClg1SjiD1r3ezJPqX9ApXRKXjOiLXhfb?=
 =?us-ascii?q?d96k5bzgozwstS551TCrEGL/LzXlH+uMbEAR8+Ngzni9rgXdd8x4QYVkqABa?=
 =?us-ascii?q?iWNK6UuliNtcw1JOzZX5MYoDbwLbAe4vfqiXIo0QsGcbKBwYocaHf+GO9vZU?=
 =?us-ascii?q?qefyy/0Z86DW4Ws19mH6TRg1qYXGsWPS6/?=
X-IPAS-Result: =?us-ascii?q?A2BAAAAbudlb/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VoqgWUojA6MXAEBAQEBAQaKRI4YgSQDUyAYAYRAAoM3IjQNDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII2JIJhBnkQUVcZgmI/gXUNqXaFPIRqh0OEJhd5gQeJboRsIgKJApYdC?=
 =?us-ascii?q?ZB/CxiQTgEsmEg4NIEhKwgCGAghD4MnkHMjMIEFAQGJAiuCIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Oct 2018 14:19:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9VEJWFl020569;
        Wed, 31 Oct 2018 10:19:32 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     jiyong@google.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: fix overly strict validation of file_contexts.bin
Date:   Wed, 31 Oct 2018 10:21:46 -0400
Message-Id: <20181031142146.8861-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <CALeUXe4MeHnt_4_pSZVTCYC4RNt2UKG0kEg0O9PRQTnmkXiLEQ@mail.gmail.com>
References: <CALeUXe4MeHnt_4_pSZVTCYC4RNt2UKG0kEg0O9PRQTnmkXiLEQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

load_mmap and regex_load_mmap (in the !USE_PCRE2 case) were
incorrectly treating the absence of any fixed stems or study data
as an error, rejecting valid file_contexts.bin files.  Remove
the extraneous validation checks.

Test:
$ cat > file_contexts <<EOF
(/.*)?                u:object_r:system_file:s0
/lib                   u:object_r:system_dir:s0
EOF
$ sefcontext_compile file_contexts
$ selabel_lookup -b file -k /lib -f file_contexts.bin

Before:
ERROR: selabel_open - Could not obtain handle.

After:
Default context: u:object_r:system_dir:s0

Reported-by: Jiyong Park <jiyong@google.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c | 2 +-
 libselinux/src/regex.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 560d8c3d..dbf51a93 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -232,7 +232,7 @@ end_arch_check:
 
 	/* allocate the stems_data array */
 	rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || !stem_map_len)
+	if (rc < 0)
 		return -1;
 
 	/*
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index dfc15d63..a6fcbbfe 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -348,7 +348,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		goto err;
 
 	rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
-	if (rc < 0 || !entry_len)
+	if (rc < 0)
 		goto err;
 
 	if (entry_len) {
-- 
2.14.5

