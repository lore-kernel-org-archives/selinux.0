Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7844C33CAA
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F2A207FF
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 22:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lINaCMny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAWWjo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:39:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35287 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgAWWjo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 17:39:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so215114qka.2
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7FzsrWaqsrhIZNFPClDPydHKMXOYMvTZXp3qXfC06ds=;
        b=lINaCMnyEIcuR3q65dkkcbstulofCNta+awmzGV0Wcjs+od4/HOdzWAAbSBEwAL+3n
         BmbCP4jVmXWp7GTaWM6QYPN56x5tLGcqamFc+x0N1iO0fnyzX29Fq75YUEW5JL1UQ86M
         XHgQ/0NFrc7afALgTcY+ulVFGmEDufBPQqkxWwVWM6elU8ag4WewRvmKO36x+DToTfkA
         6fCiuJEOz3GKHEIqi5IXDGkIbAlhbYB/HsvXD+9z1iQOTCJzOxPjjxlXBoJ9AU+y6W6W
         wc1ilmDGbDS/tATJm0Frio6Zhioj6deTHK94+wYVIyEI144FVK+e0Dmha2DFur2jGbJ3
         2C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=7FzsrWaqsrhIZNFPClDPydHKMXOYMvTZXp3qXfC06ds=;
        b=CVc7UDvWvJdBHinzVFrX91QDpHO5TVDl6oH3nn3qke41s/IV9FjVys5kEs6vFNgqRu
         DEcXa4CJXFYwW4ZfHompgxM+1Kri6e0UF7udNk/LJEtg+YDWyn6O+01o9HvfncUUlnS/
         IptPme88AQNrxEF8LNKerRaQHsaNFfDgsmZPpqxnNNlnh6bMQaWFuo2FBCODA4zCrnON
         CWJR2KHYeYJBPn19IyAgzFKxcH4ssvzYvahU8dmHDq/qUObH6h/FASpvJWuLoigq3xln
         /nd2XgiPbYtv43sVUCCJ+Kxj3efLKACqwsz8cu8HBSrk0WhwsTGmf65IXWja+M9Z6xL7
         RnhQ==
X-Gm-Message-State: APjAAAXrvEsnVgHyO5IlNDTdgwACn/XLoTbtmRQxJUELYTp0RDbVKI+/
        6uRCscQ6j/Ai8SYZhCBJGmcyjNu56A==
X-Google-Smtp-Source: APXvYqwnlJFR7TiXx708fe8/lHWqY0PTaV5uMsakhBVmGF9dM2PMUDEKYSKAqmRAUhKzc80ggIjqQQ==
X-Received: by 2002:a37:4f8e:: with SMTP id d136mr506372qkb.495.1579819182450;
        Thu, 23 Jan 2020 14:39:42 -0800 (PST)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id z126sm1758089qka.34.2020.01.23.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 14:39:41 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: move variable definitions out of
 binder_common.h
To:     selinux@vger.kernel.org
Date:   Thu, 23 Jan 2020 17:39:40 -0500
Message-ID: <157981918030.502116.11086856862222322471.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Move the definitions of variables out of binder_common.h and into
binder_common.c in order to prevent compiler errors.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/binder/binder_common.c |    4 ++++
 tests/binder/binder_common.h |   15 +++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
index 224238b..7cf6c74 100644
--- a/tests/binder/binder_common.c
+++ b/tests/binder/binder_common.c
@@ -16,6 +16,10 @@
 
 #include "binder_common.h"
 
+bool verbose;
+enum binder_test_fd_t fd_type;
+char *fd_type_str;
+
 const char *cmd_name(uint32_t cmd)
 {
 	switch (cmd) {
diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
index f0245f3..f60860e 100644
--- a/tests/binder/binder_common.h
+++ b/tests/binder/binder_common.h
@@ -1,3 +1,6 @@
+#ifndef _BINDER_COMMON_H
+#define _BINDER_COMMON_H
+
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
@@ -42,16 +45,20 @@ enum {
 #define TEST_SERVICE_GET	290317 /* Sent by Client */
 #define TEST_SERVICE_SEND_FD	311019 /* Sent by Client */
 
-bool verbose;
+extern bool verbose;
 
 const char *cmd_name(uint32_t cmd);
 void print_trans_data(const struct binder_transaction_data *txn_in);
 int binder_write(int fd, void *data, size_t len);
 
-enum {
+enum binder_test_fd_t {
 	BINDER_FD,
 	BPF_MAP_FD,
 	BPF_PROG_FD,
 	BPF_TEST
-} fd_type;
-char *fd_type_str;
+};
+extern enum binder_test_fd_t fd_type;
+
+extern char *fd_type_str;
+
+#endif

