Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B80C432BE
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D8E60F14
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 19:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbhHZTSa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243360AbhHZTSa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Aug 2021 15:18:30 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A6C061757
        for <selinux@vger.kernel.org>; Thu, 26 Aug 2021 12:17:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so4921327otu.2
        for <selinux@vger.kernel.org>; Thu, 26 Aug 2021 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAlwgZAKnn9F3IJmt2ZARV/nJSfuWNPeIv7TOzA7cQM=;
        b=ezDNTFjQlZuPhM6BqBQ3qMOpSDJa6trQeNfEtzd2hAnfWT002Ep4LzKD8SeiWUfpC2
         O44T0JFYwPsUjhQWOIij5rs4Li+9jNkP2LqkCFBOzL8naaDixfpDzIz/WmyJ+UT0LeBX
         avLLIQ2aZet0nLeaLbhDYhdwOfISDrmLxuR5aaT9M2A5Xxv7DJJ/npqZRGXBjZ8kNRXU
         nEyLSohBXBNoYDOhf+21/I51piRDGYd6k2z/Uijt8ImvaLCEUwMwVvLw09vbetXq/QMA
         lZ6UNxIM0af4iwyVdWUhViPITAGAKghZRUVe4oc6C0pwDW/WfnvAUSDkPfhzyoIDZ9EL
         arDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAlwgZAKnn9F3IJmt2ZARV/nJSfuWNPeIv7TOzA7cQM=;
        b=eU6G0ZLI/fmMZVRFpYONhL1UBs5ghCdQdyfapg5EQd0Y9ThFKIBOsUmVdD7od0Tc9i
         AedaBQiGW+fERjEMyUH8196r4rOTjs+w57I7/Y4rha8VwWF5ZzkZ4KulFLQPzZOUE4NT
         aCthsValKnrrSpKJ/jKZDSlAtclhGkP/TqDhoDv6UrDI3Cw0KJqAEpYGxFSTvMH1hIjc
         dO5jWqT7NI9/IY6VfPsohX7Fqkj3RqQ0sG0j0PwU5OZlocWEHgvU8Y5AGhFyt0cUAPKv
         ADC9+8ZdQeU/FunG+NzJgNklW7hm3/Aa34Rao+p8mhKPTmscawEv9t9hLi1cbHn6glHa
         GGYw==
X-Gm-Message-State: AOAM531DAX60iLVhD4gKB9iDrKpk/7AMa40QAehpRBRB3VUL6L1GZtFX
        4gDmB1GsG/jbuC5Yqmhs50Yf/XGlzUsP0vipB8mN3na7
X-Google-Smtp-Source: ABdhPJwRGTJIXT4oiYXoqGPp2apmxXXx8cpB8O2XZENjl5IznsRC5SLUyxN16HSKKWm1jvP1YdX3a1mMkVjOGg55Ezo=
X-Received: by 2002:a05:6830:1589:: with SMTP id i9mr4670840otr.196.1630005456044;
 Thu, 26 Aug 2021 12:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <81ea2624-ace9-4d86-9506-d6527a770cf6@redhat.com>
 <877dg8l83w.fsf@defensec.nl> <ce82e933-ceb8-a293-c57e-6dd6f8c31254@redhat.com>
 <8735qwl4tz.fsf@defensec.nl>
