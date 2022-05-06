Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40C433FE
	for <selinux@archiver.kernel.org>; Fri,  6 May 2022 15:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352275AbiEFPqi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 May 2022 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351151AbiEFPqf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 May 2022 11:46:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30D68F93
        for <selinux@vger.kernel.org>; Fri,  6 May 2022 08:42:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q8so7857959oif.13
        for <selinux@vger.kernel.org>; Fri, 06 May 2022 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqdquUO2o/q+Hv0vsSUuKQWbxJwnqFLOATXBtoDIv88=;
        b=k00dbPIieUgJvQNIdq6lMA3pVhX1Tda9dE0nK9gkgikOQ41m7E24vWlMCcGmprqNPu
         nHx97/9+maxrQaFfZGme+ML2sD2VgGCGl7VZpqabd7A3FbvrvngfB05yahXcDC6tDVkk
         lIKbX8G8u/JBPPFr0lSECjiHRX4SJvPUmvVgmccm3/PK7CBs9nbkkgktFvPTOgy3TyCq
         JapQS4VEIZS9NffXlEvYhytSRnRhQDFe/LbX1S91jvPXivDdJgcuRD2uykH8dCMneLp9
         LGXJAU9GuCJyXE9E9Ydki4h0Y8dhtoojoPUZoYBZwYzQm968Fa4QCprNESs3am6qnqxZ
         BdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqdquUO2o/q+Hv0vsSUuKQWbxJwnqFLOATXBtoDIv88=;
        b=atyhK4WNDSLMJ5Watd/Tc3Q8jNoTFOeTXEiY5UIv6fCGFX1bPBMXTO86M1vt7vjvzg
         x07Fb3TnXqzUL49/fZLMxwD//VUeSU6lYGKKLE2nit+ZPvE/1YmVt8uHWNUa+Cxw4EJ7
         Q4BT7OoR1bZD2AE2yjM2s6dTFzlWJ977G04++6OBPUHKNUSFnnJ4WnU+1MhfZfIoJNKN
         ZklsZxuGd8yJZ01mUPL2/Rne+kNqCiQ5GLD3bm7umarzQShsXsIZ5cm/UC5aCDB/K0+p
         Oo+cL6SwIWCpe7CV6eNJjOOlvZE90xAW69m+iJEbwjk2401XQg/IkgUPGn1Dnhl+4hjq
         W2Aw==
X-Gm-Message-State: AOAM533/oDiArwfIIUSAqNoP1rw8jXvj4cy5vU2Z9H3YXoWJHDFpplGB
        pWR28Ru9bI9aZqQ8d/ycG9YERy1gcqdOgsIeWB4=
X-Google-Smtp-Source: ABdhPJxVFjeIhsrd66PBPNiPdNtdnoV3YJT+4g9bTfASXqIot/dRj6Be3guYTwq0REQtetpub+f6lxgYrJCdR4pM/zo=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr1001582oiw.182.1651851771456; Fri, 06
 May 2022 08:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220426105118.506847-1-omosnace@redhat.com> <20220426105118.506847-3-omosnace@redhat.com>
 <CAP+JOzTpJ4XROVjo9-rOmh97rwiEOp2YPxXSuUOQtLbRWX0kGg@mail.gmail.com> <CAFqZXNtiHRZPsGD62y78ek7KwvdhuOqT_CizsaBcNV7ci9ng0A@mail.gmail.com>
In-Reply-To: <CAFqZXNtiHRZPsGD62y78ek7KwvdhuOqT_CizsaBcNV7ci9ng0A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 6 May 2022 11:42:40 -0400
Message-ID: <CAP+JOzTMNuPiERmtTFgGbP5fWWSgsTkmty3HFnzQoPigc08Wrg@mail.gmail.com>
Subject: Re: [PATCH userspace v2 2/2] libsepol,checkpolicy: add support for
 self keyword in type transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 6, 2022 at 9:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Apr 28, 2022 at 9:23 PM James Carter <jwcart2@gmail.com> wrote:
> > On Wed, Apr 27, 2022 at 6:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > With the addition of the anon_inode class in the kernel, 'self'
> > > transition rules became useful, but haven't been implemented.
> > >
> > > This patch implements the self keyword in all 'typetransition'
> > > statements at the TE language level and adds the support to the module
> > > policydb format. Note that changing the kernel policydb format is not
> > > necessary at all, as type transitions are always expanded in the kernel
> > > policydb.
> > >
> >
> > These patches also cause "self" to be allowed in type change and type
> > member rules as well. That is fine, but it should be stated.
>
> Good point, I'll update the commit messages.
>
> [...]
> > > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > > index d7ac2b25..5f593c1d 100644
> > > --- a/libsepol/src/write.c
> > > +++ b/libsepol/src/write.c
> > > @@ -1929,11 +1929,12 @@ static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
> > >         return POLICYDB_SUCCESS;
> > >  }
> > >
> > > -static int filename_trans_rule_write(filename_trans_rule_t * t, struct policy_file *fp)
> > > +static int filename_trans_rule_write(policydb_t *p, filename_trans_rule_t *t,
> > > +                                    struct policy_file *fp)
> > >  {
> > >         int nel = 0;
> > > -       size_t items;
> > > -       uint32_t buf[2], len;
> > > +       size_t items, entries;
> > > +       uint32_t buf[3], len;
> > >         filename_trans_rule_t *ftr;
> > >
> > >         for (ftr = t; ftr; ftr = ftr->next)
> >
> >
> > The flags field needs to be cleared if the policy version being
> > written is < MOD_POLICYDB_VERSION_SELF_TYPETRANS.
> >
> > Something like:
> > +        if ((p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS) &&
> > +            (ftr->flags & RULE_SELF)) {
> > +            WARN(fp->handle, "Module policy version %u does not support using "
> > +                 "\"self\" in a filename type transition rule", p->policyvers);
> > +            ftr->flags &= ~RULE_SELF;
> > +        }
> >
> > A similar check is needed in avrule_write(), but there needs to be a
> > check that the rule is an AVRULE_TYPE as well.
>
> I agree we need to handle this case, but should we really just discard
> the flag? It seems that currently avrule->ttypes is empty if
> (avrule->flags & RULE_SELF) is set, so we would create an empty (or
> maybe even invalid?) rule in the policy module. Setting ttypes =
> stypes would not be equivalent and expanding the rule also doesn't
> seem like a great idea. IMHO we should just return an error on any
> attempt to downgrade a module containing self AVRULE_TYPE rules below
> MOD_POLICYDB_VERSION_SELF_TYPETRANS.
>
> What do you think?
>

avrule->ttypes is not necessarily empty when self is used. I didn't
realize that myself until recently.
It is possible to have a (very ugly) rule like:
  type_transition t1 { t2 attr1 self }:file t3;

Ideally, it would be nice to get rid of the empty rules when writing
out the policy, but the number of rules has already been determined so
there would be extra work involved. Since it doesn't cause any
problems (that I have found) and it should be unusual to downgrade the
policy version anyway, writing the empty rule seems like the best
choice.

We definitely can't expand the rule because we might not have all of
the information for an attribute when we are writing a module's
policy.

Returning an error is fine. We do that when we encounter xperm rules.
We just discard the rule for default_range rules using GLBLUB,
permissive types, boolean and conditional rules, and filename
typetransition rules when the policy version doesn't support them. An
argument can be made for either behavior.

Thanks,
Jim


> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
