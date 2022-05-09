Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7DBC433FE
	for <selinux@archiver.kernel.org>; Mon,  9 May 2022 09:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiEIJxC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 May 2022 05:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiEIJbi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 May 2022 05:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FB7B210887
        for <selinux@vger.kernel.org>; Mon,  9 May 2022 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652088458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=heV4LVy5iAofFAqtLCwAhDQGAQfupGvWAoNkxiMbWLA=;
        b=Wl4Tms8XSBEsoY287wuSBg0OoaqbNX+rCtu66RL2ENnpqo6vPDIdRnu9IU5uuo3T1xLUnL
        kSW6UUEKpD1xuEWlNUmozLKh7CBPPAuV0v100LxQaqkVY65C1LO3YvEdsj+dUC/rGMaJJn
        hENpWWfkSwILclxHPYpbZeJ69hDUYeI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-M-10pldKMuqIiWJYHquXpA-1; Mon, 09 May 2022 05:27:37 -0400
X-MC-Unique: M-10pldKMuqIiWJYHquXpA-1
Received: by mail-yb1-f200.google.com with SMTP id 192-20020a250cc9000000b0064a5bbea6a7so8461259ybm.9
        for <selinux@vger.kernel.org>; Mon, 09 May 2022 02:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heV4LVy5iAofFAqtLCwAhDQGAQfupGvWAoNkxiMbWLA=;
        b=3atY+xm0af8pgQEBjaJBT2Qbas6hu3Ytl9FDcO/MZu8R821ooZ7bH8dcl6VGj+dPV2
         mlFa5uXwhsZD9+dE3PmxJFKqMCHLEnzZwb+PwS8zPBdC4z5yyQm5pZ1uyziZBYB8kMAX
         mEYLgX7DcNNImc6/3RUURKQtntKRsH1MIjh6cosQ6gwz5lOdSR7dzJfoun5sXjwKvahK
         KzT93zrZdoIIiVSVeyx+4xCBZyCrvjyN0VVw6FBYJForbRqNzrQIh6x4VYP/cAwJMAkF
         Gvi04YKb9gfPAmR7lo8jORd2pus3EYBYYFZP6E9fvCUtt5WfU8jtz77kcTEHjGiLDDpf
         GoQQ==
X-Gm-Message-State: AOAM532HMxR/wZFmdMr8uQtmQJf3Hjzbs0cPkCVM4qIfittji3PDCpWb
        gilZvcNcFyIVtNrBQkZBGH3d4LOnwoFz+ncCK0XyIorziR3CbWapRxOPFlzNKs0SyID7oIW6jEo
        d5WQXbFRzDk4Ai/l8MnafIlkKRpnfaT/Czw==
X-Received: by 2002:a25:74cc:0:b0:648:4697:9722 with SMTP id p195-20020a2574cc000000b0064846979722mr12564881ybc.21.1652088456446;
        Mon, 09 May 2022 02:27:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkVrHmV1PU8PMQgZX6bBBJxsY1j6kY2Qtk0cTC7+cgMD52jUnR8LiZihxiMoK1w0P+5XANCPkC1t2SCt35NcY=
X-Received: by 2002:a25:74cc:0:b0:648:4697:9722 with SMTP id
 p195-20020a2574cc000000b0064846979722mr12564869ybc.21.1652088456256; Mon, 09
 May 2022 02:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220426105118.506847-1-omosnace@redhat.com> <20220426105118.506847-3-omosnace@redhat.com>
 <CAP+JOzTpJ4XROVjo9-rOmh97rwiEOp2YPxXSuUOQtLbRWX0kGg@mail.gmail.com>
 <CAFqZXNtiHRZPsGD62y78ek7KwvdhuOqT_CizsaBcNV7ci9ng0A@mail.gmail.com> <CAP+JOzTMNuPiERmtTFgGbP5fWWSgsTkmty3HFnzQoPigc08Wrg@mail.gmail.com>
In-Reply-To: <CAP+JOzTMNuPiERmtTFgGbP5fWWSgsTkmty3HFnzQoPigc08Wrg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 9 May 2022 11:27:25 +0200
Message-ID: <CAFqZXNu7puwNG+9w8GAusG++X3nQzmfrv9TZJDgrcqO9hMZ4WA@mail.gmail.com>
Subject: Re: [PATCH userspace v2 2/2] libsepol,checkpolicy: add support for
 self keyword in type transitions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 6, 2022 at 5:42 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, May 6, 2022 at 9:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 9:23 PM James Carter <jwcart2@gmail.com> wrote:
