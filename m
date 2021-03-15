Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E6C433DB
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D5A64F0F
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhCOVGJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhCOVGH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:06:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEAAC06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:06:06 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id x135so31414729oia.9
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4tMIjFWfcwJtn3pkHCKiniq2Ut520D8PEBb0kxPo2k=;
        b=Q2G5s4vBfcaH1g6SulALhLlvLF7WhIs4Wv+mEoH6wJBlF12Ekv0PB6f4rwryPuyX2N
         u55ArQCWrRZwcBarumTHJtVp58q2CyH32RlIijLrypGS+gtkPJ1uZ58bjpdofpTWYCRV
         cUbBmGQK6PAKqyyfcTx2sSrGAIDmXLds9eGG+11pxMH0Ag76FjtGiU2PKOk2E/Adm5Fd
         BUwOf/t7htomyrDJK5UlYrysyKjlPDeKG2oXDX0quC4/T6M+y8VGaG//bc9K897UhN3C
         Bg0N2gAQZ48J1rRBpFVW9+e5gPCYC2ydIXudhvE0AfXCWQsEjEIOE16wWvjW2C/D4fzR
         H8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4tMIjFWfcwJtn3pkHCKiniq2Ut520D8PEBb0kxPo2k=;
        b=F1AoViijGKNkRXKLcZJ3D+nJ32MTWZ9PvTFTOjCOIf+5rwFekj0OryRyXYEJJZm8Ga
         SMlKgmPlxg/ak7hS9j7zlMWsc/9YU3jai7QKUYtuTGKjaRipIXprWHrL/ypYK3XJJzzU
         mDsIhosIfG0fPGP3Zlm/z8897iwmsJAqC9EBvi1YG5TW2iPmFO5fFjJshdWwGfkoWR2e
         Lt0U7WbTdlRTHc8Fat1dOCmeUoP1DK7yWbTz8QldIRwyk0FZ/LVAf+OncSUQtU9ow2GC
         F/Mo4jRYRKRuggU7ajt4jBZ26Q1oOCzbO7lPx5jiijVfU+1V29eSUTeTwlOMaSpeXBNY
         7fkw==
X-Gm-Message-State: AOAM533C5z+p5Tkvgs21nZOK3Agr+3FnLsKu/uC6xFw6+6P0FRQKeOiD
        ++9jaSgqIpGMU86GvSdroM0TuOYtc3wfZavg00wBUuD4ZPM=
X-Google-Smtp-Source: ABdhPJwsnc/Na52m7h+/evBUaodOgb7UEAkQmHSzZpuRtiTTU1zYYsrU83uZKz8tnqb9PJcYTeRyNeK/nXdGv2F+KBw=
X-Received: by 2002:a05:6808:14d5:: with SMTP id f21mr788115oiw.16.1615842366341;
 Mon, 15 Mar 2021 14:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org> <20210314201651.474432-6-nicolas.iooss@m4x.org>
In-Reply-To: <20210314201651.474432-6-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 17:05:54 -0400
Message-ID: <CAP+JOzRTX2HNEx=6Ho9uCi6SLzKFy2AD5aLLmFEdYywN-90SYA@mail.gmail.com>
Subject: Re: [PATCH 6/6] libsepol/cil: do not leak avrulex_ioctl_table memory
 when an error occurs
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 4:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a memory leak when trying to compile the following
> policy:
>
>     (class CLASS (PERM ioctl))
>     (classorder (CLASS))
>     (sid SID)
>     (sidorder (SID))
>     (user USER)
>     (role ROLE)
>     (type TYPE)
>     (category CAT)
>     (categoryorder (CAT))
>     (sensitivity SENS)
>     (sensitivityorder (SENS))
>     (sensitivitycategory SENS (CAT))
>     (allow TYPE self (CLASS (PERM)))
>     (roletype ROLE TYPE)
>     (userrole USER ROLE)
>     (userlevel USER (SENS))
>     (userrange USER ((SENS)(SENS (CAT))))
>     (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>
>     (permissionx ioctl_test (ioctl CLASS (and (range 0x1600 0x19FF) (not (range 0x1750 0x175F)))))
>     (allowx TYPE TYPE ioctl_test)
>
>     (boolean BOOLEAN false)
>
>     (booleanif (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (not (xor (eq BOOLEAN BOOLEAN)
>                 (and (eq BOOLEAN BOOLEAN) BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>                 BOOLEAN ) ) )
>         (true
>             (allow TYPE TYPE (CLASS (PERM)))
>         )
>     )
>
> When the CIL compiler reports "Conditional expression exceeded max
> allowable depth" because of the loooooong expression in the booleanif
> statement, cil_binary_create_allocated_pdb returns without freeing the
> memory which was allocated to store the keys and values of hash table
> avrulex_ioctl_table.
>
> Fix this by moving the freeing logic to a dedicated destructor function
> and calling it in the exit block of cil_binary_create_allocated_pdb.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28618
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index f80d84679f85..18532aad9801 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1668,14 +1668,6 @@ exit:
>                 }
>                 cil_list_destroy(&xperms_list, CIL_FALSE);
>         }
> -
> -       // hashtab_t does not have a way to free keys or datum since it doesn't
> -       // know what they are. We won't need the keys/datum after this function, so
> -       // clean them up here.
> -       free(avtab_key);
> -       ebitmap_destroy(datum);
> -       free(datum);
> -
>         return rc;
>  }
>
> @@ -1885,6 +1877,15 @@ exit:
>         return rc;
>  }
>
> +static int __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t datum, __attribute__((unused)) void *args)
> +{
> +       free(k);
> +       ebitmap_destroy(datum);
> +       free(datum);
> +
> +       return SEPOL_OK;
> +}
> +
>  int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
>  {
>         int rc;
> @@ -5037,6 +5038,7 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
>
>  exit:
>         hashtab_destroy(role_trans_table);
> +       hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy, NULL);
>         hashtab_destroy(avrulex_ioctl_table);
>         free(type_value_to_cil);
>         free(class_value_to_cil);
> --
> 2.30.2
>
