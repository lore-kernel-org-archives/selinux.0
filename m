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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5781C433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D49B60F14
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 15:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbhIGPfu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbhIGPft (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 11:35:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D581C061575
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 08:34:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so13278184otf.2
        for <selinux@vger.kernel.org>; Tue, 07 Sep 2021 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBGthI259XTzW2cZm1BQxMoARAKrOsdL67nkNmoZZhE=;
        b=WKOeviTHYG/NWPYCK+aTNyS2A8OKTu4eZyDxrSMqvT7WtykrNDQTXIX4HNvmnBYtC4
         bjWkTSqSZgBpKbOWWnc1+7A+XheoBdvSa5ssdDNe97811Y+9cjchvuy9NfpeM2QUq+I2
         ZPfthWh91Fyn0ZSwQwTNQpgjIp73TzdonH+tbKG7DWcc4SDjqTJQJ5MKSG2h2pVy/AAr
         ey8DKkDOBMF8BCCsHybhzFrseiC5y1twni+aGwuPb96PX3vmAjjQhyt0tEExPuG1htGZ
         w0E7Gf5qrYZXn5EkFlTZLW1fXHPjvnsCWjkm0erGdYwP6pYT2TEm6orX/GiZZI8AH0rI
         U+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBGthI259XTzW2cZm1BQxMoARAKrOsdL67nkNmoZZhE=;
        b=ipA0C7174oHnvNl8bKuQAf55eSTvrJ4//G2tqVU26aDJfAa384ky7MvF3Kxe89c7cO
         Re9Nbj82BFGhMF4iUN7Z6tAV+070gh9ub6RnCBBY7nbmlfjt/A+UvBNQM77f/96FQMei
         SPAHQ3R+KobIFjKZTXQok/CSnV9xC2JiB0PYU34HtHrJ+/3zb7+aJA4JxF6y4kmKHX05
         oPLFSEU+TN9pTeV+f/RXUnavYUA6flSQk7JhpsorSr1OCi2a/mWOZu7kPUrbwt3eNaG2
         S5TaVmseBUO4gwWZ2OlY2Agq/qKikWKuP7V3/NuQRNKr1Q7thfNZ/Ny4lT8xHFWKYpbH
         o9tw==
X-Gm-Message-State: AOAM5300AIWW+530funzEqZoJuo84x4UYbEd+i160xBX+W1zxALVk7IK
        wOJKa5f9dG8HufaSSxdj/I4wBDn1uji1AzJJc2h9XsjFelw=
X-Google-Smtp-Source: ABdhPJw6ob38lF6iHOcFM9LnKwxq9DrBlvB24eBNAWFOU9if9GMa1kg7Yv9N28x7I6/cT1YY+YTmWOTHUr8B5AEIgds=
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr15824757oti.139.1631028882724;
 Tue, 07 Sep 2021 08:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210907134048.282918-1-plautrba@redhat.com>
In-Reply-To: <20210907134048.282918-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Sep 2021 11:34:31 -0400
Message-ID: <CAP+JOzQSP_mr+bbc3tfwYjwgSv_dBbwvKXHChG_ppEnf7y6eSQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix detected RESOURCE_LEAKs
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 7, 2021 at 9:44 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
> Error: RESOURCE_LEAK (CWE-772): [#def5]
> libsepol/src/kernel_to_cil.c:2380: alloc_arg: "strs_init" allocates memory that is stored into "strs".
> libsepol/src/kernel_to_cil.c:2386: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
> libsepol/src/kernel_to_cil.c:2386: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
> libsepol/src/kernel_to_cil.c:2386: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
> libsepol/src/kernel_to_cil.c:2507: leaked_storage: Variable "strs" going out of scope leaks the storage it points to.
>
> libsepol/src/kernel_to_conf.c:2315: alloc_arg: "strs_init" allocates memory that is stored into "strs".
> libsepol/src/kernel_to_conf.c:2321: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
> libsepol/src/kernel_to_conf.c:2321: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
> libsepol/src/kernel_to_conf.c:2321: noescape: Resource "strs" is not freed or pointed-to in "strs_add".
> libsepol/src/kernel_to_conf.c:2385: leaked_storage: Variable "strs" going out of scope leaks the storage it points to.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c  | 5 +++--
>  libsepol/src/kernel_to_conf.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 81427e65f9a1..305567a5ef1e 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2497,9 +2497,10 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
>                 sepol_printf(out, ")\n");
>         }
>
> -       strs_destroy(&strs);
> -
>  exit:
> +       if (strs)
> +               strs_destroy(&strs);
> +
>         if (rc != 0) {
>                 sepol_log_err("Error writing user declarations to CIL\n");
>         }
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 179f0ad1a5d1..eb72e4ac983e 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2375,9 +2375,10 @@ static int write_user_decl_rules_to_conf(FILE *out, struct policydb *pdb)
>                 sepol_printf(out, ";\n");
>         }
>
> -       strs_destroy(&strs);
> -
>  exit:
> +       if (strs)
> +               strs_destroy(&strs);
> +
>         if (rc != 0) {
>                 sepol_log_err("Error writing user declarations to policy.conf\n");
>         }
> --
> 2.32.0
>
