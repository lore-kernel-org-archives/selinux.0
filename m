Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F246C77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjELKXw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjELKXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628651BC1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so14796982a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887011; x=1686479011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJy+icQz3ZaRH9DMKznHuK0ig50Tcjf4Eh/7WAUc6nQ=;
        b=MefFssQGTtTbvNLVUuiN2e97La5fIjYwkVPybty5BgFHbadt/4QUAPLi5bkkHbMOSg
         hQHQqz1LvMlZIXbZc1KOMHIBXudcdgwraJvlZTwVJJa2CKuo94sCo4C4SGwtnGJUaZ+j
         Km5qkBooIZyygZ0icwGEW0eEsMZl9+AXYhMn5BLu4wOdnew+b7zDh0ZWNmbYetYxSXoF
         DeRS5/8QH8qQHFUwMCzNP8O+z/glXQDvrS0Y7jnaSjdPaGtMjGnANU/LOj+Z9J5QFAkd
         hc8n3cROn/9FngK/FEq1t5DkZt+UDCsuPiZNp0Pdkj+cM+V+7Hc9P/Wxw/frXF+SQzrt
         6GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887011; x=1686479011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJy+icQz3ZaRH9DMKznHuK0ig50Tcjf4Eh/7WAUc6nQ=;
        b=hRZrEvfxpqB07WqHCoyct+A52XaKVm9Q0HfB4Yi3BTB0DmOMjvFRne9yRQSUUcTP16
         v30+izoCe/zWt5TWobHWYRh15wCqmW8tB6305hsk9c0YganDRCrwkb4Ee0Zhnfm2PBeA
         o6Y5kxqSCXfSGzBlSjaC2KxweZUtIGYvKDEdtuGPpyOvd3JpD2iSk/QPB5VMqfRsehf8
         pTY59cbhOK/JBgylB6sCyNOtE8cJ0C6C6cOU7bjblRr7oLxlED6I+NiW3Wv0qMgRmLfz
         1z0txX0KaKGgGSO1GAKP5FkBZgEZsKpYycrh96MP2OOqbAZvyx9nfUtyvpmBzYxiYOxN
         yc6A==
X-Gm-Message-State: AC+VfDxW0ILkPwOl8rGJbVBGYNGFIfd3nKqdS7Sp5xHfr7xJX+U1VnfP
        Ket3V3Av0DDQvTp9GYaU2C8D3MH6NWWDLA==
X-Google-Smtp-Source: ACHHUZ6ciK6ydFsBbE8S73sbddWYHiTOCay4K+tBooGCOjw3mHdW7jJRUZBAZ/QjY4JDrMQK8wj06g==
X-Received: by 2002:a17:906:ee88:b0:94b:ffe9:37fd with SMTP id wt8-20020a170906ee8800b0094bffe937fdmr23224478ejb.5.1683887010815;
        Fri, 12 May 2023 03:23:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 6/9] libselinux: ignore internal use of deprecated interfaces
Date:   Fri, 12 May 2023 12:23:19 +0200
Message-Id: <20230512102322.72235-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ignore internal use of deprecated interfaces within deprecated
interfaces.

    compute_user.c: In function ‘security_compute_user’:
    compute_user.c:93:9: error: ‘security_compute_user_raw’ is deprecated: Use get_ordered_context_list(3) family [-Werror=deprecated-declarations]
       93 |         ret = security_compute_user_raw(rscon, user, con);
          |         ^~~
    compute_user.c:13:5: note: declared here
       13 | int security_compute_user_raw(const char * scon,
          |     ^~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/compute_user.c     |  2 ++
 libselinux/src/matchpathcon.c     | 11 +++++++++++
 libselinux/src/selinux_internal.h | 14 ++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index f55f945a..5f54e16a 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -96,7 +96,9 @@ int security_compute_user(const char * scon,
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
 
+IGNORE_DEPRECATED_BEGIN
 	ret = security_compute_user_raw(rscon, user, con);
+IGNORE_DEPRECATED_END
 
 	freecon(rscon);
 	if (!ret) {
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index bf2da083..f4e34df0 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -367,7 +367,9 @@ int matchpathcon_init_prefix(const char *path, const char *subset)
 
 int matchpathcon_init(const char *path)
 {
+IGNORE_DEPRECATED_BEGIN
 	return matchpathcon_init_prefix(path, NULL);
+IGNORE_DEPRECATED_END
 }
 
 void matchpathcon_fini(void)
@@ -439,6 +441,8 @@ static int matchpathcon_internal(const char *path, mode_t mode, char ** con)
 {
 	char stackpath[PATH_MAX + 1];
 	char *p = NULL;
+
+IGNORE_DEPRECATED_BEGIN
 	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
 			return -1;
 
@@ -450,6 +454,7 @@ static int matchpathcon_internal(const char *path, mode_t mode, char ** con)
 		if (p)
 			path = p;
 	}
+IGNORE_DEPRECATED_END
 
 	return notrans ?
 		selabel_lookup_raw(hnd, con, path, mode) :
@@ -507,8 +512,10 @@ int selinux_file_context_verify(const char *path, mode_t mode)
 	char *p = NULL;
 
 	if (S_ISLNK(mode)) {
+IGNORE_DEPRECATED_BEGIN
 		if (!realpath_not_final(path, stackpath))
 			path = stackpath;
+IGNORE_DEPRECATED_END
 	} else {
 		p = realpath(path, stackpath);
 		if (p)
@@ -523,8 +530,10 @@ int selinux_file_context_verify(const char *path, mode_t mode)
 			return 0;
 	}
 	
+IGNORE_DEPRECATED_BEGIN
 	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
 			return -1;
+IGNORE_DEPRECATED_END
 
 	if (selabel_lookup_raw(hnd, &fcontext, path, mode) != 0) {
 		if (errno != ENOENT)
@@ -554,8 +563,10 @@ int selinux_lsetfilecon_default(const char *path)
 	if (lstat(path, &st) != 0)
 		return rc;
 
+IGNORE_DEPRECATED_BEGIN
 	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
 			return -1;
+IGNORE_DEPRECATED_END
 
 	/* If there's an error determining the context, or it has none, 
 	   return to allow default context */
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 06f2c038..583dc205 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -94,6 +94,20 @@ extern int selinux_page_size ;
 
 extern int has_selinux_config ;
 
+#ifdef __GNUC__
+# define IGNORE_DEPRECATED_BEGIN						\
+	_Pragma("GCC diagnostic push")					\
+	_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+#else
+# define IGNORE_DEPRECATED_BEGIN
+#endif
+
+#ifdef __GNUC__
+# define IGNORE_DEPRECATED_END	_Pragma("GCC diagnostic pop")
+#else
+# define IGNORE_DEPRECATED_END
+#endif
+
 #ifndef HAVE_STRLCPY
 size_t strlcpy(char *dest, const char *src, size_t size);
 #endif
-- 
2.40.1

