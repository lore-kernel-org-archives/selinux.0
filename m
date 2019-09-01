Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5524EC3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF0F22CF7
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfIASGz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:55 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:42406 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfIASGz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:55 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 26CE7564880
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:53 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/9] libsepol/cil: help static analyzers by aborting when an allocation fails
Date:   Sun,  1 Sep 2019 20:06:29 +0200
Message-Id: <20190901180636.31586-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:53 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When allocating memory with cil_* helpers, if malloc/calloc/realloc/...
failed, (*cil_mem_error_handler)() is called. Implementations of this
function are expected not to return to the caller, and the default one
calls exit(1) to ensure this. In order for static analyzers to find out
that cil_malloc/cil_realloc/... never returns a NULL pointer when
failing to allocate some memory, introduce a call to abort().

This decreases the number of false positive warnings about null pointer
dereferences reported by Infer static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index 12c59be21914..885431d8a8fd 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -55,6 +55,7 @@ void *cil_malloc(size_t size)
 			return NULL;
 		}
 		(*cil_mem_error_handler)();
+		abort();
 	}
 
 	return mem;
@@ -65,6 +66,7 @@ void *cil_calloc(size_t num_elements, size_t element_size)
 	void *mem = calloc(num_elements, element_size);
 	if (mem == NULL){
 		(*cil_mem_error_handler)();
+		abort();
 	}
 
 	return mem;
@@ -78,6 +80,7 @@ void *cil_realloc(void *ptr, size_t size)
 			return NULL;
 		}
 		(*cil_mem_error_handler)();
+		abort();
 	}
 
 	return mem;
@@ -95,6 +98,7 @@ char *cil_strdup(const char *str)
 	mem = strdup(str);
 	if (mem == NULL) {
 		(*cil_mem_error_handler)();
+		abort();
 	}
 
 	return mem;
@@ -111,6 +115,7 @@ __attribute__ ((format (printf, 2, 3))) int cil_asprintf(char **strp, const char
 
 	if (rc == -1) {
 		(*cil_mem_error_handler)();
+		abort();
 	}
 
 	return rc;
-- 
2.22.0