In-Reply-To: <8735qwl4tz.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 26 Aug 2021 15:25:01 -0400
Message-ID: <CAP+JOzRGVqZ1+qEam8pcNXDQRuLJ3VaEyp+zBCx5Cvu2mCQgqw@mail.gmail.com>
Subject: Re: Cil block inheritance
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Vit Mojzis <vmojzis@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Lukas Vrabec <lvrabec@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 26, 2021 at 9:21 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Vit Mojzis <vmojzis@redhat.com> writes:
>
> > On 26. 08. 21 14:10, Dominick Grift wrote:
> >> Vit Mojzis <vmojzis@redhat.com> writes:
> >>
> >>> Hi,
> >>> recent changes in block inheritance broke our use case where we use
> >>> block inheritance for generating container policies
> >>> (https://github.com/containers/udica/tree/main/udica/templates). Basically
> >>> the policy is composed by inheriting selected "template" blocks, all
> >>> of which inherit "container" block, so that they can use types defined
> >>> there.
> >>>
> >>> Reproducer:
> >>> (block template1 (type t) )
> >>> (block template2 (blockinherit template1))
> >>> (block b (blockinherit template1) (blockinherit template2))
> >> In this example there is no point in inheriting template1, because
> >> template2 already inherits it.
> >>
> >> (block template1
> >>         (type t))
> >> (block template2
> >>         (blockinherit template1))
> >> (block b (blockinherit template2)
> >>         (allow t t (file (read))))
> >>
> >> semodule -i test.cil
> >> seinfo -t b.t
> > Sure, but with more templates (as we have in udica) we get the same issue.
> >
> > (block template1 (type t) )
> > (block template2 (blockinherit template1))
> > (block template3 (blockinherit template1))
> > (block b (blockinherit template2) (blockinherit template3))
>
> This boils down to the same as above, yes.
>
> >
> > # semodule -i test.cil
> > Re-declaration of type t
> > Previous declaration of type at /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
> > Failed to copy block contents into blockinherit
> > Failed to resolve AST
> > semodule:  Failed!
> >
> >
> > Template2 and template3 mostly inherit template1 for the type defined
> > there (so that they can define rules containing the type).
> >
> >>
> >>> #semodule -i test.cil
> >>> Re-declaration of type t
> >>> Previous declaration of type at
> >>> /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
> >>> Failed to copy block contents into blockinherit
> >>> Failed to resolve AST
> >>> semodule: Failed!
> >>>
> >>> This used to work just fine.
> >>>
> >>> The following workaround seems to be working as intended, but I'm not
> >>> sure if it's the best approach. Types are only defined in template1
> >>> and the rest contains "optional" block, so that I can use types
> >>> defined in template1).
> >>>
> >>> (block template1 (type t))
> >>> (block template2
> >>>       (optional o
> >>>           (allow t t ( file ( read )))
> >>>       )
> >>> )
> >>> (block b (blockinherit template1) (blockinherit template2))
> >> You can just do something like this:
> >>
> >> (block template1 (type t))
> >> (block template2 (blockinherit template1) (optional o (allow t t (file
> >> (read))))
> >> (block b (blockinherit template2))
> >> semodule -i test.cil
> >> sesearch -A -t b.t
> > With more templates, this break as well.
> >
> > But the following works:
> >
> > (block template1 (type t))
> > (block template2 (optional o (allow t t (file (read)))))
> > (block template3 (optional o (allow t t (file (write)))))
> > (block b (blockinherit template1) (blockinherit template2) (blockinherit template3))
> >
> > #semodule -i test.cil
> > #sesearch -A -s b.t
> > allow b.t b.t:file { read write };
> >
> > Again, I'm not sure if this is the best solution, just the only one I managed to get working.
>
> Looks good enough to me (if it works then it works). I am just surprised that
> the duplicate 'o' optional block is allowed.
>

Duplicate optional blocks are allowed unless an in-statement refers to
one of them, because that is the only time the name matters.

> Duplicate type declarations are no longer allowed as you noticed, but
> fortunately you do not need them.
>

Duplicate types are allowed when using secilc with the "-m" option.
Unfortunately, that doesn't help when using semodule. It would
probably be possible to add the option if necessary.

Jim

> Whether this eventually is the best solution probably depends on other
> aspects of the policy and on the requirements.
>
> >
> > Vit
> >
> >>> #semodule -i test.cil
> >>> #sesearch -A -s b.t
> >>> allow b.t b.t:file read;
> >>>
> >>> Any pointers would be appreciated.
> >>>
> >>> Thank you.
> >>>
> >>> Vit
> >>>
> >
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
