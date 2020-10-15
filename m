Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94439C433DF
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3262122264
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjyKStQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgJOR47 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404966AbgJOR47 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:56:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B833C061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:56:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f37so3692895otf.12
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u6syvxNUWzw4Og6bFtsmGyuZmXCGkGrPlUtSWs2UaA=;
        b=WjyKStQwPmtdxPVYqiY4EScEKbuuKBxasoqCwVugxoc8/0Rv26S/6jnRXhxx8U5mp0
         RzfT+VPYf8JOTCMExkkEKIzih389EzsQ977iHexRSZbHQowlC50W7nuOLcrwjhsHS5rM
         VPQ4ITzA5e0B7JRvnu/mmjD1T1hrJo1Aqr+N0b+OJTfHAUJvhk7UBkfbj3ipMWY8rAcn
         RMdpRg5Mn6atHPQw4Ls2ws/GjiZiaMZzNflnf9urMZC8nkWWCGiTGubI8tlbQUSIlkNv
         RLMyu3q9jhBoGu9+/RF9MO5pCn57Mx44wpGpQC99jZNIa5dFbH1PEWshfQT8CL8l7Zsr
         4MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u6syvxNUWzw4Og6bFtsmGyuZmXCGkGrPlUtSWs2UaA=;
        b=QjnTEwntcPj3nLoCgJEDOcsy9yUY9HuE5r984lCpD+Pn70aBHih/x+jD2Xy2w+orMr
         YC1tm2l0zDEb6PDkEN2D75VHlo1+A2tpqWLA7xk4kU7OdufzmjhhPvfx4beV1o08OtxR
         sq5FrCEqsDQ3cTLmg+LHrMAPDrJzF9xsV7dTxtbvlC/eMm9okJD2v/ahAdIN4UOc04aw
         qWIP396HMjgBbOd5Y92jNtyhyQmMkdHQ7Z83hbOD5Mi2tH0fjJK2z7ZQpIgz7KVz/6dv
         jtksgdKV1Dn9bOwMtQ6+3XjUT737kvN5lHm9ZY0BUP8mz+keYrLYDXs5B8qElonhvAXf
         JLgQ==
X-Gm-Message-State: AOAM532m+o0zfEquA+esc4oUUmMBbBj32oPzoNYUZoq2aAgYQwC1PowW
        dmaqRHTTAGnSm3MfsnzBphSFATPJOTuQ4hvYcjnEg5cCW/k=
X-Google-Smtp-Source: ABdhPJzc1tZrUhZ2IQyuM5BZMb1Bovt3fk/imZlP/ybGruP1KF2u6ju+9TGBUzvSVilA9bhHNvkCeWgQXH+b4mKyyMs=
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr3680615oto.295.1602784618736;
 Thu, 15 Oct 2020 10:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <20201009130052.52409-3-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-3-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:56:47 -0400
