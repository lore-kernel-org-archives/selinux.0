Return-Path: <SRS0=i/ur=NR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D9CC32789
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FD420862
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeKGEoJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:44:09 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:37225 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeKGEoJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 23:44:09 -0500
X-EEMSG-check-008: 611086468|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="611086468"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 19:17:23 +0000
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="17606903"
IronPort-PHdr: =?us-ascii?q?9a23=3A/pTk7BF3gs4z7VXF8GAPY51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zp8ywAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B8kr5XrBenqhdiwYDbfZuVOeJ+cK3DYN0US2?=
 =?us-ascii?q?lPUMFTWCxPGY6wc5cDAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiHvs0q0/ze?=
 =?us-ascii?q?shChzN0RI6ENIUrHTbss/1P7oVXOC3wqjH0S/Mb+lK2Tvj84XIbhAgru2MXb?=
 =?us-ascii?q?J3a8bRz1IvGBnfglWfrozlISqY2+IQuGaY9+ptTf+jhmEopg1rojWj290ghp?=
 =?us-ascii?q?fGi44L0FzI6CN0y5svK9KiUk50e9ukHYNVtyGdKoR5XNsvQ3ptuCYm0r0Gvo?=
 =?us-ascii?q?O7fDQSxJQn2RHfb/uHfpCU4h35TuaRICp4hGl/dLKjhxe97UigyurmWsmyzF?=
 =?us-ascii?q?lKtTZKnsPJtnAM0xzf8smHSv1j8Ue9wTuDyg/e5+5eLU00iKbXMYAtz7Eump?=
 =?us-ascii?q?YJrEjPBir2l1/3jK+SeEUk4O+o6+H/b7XkqJ6TK5V7ihviMqgwgcG/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qbj8lfjTLVFif02jLHVsIrGKsQDuq65HwhV35446xmhCzem0d?=
 =?us-ascii?q?IYnWQILV9eZhKHgJbmO0vULPD7E/i/mVKsnylvx/zcOb3hGJrNJGDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwNBZ5pJbFrYBIPbpVU/qrtDYDxg5Mwuvw+b8E9h904wTWG2VDq?=
 =?us-ascii?q?+eKqPSvgzA2uV6OOWXTJMEszb6bf4+7rjhimFqt0UaePyL1J4acziTF+56Ll?=
 =?us-ascii?q?/RNXjzid4bDT0iohs1TOusjkaLFzFUeSDhDOoH+jgnBdf+Xs/4TYe3jenEhn?=
 =?us-ascii?q?+2?=
X-IPAS-Result: =?us-ascii?q?A2CyAACv5+Fb/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE1MxQTmCaLHpAZIBgBhEACg1giNwoNAQMBAQEBAQECAWwogjYkg?=
 =?us-ascii?q?mEGJ1IQUVcZG4JHPykBgUsNqjEzhTyEaodQhCiCF4ERjWsCgSoBjU12j0kGA?=
 =?us-ascii?q?4oThnQLGIFWiCKGawGZJCKBVSsIAhgpgWiBTpB4IQMwgQUBAYxsAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Nov 2018 19:17:23 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA6JHLL0004103;
        Tue, 6 Nov 2018 14:17:21 -0500
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     sds@tycho.nsa.gov
Cc:     jwcart2@tycho.nsa.gov, nicolas.iooss@m4x.org,
        selinux@vger.kernel.org
Subject: [PATCH] libsepol: mark permissive types when loading a binary policy
Date:   Tue,  6 Nov 2018 14:17:54 -0500
Message-Id: <20181106191754.6132-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
References: <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports:
When using checkpolicy to read a binary policy, permissive types are not
written in the output file. In order to reproduce this issue, a test
policy can be written from minimal.cil with the following commands:

    $ cd secilc/test/
    $ cp minimum.cil my_policy.cil
    $ echo '(typepermissive TYPE)' >> my_policy.cil
    $ secilc my_policy.cil
    $ checkpolicy -bC -o /dev/stdout policy.31

    # There is no "(typepermissive TYPE)" in checkpolicy output.

This is because TYPE_FLAGS_PERMISSIVE is added to typdatum->flags only
when loading a module, which uses the permissive flag in the type
properties. A kernel policy defines permissive types in a dedicated
bitmap, which gets loaded as p->permissive_map before the types are
loaded.

The solution is to use the permissive_map bitmap instead of relying on
the flags field of the struct type_datum when writing out CIL or
policy.conf policy from a binary.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/kernel_to_cil.c  | 14 ++++++--------
 libsepol/src/kernel_to_conf.c | 14 ++++++--------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 2c12ae9b..63e4d489 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1534,9 +1534,9 @@ exit:
 
 static int write_type_permissive_rules_to_cil(FILE *out, struct policydb *pdb)
 {
-	type_datum_t *type;
 	struct strs *strs;
 	char *name;
+	struct ebitmap_node *node;
 	unsigned i, num;
 	int rc = 0;
 
@@ -1545,13 +1545,11 @@ static int write_type_permissive_rules_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	for (i=0; i < pdb->p_types.nprim; i++) {
-		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_TYPE && (type->flags & TYPE_FLAGS_PERMISSIVE)) {
-			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
-			if (rc != 0) {
-				goto exit;
-			}
+	ebitmap_for_each_bit(&pdb->permissive_map, node, i) {
+		if (!ebitmap_get_bit(&pdb->permissive_map, i)) continue;
+		rc = strs_add(strs, pdb->p_type_val_to_name[i-1]);
+		if (rc != 0) {
+			goto exit;
 		}
 	}
 
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 219a2489..215d940c 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1579,9 +1579,9 @@ exit:
 
 static int write_type_permissive_rules_to_conf(FILE *out, struct policydb *pdb)
 {
-	type_datum_t *type;
 	struct strs *strs;
 	char *name;
+	struct ebitmap_node *node;
 	unsigned i, num;
 	int rc = 0;
 
@@ -1590,13 +1590,11 @@ static int write_type_permissive_rules_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
-	for (i=0; i < pdb->p_types.nprim; i++) {
-		type = pdb->type_val_to_struct[i];
-		if (type->flavor == TYPE_TYPE && (type->flags & TYPE_FLAGS_PERMISSIVE)) {
-			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
-			if (rc != 0) {
-				goto exit;
-			}
+	ebitmap_for_each_bit(&pdb->permissive_map, node, i) {
+		if (!ebitmap_get_bit(&pdb->permissive_map, i)) continue;
+		rc = strs_add(strs, pdb->p_type_val_to_name[i-1]);
+		if (rc != 0) {
+			goto exit;
 		}
 	}
 
-- 
2.17.2

