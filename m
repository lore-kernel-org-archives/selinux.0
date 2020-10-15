Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99CCC433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E5E2225E
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh5ryDxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgJOR4M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgJOR4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:56:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D55FC061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:56:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e20so3684018otj.11
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHXfit6hP0IcG+ILquVsRAVndUKlAZ9CjBn1b2zCJu8=;
        b=Uh5ryDxHq5G8SYor6XyXBsRWNe9o/pJnrJF6UD/vxn4Jk10x2r9aNjOQitok4Etv37
         sWhgVZZKPKHWXTiatM1Y5fl9sZdkxsd+yuSl2//3wZ+wQhbOStC7mtlY97EbcX6aBI5U
         yD6wOr0pLlY1WemRZnU/HfP+Z2WnayhEh+aVtgdnbcx8Fctw58VPOQk8Y3MonQFY8VPL
         hCeFy4VPeFAhD/KVkm4QQ44iD9UyvGSX7T0EXRzy+cmb25MaJpyo+344yaBkj/NhqyOG
         DFUQhzF2tuP4anx70e/XzAXjF7dFfjAOJiITjzIxaDOokvMhZaLNomH2TInFF9BaM2tU
         Hl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHXfit6hP0IcG+ILquVsRAVndUKlAZ9CjBn1b2zCJu8=;
        b=oaKm8fr0GlrD2dHE1ky8Z/+YliHpVVZvPi264+XD4RluFvQv4WQgPXT7bZYiWUwNKO
         sWow14YbKoST3Fsf+NyFfv7RwdeZ/brUDHbsyWOj/hkIZ7YMaKLWJ0ttpWTnhrhK3r2c
         DUeNu90rIkG6GIEKOZ/SNM3zoo9/gXTAwHoNvA1n9sn8bwcg6Ust5Llz/zkBvw3aj4UJ
         2OgRFBS+9LZum4RCcV/+fwn4sE320Y3u+KN6gMWlwNOQH409c10Jt2MDq4vG4JGWAfGU
         ZN06XsELwRVepAZTvL8/xluYh2EHI/9HrnRwXwGuCpgbjm9hCdnHxbRonhnC/H1BXBWO
         gyIg==
X-Gm-Message-State: AOAM530lXMUvieIwGoIIc1n/vvcLj70ARXyU7PHEDCsV3xMCGShU+kts
        iA/x8f8RNuUY5EN2AE10NptM4rhVeM8MFOd+Zv58YUT55Rk=
X-Google-Smtp-Source: ABdhPJz9YvOJYkDYdkPdHqCsQanYaFBS7tEU2RXuUsZwlDi36ljBD/vqHoQNCGVjJkZH4FL2d+PxL2ZDtDGUs6cOmFc=
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr3678331oto.295.1602784569386;
 Thu, 15 Oct 2020 10:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <20201009130052.52409-2-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-2-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:55:58 -0400