Message-ID: <CAP+JOzR_40xCxMy4geP2EkhzPiisPfTjreGWotGYBCMknyj3oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] libsepol: Drop deprecated functions
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:47 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> These functions were converted to no-op by commit
> c3f9492d7ff0 ("selinux: Remove legacy local boolean and user code") and
> left in libsepol/src/deprecated_functions.c to preserve API/ABI. As we
> change libsepol ABI dropping duplicate symbols it's time to drop these
> functions too.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/booleans.h |  5 ----
>  libsepol/include/sepol/users.h    |  6 ----
>  libsepol/src/deprecated_funcs.c   | 50 -------------------------------
>  libsepol/src/libsepol.map.in      |  4 ---
>  4 files changed, 65 deletions(-)
>  delete mode 100644 libsepol/src/deprecated_funcs.c
>
> diff --git a/libsepol/include/sepol/booleans.h b/libsepol/include/sepol/booleans.h
> index 06d2230c395d..25229057dbd7 100644
> --- a/libsepol/include/sepol/booleans.h
> +++ b/libsepol/include/sepol/booleans.h
> @@ -10,11 +10,6 @@
>  extern "C" {
>  #endif
>
> -/* These two functions are deprecated. See src/deprecated_funcs.c */
> -extern int sepol_genbools(void *data, size_t len, const char *boolpath);
> -extern int sepol_genbools_array(void *data, size_t len,
> -                               char **names, int *values, int nel);
> -
>  /* Set the specified boolean */
>  extern int sepol_bool_set(sepol_handle_t * handle,
>                           sepol_policydb_t * policydb,
> diff --git a/libsepol/include/sepol/users.h b/libsepol/include/sepol/users.h
> index 70158ac41e40..156d1adb2d60 100644
> --- a/libsepol/include/sepol/users.h
> +++ b/libsepol/include/sepol/users.h
> @@ -10,12 +10,6 @@
>  extern "C" {
>  #endif
>
> -/* These two functions are deprecated. See src/deprecated_funcs.c */
> -extern int sepol_genusers(void *data, size_t len,
> -                         const char *usersdir,
> -                         void **newdata, size_t * newlen);
> -extern void sepol_set_delusers(int on);
> -
>  /* Modify the user, or add it, if the key is not found */
>  extern int sepol_user_modify(sepol_handle_t * handle,
>                              sepol_policydb_t * policydb,
> diff --git a/libsepol/src/deprecated_funcs.c b/libsepol/src/deprecated_funcs.c
> deleted file mode 100644
> index d0dab7dfcb4a..000000000000
> --- a/libsepol/src/deprecated_funcs.c
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -#include <stdio.h>
> -#include "debug.h"
> -
> -/*
> - * Need to keep these stubs for the libsepol interfaces exported in
> - * libsepol.map.in, as they are part of the shared library ABI.
> - */
> -
> -static const char *msg = "Deprecated interface";
> -
> -/*
> - * These two functions are deprecated and referenced in:
> - *     include/libsepol/users.h
> - */
> -int sepol_genusers(void *data __attribute((unused)),
> -                  size_t len __attribute((unused)),
> -                  const char *usersdir __attribute((unused)),
> -                  void **newdata __attribute((unused)),
> -                  size_t *newlen __attribute((unused)))
> -{
> -       WARN(NULL, "%s", msg);
> -       return -1;
> -}
> -
> -void sepol_set_delusers(int on __attribute((unused)))
> -{
> -       WARN(NULL, "%s", msg);
> -}
> -
> -/*
> - * These two functions are deprecated and referenced in:
> - *     include/libsepol/booleans.h
> - */
> -int sepol_genbools(void *data __attribute((unused)),
> -                  size_t len __attribute((unused)),
> -                  const char *booleans __attribute((unused)))
> -{
> -       WARN(NULL, "%s", msg);
> -       return -1;
> -}
> -
> -int sepol_genbools_array(void *data __attribute((unused)),
> -                        size_t len __attribute((unused)),
> -                        char **names __attribute((unused)),
> -                        int *values __attribute((unused)),
> -                        int nel __attribute((unused)))
> -{
> -       WARN(NULL, "%s", msg);
> -       return -1;
> -}
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 98da9789b71b..eb5721257638 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -45,9 +45,6 @@ LIBSEPOL_1.0 {
>         sepol_context_to_string;
>         sepol_debug;
>         sepol_expand_module;
> -       sepol_genbools;
> -       sepol_genbools_array;
> -       sepol_genusers;
>         sepol_get_disable_dontaudit;
>         sepol_get_preserve_tunables;
>         sepol_handle_create;
> @@ -213,7 +210,6 @@ LIBSEPOL_1.0 {
>         sepol_port_set_port;
>         sepol_port_set_proto;
>         sepol_port_set_range;
> -       sepol_set_delusers;
>         sepol_set_disable_dontaudit;
>         sepol_set_expand_consume_base;
>         sepol_set_policydb_from_file;
> --
> 2.28.0
>
