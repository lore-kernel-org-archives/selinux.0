Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3167BC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbhLIQza (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbhLIQz3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29855C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so21859703edd.3
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3B9Gi0xW0n1QjZAHNOeMMGJ/9nalVXs8D1ZE0iFI/AM=;
        b=UEVm6AnqdDVT2yX4TpUsBjYjQndpRtFY/wd4PBcSVofDt403I0PMyejsvRTg0MixA6
         vjVrjpBlElyf8tAXCBdX414ZLtltoVtdBMpOeWeZxTbC1Q9RbLM88xUOhWwmzkF2TPDW
         hldSLeoxJc6urStnDrxogg4DgJXLRi+a9HMhoScyljKIXHhfE1vy9zV8+mKz0/Nyptlm
         Q+okSvvKiI7Wieyf9dJc0kid33xu1dKHibw8m7GCW3PpiI/XqlrUNZnKbxsN410rVb4d
         uL9qNc0Gb4ZA8y3OIjnNj+Yy3Wzm6pI07NMwHPtL3Cu9dk68I/uIqXzDucEhcU5tvoC6
         2wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3B9Gi0xW0n1QjZAHNOeMMGJ/9nalVXs8D1ZE0iFI/AM=;
        b=c/5qur1sfzk8Pjgm/wONZ8+UU5fP8kUCHPTM+3tX8wyPYVamWk3SWVL8DI87vxMb+v
         2+vJehoSuV9EEbotfGJeNLaJa/35fSAOBsbH3+oBEkQVhkioSx+4s2gNh5uqjmHOJblE
         O2y8ULaLXxqyAeBk/WtT0OcMGpmYS0MG6lSpQ7btGFkIIAGAO7yl2mUe5riL4gBGbzus
         Jp+QG70NI/xmIRA9YY9UmDo7ElfQhGTmLIhzdqkpFNa1DWX9+f+WWWeRUF5ohoY0IBWr
         GqI2vN/WKv4NEJ4fz6Ei8H7nszla9xrF8AAllQMAxgb3y4ahbgAsvsN6G3YbbGLRFWkE
         lzLQ==
X-Gm-Message-State: AOAM532wTSWZV+XJHeFdp8ZX2L6wV/l5eY4kATaSyOwDHUzKvg3ccpBO
        4Kio/LUqmMLrcG1sSeILtcN+0C5B96w=
X-Google-Smtp-Source: ABdhPJyrhbUjAtBjNEwoBFBVWVQ0zL4OTTTpOAtOl23KMWYKXnOmP1C+f1LXU5URPpCXswv9bQMnJA==
X-Received: by 2002:a50:c212:: with SMTP id n18mr31467781edf.211.1639068597728;
        Thu, 09 Dec 2021 08:49:57 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:57 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 32/36] libsepol: validate permissive types
Date:   Thu,  9 Dec 2021 17:49:24 +0100
Message-Id: <20211209164928.87459-33-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 11f13d65..d9968a8e 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -961,6 +961,23 @@ bad:
 	return -1;
 }
 
+static int validate_permissives(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	ebitmap_node_t *node;
+	unsigned i;
+
+	ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
+		if (validate_value(i, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid permissive type");
+	return -1;
+}
+
 static void validate_array_destroy(validate_t flavors[])
 {
 	unsigned int i;
@@ -1013,6 +1030,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_datum_array_entries(handle, p, flavors))
 		goto bad;
 
+	if (validate_permissives(handle, p, flavors))
+		goto bad;
+
 	validate_array_destroy(flavors);
 
 	return 0;
-- 
2.34.1

