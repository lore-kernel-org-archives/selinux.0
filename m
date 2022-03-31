Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD2AC4321E
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiCaOsL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiCaOsF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:48:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB121FC47
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:46:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so48598607ejd.5
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VgfGyQ8ApaeP0ZfKOHG5KlwOWn4Oh4MYjXxzHo/ny4g=;
        b=fB8ihnlrvjs/hA8WkliWesSFo2pfyy9EQ7/iNvsms+hgaIPt14jq5gSU6sI3BkhLJ9
         STlBOsG+X3SOQXOmFOtA0bPx/BBMvpemQf7Q8tc5jn/tflKAVcCRMgJ3Fscfix62dF75
         6ayMmP2V2kxfLZVxlSL4c/EFtISG10Fqt/t9p2wz3nVGZp3YWcRtn7YxKoHG+jXMbMIt
         KfBR7pD4qT/CirB8ZxMveBi6HWu92bIJI47n0mtEI6ETsgqaOQ223+sNsCbQzHfNgIEy
         /9j0WW27CSz6MIFByRWhO4/f4vPmMtUJ4ie4OuuqCbTeu+oRju7xPk5OdYG69GoL5dap
         Wgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgfGyQ8ApaeP0ZfKOHG5KlwOWn4Oh4MYjXxzHo/ny4g=;
        b=upoQFcY0pRVZIpvS+mUc5EC4u3KoZkEF8+26ghyZXuBfxEeHC1LiVy/tRzXSHNs1Yq
         BMeKVzc7sZffv+KsbLF+uWU7taVC40WUJEoni8P37Nj3s2OlxprOsSqGonzAcB+NHEuu
         TOKvWBPeC6ucOlTCvk8pqnwdJhByJmzh2D5N/FObdQtTr6CDd8DhBNu22FAr8APWlml4
         75LSWFx7ym+kgdLacvSjOYPXltDfjBlyHtzf22m9aOTsNEXWKgaRMe05hz2cd3rNVsA5
         KOjPW+2jtgS/JtW3ByOGwv20E2f29qB9+yA2k6US0bxrnV/wNmI0fYN3LJ8tlmilHO/4
         mB8w==
X-Gm-Message-State: AOAM530gdNs8BC3P/fu/I1XdkjyQGyId8Vz4xE7f0AOB6kX6TDVoHaFR
        JOrRWBmkJfrstgwSVJjLrrz6jkQJz68=
X-Google-Smtp-Source: ABdhPJwFjMG3LuCKnVciAlr8fraZOFycErdiuxMHJXcEqgc0KD+a6N75erK/EWc0aTa6Lps38tfnog==
X-Received: by 2002:a17:906:32d0:b0:6ce:e1cf:3f2e with SMTP id k16-20020a17090632d000b006cee1cf3f2emr5046611ejk.214.1648737976978;
        Thu, 31 Mar 2022 07:46:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090672cd00b006df86017b61sm9593824ejl.105.2022.03.31.07.46.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:46:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: mark immutable common helper parameter const
Date:   Thu, 31 Mar 2022 16:46:10 +0200
Message-Id: <20220331144610.31056-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331144610.31056-1-cgzones@googlemail.com>
References: <20220331144610.31056-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more obvious which parameters are read-only and not being
modified and allow callers to pass const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 16 ++++++++--------
 libsepol/src/kernel_to_common.h | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 972499ab..775703a9 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -267,12 +267,12 @@ void strs_sort(struct strs *strs)
 	qsort(strs->list, strs->num, sizeof(char *), strs_cmp);
 }
 
-unsigned strs_num_items(struct strs *strs)
+unsigned strs_num_items(const struct strs *strs)
 {
 	return strs->num;
 }
 
-size_t strs_len_items(struct strs *strs)
+size_t strs_len_items(const struct strs *strs)
 {
 	unsigned i;
 	size_t len = 0;
@@ -285,7 +285,7 @@ size_t strs_len_items(struct strs *strs)
 	return len;
 }
 
-char *strs_to_str(struct strs *strs)
+char *strs_to_str(const struct strs *strs)
 {
 	char *str = NULL;
 	size_t len = 0;
@@ -327,7 +327,7 @@ exit:
 	return str;
 }
 
-void strs_write_each(struct strs *strs, FILE *out)
+void strs_write_each(const struct strs *strs, FILE *out)
 {
 	unsigned i;
 
@@ -339,7 +339,7 @@ void strs_write_each(struct strs *strs, FILE *out)
 	}
 }
 
-void strs_write_each_indented(struct strs *strs, FILE *out, int indent)
+void strs_write_each_indented(const struct strs *strs, FILE *out, int indent)
 {
 	unsigned i;
 
@@ -360,7 +360,7 @@ int hashtab_ordered_to_strs(char *key, void *data, void *args)
 	return strs_add_at_index(strs, key, datum->value-1);
 }
 
-int ebitmap_to_strs(struct ebitmap *map, struct strs *strs, char **val_to_name)
+int ebitmap_to_strs(const struct ebitmap *map, struct strs *strs, char **val_to_name)
 {
 	struct ebitmap_node *node;
 	uint32_t i;
@@ -379,7 +379,7 @@ int ebitmap_to_strs(struct ebitmap *map, struct strs *strs, char **val_to_name)
 	return 0;
 }
 
-char *ebitmap_to_str(struct ebitmap *map, char **val_to_name, int sort)
+char *ebitmap_to_str(const struct ebitmap *map, char **val_to_name, int sort)
 {
 	struct strs *strs;
 	char *str = NULL;
@@ -427,7 +427,7 @@ char *strs_stack_pop(struct strs *stack)
 	return strs_remove_last(stack);
 }
 
-int strs_stack_empty(struct strs *stack)
+int strs_stack_empty(const struct strs *stack)
 {
 	return strs_num_items(stack) == 0;
 }
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index e9932d30..159c4289 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -102,19 +102,19 @@ char *strs_remove_last(struct strs *strs);
 int strs_add_at_index(struct strs *strs, char *s, size_t index);
 char *strs_read_at_index(struct strs *strs, size_t index);
 void strs_sort(struct strs *strs);
-unsigned strs_num_items(struct strs *strs);
-size_t strs_len_items(struct strs *strs);
-char *strs_to_str(struct strs *strs);
-void strs_write_each(struct strs *strs, FILE *out);
-void strs_write_each_indented(struct strs *strs, FILE *out, int indent);
+unsigned strs_num_items(const struct strs *strs);
+size_t strs_len_items(const struct strs *strs);
+char *strs_to_str(const struct strs *strs);
+void strs_write_each(const struct strs *strs, FILE *out);
+void strs_write_each_indented(const struct strs *strs, FILE *out, int indent);
 int hashtab_ordered_to_strs(char *key, void *data, void *args);
-int ebitmap_to_strs(struct ebitmap *map, struct strs *strs, char **val_to_name);
-char *ebitmap_to_str(struct ebitmap *map, char **val_to_name, int sort);
+int ebitmap_to_strs(const struct ebitmap *map, struct strs *strs, char **val_to_name);
+char *ebitmap_to_str(const struct ebitmap *map, char **val_to_name, int sort);
 
 int strs_stack_init(struct strs **stack);
 void strs_stack_destroy(struct strs **stack);
 int strs_stack_push(struct strs *stack, char *s);
 char *strs_stack_pop(struct strs *stack);
-int strs_stack_empty(struct strs *stack);
+int strs_stack_empty(const struct strs *stack);
 
 int sort_ocontexts(struct policydb *pdb);
-- 
2.35.1

