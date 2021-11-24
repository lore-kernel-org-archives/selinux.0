Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C94C433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 19:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbhKXTLe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbhKXTLd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 14:11:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81089C061574
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so14986016edu.4
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SQAykfFeb480DYd2vbO+CXZfu4SweCc2LVREB//N0RI=;
        b=hxbOE5xQr8go8bTFvcB8vncRNT9/Prb5RRh5iyw9H141i7dylz6kqNkddIBDltQYgB
         +MinGWi7TIm78cxelY4FCyx0jfAt7FH0HTWJ5/cu1B2wMd1BKSu75z+ioC+YoewBOH2H
         s0EoBk71VE76N+w1DzxwEmgznIPIa0+8meHzXFH5gLypt5+Um7UA8eWQFeql3lIjk/sa
         J0HwOX4sfQ5/jycjU/lK6zx+nvThNFqXtGkFbDuAmwKUoqAq4GNNU0h8i3CnfXQ+ReEC
         6Uyq3empp8qXT0yb3fqlv+DIxy0MANnpAhn8HF72tR3Y7r5apz5BYfHnmc4aEa0aDKF3
         fKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQAykfFeb480DYd2vbO+CXZfu4SweCc2LVREB//N0RI=;
        b=l6AYpg77bGyD0tAz0Y3D6lsdLD6xvvwHIoeEAl2VmLF59nQ6Ik5grCxkslPMVPCZ9z
         hQDyx8auMlzjIaZgNBBv4sF85+RxKHRWMiwE2rwoCuxCz0PCbWv86XkZ12mx1CNHqZE/
         cIkvwf9M2KN5Rz6xOj/jnc/0545Pk1C2mfwAnxzVLUg68x7+N4NVihvHyv3lrxpaWo6p
         7U7TPz9Jv9zvNYbprniTpKRuKrpPVLAvl0GUyMtJZ2bR2LnUQ8awJpXiA3zVnG1+mE19
         tZDnJubtkd2pFx36VecWOKqi7EsOMKHA7iv+6fQAaZPZTSIAicpI5JeLQST1FRRW3wU0
         cnkQ==
X-Gm-Message-State: AOAM530Q3+zVD1GJvwrWTvAbquBg9qf132KtPhtOQAdSjXiOsyhhb0K5
        jPJFXEAVH+22D3xlbrdBz7GJOj1hG5gF5A==
X-Google-Smtp-Source: ABdhPJzh/OtOVaSauYnkaKH4U7j3MwhJf8YelsiW3TC0aq9OHC43n6SB4Z35dpMSR7HQvPBY/Wdv2g==
X-Received: by 2002:a17:906:7955:: with SMTP id l21mr24823912ejo.6.1637780901936;
        Wed, 24 Nov 2021 11:08:21 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-186-056.77.8.pool.telefonica.de. [77.8.186.56])
        by smtp.gmail.com with ESMTPSA id p3sm339256ejy.94.2021.11.24.11.08.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:08:21 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 1/4] libsepol: introduce ebitmap_subtract()
Date:   Wed, 24 Nov 2021 20:08:12 +0100
Message-Id: <20211124190815.12757-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123190704.14341-1-cgzones@googlemail.com>
References: <20211123190704.14341-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a subtract method for ebitmaps.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   - add shortcut for empty ebitmaps
---
 libsepol/include/sepol/policydb/ebitmap.h |  1 +
 libsepol/src/ebitmap.c                    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index 1de3816a..80f0e201 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -72,6 +72,24 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 	return 0;
 }
 
+int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1)
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
2.34.0

