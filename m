Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973EC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 14:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BF061289
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 14:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUOGD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUOGC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 10:06:02 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9EC061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 07:03:46 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n20-20020a4abd140000b029024b43f59314so2702413oop.9
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoaByw8t+YTUjwBnTO9CDSWXmc7bBU/pqBjs2AvQGL4=;
        b=UFLiqQM+sYxn1vFwDU/E6yeXX1Gpb3GUq4t/K0OzuBp6L599aOGFpwTDKpxt+bMe/v
         CVpWICT/mjw+44miiKHyrCstl4g1e7fZM2BUPui51kqmvOJGstRbgqMggRcxYsZcXwYB
         XDP+87bPgz/joM+OmmKTDCNBGgz32U35xCeWg4zY8D5bPyUuJeVoEA4vsGlD3g+OpKdb
         dqT26b0SZPSFR9jJ2PsXaJHiowmEjQb6yNKNIGpv23wg0p3oQ5j7Gk5ctgulpwY3AHJh
         9kCWLMJpm5Y0dDaMGwaXOYaAplKy0o2XvCDaq9njiNdriHFA7Rp653SpcJRR+JMIDkYc
         ONiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoaByw8t+YTUjwBnTO9CDSWXmc7bBU/pqBjs2AvQGL4=;
        b=qXg+VcLUF5E4slDng6RWubdeReWnWuc3c0YVGlVZ1ThKnzX6L/ODLZq6cZTBSspusT
         MkPin9LAYNtaRLxgC34+BdNIg1tyOV9PSG5ULpzE8aazdCFTKdzGYVIaWZzkvX+FNMGD
         ws6K+y41myoaoTwNBWesoRYDDwM1qTvU+t9PG+hwAtD/X0ANbdFIXzx2DhtgD7hI0IiN
         nd2YtokRKn4Zy3nleE8WG9qdNa7bverJWsqYrfnOv5XbeDyWsp8jPIQE6KgSY4xrcprT
         /AUoeM3HYBgdHlUP/Mnv3GYY5qzNj3x1mLqvYD/g/wTpP2hu29pwXjl2JYqjTWL/nASD
         VhvA==
X-Gm-Message-State: AOAM531Xvz+HhzfZ0r7wpSl9piTyIsiRHSzCdA3ZpAazQAO1jqV4t0Lp
        cfOdbkSshW+XWdRLK5Pb8Jfare7h7dsn1UiiSp0=
X-Google-Smtp-Source: ABdhPJyackKO44nok+DUB6Letb02/L/TBBrPHVk1LzfBFFpdv8sw3zdU/jcjDTkkXYpgQ4lPzJZYcmvZQvZA4ZLBDYg=
X-Received: by 2002:a4a:c55:: with SMTP id n21mr20703390ooe.59.1624284225752;
 Mon, 21 Jun 2021 07:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-3-jwcart2@gmail.com>
 <CAJfZ7=kHN7b9LoHDrRwkORUNNDS-q8OsVyh21TLe0JHdbEBvyQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=kHN7b9LoHDrRwkORUNNDS-q8OsVyh21TLe0JHdbEBvyQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 10:03:34 -0400
Message-ID: <CAP+JOzQSJ3Xn1Fa7Vz7TZS_4kJychD0wnAcastJ15j3qY_a6ZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] libsepol/cil: Fix syntax checking of defaultrange rule
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 19, 2021 at 9:36 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The syntax array that cil_gen_defaultrange() called __cil_verify_syntax()
> > with was wrong. It had the range (which should be low, high, or low-high)
> > as optional when it is not.
> >
> > Use the correct syntax array to check the syntax of the defaultrange rule.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 71f14e20..a5f617d8 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -5862,7 +5862,7 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
> >                 CIL_SYN_STRING,
> >                 CIL_SYN_STRING | CIL_SYN_LIST,
> >                 CIL_SYN_STRING,
> > -               CIL_SYN_STRING | CIL_SYN_END,
> > +               CIL_SYN_STRING,
> >                 CIL_SYN_END
> >         };
> >         int syntax_len = sizeof(syntax)/sizeof(*syntax);
> > --
> > 2.26.3
>
> Hello,
> This patch will break selinux-testsuite with:
>
> /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
> test_overlay_defaultrange.cil test_userfaultfd.cil test_add_levels.cil
> test_glblub.cil
> Invalid syntax
> Bad defaultrange declaration at
> /var/lib/selinux/targeted/tmp/modules/400/test_glblub/cil:1
> Failed to build AST
> /usr/sbin/semodule: Failed!
>
> ... because it currently uses, in
> https://github.com/SELinuxProject/selinux-testsuite/blob/0b78a9d433e8c4f956d18dc0db901f0a1a58c003/policy/test_glblub.cil
> :
>
>     (defaultrange db_table glblub)
>
> If I understand the commit message correctly, a range (low, high or
> low-high) has to be added to this statement. I am not familiar with
> glbulb and do not know how the testsuite should be modified. Could the
> policy used by the testsuite be fixed before applying this patch?
>

No, the policy is correct. I forgot about glbulb and misread the
source code. I will have to check the syntax in a different way.

Thanks,
Jim


> Cheers,
> Nicolas
>
> (PS : I was quite busy last month but now I have some time again to
> catch up with SELinux patches :) )
>