Message-ID: <CAP+JOzRrGe2v1TenUgSN1Vqsyj=eyBOfs9BBQ+UQyfpZN0HWwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] libsepol: Get rid of the old and duplicated symbols
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:47 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Versioned duplicate symbols cause problems for LTO. These symbols were
> introduced during the CIL integration several releases ago and were only
> consumed by other SELinux userspace components.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/245
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil.c       | 84 ------------------------------------
>  libsepol/src/libsepol.map.in |  5 ---
>  2 files changed, 89 deletions(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index a3c6a2934c72..95bdb5e5854c 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -51,27 +51,6 @@
>  #include "cil_policy.h"
>  #include "cil_strpool.h"
>
> -#if !defined(SHARED) || defined(ANDROID) || defined(__APPLE__)
> -    #define DISABLE_SYMVER 1
> -#endif
> -
> -#ifndef DISABLE_SYMVER
> -asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
> -asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
> -
> -asm(".symver cil_compile_pdb,   cil_compile@LIBSEPOL_1.0");
> -asm(".symver cil_compile_nopdb, cil_compile@@LIBSEPOL_1.1");
> -
> -asm(".symver cil_userprefixes_to_string_pdb,   cil_userprefixes_to_string@LIBSEPOL_1.0");
> -asm(".symver cil_userprefixes_to_string_nopdb, cil_userprefixes_to_string@@LIBSEPOL_1.1");
> -
> -asm(".symver cil_selinuxusers_to_string_pdb,   cil_selinuxusers_to_string@LIBSEPOL_1.0");
> -asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSEPOL_1.1");
> -
> -asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@LIBSEPOL_1.0");
> -asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
> -#endif
> -
>  int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
>         {64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
>         {64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
> @@ -549,11 +528,7 @@ exit:
>         return rc;
>  }
>
> -#ifdef DISABLE_SYMVER
>  int cil_compile(struct cil_db *db)
> -#else
> -int cil_compile_nopdb(struct cil_db *db)
> -#endif
>  {
>         int rc = SEPOL_ERR;
>
> @@ -597,33 +572,7 @@ exit:
>         return rc;
>  }
>
> -#ifndef DISABLE_SYMVER
> -int cil_compile_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db)
> -{
> -       return cil_compile_nopdb(db);
> -}
> -
> -int cil_build_policydb_pdb(cil_db_t *db, sepol_policydb_t *sepol_db)
> -{
> -       int rc;
> -
> -       cil_log(CIL_INFO, "Building policy binary\n");
> -       rc = cil_binary_create_allocated_pdb(db, sepol_db);
> -       if (rc != SEPOL_OK) {
> -               cil_log(CIL_ERR, "Failed to generate binary\n");
> -               goto exit;
> -       }
> -
> -exit:
> -       return rc;
> -}
> -#endif
> -
> -#ifdef DISABLE_SYMVER
>  int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
> -#else
> -int cil_build_policydb_create_pdb(cil_db_t *db, sepol_policydb_t **sepol_db)
> -#endif
>  {
>         int rc;
>
> @@ -1371,11 +1320,7 @@ const char * cil_node_to_string(struct cil_tree_node *node)
>         return "<unknown>";
>  }
>
> -#ifdef DISABLE_SYMVER
>  int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size)
> -#else
> -int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
> -#endif
>  {
>         int rc = SEPOL_ERR;
>         size_t str_len = 0;
> @@ -1420,13 +1365,6 @@ exit:
>
>  }
>
> -#ifndef DISABLE_SYMVER
> -int cil_userprefixes_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
> -{
> -       return cil_userprefixes_to_string_nopdb(db, out, size);
> -}
> -#endif
> -
>  static int cil_cats_to_ebitmap(struct cil_cats *cats, struct ebitmap* cats_ebitmap)
>  {
>         int rc = SEPOL_ERR;
> @@ -1614,11 +1552,7 @@ static int __cil_level_to_string(struct cil_level *lvl, char *out)
>         return str_tmp - out;
>  }
>
> -#ifdef DISABLE_SYMVER
>  int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size)
> -#else
> -int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
> -#endif
>  {
>         size_t str_len = 0;
>         int buf_pos = 0;
> @@ -1675,18 +1609,7 @@ int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size
>         return SEPOL_OK;
>  }
>
> -#ifndef DISABLE_SYMVER
> -int cil_selinuxusers_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
> -{
> -       return cil_selinuxusers_to_string_nopdb(db, out, size);
> -}
> -#endif
> -
> -#ifdef DISABLE_SYMVER
>  int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
> -#else
> -int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
> -#endif
>  {
>         uint32_t i = 0;
>         int buf_pos = 0;
> @@ -1804,13 +1727,6 @@ int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
>         return SEPOL_OK;
>  }
>
> -#ifndef DISABLE_SYMVER
> -int cil_filecons_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
> -{
> -       return cil_filecons_to_string_nopdb(db, out, size);
> -}
> -#endif
> -
>  void cil_set_disable_dontaudit(struct cil_db *db, int disable_dontaudit)
>  {
>         db->disable_dontaudit = disable_dontaudit;
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index f08c2a861693..98da9789b71b 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -1,19 +1,14 @@
>  LIBSEPOL_1.0 {
>    global:
>         cil_add_file;
> -       cil_build_policydb;
> -       cil_compile;
>         cil_db_destroy;
>         cil_db_init;
> -       cil_filecons_to_string;
> -       cil_selinuxusers_to_string;
>         cil_set_disable_dontaudit;
>         cil_set_disable_neverallow;
>         cil_set_handle_unknown;
>         cil_set_log_handler;
>         cil_set_log_level;
>         cil_set_preserve_tunables;
> -       cil_userprefixes_to_string;
>         expand_module_avrules;
>         sepol_bool_clone;
>         sepol_bool_compare;
> --
> 2.28.0
>
