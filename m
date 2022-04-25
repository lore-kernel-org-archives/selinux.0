Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE3BC433EF
	for <selinux@archiver.kernel.org>; Mon, 25 Apr 2022 11:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiDYLdg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Apr 2022 07:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiDYLd1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Apr 2022 07:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED53E1F618
        for <selinux@vger.kernel.org>; Mon, 25 Apr 2022 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650886208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBjTY5s3XVQ33U5++f0xsua2G1aFHq+yNpmVCSSw3Pw=;
        b=GxSen5fww+BZq3kxDP3SzLapTV4RLyYVb4RBYtxhtNlqjnj0Mm9avnhmYiyo9k/BsifX5C
        Co/dO8ZCf52uznrhLYV5s1Q4JuIz5nj0Zf8T1zskCZ2Gb+sOuzQ0Y8WD/1R7wlyuxZ/kgK
        panAxuynB0g+Kkby4rDcrsULjXXhU2U=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-0a54LKICNie1fVxWJ3vYzA-1; Mon, 25 Apr 2022 07:30:07 -0400
X-MC-Unique: 0a54LKICNie1fVxWJ3vYzA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2f7c011e3e9so53541587b3.23
        for <selinux@vger.kernel.org>; Mon, 25 Apr 2022 04:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TBjTY5s3XVQ33U5++f0xsua2G1aFHq+yNpmVCSSw3Pw=;
        b=DhmOZrtp6zQNzktyYhFVl6NK+BlmQkS/mL90En+v1tPY9Fj5asSONPZ2y2ZWZrihGn
         gKznNKuWu9MQ3KVddIGop8dFLgiwQEu90tc7G5ftKrsxPLP0aCIDNOjEcSegZLnv+EtC
         Mng09k6wlLyxw4ZRHJuuYkC+a8IEB4jVN9bnShVBvpMetxFgwTe5v0iQWCrzZILOWtRJ
         FWDJ25XAzf0TEjEiFFHWBr4w91WJN1wF0CGU0f+wPk69j6nIKYmAk40Cw2lGqPAzH3uY
         siGptiD8IxIC/ACIfLgiskOT9uuVjBfRJMEdnVIsieTNqbLCDfkTSHmiOo/CcFUSjh2l
         +pLg==
X-Gm-Message-State: AOAM533da6uhQ3tyECtQ9dWTcZwKPA3RDoPnFY4Td7WWu6T93gW2NH3Q
        OPLMqnjYn7LsXgFl1kyEX34pKS4+dDbGrRj9qf402HVgWmGJAAA2xKzc1Z+h0x2lhDPReGAoWj5
        kBnX5Ti4fidPxcHQZfTVo42xQCiqmeS67aw==
X-Received: by 2002:a81:2514:0:b0:2f4:e0e6:d82f with SMTP id l20-20020a812514000000b002f4e0e6d82fmr15321000ywl.77.1650886206033;
        Mon, 25 Apr 2022 04:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysc6Zoa8bg0HdDMx8YrwjFueo91N4IZifGHqMw7Q6PuAZsimG/rGx1CWepaS5gGd6SMLrDa3AO43bJ5SKIPHQ=
X-Received: by 2002:a81:2514:0:b0:2f4:e0e6:d82f with SMTP id
 l20-20020a812514000000b002f4e0e6d82fmr15320977ywl.77.1650886205788; Mon, 25
 Apr 2022 04:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220422154307.968527-1-omosnace@redhat.com> <CAJ2a_DeMsOBd6ybsXXmzhwDnejJhvDVoyOucaAUY63zxN2fFcg@mail.gmail.com>
In-Reply-To: <CAJ2a_DeMsOBd6ybsXXmzhwDnejJhvDVoyOucaAUY63zxN2fFcg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Apr 2022 13:29:51 +0200
Message-ID: <CAFqZXNv63VGYyGRa1vkTLkzUt=F=xKQHVHQO7NMbQhDQ8jK5hA@mail.gmail.com>
Subject: Re: [PATCH userspace 0/2] Support the 'self' keyword in type transitions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 23, 2022 at 9:52 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Fri, 22 Apr 2022 at 17:44, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > With the addition of the anon_inode class in the kernel, 'self'
> > transition rules became useful, but haven't been implemented.
> >
> > This series implements the self keyword support in the CIL & TE
> > languages and the module policydb format. The kernel policydb format
> > doesn't need any changes, as type transitions are always expanded in th=
e
> > kernel policydb.
>
> Since the type transitions are expanded a single usage of
>
>     type_transition domain self iouring_t:anon_inode "[io_uring]";
>
> will result of thousands of filetrans entries in the binary policy.
> When using a limited type-attribute
>
>      type_transition iouring_domain self iouring_t:anon_inode "[io_uring]=
";
>
> what is the benefit of implementing the interface kernel_iouring_domain()=
 as
>
>     typeattribute $1 iouring_domain;
>
> instead of
>
>     type_transition $1 $1 iouring_t:anon_inode "[io_uring]";
>
> ?

Indeed currently it will only make a cosmetic difference. Still, I
think it is more intuitive to write the self rule than to add a rule
into the interface. Plus, it would allow you to write today a policy
that is ready for policy handling optimizations in the future (e.g. by
implementing a better attribute support for type transitions).

> Wouldn't true policydb support be much more efficient (not only
> regarding size but also (lookup) performance)?

It would only be more space-efficient. The lookup performance would
actually get worse, since you would need to look up the cartesian
product of all attributes for source and target in case of attribute
support. The individual lookups would not become faster by making the
table smaller, since the hash table size already scales with the
number of rules (elements).

> > The patches have been tested using the following WIP beakerlib/tmt test=
:
> > https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f=
/libsepol/self-keyword-in-type-transitions
> >
> > Ondrej Mosnacek (2):
> >   libsepol/cil: add support for self keyword in type transitions
> >   libsepol,checkpolicy: add support for self keyword in type transition=
s
> >
> >  checkpolicy/policy_define.c                |  42 +++++-
> >  libsepol/cil/src/cil_binary.c              | 168 +++++++++++++++------
> >  libsepol/cil/src/cil_resolve_ast.c         |  25 ++-
> >  libsepol/include/sepol/policydb/policydb.h |   4 +-
> >  libsepol/src/expand.c                      |  69 ++++++---
> >  libsepol/src/link.c                        |   1 +
> >  libsepol/src/module_to_cil.c               |  30 ++--
> >  libsepol/src/policydb.c                    |  33 +++-
> >  libsepol/src/write.c                       |  19 ++-
> >  secilc/test/policy.cil                     |   3 +
> >  10 files changed, 293 insertions(+), 101 deletions(-)
> >
> > --
> > 2.35.1
> >
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

