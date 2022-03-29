Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE03C433F5
	for <selinux@archiver.kernel.org>; Tue, 29 Mar 2022 19:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiC2Tp2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Mar 2022 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbiC2TpZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Mar 2022 15:45:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37CA2316C
        for <selinux@vger.kernel.org>; Tue, 29 Mar 2022 12:43:40 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-de48295467so19888592fac.2
        for <selinux@vger.kernel.org>; Tue, 29 Mar 2022 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COLOv2W6kb98p/qqe60XK5otMso3FIUd0noWuXfSJQs=;
        b=Z0DqcddA5jji77hcPYj4CLEDQI9cz5xj71rGzMj7Lq2av1lf+jqdtU/+55zukmxopA
         /wkCOg7GggNcBPbl3M6LnA9cjpMdNYcIYovUxBUCCkK1HuglJWorxE64quPlJ3BlLSze
         CDbtci/OsflT74wwL5lstgo+DppxZEHjzWdW6GCV8Exx6F68O7YA8PE8v223rAPrFkxG
         3M0VXDwk3LqOKha57+rbQSeLNk7DHYKl7+IWuNreOPZP22m7ofPut/2FgpJvDG1uHXCH
         m3BgTFFUbvtumb6f49THphLCAbzgU1xCAKNbhU44Fs9dRzIqpGHoTx/fxK+PGSecW0T2
         FPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COLOv2W6kb98p/qqe60XK5otMso3FIUd0noWuXfSJQs=;
        b=2DLZxOa9EqAnLaWJiYnPwpJe5A0olU3G+0TATEgPw8B546BobtWWd6EXJM8UJw10Ob
         ZfA+33d0tQ2cg1dDikiczg6NnCgG7n6xsj8NmN0EATmn9ozQfynXcRy0hJF6aUcSY+TI
         iW7zx0KAC0csuLVMo/p8dSNAtUMC+CCeOyVsgf19U/VKrpN0bmAmAEvMNoxjAVCNRgBQ
         hmVa/OuTHkDpKx1Af5sd8wFK+1JhKFfXhp/Z7/0JOZnrhiMa4JtdEYX/5K/hdPsDROiy
         4KR03X5PVpZeJ0byrL0Kvw402PfLKllRN8LbkbGMT4jEZrQrlTL2JNRBj2n+kkIfbaca
         uMuw==
X-Gm-Message-State: AOAM532MvH0mSybGXoZAnWCWKqELOIAbsfXJScxL+WAmQ43X6yKMJ7nJ
        8u5CjtUSpI1WGUtH8L8lgG/TUte9T4QJX7xs1jJAXbr94eI=
X-Google-Smtp-Source: ABdhPJxjNYV3Uc1NboKexsaLontsUY6ju1rvTM9P28lfIAIdkdMlNlgnohaosE6VScx9JUJEQYsg9FwFaKNthT5LNYM=
X-Received: by 2002:a05:6870:e408:b0:de:b929:5206 with SMTP id
 n8-20020a056870e40800b000deb9295206mr466615oag.71.1648583020092; Tue, 29 Mar
 2022 12:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com>
In-Reply-To: <20220314182400.121510-1-jwcart2@gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 29 Mar 2022 21:43:29 +0200
Message-ID: <CAJ2a_Dd-c=xTsnz9q95dhQkwTD+iFcVuRyMCUAG2TopASY739Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 14 Mar 2022 at 19:24, James Carter <jwcart2@gmail.com> wrote:
>
> Use calloc() instead of mallocarray() so that everything is
> initialized to zero to prevent the use of unitialized memory when
> validating malformed binary policies.
>
> Found by oss-fuzz (#45493)
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index f78b38a2..a620451d 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
>         if (p->bool_val_to_struct)
>                 free(p->bool_val_to_struct);
>         p->bool_val_to_struct = (cond_bool_datum_t **)
> -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
>         if (!p->bool_val_to_struct)
>                 return -1;
>         return 0;
> --
> 2.34.1
>

Can this be merged? I think it might hurt the fuzzer, e.g. cause the
flakiness in issue #45327.

On a technical note:
In src/policydb.c::policydb_index_others() the return value of
cond_init_bool_indexes() is not checked.

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc71463e..e29cbd51 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1252,7 +1252,8 @@ int policydb_index_others(sepol_handle_t * handle,
       if (!p->type_val_to_struct)
               return -1;

-       cond_init_bool_indexes(p);
+       if (cond_init_bool_indexes(p) == -1)
+               return -1;

       for (i = SYM_ROLES; i < SYM_NUM; i++) {
               free(p->sym_val_to_name[i]);
