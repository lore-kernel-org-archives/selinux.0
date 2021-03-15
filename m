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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87399C433E6
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 15:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D69B64D5D
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 15:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCOPBf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhCOPBd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 11:01:33 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9ECC06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 08:01:33 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so2990155ool.0
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYEeMsA4j7jaWKS90jObBYSrTyrTDkUZH6sDZPTQf4s=;
        b=I7jk/XBbdvoyVE7E4Am8HrzWqgM418DI23q3/7/EviJS0s5GfEMiYYDPiUTrHN+vGv
         gU+oJPZa+tbPk5tt/WW4n9tRkCs8yOENlMvVr9qSD+DGiK5+DRF6oQUGu7R6nx6uBIzv
         dN+k0zyNcAqB3L3vv2SXFmNozqMP2fcFml8zEbP1MFQxgH4wWtRCDsVWp+oa09Z2XmLF
         YWYwRxI/OLPGm7nN6OlCH9am1rHm4ijWUmJSyOZmFQPzFSb4Y2TGYiNDKcRm64v+B0dW
         VO/8ZFgXk09lA58Rbat798JS8S4osugFxhsZiPQBlHSOGMYxhWZmTG47ip09aKDB+T4y
         YWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYEeMsA4j7jaWKS90jObBYSrTyrTDkUZH6sDZPTQf4s=;
        b=KyGEeJjv6ys28e+tgaXaUjPpp8FppSQE+vM+2BcHp7QeHfHtACSjIoQ1XJQey7kb9R
         IUfSfq1K1+xNYc+YP8sedoj/TWPK1Wh8813+c5eD6paruJrJqzp95I8n1cJMn4q6Gnlt
         5Bl4vBfyBIOwPkqvIUL+v/5Wvu8Mfg503JPguuijcAYS/isR2k/5OgAjgzbEUyUsDc9m
         ZXtQZK+4nIn5xN/EC3KatFoSM95HQAzCQEMVvUu8OHNdRZwJab99PcC/G+3SqlWWQsLU
         EDrvmQq0SEwaFB8ypbDprCHmFEWQ66rLZ9susTYi1iAfJHgdEtHmJlK8vOPTt9NfPJS8
         6Jkg==
X-Gm-Message-State: AOAM533ROp/7JiCueAyKLrFcFzfrn8/dRlpfgEoJcmFyKThC9alMSAms
        lTAGWnLxhUDP/dpO9BlMgO9F/HgWpdE7VE1gvxUDa83t
X-Google-Smtp-Source: ABdhPJygg7i3IR/JGxC3sbBbaTBPhd/D7w1dGzjWedTHvdGxlKLurozC0ygzlECQM4FYUaeG7S0Htz0mu/GediN36IQ=
X-Received: by 2002:a4a:bb14:: with SMTP id f20mr13787303oop.1.1615820492731;
 Mon, 15 Mar 2021 08:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210311154105.195494-1-jwcart2@gmail.com> <CAJfZ7==b4MYBKtAHL-M-YdU5Pk+SbgVad-YN6UZBxi6cvV=Mcg@mail.gmail.com>
In-Reply-To: <CAJfZ7==b4MYBKtAHL-M-YdU5Pk+SbgVad-YN6UZBxi6cvV=Mcg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 11:01:21 -0400
Message-ID: <CAP+JOzSLw1Hrgs9k8oCt_MAaHSkmwfmEZcDiZDqGoH=GBWB=0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: Do not automatically upgrade when using
 "-b" flag
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 7:27 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Mar 11, 2021 at 4:41 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > When reading a binary policy, do not automatically change the version
> > to the max policy version supported by libsepol or, if specified, the
> > value given using the "-c" flag.
> >
> > If the binary policy version is less than or equal to version 23
> > (POLICYDB_VERSION_PERMISSIVE) than do not automatically upgrade the
> > policy and if a policy version is specified by the "-c" flag, only set
> > the binary policy to the specified version if it is lower than the
> > current version.
> >
> > If the binary policy version is greater than version 23 than it should
> > be set to the maximum version supported by libsepol or, if specified,
> > the value given by the "-c" flag.
> >
> > The reason for this change is that policy versions 20
> > (POLICYDB_VERSION_AVTAB) to 23 have a more primitive support for type
> > attributes where the datums are not written out, but they exist in the
> > type_attr_map. This means that when the binary policy is read by
> > libsepol, there will be gaps in the type_val_to_struct and
> > p_type_val_to_name arrays and policy rules can refer to those gaps.
> > Certain libsepol functions like sepol_kernel_policydb_to_conf() and
> > sepol_kernel_policydb_to_cil() do not support this behavior and need
> > to be able to identify these policies. Policies before version 20 do not
> > support attributes at all and can be handled by all libsepol functions.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  checkpolicy/checkpolicy.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index 5841c5c4..e7b225b8 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -106,7 +106,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
> >  static const char *txtfile = "policy.conf";
> >  static const char *binfile = "policy";
> >
> > -unsigned int policyvers = POLICYDB_VERSION_MAX;
> > +unsigned int policyvers = 0;
>
> Hi,
> This change breaks "make test" when testing secilc. This is because
> secilc/Makefile uses "checkpolicy -V" to compute a policy version:
>
> POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
>
> Before your patch:
>
> $ checkpolicy -V
> 33 (compatibility range 33-15)
>
> After:
>
> $ checkpolicy -V
> 0 (compatibility range 33-15)
>
> .. which makes secilc/Makefile try using "secilc -c 0 ...", which does not work.
>
> Should "policyvers ? policyvers : POLICYDB_VERSION_MAX" also be used
> when "checkpolicy -V" displays version information?
>

Yes it should. I'll send an updated patch.
Thanks,
Jim

> Thanks,
> Nicolas
>
> >
> >  static __attribute__((__noreturn__)) void usage(const char *progname)
> >  {
> > @@ -588,6 +588,16 @@ int main(int argc, char **argv)
> >                                 exit(1);
> >                         }
> >                 }
> > +
> > +               if (policydbp->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
> > +                       if (policyvers > policydbp->policyvers) {
> > +                               fprintf(stderr, "Binary policies with version <= %u cannot be upgraded\n", POLICYDB_VERSION_PERMISSIVE);
> > +                       } else if (policyvers) {
> > +                               policydbp->policyvers = policyvers;
> > +                       }
> > +               } else {
> > +                       policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
> > +               }
> >         } else {
> >                 if (conf) {
> >                         fprintf(stderr, "Can only generate policy.conf from binary policy\n");
> > @@ -629,6 +639,8 @@ int main(int argc, char **argv)
> >                         policydb_destroy(policydbp);
> >                         policydbp = &policydb;
> >                 }
> > +
> > +               policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
> >         }
> >
> >         if (policydb_load_isids(&policydb, &sidtab))
> > @@ -654,8 +666,6 @@ int main(int argc, char **argv)
> >                         }
> >                 }
> >
> > -               policydb.policyvers = policyvers;
> > -
> >                 if (!cil) {
> >                         if (!conf) {
> >                                 policydb.policy_type = POLICY_KERN;
> > --
> > 2.26.2
> >
>
