Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736D8C433B4
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB561103
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 20:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbhDFUct (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Apr 2021 16:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233034AbhDFUct (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Apr 2021 16:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617741160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HkuAZYJenT22XjyGFlVo937raNt2KqPoWJh+Ini5/RI=;
        b=PERioO3212aE6HNh/C6KjPSVAnn+6pfbi9nFBrHVH5yq9lIN0cqipSTFAgxdeaR3wZC/kA
        8ewbqhUeIi06+tM+XjThOjU0QIHelsIDsCjY02M57jHQxeIil8YVSmwYPbP969KOXQFb8J
        9PrDcMCWoJ/Eaa4yX/MjM2bgbJ+/iRI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-aSTqneESOLWE9rMUIzUfwQ-1; Tue, 06 Apr 2021 16:32:39 -0400
X-MC-Unique: aSTqneESOLWE9rMUIzUfwQ-1
Received: by mail-yb1-f200.google.com with SMTP id 131so21759020ybp.16
        for <selinux@vger.kernel.org>; Tue, 06 Apr 2021 13:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkuAZYJenT22XjyGFlVo937raNt2KqPoWJh+Ini5/RI=;
        b=WmlQQrWDJTT19XTP7DXTvxWweZFBsnd9y5kw4GQBt0RyljIHSp3V1ZeA9Ksupp2Z/g
         0MlDxCQCks+puIXCQHcX1geptjigvM4x/CAOO7D9vGFzrKmm1DUeDKlzYujQw9KJFMLs
         iQFaVKFPaw/Qj4McJAyxrISITCXWSmCvGEFzCSQkeh5aAHZHaxS5ydcOl9Z39+TwSR6D
         g/jeKJlKMsrCdR8yEuBfxr7HhNsbTOCs3a/LQ8GOR1KjHQv7OXQh3gW3gsXYvvYlO5nV
         /fan8lEgeYvkWLDFJtdKSV1zIap+U4K94W89b87HiQ/0/DcvJR4fTcJ+WTKNXziGYsN5
         BMBQ==
X-Gm-Message-State: AOAM531NIgTmOhdVhaQIasEAfHDvSI5fiG+CdX2w1KL1XzGoqRLMGSDV
        9ST6cDnEGpEU2j8k9oMhKEWZUlQxGGsSEPaX7gCbiLIhkgo15m2/FzIAHXwAt2RXxgLhsii1ZgP
        ai9h68pi5lo8qO5TYt6B8f9HswvIRUt8fTA==
X-Received: by 2002:a25:6949:: with SMTP id e70mr13594399ybc.26.1617741158775;
        Tue, 06 Apr 2021 13:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6trQXPut7icamKGyOEA32EJvlABnXdyVYZdp4O3bPAeSU1gqojK86dwHAem/8ot3YN6PZqtneWPeju60hjTw=
X-Received: by 2002:a25:6949:: with SMTP id e70mr13594367ybc.26.1617741158472;
 Tue, 06 Apr 2021 13:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210405091052.2296792-1-omosnace@redhat.com> <CAHC9VhSCSNvRE1JCjmYimifd4ip0Ar6mipouVqj2_zEGXij0Rg@mail.gmail.com>
 <CAFqZXNvd3dP1Wm6JFBJ+P+uttd=1Yg_MuaDdcyUizK6SWpMrbg@mail.gmail.com> <CAHC9VhS5NgCpXO5DO6W6VPRo2K2YenPAAaOX3KNnq-waNASe4g@mail.gmail.com>
In-Reply-To: <CAHC9VhS5NgCpXO5DO6W6VPRo2K2YenPAAaOX3KNnq-waNASe4g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 6 Apr 2021 22:32:26 +0200
Message-ID: <CAFqZXNtdwhwCJ2qVHnPDL8=j4S+DmOjE7SH6mmP7=71932EN7g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race between old and new sidtab
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 6, 2021 at 9:15 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Apr 6, 2021 at 5:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Apr 6, 2021 at 12:11 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Apr 5, 2021 at 5:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...
>
> > > > @@ -2534,10 +2577,18 @@ int security_netif_sid(struct selinux_state *state,
> > > >                 if (!c->sid[0] || !c->sid[1]) {
> > > >                         rc = sidtab_context_to_sid(sidtab, &c->context[0],
> > > >                                                    &c->sid[0]);
> > > > +                       if (rc == -ESTALE) {
> > > > +                               rcu_read_unlock();
> > > > +                               goto retry;
> > > > +                       }
> > > >                         if (rc)
> > > >                                 goto out;
> > > >                         rc = sidtab_context_to_sid(sidtab, &c->context[1],
> > > >                                                    &c->sid[1]);
> > > > +                       if (rc == -ESTALE) {
> > > > +                               rcu_read_unlock();
> > > > +                               goto retry;
> > > > +                       }
> > >
> > > If the first sidtab_context_to_sid() ran successfully we are not going
> > > to see -ESTALE here, correct?  Assuming yes, perhaps we can drop this
> > > -ESTALE check with a comment about how a frozen sidtab will be caught
> > > by the call above.
> >
> > No, nothing really prevents the sidtab from becoming frozen between
> > the two calls.
>
> Yes, my mistake, I was focused on the RCU policy copies and not
> looking at the spinlock for the freeze state.
>
> > > > @@ -2676,18 +2732,20 @@ int security_get_user_sids(struct selinux_state *state,
> > > >         struct sidtab *sidtab;
> > > >         struct context *fromcon, usercon;
> > > >         u32 *mysids = NULL, *mysids2, sid;
> > > > -       u32 mynel = 0, maxnel = SIDS_NEL;
> > > > +       u32 i, j, mynel, maxnel = SIDS_NEL;
> > > >         struct user_datum *user;
> > > >         struct role_datum *role;
> > > >         struct ebitmap_node *rnode, *tnode;
> > > > -       int rc = 0, i, j;
> > > > +       int rc;
> > > >
> > > >         *sids = NULL;
> > > >         *nel = 0;
> > > >
> > > >         if (!selinux_initialized(state))
> > > > -               goto out;
> > > > +               return 0;
> > > >
> > > > +retry:
> > > > +       mynel = 0;
> > > >         rcu_read_lock();
> > > >         policy = rcu_dereference(state->policy);
> > > >         policydb = &policy->policydb;
> > > > @@ -2723,6 +2781,10 @@ int security_get_user_sids(struct selinux_state *state,
> > > >                                 continue;
> > > >
> > > >                         rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
> > > > +                       if (rc == -ESTALE) {
> > > > +                               rcu_read_unlock();
> > >
> > > Don't we need to free and reset 'mysids' here?  'mynel' and 'maxnel'
> > > are probably less critical since the -ESTALE condition should happen
> > > before they are ever modified, but a constant assignment is pretty
> > > cheap so it may make sense to reset those as well.
> >
> > No, we can keep "mysids" and "maxnel", since they represent an
> > automatically growing vector, which we can keep and reuse in the retry
> > path rather than starting from scratch. It is more efficient, since
> > the new policy will likely have the same number of SIDs in the result.
> > If it has more, we just grow the vector further as needed; if it has
> > less, we just don't use the full capacity and the array will be freed
> > after a while anyway (see "out_unlock"), so the extra memory shouldn't
> > be held for too long. Not to mention that this is a deprecated
> > interface that will hopefully be removed one day :)
>
> I believe you are ignoring the case where mysids is non-NULL when an
> -ESTALE occurs and the code jumps to 'retry' and that ends up calling
> 'mysids = kcalloc(...)' before the ebitmap loop.  Perhaps I'm
> mistaken, but this looks like a memory leak to me.

Ah, yes, I was blind... somehow I believed it was allocated outside
the retry loop, yet it pretty obviously isn't :) It's a constant-size
allocation though, so it could just be moved outside and even changed
to a GFP_KERNEL allocation. So that'll be an easy fix and even a tiny
improvement.

>
> > (And you're wrong that mynel/maxnel can't be modified - notice that
> > the sidtab_context_to_sid() call is inside a loop ;)
>
> My comments were correct if you work under the (faulty) assumption
> that the sidtab isn't being frozen underneath you :-P

Hah, yeah, didn't realize that :)

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

