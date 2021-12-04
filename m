Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F711C433F5
	for <selinux@archiver.kernel.org>; Sat,  4 Dec 2021 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhLDKiz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLDKiz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 Dec 2021 05:38:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F1C061751
        for <selinux@vger.kernel.org>; Sat,  4 Dec 2021 02:35:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x6so21752912edr.5
        for <selinux@vger.kernel.org>; Sat, 04 Dec 2021 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jnET9FsEAJtRNz6d9+elQT9sQrcQIGpA5a9I58c9zck=;
        b=J6BnhHXo1/WyrkiReM9A5KQEWyGnCG4zRmdab+xa0d1xoM2O8vOdA3rnoatsBdJ2HB
         9hc35OFUWsapOUfWbt+a3+XU/XtsM4t7gPI3c5S9q97VWNOGyXYZOmclU3z2j5ABXHGK
         36ypZPNSikfK4QCj4iflXzfhyj9VVx18miw9rWPFsxPjhbUFfuTeOnGm3zcTG5BP7Vp1
         GYUleYZwmbT32/y7z7bo5rblxevb4HMIl54dDNzG5k7470J524Cn40SvYGwInd7DgZrF
         pliDIXHjhtkcs9zFgM8EQHVolrPZqaP5xf32nMbxV4v26JNC9E49VmE0urioc3hwdYrS
         XhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnET9FsEAJtRNz6d9+elQT9sQrcQIGpA5a9I58c9zck=;
        b=7WgYd5Zm3rYeNrK9aWbdtngMH+Ms28E8mX1tY25eVfKFuRGNm+AIgAINuQ0UOd/pNB
         m5R5v2z4gHAJlmB3YwImelAUJJ3RBb4LJjgxPkX0wrOlpFOpiKHvzHhHHOV9Mazhie1g
         YD1qFIHFdCV4rmgv+cyOkBQgf52qO8Vclf/k/qUIS0SWwNtqE4hwfDxOVl4opdK7fD2y
         MAN+yuaMO2Co3D9WX81RnoiDHDW3TKhLUUv7+R8aIx4DjQ/A2xZYtATObIyrdqzpio8F
         cTYJrooGtBfzIc3PggrMN9Crax3OXGn9V+GsvoM/1sMFijXIzF7Tv2tixDNN20wLdWEv
         e9TA==
X-Gm-Message-State: AOAM530ggYfTKKVVrGoKgVkmUSu2c+t1VUStAX6NP9BpPNfYTn5mHbfk
        L2HHAxp85FKXCwvA44/Dx9vLbZi4hpA=
X-Google-Smtp-Source: ABdhPJzA4Bkg4xmB7q7TsFSLqWFUNoFDI7rvdeQ2Vk8cBBOFuxoWlorqf9o3/FarRc+xc6X2064cBQ==
X-Received: by 2002:a17:906:5d09:: with SMTP id g9mr1351983ejt.3.1638614128470;
        Sat, 04 Dec 2021 02:35:28 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-110-042.77.6.pool.telefonica.de. [77.6.110.42])
        by smtp.gmail.com with ESMTPSA id hc16sm3192756ejc.12.2021.12.04.02.35.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:35:28 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v3 1/5] libsepol: introduce ebitmap_relative_complement()
Date:   Sat,  4 Dec 2021 11:35:12 +0100
Message-Id: <20211204103516.17375-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211124190815.12757-1-cgzones@googlemail.com>
References: <20211124190815.12757-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a method for ebitmaps that computes the relative complement.
All bits set in the second ebitmap are set to zero in the first one.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v3:
   - rename from ebitmap_subtract() to ebitmap_relative_complement()
v2:
   - add shortcut for empty ebitmaps
---
 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 81d0c7a6..076b9341 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -83,6 +83,7 @@ static inline int ebitmap_node_get_bit(const ebitmap_node_t * n, unsigned int bi
 extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
+extern int ebitmap_relative_complement(ebitmap_t *dst, const ebitmap_t *e1);
 extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2);
 extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit);
diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 1de3816a..5f166e8c 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -72,6 +72,24 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 	return 0;
 }
 
+int ebitmap_relative_complement(ebitmap_t *dst, const ebitmap_t *e1)
+{
+	unsigned int i, length;
+
+	if (ebitmap_is_empty(dst) || ebitmap_is_empty(e1))
+		return 0;
+	
+	length = min(ebitmap_length(dst), ebitmap_length(e1));
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
2.34.1

