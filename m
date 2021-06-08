Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3A3C48BCF
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6805160FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFHQCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:31 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:35416 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhFHQCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:30 -0400
Received: by mail-ej1-f49.google.com with SMTP id h24so33483322ejy.2
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0z7t5twwtM2WwZB2k3WH5stRi/ApvczF5bMdyFPqhA0=;
        b=sVZDhUc3y/ZZQGfvhYSvDGQh2l/2noHMwB6DWygYq4Ku82nIVjqWIuC8PkQ2/Y3rgw
         EXIX/p01l2QJxnEq1IYk618t5EQ4SKBaRzuIpSP9hI3sr/g919k9Se4gbt2DqvkK0UA+
         XFph79fGptrVYcvTVMzo+NRN7QQBDrNcjvm+Ie1X00VY2pGIZhVsK+v3ou2lSPTwCUAO
         1mlmnVGheXD+wo6nxLQELNcoh1lcfDTea5/OHbk/9wp8Hc7lY/1nFJS8c3hRQTOToRse
         m0rV4kufZWdpLdd+ePgAV4fe4RN5Wj9tQTCjCW3VZQEIKtwlHYxkzzIPZmnuMlq2/ol3
         XX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0z7t5twwtM2WwZB2k3WH5stRi/ApvczF5bMdyFPqhA0=;
        b=FbbBoiop8WMyRd2iWilBdmHSP1Rnf2e0Whp1dri6mPqCI1NaMcHjVnG1U7YS71kJ0j
         5GMaLqZXnys0W4Qtvv5p2QUGUQtAtfefjFyh0df0MqnfDBns1xByGj2LGpq/6l8l2UF8
         WPYgVgUYB5CYwj25cPXmWmH/RQxmSk27PHigHJ9q/gCKCI2wJYUaCv0ElcEuDEfMi++I
         7gFtXcAHkfPpWkhaV954biL2r1zhvur0ArT6sxKL0dbNQOt6IFNsBfU4BkR6aPTvT+sX
         Y+LZeAqGgc9KgauzNQRnlVIAIpUzHd9tCsTv5boAfnsJENZvW+IXACtS1sfH2e/j2T4T
         X8dQ==
X-Gm-Message-State: AOAM532B6WSEYrjUi9zR9LkwYeaUqif3bR6jXgT8Qlgu61kVDolqBlkU
        7upbRZj07fsGJiCiV2W4FRT3s43A65w=
X-Google-Smtp-Source: ABdhPJzJ6uHWXHLkflR16P/gTmYZvCALcM7hHKaspTgsbDl9qBwLEYc8mw1Ar0oTDOW+U696Yl+Pfg==
X-Received: by 2002:a17:906:fcb5:: with SMTP id qw21mr23773611ejb.57.1623167966075;
        Tue, 08 Jun 2021 08:59:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 12/23] libsepol: do not allocate memory of size 0
Date:   Tue,  8 Jun 2021 17:59:01 +0200
Message-Id: <20210608155912.32047-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case cats_ebitmap_len() returns 0, do not allocate but quit.

Found by clang-analyzer

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 5 ++++-
 libsepol/src/kernel_to_conf.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 989aacde..17b5ebf0 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1034,11 +1034,14 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 {
 	struct ebitmap_node *node;
 	uint32_t i, start, range;
-	char *catsbuf, *p;
+	char *catsbuf = NULL, *p;
 	const char *fmt;
 	int len, remaining;
 
 	remaining = (int)cats_ebitmap_len(cats, val_to_name);
+	if (remaining == 0) {
+		goto exit;
+	}
 	catsbuf = malloc(remaining);
 	if (!catsbuf) {
 		goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 5db47fe4..c1253820 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1025,12 +1025,15 @@ static char *cats_ebitmap_to_str(struct ebitmap *cats, char **val_to_name)
 {
 	struct ebitmap_node *node;
 	uint32_t i, start, range, first;
-	char *catsbuf, *p;
+	char *catsbuf = NULL, *p;
 	const char *fmt;
 	char sep;
 	int len, remaining;
 
 	remaining = (int)cats_ebitmap_len(cats, val_to_name);
+	if (remaining == 0) {
+		goto exit;
+	}
 	catsbuf = malloc(remaining);
 	if (!catsbuf) {
 		goto exit;
-- 
2.32.0

