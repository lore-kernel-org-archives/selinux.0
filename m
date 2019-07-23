Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF9C76188
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 06:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E462238E
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 06:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfGWGsY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:48:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36606 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfGWGsY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jul 2019 02:48:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so42953614oti.3
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 23:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY5YICyEZTZmKAe8S+z84IVZKH+kurb4pXia9o6wuCY=;
        b=npPyA4MaNm/pE1HOKC/P/Z7wcOUg5RfPNrgeOawJvn1Nejjo9EQSSWN54xYMSxjU1f
         MbayM6LdJdM0kNh2eDdSMXuqxa7npaG0+ee/Lor1qhn7uMymyLAMcnsgLC/Uf/gvoCsJ
         Ulo2gGOI1CgG4SQU50nw1XiZg5k0IOUySvpOsBG5wz34J2wke6HjP+D8ZQZl39oiCmPj
         IdkVZWN/I5/HD3f4B47YUezWY0Yr7Z6OhPVwFPVBsep6sYCqV/zsHafTw+LSUwc4Cw30
         BUJS0P3Y+6kRLa6n5xp4XwD0BLVrCn/tEGEJhWVIJzl0OrpwQMcFN6Mx3aFkBjE1UnDW
         4aeQ==
X-Gm-Message-State: APjAAAXMnWZH7qZkbKnhn/NLxy61zzvsEKei+C04Mr/PUXvLcNPJ8FTc
        DhugYCcqoco8Xgeu/9SdEHj+d/ZPfK1lidlyVmU2Rewm
X-Google-Smtp-Source: APXvYqxsddQYVNqohu4Jb847ypd+7U9vUJnysW3/+0Sp9QkhauBUew6rE6lNs/w8PcqsF2R2eim5RvqRMoXbKMYvJEE=
X-Received: by 2002:a9d:73cd:: with SMTP id m13mr20394988otk.43.1563864503462;
 Mon, 22 Jul 2019 23:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190722132111.25743-1-omosnace@redhat.com> <CAFftDdqROGAUDD3wXRC-PSjnrm29B6bfsBDn8AMPKkzJ8yJ=Hg@mail.gmail.com>
In-Reply-To: <CAFftDdqROGAUDD3wXRC-PSjnrm29B6bfsBDn8AMPKkzJ8yJ=Hg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Jul 2019 08:48:12 +0200
Message-ID: <CAFqZXNtSVvE9XiMSFei7+PD6v-urELi=UjdOtWW8KPdM8e=Q5Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: check sidtab limit before adding a new entry
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 22, 2019 at 4:17 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Mon, Jul 22, 2019 at 8:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > We need to error out when trying to add an entry above SIDTAB_MAX in
> > sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> > happens.
> >
> > Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/sidtab.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> > index e63a90ff2728..54c1ba1e79ab 100644
> > --- a/security/selinux/ss/sidtab.c
> > +++ b/security/selinux/ss/sidtab.c
> > @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> >                 ++count;
> >         }
> >
> > +       /* bail out if we already reached max entries */
> > +       rc = -ENOMEM;
>
> Wouldn't -EOVERFLOW be better?

Good point. Will change it in v2.

>
> > +       if (count == SIDTAB_MAX)
> > +               goto out_unlock;
> > +
> >         /* insert context into new entry */
> >         rc = -ENOMEM;
> >         dst = sidtab_do_lookup(s, count, 1);
> > --
> > 2.21.0
> >

Thanks,
-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
