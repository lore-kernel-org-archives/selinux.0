Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B3FC46475
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 14:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B540F20819
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 14:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B540F20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeKEX41 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:56:27 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:61000 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEX41 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Nov 2018 18:56:27 -0500
X-EEMSG-check-008: 168373786|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Nov 2018 14:36:20 +0000
X-IronPort-AV: E=Sophos;i="5.54,468,1534809600"; 
   d="scan'208";a="20267615"
IronPort-PHdr: =?us-ascii?q?9a23=3AI7V+gxHPkZIbbTX1RVKYfZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78oMmwAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/Vj?=
 =?us-ascii?q?q476dvVRTmliEJOTAk+23Tk8B8kb5XrBenqhdiwYDbfZuVOeJ+cK3DYN0US2?=
 =?us-ascii?q?lPUMFeWCJOGY6wc4gCAvAdMetCs4Xxu10Dpga+Cwm2A+PvzydFiGLq3aIky+?=
 =?us-ascii?q?QhER/J3Ao9FNwTtXTbttH1NKMMXuG10aLFyi7DYO5N2Trm9IjJcgwuofGLXb?=
 =?us-ascii?q?5qd8rR0lMgGxnKjlWXt4zoJjWY3fkDvWic6upvT+Ovi2g/pgF+oziv2scsip?=
 =?us-ascii?q?TSiY4P1l/E8iB5zYAoLtO7UE52ecOoHZRfui2AN4Z6X9kuT39ntSok0LEKpJ?=
 =?us-ascii?q?i2dzUQxps93R7QcfmHfpCN4hLkSemePy91hGlgeLKjnxay9lWgyvHkWsm0zl?=
 =?us-ascii?q?lKqi1Fn8HQtn8XzRzT69WHSuBn8ke92TeAywDT6uZeLUAyiaXbMIIuzqQ1lp?=
 =?us-ascii?q?oStUTPBi72mEPog6+Kbkgo5+el5uv9brjmu5OQLZF4hw7gPqg0h8CzGeE4PR?=
 =?us-ascii?q?IPX2if9+S8zrrj/UjhTbVRk/I2ibLUsIzaJMsHpq65BBVZ0oA46xmlFTum39?=
 =?us-ascii?q?MYnWcfIFJfZB2Hl5TpO03JIP3gFvewnVCskDZtx/DbMbzsGYvNLnfdn7f7Z7?=
 =?us-ascii?q?p96FBTyBA1zd9B45JYELYBIOj8Why5iNuNFRI9Mgqp0875B9hnkIATQ2SCBu?=
 =?us-ascii?q?meKqyBn0WP47cUP+SUZIIT8A34Ivwh6u+m2WQ1gncBbKKp2t0Rc3n+EfN4dR?=
 =?us-ascii?q?bKKUHwi8sMRD9Z9jE1S/bn3RjbCTM=3D?=
X-IPAS-Result: =?us-ascii?q?A2CHAAAMVOBb/wHyM5BlHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VoqZn8omCVMAQEBAQEBBopFjh2BeiAQCAGDekaDUCI2Cw0BAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjYkgw4LAUaBUYJiPwGBdA0PqQEzhC0BgQ6EVwWHToQoF3mBB4c+AoIuh?=
 =?us-ascii?q?Q4CiQWGZY9ICYZuihgLGJBfASyMXIwIBiuBVSsIAhgIIQ+DJ4JQgzeKcCEwg?=
 =?us-ascii?q?QUBAY0bAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Nov 2018 14:36:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA5EaJHL016701;
        Mon, 5 Nov 2018 09:36:19 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: ibpkeys.c: fix printf format string specifiers for subnet_prefix
Date:   Mon,  5 Nov 2018 09:38:38 -0500
Message-Id: <20181105143838.5198-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use PRIx64 to print the subnet_prefix (which is a uint64_t) instead
of lx.

Fixes https://github.com/SELinuxProject/selinux/issues/108

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/ibpkeys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/ibpkeys.c b/libsepol/src/ibpkeys.c
index 682bf5db..68a9bdfe 100644
--- a/libsepol/src/ibpkeys.c
+++ b/libsepol/src/ibpkeys.c
@@ -1,5 +1,6 @@
 #include <netinet/in.h>
 #include <stdlib.h>
+#include <inttypes.h>
 
 #include "debug.h"
 #include "context.h"
@@ -176,7 +177,7 @@ int sepol_ibpkey_query(sepol_handle_t *handle,
 	return STATUS_SUCCESS;
 
 err:
-	ERR(handle, "could not query ibpkey subnet prefix: %#lx range %u - %u exists",
+	ERR(handle, "could not query ibpkey subnet prefix: %#" PRIx64 " range %u - %u exists",
 	    subnet_prefix, low, high);
 	return STATUS_ERR;
 }
@@ -203,7 +204,7 @@ int sepol_ibpkey_modify(sepol_handle_t *handle,
 	return STATUS_SUCCESS;
 
 err:
-	ERR(handle, "could not load ibpkey subnet prefix: %#lx range %u - %u exists",
+	ERR(handle, "could not load ibpkey subnet prefix: %#" PRIx64 " range %u - %u exists",
 	    subnet_prefix, low, high);
 	if (ibpkey) {
 		context_destroy(&ibpkey->context[0]);
-- 
2.19.1

