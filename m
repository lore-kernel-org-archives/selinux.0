Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7ECC433FE
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiKIUJx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 15:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIUJw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 15:09:52 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10710DEBB
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 12:09:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so49921341eje.1
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry5PNnAbiJxq8NNqb+nL9MTL5scPcOFNyhWrJ0VFPOw=;
        b=pDhH5TfgbHZG0iD1m5P5cSCQibrZv1xwBY6v6Wf6iHV3nQyP++66ci5x/+TXlbLca2
         LcTsOrmuNB1CCjX12HmEz+COeww/5xHglrl9+8rrs/CLLKI6sjo+mX+2aJJg7gSgqKe4
         jbLIQUy8eFo0ln70F+D6LfH4aJla9Vp82O+8VaB72AbpEfE1OncWhpUL29PCQ60FT0Nu
         qa84xbHf5wn6kKqz6vfpmmH4BjWQHhl6q+u9NCTmlZR7mS2j1MwuOrveciu4LvRBaoOn
         j4A7/tfsojAwJmE4eEaqc2FyvTS2EzTuoukiIcmWIL4YLnTgae+kcb5PjZrBAdxGyng6
         MI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry5PNnAbiJxq8NNqb+nL9MTL5scPcOFNyhWrJ0VFPOw=;
        b=fognajI/taPQVQxgspPJsG45B8TbeSFAzJj6sNMYJyol0g+Sk2yCp8dC3oFIlfXDxg
         YLybKr/G8QQUDsyBcw9svtUtKDIzZVanq7nWgjWC1KzYLxpQNa4F9ExEgh5pAF/VyHqs
         3Js/QQWRkSRU8fkqF8mGdT5PsCemEahLfrDzYNMKcV0V3YaitUBk88cxRyjFxoaYiCTo
         mQXFJVyvyIMZ9DKnb79O/WEy2ZvqttOSbBhdZgNsKqmJmuCr3mx6S5t/SdHMND0PABaE
         FRDxGj/ksSRxm7dRWc6tamood32LLnOHKTbZA/wVkTxTnt+hShrysqS2p3nYmBttBJtb
         WrJQ==
X-Gm-Message-State: ACrzQf0NlhR17BAGS12qRmMEa3VDsD7YztleuP8uY5rz41oXfrugOkLg
        3J3hOp7AFWxXvETpLODyEQa8R1d0X2A=
X-Google-Smtp-Source: AMsMyM4sQEzyShilt9x/6p/BKYuH9bmFLBxPHgVwJQN2k1tRa0Bkgo4ZXPcx3ALIZM8lFaB1uI6o6A==
X-Received: by 2002:a17:906:846b:b0:7ad:88f8:469a with SMTP id hx11-20020a170906846b00b007ad88f8469amr57900821ejc.519.1668024586550;
        Wed, 09 Nov 2022 12:09:46 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-185-019.77.10.pool.telefonica.de. [77.10.185.19])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b007adbd01c566sm6386115ejf.146.2022.11.09.12.09.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:09:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: simplify string copying
Date:   Wed,  9 Nov 2022 21:09:37 +0100
Message-Id: <20221109200939.62525-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use strdup(3)/strndup(3) instead of allocating memory and then manually
copying the content.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/context.c                     | 11 +++++------
 libselinux/src/get_default_type.c            |  3 +--
 libselinux/src/matchpathcon.c                |  9 +++------
 libselinux/utils/selabel_lookup_best_match.c | 10 ++++------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index 9dddbc5a..8830bf42 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -149,19 +149,18 @@ static int set_comp(context_private_t * n, int idx, const char *str)
 	char *t = NULL;
 	const char *p;
 	if (str) {
-		t = (char *)malloc(strlen(str) + 1);
-		if (!t) {
-			return -1;
-		}
 		for (p = str; *p; p++) {
 			if (*p == '\t' || *p == '\n' || *p == '\r' ||
 			    ((*p == ':' || *p == ' ') && idx != COMP_RANGE)) {
-				free(t);
 				errno = EINVAL;
 				return -1;
 			}
 		}
-		strcpy(t, str);
+
+		t = strdup(str);
+		if (!t) {
+			return -1;
+		}
 	}
 	conditional_free(&n->component[idx]);
 	n->component[idx] = t;
diff --git a/libselinux/src/get_default_type.c b/libselinux/src/get_default_type.c
index dd7b5d79..766ea4b7 100644
--- a/libselinux/src/get_default_type.c
+++ b/libselinux/src/get_default_type.c
@@ -62,10 +62,9 @@ static int find_default_type(FILE * fp, const char *role, char **type)
 		return -1;
 	}
 
-	t = malloc(strlen(buf) - len);
+	t = strndup(ptr, strlen(buf) - len - 1);
 	if (!t)
 		return -1;
-	strcpy(t, ptr);
 	*type = t;
 	return 0;
 }
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index ea78a23e..bf2da083 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -215,10 +215,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 			if (ret < 0 || sb.st_ino != ino) {
 				fl->specind = specind;
 				free(fl->file);
-				fl->file = malloc(strlen(file) + 1);
+				fl->file = strdup(file);
 				if (!fl->file)
 					goto oom;
-				strcpy(fl->file, file);
 				return fl->specind;
 
 			}
@@ -232,10 +231,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 			     __FUNCTION__, file, fl->file,
 			     con_array[fl->specind]);
 			free(fl->file);
-			fl->file = malloc(strlen(file) + 1);
+			fl->file = strdup(file);
 			if (!fl->file)
 				goto oom;
-			strcpy(fl->file, file);
 			return fl->specind;
 		}
 
@@ -248,10 +246,9 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 		goto oom;
 	fl->ino = ino;
 	fl->specind = specind;
-	fl->file = malloc(strlen(file) + 1);
+	fl->file = strdup(file);
 	if (!fl->file)
 		goto oom_freefl;
-	strcpy(fl->file, file);
 	fl->next = prevfl->next;
 	prevfl->next = fl;
 	return fl->specind;
diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/utils/selabel_lookup_best_match.c
index a4af0679..e816c04b 100644
--- a/libselinux/utils/selabel_lookup_best_match.c
+++ b/libselinux/utils/selabel_lookup_best_match.c
@@ -30,7 +30,7 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 	exit(1);
 }
 
-static mode_t string_to_mode(char *s)
+static mode_t string_to_mode(const char *s)
 {
 	switch (s[0]) {
 	case 'b':
@@ -53,7 +53,7 @@ static mode_t string_to_mode(char *s)
 
 int main(int argc, char **argv)
 {
-	int raw = 0, mode = 0, rc, opt, i, num_links, string_len;
+	int raw = 0, mode = 0, rc, opt, i, num_links;
 	char *validate = NULL, *path = NULL, *context = NULL, *file = NULL;
 	char **links = NULL;
 
@@ -101,13 +101,11 @@ int main(int argc, char **argv)
 		}
 
 		for (i = optind, num_links = 0; i < argc; i++, num_links++) {
-			string_len = strlen(argv[i]) + 1;
-			links[num_links] = malloc(string_len);
+			links[num_links] = strdup(argv[i]);
 			if (!links[num_links]) {
-				fprintf(stderr, "ERROR: malloc failed.\n");
+				fprintf(stderr, "ERROR: strdup failed.\n");
 				exit(1);
 			}
-			strcpy(links[num_links], argv[i]);
 		}
 	}
 
-- 
2.38.1

