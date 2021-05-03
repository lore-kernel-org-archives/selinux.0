Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FCDC433B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2613B61186
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 13:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhECNtq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhECNto (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 09:49:44 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918CC06174A
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 06:48:51 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so4442291oth.5
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IL7ghQ8MMCoyFJ9NvxJ5JsnLSOMH2l43/Sc5qeSVw+w=;
        b=nmahqKYz+IgYQpL/Ig+/roY1sSHl+et1uCGZ7M8WTE+LMsbWTMWHg8FMR1kG8+L6tL
         GU/pk5Cq0BPR6oIb29gJSXUNbBLBtaN1ascy0r8DKk3S9Vwz3OFLFWnptbH1MzY3Ol++
         Gk1qmIpY3Pxy04hLvsVrm5j8O69b8MGAkYfatCGeDKLEtj3tOY1IqgwkTeAwHD5Eq2lv
         +YJOzfFwywf1AR53nuUM+vPuhpFtsReLrmh1W6hrqEX3D7+0uZ8Jp+RHo6V1dzn2HCGl
         2y/Gzf3HSgcje6HlPZ6eCmZe+nmeedryVrbdgutdtwvAHxLB84cngwzaTA20J23s2qjm
         6YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL7ghQ8MMCoyFJ9NvxJ5JsnLSOMH2l43/Sc5qeSVw+w=;
        b=CeellvF8avFnIq6JdLySQzNjzhTVg9orhFwAzX6bpvSa6UZ+ZWzhWpGFaQBi4g+d8j
         PViQ7cQKHU3zJ4QbPlYPWgab6FP6rk+zIqfiLeBHnKv/ZbQwPkPyhC6cmhTMrw5b3Xtc
         iJxH/gV2+vNERHj5cwVr1kW8XaOSPrv09cEFkGKaxJKPEt7TUBqfxPy6zgx8/mg95Z2x
         KtsEL92V7WXl9IOFhlrLlvOnDCgBpYiPyRa3SVmeSWy41vtDU3iwfjgzQfbp+Hv4FoWZ
         4sycoxIZLMaDJJgemvxSmlC3RWBgSyiqx5UEFyaeydc3OSzOY3SVG4SaDJWvnBbWLKSY
         57sg==
X-Gm-Message-State: AOAM532DwiW7i42mfzRKqF1qdtREpdn9Zn2LfxtfT1e47WVHFYZmRhHt
        gW2KQe8ZADwdqBjysFdRKMjdl+7mwbi55FMCAlTDT+Md9c0=
X-Google-Smtp-Source: ABdhPJzMvwHxi5M8vBaAjZZ2SUULc0/5jJiK39EhkC9l8zdoqbCtDsMt7T1dOcpKgPPNlIA/gY2EtQXNfbf4ReHSbD0=
X-Received: by 2002:a9d:684e:: with SMTP id c14mr7166557oto.295.1620049730456;
 Mon, 03 May 2021 06:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210428201753.282831-1-jwcart2@gmail.com> <20210428201753.282831-5-jwcart2@gmail.com>
 <CAJfZ7==fJx3RFAgkkip+3+e1WbpkkJtDryvsxrO9oZ0smHLDgA@mail.gmail.com>
In-Reply-To: <CAJfZ7==fJx3RFAgkkip+3+e1WbpkkJtDryvsxrO9oZ0smHLDgA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 3 May 2021 09:48:39 -0400
Message-ID: <CAP+JOzQZ6MBoAeReq++Y0Kx5yLGv78UjOc_RVkhaJPcG7F-+sg@mail.gmail.com>
Subject: Re: [PATCH 4/5] libsepol/cil: Check for self-referential loops in sets
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 1, 2021 at 10:33 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Apr 28, 2021 at 10:18 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The secilc-fuzzer found a self-referential loop using category sets.
> > Any set declaration in CIL that allows sets in it is susceptible to
> > the creation of a self-referential loop. There is a check, but only
> > for the name of the set being declared being used in the set
> > declaration.
> >
> > Check for self-refential loops in user, role, and type attributes
> > and in category sets. Since all of the sets need to be declared,
> > this check has to be done when verifying the CIL db before doing
> > the post phase.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 31 +---------
> >  libsepol/cil/src/cil_verify.c      | 97 +++++++++++++++++++++---------
> >  libsepol/cil/src/cil_verify.h      |  1 -
> >  3 files changed, 71 insertions(+), 58 deletions(-)
> >
> [...]
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > index 5a37dd2f..4c860a21 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -430,28 +430,71 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
> >         return SEPOL_OK;
> >  }
> >
> > -int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
> > +int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);
>
> Hello,
> Your patches look fine. Nevertheless it would be cleaner if this
> function was declared "static", as it is not used outside of
> cil_verify.c. This is a suggestion which is not blocking any merge, so
> if you prefer to merge the patches directly, feel free to do so.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

I like your suggestion better.
Thanks,
Jim

> And thanks for working on fixing issues identified by OSS-Fuzz!
> Nicolas
>
