Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4DEEB64D7
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 09:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFTJZm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjFTJZl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 05:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D17D1
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687253094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ee8MeM7pdwC9xdBvX/lSGI6rMIKhaTLCUn3gLud4gx0=;
        b=X5QYtVuoOtjhbLqs3S7q/4DtvejGW/zd5WXMiw0xhjB0DWRYSrVq7IUY5/8QVyIsjqIQuO
        rwYMLhZBUfEunhwvjTae2j3+jiHkMR8iNj0WeUFC+Ljo85id4enMsM0KswqJbbBlIv0csR
        xe1Ayug3zF9yk6xW6PCHzlegGxONYvo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-qewHObgsPciLUDgykwhbog-1; Tue, 20 Jun 2023 05:24:50 -0400
X-MC-Unique: qewHObgsPciLUDgykwhbog-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-66881827473so893146b3a.2
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687253089; x=1689845089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee8MeM7pdwC9xdBvX/lSGI6rMIKhaTLCUn3gLud4gx0=;
        b=X7gHuJJzvfKthbti7HbBFQO3HCejMfAyfwfZ6mlRvSRTq+LO7FTW6cd2StMD/VuudO
         TFDyhP6JyLB8qVHN0CK7BbHrEEh/Xam37Ikfhn+kHaJu7EpczVogfKakWNpWHveuvfkl
         Vaz6AJ4q8DhAxkhzGs8ONNSOgq5chaKxG2CGx5bi9ifrpAodPzJAGTx94yK6azljSKFn
         SGGNiadaQQCbSYODmcykRxQtZQ45Qd+9fwOYGJPnE61HpGqq+7Hft6WBiAh9y7JkJYDA
         8JfjyKeI1bh9jDmCEHlsWg6sAcJzCLcqpTgqDwvR4iTDFpTi3iT9cRX7PDzuztYYfAgY
         G2/Q==
X-Gm-Message-State: AC+VfDydhzbf7ehaI3igSCMjuMeUN1cSLtlm8M5JmawNnM00AyfuZSKU
        iK++t/3SAstgk/+AU8uf+QXka9Ug+a7DjW7iatlSpzx302MoVAjmMNP2X7VzqtQ05tbNvuETqEZ
        x2GlqaC0aZEsnXAUAEMWPzIue18Cd+Gq4Z6Y9wGnXTLVl
X-Received: by 2002:a05:6a00:a17:b0:668:7090:bf11 with SMTP id p23-20020a056a000a1700b006687090bf11mr5608927pfh.5.1687253089098;
        Tue, 20 Jun 2023 02:24:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+8hr4cR6p5YmiT64B5W95qS1mcWBl9wFS+3rT8l0Pt/npW0b3VnQVn0RbR/o32D8i1NVwOF3NZd8I4hHSzIg=
X-Received: by 2002:a05:6a00:a17:b0:668:7090:bf11 with SMTP id
 p23-20020a056a000a1700b006687090bf11mr5608915pfh.5.1687253088787; Tue, 20 Jun
 2023 02:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com> <CAHC9VhQg3ThH4A5+MggCqNxGnUOsEEgawbTmb4VO1XTWSAKCPg@mail.gmail.com>
 <CAFqZXNtjT80yK7fzGeXzXjx6E+G8GZivc8xJ20DWyUA1upmikQ@mail.gmail.com> <CAHC9VhSMce83Do9_oE7W5Hu2RYJED_ycfqWOCuhujERGKkFXhA@mail.gmail.com>
In-Reply-To: <CAHC9VhSMce83Do9_oE7W5Hu2RYJED_ycfqWOCuhujERGKkFXhA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 20 Jun 2023 11:24:35 +0200
Message-ID: <CAFqZXNuttbwb1FLJfbFGK8TDSttg9WdHGg5F+rHWAaeQ598+nQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 19, 2023 at 11:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sat, Jun 17, 2023 at 5:30=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Fri, Jun 16, 2023 at 10:43=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Mon, Jun 12, 2023 at 5:01=E2=80=AFAM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> >
> > ...
> >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 99ded60a6b911..dd410ceb178cb 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -2264,6 +2264,18 @@ static int selinux_bprm_creds_for_exec(struc=
t linux_binprm *bprm)
> > > >         new_tsec->keycreate_sid =3D 0;
> > > >         new_tsec->sockcreate_sid =3D 0;
> > > >
> > > > +       /*
> > > > +        * Before policy is loaded, label any task outside kernel s=
pace
> > > > +        * as SECINITSID_INIT, so that any userspace tasks survivin=
g from
> > > > +        * early boot end up with a label different from SECINITSID=
_KERNEL
> > > > +        * (if the policy chooses to set SECINITSID_INIT !=3D SECIN=
ITSID_KERNEL).
> > > > +        */
> > > > +       if (!selinux_initialized()) {
> > > > +               new_tsec->sid =3D SECINITSID_INIT;
> > > > +               new_tsec->exec_sid =3D 0; /* just in case */
> > >
> > > Style nit, I don't like placing trailing comments on the same line as
> > > code.  Don't respin this patch just for this, but remember this for
> > > future submissions.
> >
> > Ack.
> >
> > > > +               return 0;
> > > > +       }
> > > > +
> > > >         if (old_tsec->exec_sid) {
> > > >                 new_tsec->sid =3D old_tsec->exec_sid;
> > > >                 /* Reset exec SID on execve. */
> > >
> > > ...
> > >
> > > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/p=
olicydb.c
> > > > index 97c0074f9312a..240e0fb1d57f9 100644
> > > > --- a/security/selinux/ss/policydb.c
> > > > +++ b/security/selinux/ss/policydb.c
> > > > @@ -863,6 +863,8 @@ void policydb_destroy(struct policydb *p)
> > > >  int policydb_load_isids(struct policydb *p, struct sidtab *s)
> > > >  {
> > > >         struct ocontext *head, *c;
> > > > +       bool secsid_init_supported =3D ebitmap_get_bit(&p->policyca=
ps,
> > > > +                                                    POLICYDB_CAP_U=
SERSPACE_INITIAL_CONTEXT);
> > >
> > > This is another "please don't respin for this", but if you have to
> > > respin for any reason can you change the variable name to
> > > "isid_init_supported" or something similar?  The "secsid" portion of
> > > the name looks wrong to me.
> >
> > It was supposed to be "secinitsid_init_supported" but I botched it :)
> > Though that name is very long, so if I were to change it, I would go
> > with your suggestion.
>
>  :)
>
> Since we've got a couple of weeks (-rc7 + merge window), why not go
> ahead and do the respin to fix up those small things and simplify the
> policycap accessor (see the other patch I posted) - does that sound
> reasonable?

Sure, will do.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

