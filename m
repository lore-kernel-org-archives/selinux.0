Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0F5C77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbjELKXi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjELKXf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85F12E
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9661047f8b8so1385059066b.0
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887008; x=1686479008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hviBcf0QT4Xg8z3jYcj4W5h7zQQx/+YLgo6TweBa6UA=;
        b=Sharqyqv5Eqjctt04VMynCiZNOzNH0HFUWWJpSxOXnyGZiHoE8KqRv+6fNnR+rUmMS
         +tv4aSWhPUgy8BNEs0xNb6/Oyxs1r52Ncp5Q/c1l1EaCC8AgXgS1Ih0Xa2FBWXPPcjot
         t04HmE4fz7bgfkGcQAEVQG75yErIcG73Y7idd95ieAvWV6qzWmYap+JErKwKgjQELG4x
         354VG7mC3ijehV5GpIVdFAQRelHwuj7hqG92hCDB8ZSMVSQ50ZYJeuNdxN8ZesoFErhK
         KoNUdv3rzzTzL1INQJdYeob+hGDOO5F9zEZmkZO7aMrspi8/yNk1AEZ3m3Do0YOyCZRc
         0hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887008; x=1686479008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hviBcf0QT4Xg8z3jYcj4W5h7zQQx/+YLgo6TweBa6UA=;
        b=R1zqHqloVU8a/zKDGklWz4Q0dj0T5UubcSxCuPPSDkTw6PbwechzDx1HPPoC9FNckw
         5NDf53OqcVHsyCfcsujpdiZIsBY03FVkZW9N+xANpISdBolSdnxA3mDalaJoj6qzX84R
         eNXUJXUzJclxV6xUY4GXnh/seH5gnr21LtLzgm8Fz4sORL5LzJ27s6uzD9OrhUzKPOq3
         PclZJgYfHqFpj2oJaHjxopM9ocVJtm83GDy9haoUfB+xQrvGjM8OaZWL/Xc70YkoC3Ib
         P78uCPbq2jlhZj7YDbvCdW3dHOSQnCqF4t7NMe1wIJM+5oK9gP4irLHvfvIrpQUBs48c
         76vQ==
X-Gm-Message-State: AC+VfDxaNiV3OIqY2DexT4qG9+Yjv3tIphekbp0oT3ljDcwO/I9j+y/x
        ZJ2ifBOkU/FkNm1ZYQCsPHyky7/2HsWrQw==
X-Google-Smtp-Source: ACHHUZ4SgjZie8wWHBfBEnjVhk7Fg5svYPxWeGLjETXvT9LENFR1Yx4SsE5x3KwI/mlSiVLvJBdWww==
X-Received: by 2002:a17:907:70a:b0:953:9024:1b50 with SMTP id xb10-20020a170907070a00b0095390241b50mr20764182ejb.74.1683887008288;
        Fri, 12 May 2023 03:23:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/9] libselinux: deprecate matchpathcon and compute_user interfaces
Date:   Fri, 12 May 2023 12:23:15 +0200
Message-Id: <20230512102322.72235-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Annotate interfaces of the matchpathcon family and
security_compute_user(3) and security_compute_user_raw(3) as deprecated.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 7f8deb65..4799dd1c 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -261,10 +261,12 @@ extern int security_compute_member_raw(const char * scon,
  */
 extern int security_compute_user(const char * scon,
 				 const char *username,
-				 char *** con) selinux_nonnull((1,2,3)) selinux_nodiscard;
+				 char *** con) selinux_nonnull((1,2,3)) selinux_nodiscard
+					       selinux_deprecated("Use get_ordered_context_list(3) family");
 extern int security_compute_user_raw(const char * scon,
 				     const char *username,
-				     char *** con) selinux_nonnull((1,2,3)) selinux_nodiscard;
+				     char *** con) selinux_nonnull((1,2,3)) selinux_nodiscard
+						   selinux_deprecated("Use get_ordered_context_list(3) family");
 
 /* Validate a transition. This determines whether a transition from scon to newcon
    using tcon as the target for object class tclass is valid in the loaded policy.
@@ -435,7 +437,7 @@ extern void selinux_flush_class_cache(void);
 /* Set the function used by matchpathcon_init when displaying
    errors about the file_contexts configuration.  If not set,
    then this defaults to fprintf(stderr, fmt, ...). */
-extern void set_matchpathcon_printf(void (*f) (const char *fmt, ...));
+extern void set_matchpathcon_printf(void (*f) (const char *fmt, ...)) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Set the function used by matchpathcon_init when checking the
    validity of a context in the file contexts configuration.  If not set,
