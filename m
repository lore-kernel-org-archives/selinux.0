Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B96C433EF
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 19:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhKWTKZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhKWTKY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 14:10:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DCC061574
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 11:07:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so79495662eda.11
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lperPD0EgmDe1UueVG3FdQoaVjhZvf7afOR3TfMdptc=;
        b=i3Kxh+ytSq6Kjai7WLeAsVinV9o1I7S288mG4hpb5l72HtWa+weBdTL8G4+fNh/vwt
         pYAd/neylcc0whWrd7RqL/815C1tigEkC4ntl5UkoJkm9A3KusgyqYr+rtdeuvFecgxt
         mdY5EFsw182mijgh7Gf1Ifb7D7zOHNSpttyEonC1wMSvEcCsiZeHkSmyxdRym9hDLaaA
         m8nYqYMY2IoNjb+JPSljWnriM7HaQuSE764facgH9XfquY06ZQqj/qcysFYAX8dJSwBe
         eJ4CKcoOtr50qfZ+88GtSG6R+WzbUFv7OjryfYFSDHwallvb9An6niawI89b41fgCcC3
         BPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lperPD0EgmDe1UueVG3FdQoaVjhZvf7afOR3TfMdptc=;
        b=pOJKOPoaGduKodQzQrWg1B/STsbHxcyCljX9p1nOw8PC+7/iJEqXLo/Wd2mdWd9LL9
         faMFFEFVf7vMUAmPu13qro3qsH7N2YXWsCZbYyWX788ATiGlDkzjtqD60UifweeXaRF+
         i0FsNbZT1Z9adegbtUC801ldQsTaFZNeQyTEiXAE4im7MjDfWEJgk7BEhZHRXKV9wbFW
         ol+1kvoPeA10ltoG6vhmBt8Q2dAZ+yg8/wN5Sl+FmSx/krSnxCOQazW6fC11LsRFGk3D
         R1TkEymaCcuDQ3gQkeRjkPyS+Dd41Pfp5O2NQbiCXSSCcJD4abZ5T5CcjA6WvNuPV+Lr
         fVBg==
X-Gm-Message-State: AOAM533wD7uNe1sYRdPXDLpf5RUbnaZbT79mhmAbgIUyXZovzWIpe2UI
        L7+1IAjpcyDOp0s7iX5ne0j86/i/3vI=
X-Google-Smtp-Source: ABdhPJwPbjvsmcjHj59ZYE0vZNnrA10de911/jdmCeSEVci/AIcC5M+kgcvONh07djWi0vVQHKDiEw==
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr10742090ejc.299.1637694434574;
        Tue, 23 Nov 2021 11:07:14 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-244-006.95.112.pool.telefonica.de. [95.112.244.6])
        by smtp.gmail.com with ESMTPSA id e16sm7093326edz.18.2021.11.23.11.07.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:07:14 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/3] libsepol: introduce ebitmap_subtract()
Date:   Tue, 23 Nov 2021 20:07:02 +0100
Message-Id: <20211123190704.14341-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a subtract method for ebitmaps.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 81d0c7a6..daca67a2 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -83,6 +83,7 @@ static inline int ebitmap_node_get_bit(const ebitmap_node_t * n, unsigned int bi
 extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
+extern int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1);
 extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit);
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 1de3816a..faa9e42e 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -72,6 +72,19 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 	return 0;
 }
 
+int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1)
+{
+	unsigned int i, length = min(ebitmap_length(dst), ebitmap_length(e1));
+	for (i=0; i < length; i++) {
+		if (ebitmap_get_bit(e1, i)) {
+			int rc = ebitmap_set_bit(dst, i, 0);
+			if (rc < 0)
+				return rc;
+		}
+	}
+	return 0;
+}
+
 int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2)
 {
 	unsigned int i, length = min(ebitmap_length(e1), ebitmap_length(e2));
-- 
2.34.0

