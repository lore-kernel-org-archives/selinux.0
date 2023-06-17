Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A550EB64D9
	for <selinux@archiver.kernel.org>; Sat, 17 Jun 2023 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjFQJbA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 17 Jun 2023 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJa7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 17 Jun 2023 05:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298A6E4D
        for <selinux@vger.kernel.org>; Sat, 17 Jun 2023 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686994212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twfq5AZVQioInaqL5KqGplSer7BaHc3vhC2Mb61IlAI=;
        b=ZrogoNQINm2a0vezIocZSNaWDHOoJr3eGUbczgU2pQzQv4C8nu0WUt0z004Dbf5DzMkhGa
        JbrnLdN9g4xlNUz3iifjdA/NpQwDjW2E8Q9JPmaVCeEbw9D+wSmwHL4/81QasvJPM671mL
        2oXBoZ38PU/z3LEB79D3lK2fVEpuy9c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-nqK0_aSDP1yLPsXpIZmrNg-1; Sat, 17 Jun 2023 05:30:07 -0400
X-MC-Unique: nqK0_aSDP1yLPsXpIZmrNg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2566f2acd88so1367596a91.1
        for <selinux@vger.kernel.org>; Sat, 17 Jun 2023 02:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686994206; x=1689586206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twfq5AZVQioInaqL5KqGplSer7BaHc3vhC2Mb61IlAI=;
        b=Z5L/wK/ytwslT4PFoT68K9FeUBPK2zi8cZPXxhxCNccKa/VoN5q4pYEoM16BQOg5Rc
         MHRaebnkY0jv89XbEn44jx6AaQnqMnHcNt3g6fmqD7yA8m9fnN6rzjCNKxqKA6uMn4sZ
         mX1FYJL6dHUYqZnyw1ma/GxoA/6TL433DxpfoWGS9YcCdKAO/uVP4xRIsOFrQrqEt8Qk
         Rguzv2elpaoFD/Bv60+d1uOCVDIClTxvG551DwgjW4txrMow+HpggyByHb/nvOVE18EH
         O9WdWXdjtGzYPVw6RM6wCo4y0Hm19jERIDO8QwO1wm2sfReSJxuYd08ClqPrqzjxOGdm
         iEBQ==
X-Gm-Message-State: AC+VfDyotBRju/BVkOIyKc/gwuY2kxITnvTH3jCUqo9m6/t7p6brviIb
        5D49GV/F9heNFojcPr1sZaCTFcLrtKd6jd0UQQLvsnVHcyBrOPm6kUzXAVJNrguQwkyGTsD+l+j
        we/fKyedxpl71VcyEgjN2GBY5m+1NMIBAJ+ZYzkyfaRlL
X-Received: by 2002:a17:90a:3983:b0:25c:a3f:3adb with SMTP id z3-20020a17090a398300b0025c0a3f3adbmr4257043pjb.9.1686994206083;
        Sat, 17 Jun 2023 02:30:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4n4q4d201I8zKRJUuG6t3Epcp+5FEmYXs5e7hCFzQxPnlQF2GnCggL0OY8dTHudqqsmwNokHQRmse1xgfiIQg=
X-Received: by 2002:a17:90a:3983:b0:25c:a3f:3adb with SMTP id
 z3-20020a17090a398300b0025c0a3f3adbmr4257030pjb.9.1686994205818; Sat, 17 Jun
 2023 02:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com> <CAHC9VhQg3ThH4A5+MggCqNxGnUOsEEgawbTmb4VO1XTWSAKCPg@mail.gmail.com>
In-Reply-To: <CAHC9VhQg3ThH4A5+MggCqNxGnUOsEEgawbTmb4VO1XTWSAKCPg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 17 Jun 2023 11:29:54 +0200
Message-ID: <CAFqZXNtjT80yK7fzGeXzXjx6E+G8GZivc8xJ20DWyUA1upmikQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 16, 2023 at 10:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Jun 12, 2023 at 5:01=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:

...

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 99ded60a6b911..dd410ceb178cb 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2264,6 +2264,18 @@ static int selinux_bprm_creds_for_exec(struct li=
nux_binprm *bprm)
> >         new_tsec->keycreate_sid =3D 0;
> >         new_tsec->sockcreate_sid =3D 0;
> >
> > +       /*
> > +        * Before policy is loaded, label any task outside kernel space
> > +        * as SECINITSID_INIT, so that any userspace tasks surviving fr=
om
> > +        * early boot end up with a label different from SECINITSID_KER=
NEL
> > +        * (if the policy chooses to set SECINITSID_INIT !=3D SECINITSI=
D_KERNEL).
> > +        */
> > +       if (!selinux_initialized()) {
> > +               new_tsec->sid =3D SECINITSID_INIT;
> > +               new_tsec->exec_sid =3D 0; /* just in case */
>
> Style nit, I don't like placing trailing comments on the same line as
> code.  Don't respin this patch just for this, but remember this for
> future submissions.

Ack.

> > +               return 0;
> > +       }
> > +
> >         if (old_tsec->exec_sid) {
> >                 new_tsec->sid =3D old_tsec->exec_sid;
> >                 /* Reset exec SID on execve. */
>
> ...
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 97c0074f9312a..240e0fb1d57f9 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -863,6 +863,8 @@ void policydb_destroy(struct policydb *p)
> >  int policydb_load_isids(struct policydb *p, struct sidtab *s)
> >  {
> >         struct ocontext *head, *c;
> > +       bool secsid_init_supported =3D ebitmap_get_bit(&p->policycaps,
> > +                                                    POLICYDB_CAP_USERS=
PACE_INITIAL_CONTEXT);
>
> This is another "please don't respin for this", but if you have to
> respin for any reason can you change the variable name to
> "isid_init_supported" or something similar?  The "secsid" portion of
> the name looks wrong to me.

It was supposed to be "secinitsid_init_supported" but I botched it :)
Though that name is very long, so if I were to change it, I would go
with your suggestion.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

