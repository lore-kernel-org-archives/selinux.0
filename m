Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD59C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9F96108E
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFUVAO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFUVAO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:00:14 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A02C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:57:59 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so3161587oos.1
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LLSA8iYG+n9TX1yzq3TX/JqbFc+fZ8BSd2lDwRcPxPc=;
        b=RB2aYN3jFySungjK62tTUuurWLPGFU154UN4ZidfHj6ZJfE4QShOgZ/xT2UwqMUD+n
         yn7bYQ7Qb97V/oQDcjs28XdjuAgt7gdwTzi8IRcF7J4SFSGNd4OiLqFe8dZPQ2crgahV
         Wi9DqnUNsTpubwMY1eaISFJgaeZWtJH7hLSJ3lTFp58+fI6+//7MYHrNbQnEKIZqMKr3
         EGPs3eLPURX3Qlpct1qItOrsvoD/imFXZ5zZ/6rPEjoZ7HDusLAaz0ZzF3Yr07Xi941f
         7ffjp19V/tL0mm/n2VA3addop45AKMOaaT+Lo0O7q1/DV8pTeAvTD5jZ+5VoAfHwxJLM
         UTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LLSA8iYG+n9TX1yzq3TX/JqbFc+fZ8BSd2lDwRcPxPc=;
        b=P4dYGmhYR61/wnPQi1fj6wI8ZD91Rv58lfsefnxmvOVlQc/htHdANTn04onnnRxuwg
         iM2RQVAbMutdLfSVFxmORfPzVXuV7HnC/NxOmKxN6Gf+GY1wuQf2kXcsQtYHHNEwqMqe
         d3cBR/Qu60O8PQXKFw2TscM1uNjb2njafsNGjhofyHxiF2Oq4flv/9id7oxXglVbdMTX
         3SGcNkSVm+gh4ukLtmoyNabzcTgImyJZobbEODOFkFpOuPI4qe/5I8eJe/9V3sraolFo
         ZQs0AuHXVSxEBSBmf9LQS2h7NzxFUSJuzV8vGCbe8Lk+sSd5eo2aW2fkeY+6x8UMHDSH
         KuSQ==
X-Gm-Message-State: AOAM532PJ4TSh3yWJTdgg+/EzE0a/Sw6BK07FvrH3XrdHwbXzpz4R50X
        PDxtpFeK0VT4/H17lZc0zzEdCHY+RQOY0q/nYgE=
X-Google-Smtp-Source: ABdhPJxdCRDeeohQlLnRvj/0IOY61UZ1kXYlScGCUE9W4wDVLHlSZ/blXApRhD/IW3QgFBkyOnX1+SyCE93xRX/n3hU=
X-Received: by 2002:a4a:c55:: with SMTP id n21mr45023ooe.59.1624309079315;
 Mon, 21 Jun 2021 13:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-22-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-22-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:57:48 -0400
Message-ID: <CAP+JOzTYhG4dkvGk-Cj5dE3b1J5aG+76mPmmc27Y-UR+nkANvg@mail.gmail.com>
Subject: Re: [PATCH 21/23] libsepol: drop unnecessary casts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> `hashtab_search()` does take `const_hashtab_key_t` as second parameter,
> which is a typedef for `const char *`.
> Drop the unnecessary and const-violating cast.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/services.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index f7c31d80..47a3dc14 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1182,7 +1182,7 @@ int sepol_string_to_security_class(const char *clas=
s_name,
>         class_datum_t *tclass_datum;
>
>         tclass_datum =3D hashtab_search(policydb->p_classes.table,
> -                                     (hashtab_key_t) class_name);
> +                                     class_name);
>         if (!tclass_datum) {
>                 ERR(NULL, "unrecognized class %s", class_name);
>                 return STATUS_ERR;
> @@ -1211,7 +1211,7 @@ int sepol_string_to_av_perm(sepol_security_class_t =
tclass,
>         /* Check for unique perms then the common ones (if any) */
>         perm_datum =3D (perm_datum_t *)
>                         hashtab_search(tclass_datum->permissions.table,
> -                       (hashtab_key_t)perm_name);
> +                       perm_name);
>         if (perm_datum !=3D NULL) {
>                 *av =3D 0x1 << (perm_datum->s.value - 1);
>                 return STATUS_SUCCESS;
> @@ -1222,7 +1222,7 @@ int sepol_string_to_av_perm(sepol_security_class_t =
tclass,
>
>         perm_datum =3D (perm_datum_t *)
>                         hashtab_search(tclass_datum->comdatum->permission=
s.table,
> -                       (hashtab_key_t)perm_name);
> +                       perm_name);
>
>         if (perm_datum !=3D NULL) {
>                 *av =3D 0x1 << (perm_datum->s.value - 1);
> --
> 2.32.0
>
