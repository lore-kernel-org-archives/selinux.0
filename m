Return-Path: <SRS0=5Yad=XI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5283C49ED7
	for <selinux@archiver.kernel.org>; Fri, 13 Sep 2019 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788242089F
	for <selinux@archiver.kernel.org>; Fri, 13 Sep 2019 16:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kp+UYvea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfIMQw3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:52:29 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:27988 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfIMQw3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Sep 2019 12:52:29 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 12:52:27 EDT
X-EEMSG-check-017: 13672661|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="13672661"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Sep 2019 16:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568393120; x=1599929120;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pXAyR9Jm9fn2+L9FtNw/YUw2HEgNCVWT3wyRgudZKpc=;
  b=kp+UYveauwiJK3ZKAtnwhGGcoxpzdjDzC6WMji+hGoZ3dsYpjKZWS5cQ
   zAxDxOi8W05w9oLo+zp3QZlmdu91LjwyUOrNWpgfEZOChvXX6WYA05QAo
   Z+fuw3UdXsbmdT0oYI0TWgfX2BzNCEMBpyrgyTg2A38crSvfZCl9qTr+d
   BBIeY+9oBN6XAu4BaUFMkS7DNEnkcIljkjTXUsiqX4k/opLcnY/Cv2PHg
   mPvIV9pSWnL/N2rPATvxxozCTeQYLHOiufwu5si/iMA5wxsTI9CH5UBGZ
   4G9SK4Fihy0syK4Y8efAER9gsrGQD70VD2ZlUf1Nezrh6S9JjuEfp4Q8h
   w==;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="27897055"
IronPort-PHdr: =?us-ascii?q?9a23=3A9kNaRR1pL9oDZJHusmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8Zse0fLPad9pjvdHbS+e9qxAeQG9mCsLQc1KGP6/moGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF+JqszxR?=
 =?us-ascii?q?fFv2dEd/lLzm9sOV6fggzw68it8JJ96Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgVS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMetWq4Txol0Dpga8CwaxHuPi0j9GiGHr06M00O?=
 =?us-ascii?q?ovFg7J0gM7Et4Ss3nZtsn5Ob0OXeypyqTD0DXNb+lR2Tf48IXGdgouofSSUr?=
 =?us-ascii?q?JrbMHc11MgFxnZjlqOs4zuIjSY1uYDsmeH9eVgT/6vh3A8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsJLUJMsHvKG5GRNV3pg45hajDzapzN?=
 =?us-ascii?q?QYnX4dIFJDYxKIlZLlO17JIPDmFfu/mUijkC93x/DaOb3sGo7NIWbHkLfge7?=
 =?us-ascii?q?Z99kFdxREtzdBQ+Z1UEKsNIPHtVU/rstzXEBs5Pxazw+b9B9Uunr8ZDHmCBq?=
 =?us-ascii?q?6fLbP6r1CF/KQsLvOKaYtTvyzyeNY/4Pu7r3Y8lERVVqCzwZYNICS6Af9vOV?=
 =?us-ascii?q?nDSWb9idcGV2ERt0wxS/K82w7KaiJae3vnB/F03To8Eo/zSNySSw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CSAADUxntd/wHyM5BmHgEGBwaBUwkLAYFtKoE/ATIqk?=
 =?us-ascii?q?yZNAQEBAQEBBospigeFJIF7CQEBAQEBAQEBARsZAQIBAYchIzQJDgIMAQEBB?=
 =?us-ascii?q?AEBAQEBBgMBAWyFOoI6KYMgAYIXgmM/gXcUrECFS4MygUmBNAGHHoRZgRCBB?=
 =?us-ascii?q?4ERg1CFEYUWBIEvAYsiCoo0lTcGgiWUawwbmQkBLag6OIFYKwgCGCmBaIFOg?=
 =?us-ascii?q?k4Xjj4kAzCBBgEBjyABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Sep 2019 16:45:18 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8DGjIer002146
        for <selinux@vger.kernel.org>; Fri, 13 Sep 2019 12:45:18 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: Remove cil_mem_error_handler() function pointer
Date:   Fri, 13 Sep 2019 12:47:13 -0400
Message-Id: <20190913164713.29432-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As reported by Nicolas Iooss (nicolas.iooss@m4x.org), static analyzers
have problems understanding that the default memory error handler does
not return since it is called through the cil_mem_error_handler()
function pointer. This results in a number of false positive warnings
about null pointer dereferencing.

Since the ability to set the cil_mem_error_handler() is only through
the function cil_set_mem_error_handler() which is never used and whose
definition is not in any header file, remove that function, remove the
use of cil_mem_error_handler() and directly in-line the contents of
the default handler, cil_default_mem_error_handler().

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_mem.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index 12c59be2..f73021b5 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -34,19 +34,6 @@
 
 #include "cil_log.h"
 
-__attribute__((noreturn)) void cil_default_mem_error_handler(void)
-{
-	cil_log(CIL_ERR, "Failed to allocate memory\n");
-	exit(1);
-}
-
-void (*cil_mem_error_handler)(void) = &cil_default_mem_error_handler;
-
-void cil_set_mem_error_handler(void (*handler)(void))
-{
-	cil_mem_error_handler = handler;
-}
-
 void *cil_malloc(size_t size)
 {
 	void *mem = malloc(size);
@@ -54,7 +41,8 @@ void *cil_malloc(size_t size)
 		if (size == 0) {
 			return NULL;
 		}
-		(*cil_mem_error_handler)();
+		cil_log(CIL_ERR, "Failed to allocate memory\n");
+		exit(1);
 	}
 
 	return mem;
@@ -64,7 +52,8 @@ void *cil_calloc(size_t num_elements, size_t element_size)
 {
 	void *mem = calloc(num_elements, element_size);
 	if (mem == NULL){
-		(*cil_mem_error_handler)();
+		cil_log(CIL_ERR, "Failed to allocate memory\n");
+		exit(1);
 	}
 
 	return mem;
@@ -77,7 +66,8 @@ void *cil_realloc(void *ptr, size_t size)
 		if (size == 0) {
 			return NULL;
 		}
-		(*cil_mem_error_handler)();
+		cil_log(CIL_ERR, "Failed to allocate memory\n");
+		exit(1);
 	}
 
 	return mem;
@@ -94,7 +84,8 @@ char *cil_strdup(const char *str)
 
 	mem = strdup(str);
 	if (mem == NULL) {
-		(*cil_mem_error_handler)();
+		cil_log(CIL_ERR, "Failed to allocate memory\n");
+		exit(1);
 	}
 
 	return mem;
@@ -110,7 +101,8 @@ __attribute__ ((format (printf, 2, 3))) int cil_asprintf(char **strp, const char
 	va_end(ap);
 
 	if (rc == -1) {
-		(*cil_mem_error_handler)();
+		cil_log(CIL_ERR, "Failed to allocate memory\n");
+		exit(1);
 	}
 
 	return rc;
-- 
2.21.0