@@ -444,7 +446,7 @@ extern void set_matchpathcon_printf(void (*f) (const char *fmt, ...));
    may include the 'path' and 'lineno' in such error messages. */
 extern void set_matchpathcon_invalidcon(int (*f) (const char *path,
 						  unsigned lineno,
-						  char *context));
+						  char *context)) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Same as above, but also allows canonicalization of the context,
    by changing *context to refer to the canonical form.  If not set,
@@ -452,13 +454,13 @@ extern void set_matchpathcon_invalidcon(int (*f) (const char *path,
    security_canonicalize_context(). */
 extern void set_matchpathcon_canoncon(int (*f) (const char *path,
 						unsigned lineno,
-						char **context));
+						char **context)) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Set flags controlling operation of matchpathcon_init or matchpathcon. */
 #define MATCHPATHCON_BASEONLY 1	/* Only process the base file_contexts file. */
 #define MATCHPATHCON_NOTRANS  2	/* Do not perform any context translation. */
 #define MATCHPATHCON_VALIDATE 4	/* Validate/canonicalize contexts at init time. */
-extern void set_matchpathcon_flags(unsigned int flags);
+extern void set_matchpathcon_flags(unsigned int flags) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Load the file contexts configuration specified by 'path'
    into memory for use by subsequent matchpathcon calls.  
@@ -472,7 +474,7 @@ extern int matchpathcon_init(const char *path) selinux_nodiscard selinux_depreca
 
 /* Same as matchpathcon_init, but only load entries with
    regexes that have stems that are prefixes of 'prefix'. */
-extern int matchpathcon_init_prefix(const char *path, const char *prefix) selinux_nodiscard;
+extern int matchpathcon_init_prefix(const char *path, const char *prefix) selinux_nodiscard selinux_deprecated("Use selabel_open(3) with backend SELABEL_CTX_FILE");
 
 /* Free the memory allocated by matchpathcon_init. */
 extern void matchpathcon_fini(void) selinux_deprecated("Use selabel_close(3)");
@@ -480,7 +482,7 @@ extern void matchpathcon_fini(void) selinux_deprecated("Use selabel_close(3)");
 /* Resolve all of the symlinks and relative portions of a pathname, but NOT
  * the final component (same a realpath() unless the final component is a
  * symlink.  Resolved path must be a path of size PATH_MAX + 1 */
-extern int realpath_not_final(const char *name, char *resolved_path) selinux_nonnull((1,2)) selinux_nodiscard;
+extern int realpath_not_final(const char *name, char *resolved_path) selinux_nonnull((1,2)) selinux_nodiscard selinux_deprecated("Not meant for external use");
 
 /* Match the specified pathname and mode against the file contexts
    configuration and set *con to refer to the resulting context.
@@ -494,25 +496,25 @@ extern int matchpathcon(const char *path,
 /* Same as above, but return a specification index for 
    later use in a matchpathcon_filespec_add() call - see below. */
 extern int matchpathcon_index(const char *path,
-			      mode_t mode, char ** con) selinux_nonnull((1,3)) selinux_nodiscard;
+			      mode_t mode, char ** con) selinux_nonnull((1,3)) selinux_nodiscard selinux_deprecated("Use selabel_lookup(3)");
 
 /* Maintain an association between an inode and a specification index,
    and check whether a conflicting specification is already associated
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the 
    file contexts configuration.  Return the used specification index. */
-extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file) selinux_nonnull((3)) selinux_nodiscard;
+extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file) selinux_nonnull((3)) selinux_nodiscard selinux_deprecated("matchpathcon family is deprecated");
 
 /* Destroy any inode associations that have been added, e.g. to restart
    for a new filesystem. */
-extern void matchpathcon_filespec_destroy(void);
+extern void matchpathcon_filespec_destroy(void) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Display statistics on the hash table usage for the associations. */
-extern void matchpathcon_filespec_eval(void);
+extern void matchpathcon_filespec_eval(void) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Check to see whether any specifications had no matches and report them.
    The 'str' is used as a prefix for any warning messages. */
-extern void matchpathcon_checkmatches(char *str);
+extern void matchpathcon_checkmatches(char *str) selinux_deprecated("matchpathcon family is deprecated");
 
 /* Match the specified media and against the media contexts 
    configuration and set *con to refer to the resulting context.
-- 
2.40.1