> > > On Wed, Apr 27, 2022 at 6:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > With the addition of the anon_inode class in the kernel, 'self'
> > > > transition rules became useful, but haven't been implemented.
> > > >
> > > > This patch implements the self keyword in all 'typetransition'
> > > > statements at the TE language level and adds the support to the module
> > > > policydb format. Note that changing the kernel policydb format is not
> > > > necessary at all, as type transitions are always expanded in the kernel
> > > > policydb.
> > > >
> > >
> > > These patches also cause "self" to be allowed in type change and type
> > > member rules as well. That is fine, but it should be stated.
> >
> > Good point, I'll update the commit messages.
> >
> > [...]
> > > > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > > > index d7ac2b25..5f593c1d 100644
> > > > --- a/libsepol/src/write.c
> > > > +++ b/libsepol/src/write.c
> > > > @@ -1929,11 +1929,12 @@ static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
> > > >         return POLICYDB_SUCCESS;
> > > >  }
> > > >
> > > > -static int filename_trans_rule_write(filename_trans_rule_t * t, struct policy_file *fp)
> > > > +static int filename_trans_rule_write(policydb_t *p, filename_trans_rule_t *t,
> > > > +                                    struct policy_file *fp)
> > > >  {
> > > >         int nel = 0;
> > > > -       size_t items;
> > > > -       uint32_t buf[2], len;
> > > > +       size_t items, entries;
> > > > +       uint32_t buf[3], len;
> > > >         filename_trans_rule_t *ftr;
> > > >
> > > >         for (ftr = t; ftr; ftr = ftr->next)
> > >
> > >
> > > The flags field needs to be cleared if the policy version being
> > > written is < MOD_POLICYDB_VERSION_SELF_TYPETRANS.
> > >
> > > Something like:
> > > +        if ((p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS) &&
> > > +            (ftr->flags & RULE_SELF)) {
> > > +            WARN(fp->handle, "Module policy version %u does not support using "
> > > +                 "\"self\" in a filename type transition rule", p->policyvers);
> > > +            ftr->flags &= ~RULE_SELF;
> > > +        }
> > >
> > > A similar check is needed in avrule_write(), but there needs to be a
> > > check that the rule is an AVRULE_TYPE as well.
> >
> > I agree we need to handle this case, but should we really just discard
> > the flag? It seems that currently avrule->ttypes is empty if
> > (avrule->flags & RULE_SELF) is set, so we would create an empty (or
> > maybe even invalid?) rule in the policy module. Setting ttypes =
> > stypes would not be equivalent and expanding the rule also doesn't
> > seem like a great idea. IMHO we should just return an error on any
> > attempt to downgrade a module containing self AVRULE_TYPE rules below
> > MOD_POLICYDB_VERSION_SELF_TYPETRANS.
> >
> > What do you think?
> >
>
> avrule->ttypes is not necessarily empty when self is used. I didn't
> realize that myself until recently.
> It is possible to have a (very ugly) rule like:
>   type_transition t1 { t2 attr1 self }:file t3;

Ah, so it actually extends the target type list instead of overriding
it... Yes, looking at the code more carefully I can see that it indeed
matches this semantic.

> Ideally, it would be nice to get rid of the empty rules when writing
> out the policy, but the number of rules has already been determined so
> there would be extra work involved. Since it doesn't cause any
> problems (that I have found) and it should be unusual to downgrade the
> policy version anyway, writing the empty rule seems like the best
> choice.
>
> We definitely can't expand the rule because we might not have all of
> the information for an attribute when we are writing a module's
> policy.
>
> Returning an error is fine. We do that when we encounter xperm rules.
> We just discard the rule for default_range rules using GLBLUB,
> permissive types, boolean and conditional rules, and filename
> typetransition rules when the policy version doesn't support them. An
> argument can be made for either behavior.

It would be against my conscience to post a patch that drops rules
from the policy with "only" a warning, so I'll opt for returning an
error :)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

