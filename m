Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C8C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B770660E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhJKQ2g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhJKQ2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C3C061749
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d9so46037486edh.5
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EAcjYo/UANBtXSL6TDkzco2wBxRBoJWi6Qv9xG+KoXc=;
        b=fBhI9Ogi2uxbRANQgQBA9HWJT7jlBlKeM9Bsjxsplmckd7hbu4piQyz1+nJKa0mGnC
         Ekp3wq/XssuXFmzSUCixkQ1ft2GrQRHjZPAOgFMxKTSGXovYnD6AjnUr5T2GxP0j9Kld
         u3o1DH+zxmY2jDoMYxtFRTqeVlDuBGK6oyL4nFzcTBoTyGmHXQ42dugYSWMli3zQO9rS
         SNP/X/d4kYIe5GXImti9B34UL9HKRbiNZ+NsThezQF82Ep9slb2T8c0gCqTOr9OoOxTs
         ROf3djXNqeGdiyLVY/sa4/WIdmbHF5F3Znx3pPb2tGLhCIwDxVkG1bUMhwPwcQ+gyExS
         1BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAcjYo/UANBtXSL6TDkzco2wBxRBoJWi6Qv9xG+KoXc=;
        b=DvvCE9RAERD9emHBeHUYQoZ2ZFS3khXIxGKvSXv+eKJFGf0IceskPQlU0Nr1MqyH6S
         oE5+GviupY4oBt3K0/eafLj2blAl4VqceXcl5XwG2uKV9tdEOPwdp/3MtZy44DwYt0Zz
         89MVwAos4bIXwMVhVwMMbDJjHHzFvLl0ZjqbEH7cyeY8WNIx3P3xhh7PuhcQZrP1xBE0
         po2cr+Pf0wnCWiQg0fQwNrzUDRLkgR7mAbvJ/rmjnpC7ORtT+SF7uN17C3eVzZdXsJUX
         A/88cND0HcwUOtgzsSmRaDxIc+3WMOnA3HQGwAxq0kykWrn5LQ22ZHPc1jRnrYmG92SM
         9vkg==
X-Gm-Message-State: AOAM5314EsFS/NUROTSUfYkNmMoGwU8QaYBKEMvclI0nPjyRYAJTN9tt
        qyNYSoBKadqTbLhVssJk9qR8N/+Uk6Y=
X-Google-Smtp-Source: ABdhPJzsb0cZX932+buHKkfU/L693MzSQGxt28wmrbHkrUc6fZ6+abpILRunA1C6RJfHAJc/nGg81g==
X-Received: by 2002:a17:906:2bc7:: with SMTP id n7mr26375048ejg.238.1633969590986;
        Mon, 11 Oct 2021 09:26:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 18/35] libsepol: use size_t for indexes in strs helpers
Date:   Mon, 11 Oct 2021 18:25:16 +0200
Message-Id: <20211011162533.53404-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use size_t, as the strs struct uses it for its size member.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 8 ++++----
 libsepol/src/kernel_to_common.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 51df8c25..47c02d61 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -159,7 +159,7 @@ int strs_add(struct strs *strs, char *s)
 {
 	if (strs->num + 1 > strs->size) {
 		char **new;
-		unsigned i = strs->size;
+		size_t i = strs->size;
 		strs->size *= 2;
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
@@ -212,11 +212,11 @@ char *strs_remove_last(struct strs *strs)
 	return strs->list[strs->num];
 }
 
-int strs_add_at_index(struct strs *strs, char *s, unsigned index)
+int strs_add_at_index(struct strs *strs, char *s, size_t index)
 {
 	if (index >= strs->size) {
 		char **new;
-		unsigned i = strs->size;
+		size_t i = strs->size;
 		while (index >= strs->size) {
 			strs->size *= 2;
 		}
@@ -237,7 +237,7 @@ int strs_add_at_index(struct strs *strs, char *s, unsigned index)
 	return 0;
 }
 
-char *strs_read_at_index(struct strs *strs, unsigned index)
+char *strs_read_at_index(struct strs *strs, size_t index)
 {
 	if (index >= strs->num) {
 		return NULL;
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 8aa483fa..e9932d30 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -99,8 +99,8 @@ int strs_add(struct strs *strs, char *s);
 __attribute__ ((format(printf, 2, 4)))
 int strs_create_and_add(struct strs *strs, const char *fmt, int num, ...);
 char *strs_remove_last(struct strs *strs);
-int strs_add_at_index(struct strs *strs, char *s, unsigned index);
-char *strs_read_at_index(struct strs *strs, unsigned index);
+int strs_add_at_index(struct strs *strs, char *s, size_t index);
+char *strs_read_at_index(struct strs *strs, size_t index);
 void strs_sort(struct strs *strs);
 unsigned strs_num_items(struct strs *strs);
 size_t strs_len_items(struct strs *strs);
-- 
2.33.0

