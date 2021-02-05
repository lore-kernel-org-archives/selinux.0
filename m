Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE5C433E0
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993A264F9F
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBEWdo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBEOOq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 09:14:46 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0484C061B3F
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 07:52:40 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 19so7318722qkh.3
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JJ/SG8ZE/ueAt4e7hJEPGv0T9HLO6lxAM8gv4GnxzI=;
        b=YHuLwj+eNn7f2dAln/cS3xgM+eW9/fb0WGzlqB/d9DPQ+MNqIJLie/3TTM66A/fU4G
         7+sW7rYjxKCMB+2DJrP6HPvxzp3sghRGDyUYST97iBR7K50A04VnXMO3/qMSmWsp28zS
         nBG1gUQj+qu9Uo6thVNGYe/C85Dvp2anbsJ/Rz98N8WL0NN2odOpoV8KCr+kuMR9FxgE
         2uEc1sN7O1rkWBUeqb+HpX1HFpX18yQKApVmHyDjJnDP4TbJh2kp4IfHurKcf176UVzy
         HkOCLParezIEk0TnvfdUz9srTY2X8Bu1LTL1N2ag8asezu98NLeM02wOXy43F5h8AV/k
         BeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JJ/SG8ZE/ueAt4e7hJEPGv0T9HLO6lxAM8gv4GnxzI=;
        b=RGn2hnC3C5PcAWRIH1lCK3UqHUx9WFeHOzbTwcwTD5K7X5DxX+91VJ0lTCQZTaTBzV
         JJhPWZuLHwq8Qg2jGbmVzGlYqtu4VEHYowl1jO0DHQzOQJyEOMnOVQYsbTitvLeJ8lIy
         lRKpokwxv9aXNcTPgIB3NaSDRMbG3FgJsQguETM2hi40PVgOslcH2paX9EnmZJK3MbSY
         ttDmZcdruTC1KGXTKh7gImKN+D714YrPerxEv96uyZ2/nRCiS2gypGrkn6vWhdhClOsz
         5dq/iv2zOSYd3yNF0az8JtCz9aefMZnTTtFa+jpxgNBqKHyGVtCaH7wT4cf11rTNg+Cf
         e9YA==
X-Gm-Message-State: AOAM532iDdxnZ8Grpda+ydOE8YvzOZTZHCttbqliQRblD1gAbARNunkj
        9MasR/BTcLFX2aLxgunPcnkPB0ku6gohoA==
X-Google-Smtp-Source: ABdhPJx/lYPUxkWYiblP+khZeVNSwMsbqNGIesWrTzz1TOCu+R4iJOvLuGO9PNO9KtRk3Hs1/6vcVA==
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr4322751qki.339.1612534094189;
        Fri, 05 Feb 2021 06:08:14 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c12sm8079219qtq.76.2021.02.05.06.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:08:13 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Create function ebitmap_highest_set_bit()
Date:   Fri,  5 Feb 2021 09:07:59 -0500
Message-Id: <20210205140800.275993-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205140800.275993-1-jwcart2@gmail.com>
References: <20210205140800.275993-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create the function ebitmap_highest_set_bit() which returns the position
of the highest bit set in the ebitmap.

The return value is valid only if the ebitmap is not empty. An empty
ebitmap will return 0.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 910834dd..634436f6 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -94,6 +94,7 @@ extern int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
 extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
+extern unsigned int ebitmap_highest_set_bit(ebitmap_t * e);
 extern void ebitmap_destroy(ebitmap_t * e);
 extern int ebitmap_read(ebitmap_t * e, void *fp);
 
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 963b8080..7f425349 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -344,6 +344,26 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 	return 0;
 }
 
+unsigned int ebitmap_highest_set_bit(ebitmap_t * e)
+{
+	ebitmap_node_t *n;
+	MAPTYPE map;
+	unsigned int pos = 0;
+
+	n = e->node;
+	if (!n)
+		return 0;
+
+	while (n->next)
+		n = n->next;
+
+	map = n->map;
+	while (map >>= 1)
+		pos++;
+
+	return n->startbit + pos;
+}
+
 void ebitmap_destroy(ebitmap_t * e)
 {
 	ebitmap_node_t *n, *temp;
-- 
2.26.2

