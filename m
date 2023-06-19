Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A95EB64D9
	for <selinux@archiver.kernel.org>; Mon, 19 Jun 2023 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFSVKl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 17:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVKk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Jun 2023 17:10:40 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49981E4D
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:10:39 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5700b37da3fso35553477b3.1
        for <selinux@vger.kernel.org>; Mon, 19 Jun 2023 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687209038; x=1689801038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eky39eKpgt+uahan8pNgjM2Jlc9xb7IBajMDBWI/III=;
        b=byKvbfkjmmj+mxkDLFMoJjbDX5ouCCybj9ukgKGYpk5XvnwKca87DNhK0F6mlbCswC
         tQE11YzC11QrR9XktGjujz6JiYgJmJuy+31JfVPGUiFWES0BU+cRHQbZerMuAmiMUh55
         BqUlNVaQZmxsBm2yQk214djhlaSMOm/6ihuQdvb1RiN8P7Dr9cb1030k7qNA9fRj5Ngz
         M6QqZ7aIrFDvPCo4Rd6ZpqrSfJklZ37W8GWrzZ/yUWtDYJD1/s90kX66WqoLppuH4GVJ
         75jjAa3QHkafpzogV8zxFa1n7VcNk98Klp+UlOPqUW2Yrt2oZeQtNIAAG0i/VMHEzoc3
         +MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687209038; x=1689801038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eky39eKpgt+uahan8pNgjM2Jlc9xb7IBajMDBWI/III=;
        b=O7cmjo7+fJOLEPUTnoS6eB9J+e8WNEpjsSh9RTTd4hvcVwOEzEl0zr1H9yA7rZXTBE
         vRlrL98dtsBR4R1bgAcdTVYe+5LUBZMFof8czW9BBMnpM+fmfVyZEgdF9hoV0Afpjyeq
         4n9EGKpFcR1701ChcS2BdNEJQfpO7vgibpVv4BpfsxKL2V1Leo7LDb1ZJuL/5vjKbS08
         fHX41O3yHf4INeyhCAq9OQcPerHVv8Dp9U7HRmpeJNN30QyL+lAopwD2VLIaxECiSwCn
         YjiW5GA3OY4aGt21d9xPND9XekEFqfvEWhRkRCN1DtXfVrIyrzwZDSKKWh/Ino8XRxtr
         wSxA==
X-Gm-Message-State: AC+VfDwKWYOOMiHDxgiRa/ai9nPeGrYIn2c5ZCNi6fJSnZGzcTLiuYXk
        1IAO4fW4DDvQyJv7yZs9vJ6m6WNzMjjo8YHWb+Ei
X-Google-Smtp-Source: ACHHUZ5cWhGkPaiHaBXa9tSgOQVhTYaRtlb4a7sa8AK0SP0uqJtlsbtnTpLiHkahRD8w36mg8ed1NeeO6LbsEGFkaT4=
X-Received: by 2002:a81:83d7:0:b0:56c:ea2c:5cb2 with SMTP id
 t206-20020a8183d7000000b0056cea2c5cb2mr2168042ywf.49.1687209038434; Mon, 19
 Jun 2023 14:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com> <CAHC9VhQg3ThH4A5+MggCqNxGnUOsEEgawbTmb4VO1XTWSAKCPg@mail.gmail.com>
 <CAFqZXNtjT80yK7fzGeXzXjx6E+G8GZivc8xJ20DWyUA1upmikQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtjT80yK7fzGeXzXjx6E+G8GZivc8xJ20DWyUA1upmikQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Jun 2023 17:10:27 -0400
Message-ID: <CAHC9VhSMce83Do9_oE7W5Hu2RYJED_ycfqWOCuhujERGKkFXhA@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 17, 2023 at 5:30=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Fri, Jun 16, 2023 at 10:43=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Jun 12, 2023 at 5:01=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
>
> ...
>
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 99ded60a6b911..dd410ceb178cb 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -2264,6 +2264,18 @@ static int selinux_bprm_creds_for_exec(struct =
linux_binprm *bprm)
> > >         new_tsec->keycreate_sid =3D 0;
> > >         new_tsec->sockcreate_sid =3D 0;
> > >
> > > +       /*
> > > +        * Before policy is loaded, label any task outside kernel spa=
ce
> > > +        * as SECINITSID_INIT, so that any userspace tasks surviving =
from
> > > +        * early boot end up with a label different from SECINITSID_K=
ERNEL
> > > +        * (if the policy chooses to set SECINITSID_INIT !=3D SECINIT=
SID_KERNEL).
> > > +        */
> > > +       if (!selinux_initialized()) {
> > > +               new_tsec->sid =3D SECINITSID_INIT;
> > > +               new_tsec->exec_sid =3D 0; /* just in case */
> >
> > Style nit, I don't like placing trailing comments on the same line as
> > code.  Don't respin this patch just for this, but remember this for
> > future submissions.
>
> Ack.
>
> > > +               return 0;
> > > +       }
> > > +
> > >         if (old_tsec->exec_sid) {
> > >                 new_tsec->sid =3D old_tsec->exec_sid;
> > >                 /* Reset exec SID on execve. */
> >
> > ...
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/pol=
icydb.c
> > > index 97c0074f9312a..240e0fb1d57f9 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -863,6 +863,8 @@ void policydb_destroy(struct policydb *p)
> > >  int policydb_load_isids(struct policydb *p, struct sidtab *s)
> > >  {
> > >         struct ocontext *head, *c;
> > > +       bool secsid_init_supported =3D ebitmap_get_bit(&p->policycaps=
,
> > > +                                                    POLICYDB_CAP_USE=
RSPACE_INITIAL_CONTEXT);
> >
> > This is another "please don't respin for this", but if you have to
> > respin for any reason can you change the variable name to
> > "isid_init_supported" or something similar?  The "secsid" portion of
> > the name looks wrong to me.
>
> It was supposed to be "secinitsid_init_supported" but I botched it :)
> Though that name is very long, so if I were to change it, I would go
> with your suggestion.

 :)

Since we've got a couple of weeks (-rc7 + merge window), why not go
ahead and do the respin to fix up those small things and simplify the
policycap accessor (see the other patch I posted) - does that sound
reasonable?

--=20
paul-moore.com
