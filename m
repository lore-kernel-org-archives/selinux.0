Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6ABC433DF
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE98A22264
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv/pyGGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgJOR5h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbgJOR5g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:57:36 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F73C061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:57:36 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id w25so922990oos.10
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ogn8vjS2DhpS9XC1XaMV13FAO/PKn/kpm0Sja3TLF7g=;
        b=Mv/pyGGOfQKyK9mcvgtnPgaTQC5KTuwXQXjiU9dA1kexaE8tyYA89O9iRnruw/dM2I
         wD+TqmpIpd0Uchn5NyCWV/3mwMDy4whnZhsGf1CWVW4/XKzqcJryqn0HoBkOF91mIgQV
         //AlpBp7esp5SPUuEEwNr88CuBoxY31T1tflTG0ivBp0aovZMsk6XfnbVMOb+1ym5Rbm
         eqnkQ0Gc2TjrhbeFfIdrkE4XkmIWfiayXNlK5bwd73UFdYutBDKnWRQaDfb8zLt62Ans
         6n+Y4eBaKcZPznOjAqzTgnn6ZPRR9bvpEVLGujU8307QWut9B6ss7sTWkpprcpHATyzR
         cm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ogn8vjS2DhpS9XC1XaMV13FAO/PKn/kpm0Sja3TLF7g=;
        b=FNtXglLhMb7mG4luEUO8TH/nKr2DDK9sc+zGjHFTOxAoJ/2lm7bwTlkNnuJh0JbhXB
         DFdgcTev/7bpfstV8rmJlfQYy0cZSN7vyHqpmPfISoNVrNGZqEdCrHZombFf4V62tEop
         g9h+iLr9nITStzzj/apwFi+tO/6SxFHQc71e+f7+IBkNOaf/bYsuxYQ6e9wE51y+Jvr/
         xWF4SjTLN4Vrjq8DvUFRBYJRYpHAcupMuszv7wXt/5/xK+NajrCjAcbzNeO+fg+pvVn6
         pFZEeMPJ863tDQec1W1DElr7nGCFeNFos4Nt7reoge3eE3xfZyChPoqpH0lA0tID5C2v
         XOfg==
X-Gm-Message-State: AOAM532Oc/vlYiTmqMILPC1eMm6/+4yHtK3ORPkSyNTkf+K/8h++zdoY
        i66IVxU6ngjqTKBzDGdhboNPOdwC0oK4mJsEneE=
X-Google-Smtp-Source: ABdhPJxTRJijpg9Mpz8fSS6QXzXU4YfxrFpVGW9b4d1hy5f58B6bvwZPnwKsGRKhOOadNJf9joABers5fmiEd5EGYyc=
X-Received: by 2002:a4a:a844:: with SMTP id p4mr3273893oom.59.1602784656171;
 Thu, 15 Oct 2020 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <20201009130052.52409-6-plautrba@redhat.com>
In-Reply-To: <20201009130052.52409-6-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:57:25 -0400
Message-ID: <CAP+JOzS0F2ZesNrw+L8+A0eQ6Tp8axMqpQa230NeDMNjGJms6g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] libsemanage: Drop deprecated functions
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 9:48 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> semanage_module_enable() and semanage_module_disable() were deprecated
> by commit 9fbc6d14418f ("libsemanage: add back original module
> enable/disable functions for ABI compatability") in 2014 in order to
> preserve ABI compatibility. As we the libsemanage ABI is changed by the
> previous commit, it makes sense to drop them completely.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/libsemanage.map |  2 --
>  libsemanage/src/modules.c       | 56 ---------------------------------
>  2 files changed, 58 deletions(-)
>
> diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
> index 4bec06aaae27..3ea7b60f97bb 100644
> --- a/libsemanage/src/libsemanage.map
> +++ b/libsemanage/src/libsemanage.map
> @@ -165,8 +165,6 @@ LIBSEMANAGE_1.0 {
>      semanage_is_connected;
>      semanage_is_managed;
>      semanage_mls_enabled;
> -    semanage_module_disable;
> -    semanage_module_enable;
>      semanage_module_get_name;
>      semanage_module_get_version;
>      semanage_module_info_datum_destroy;
> diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
> index 8b36801038df..b6dd456cac32 100644
> --- a/libsemanage/src/modules.c
> +++ b/libsemanage/src/modules.c
> @@ -734,62 +734,6 @@ int semanage_module_set_enabled(semanage_handle_t *sh,
>  }
>
>
> -/* This function exists only for ABI compatibility. It has been deprecated and
> - * should not be used. Instead, use semanage_module_set_enabled() */
> -int semanage_module_enable(semanage_handle_t *sh, char *module_name)
> -{
> -       int rc = -1;
> -       semanage_module_key_t *modkey = NULL;
> -
> -       rc = semanage_module_key_create(sh, &modkey);
> -       if (rc != 0)
> -               goto exit;
> -
> -       rc = semanage_module_key_set_name(sh, modkey, module_name);
> -       if (rc != 0)
> -               goto exit;
> -
> -       rc = semanage_module_set_enabled(sh, modkey, 1);
> -       if (rc != 0)
> -               goto exit;
> -
> -       rc = 0;
> -
> -exit:
> -       semanage_module_key_destroy(sh, modkey);
> -       free(modkey);
> -
> -       return rc;
> -}
> -
> -/* This function exists only for ABI compatibility. It has been deprecated and
> - * should not be used. Instead, use semanage_module_set_enabled() */
> -int semanage_module_disable(semanage_handle_t *sh, char *module_name)
> -{
> -       int rc = -1;
> -       semanage_module_key_t *modkey = NULL;
> -
> -       rc = semanage_module_key_create(sh, &modkey);
> -       if (rc != 0)
> -               goto exit;
> -
> -       rc = semanage_module_key_set_name(sh, modkey, module_name);
> -       if (rc != 0)
> -               goto exit;
> -
> -       rc = semanage_module_set_enabled(sh, modkey, 0);
> -       if (rc != 0)
> -               goto exit;
> -
> -       rc = 0;
> -
> -exit:
> -       semanage_module_key_destroy(sh, modkey);
> -       free(modkey);
> -
> -       return rc;
> -}
> -
>  /* Converts a string to a priority
>   *
>   * returns -1 if str is not a valid priority.
> --
> 2.28.0
>
