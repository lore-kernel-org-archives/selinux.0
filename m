Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E47C433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiBRVIq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:08:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRVIq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 16:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAE2E10FD3
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645218507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Utw6U2flpKnc1nHeHNPh/CMSFr4TBNleapAJUkHSSYw=;
        b=B8ngmzAuxQM3Q7c+wBuNVYwX9QDNDQ102gPksS1Yi5DPL+bzMA6vDoC28JS7w6zb22gJMv
        8xZdwm4cXtU09FrK/SLCet0ZcSMX1lJnUmYj+WRe1usVeVeBtSGyTsWUWz4KmB07yf5AIO
        aJLFNzo3K9XdxZuZE0q3ZyuQTfLFcCc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-vwzkzz4NOUm_rFKDYonGYg-1; Fri, 18 Feb 2022 16:08:19 -0500
X-MC-Unique: vwzkzz4NOUm_rFKDYonGYg-1
Received: by mail-ej1-f72.google.com with SMTP id gn20-20020a1709070d1400b006cf1fcb4c8dso3601946ejc.12
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 13:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Utw6U2flpKnc1nHeHNPh/CMSFr4TBNleapAJUkHSSYw=;
        b=IQNhBTZLPRbZcBMWJcHPi/Dvy912q+h0nkwu4jZEoV7EC+WWCVsrb39h1bks8qznvC
         MaC+zSVCWhMAmlvy/DwjRcaZAPDjdi7DjPEULo2o9Y6gYiUODRIhPx+tvUEwBLvqd9Ud
         oDl0f9be3ykoY1yYKqV4YiZlihcpu/1mOVHJV/mDV0Oe1vOXSl6+4HD+gLjZ11/Cu4a7
         jX1w/K3xMNz6g8tv89NS21Iet+n7twK25TVHjGtIqZJGX+v0LrOnVXuoX4bp2U84FNUj
         gJA7QbVTyKuZPoBNl7zUy1XixJZl059jMVPunhxZqkaybI6oDQKA8m+jmmUPV91nP29t
         T7NQ==
X-Gm-Message-State: AOAM532J0QCHP1Eef3XNRQnoH9CQ43al5U2Ll+875A9K1WPjOItjLOeQ
        ayu0RPLXZdbQfgMfJcAg9bSXMtiIFt4J5erzKX8XnM06sMsN3fNyE0Abqay3ImEmukOxnRqYwFu
        B7jJdaa2ot+SF5T/fud/Z/KQ7GMfSnxyrPaXtM0r4PXHPRZKUx3ONd9Y3ezWDEt5sSpHI1g==
X-Received: by 2002:a17:906:301a:b0:6cc:955d:4dec with SMTP id 26-20020a170906301a00b006cc955d4decmr7942045ejz.143.1645218498093;
        Fri, 18 Feb 2022 13:08:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6MSsPHwsLg/EONeF6wwyZJ7/XKapf5A0/1oplJOtyG9/zeOw/6GSGTeFiejsM1DTu4Eltmg==
X-Received: by 2002:a17:906:301a:b0:6cc:955d:4dec with SMTP id 26-20020a170906301a00b006cc955d4decmr7942026ejz.143.1645218497701;
        Fri, 18 Feb 2022 13:08:17 -0800 (PST)
Received: from localhost.localdomain (adsl-dyn144.78-99-32.t-com.sk. [78.99.32.144])
        by smtp.gmail.com with ESMTPSA id v1sm2615562ejk.11.2022.02.18.13.08.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:08:16 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/bpf: use new API if version >= 0.6
Date:   Fri, 18 Feb 2022 22:08:15 +0100
Message-Id: <20220218210815.107961-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In version 0.7 the old API is deprecated and without this patch the
testsuite fails to build with -Werror with this version.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/bpf/bpf_common.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
index f499034..88aae2f 100644
--- a/tests/bpf/bpf_common.c
+++ b/tests/bpf/bpf_common.c
@@ -1,12 +1,28 @@
 #include "bpf_common.h"
 
+/*
+ * v0.7 deprecates some functions in favor of a new API (introduced in v0.6).
+ * Make this work with both to satisfy -Werror (and older distros).
+ */
+#if defined(LIBBPF_MAJOR_VERSION)
+#if LIBBPF_MAJOR_VERSION > 0 || (LIBBPF_MAJOR_VERSION == 0 && \
+	LIBBPF_MINOR_VERSION > 6)
+#define USE_NEW_API
+#endif
+#endif
+
 int create_bpf_map(void)
 {
 	int map_fd, key;
 	long long value = 0;
 
+#ifdef USE_NEW_API
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(key),
+				sizeof(value), 256, NULL);
+#else
 	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key),
 				sizeof(value), 256, 0);
+#endif
 	if (map_fd < 0) {
 		fprintf(stderr, "Failed to create BPF map: %s\n",
 			strerror(errno));
@@ -18,17 +34,20 @@ int create_bpf_map(void)
 
 int create_bpf_prog(void)
 {
-	int prog_fd;
-	size_t insns_cnt;
-
 	struct bpf_insn prog[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	};
-	insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	int prog_fd;
 
+#ifdef USE_NEW_API
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPF",
+				prog, insns_cnt, NULL);
+#else
 	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
 				   insns_cnt, "GPL", 0, NULL, 0);
+#endif
 
 	if (prog_fd < 0) {
 		fprintf(stderr, "Failed to load BPF prog: %s\n",
-- 
2.35.1

