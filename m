Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9099C43460
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FEE61399
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 19:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbhDFTPG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Apr 2021 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhDFTPG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Apr 2021 15:15:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90ABC06174A
        for <selinux@vger.kernel.org>; Tue,  6 Apr 2021 12:14:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r22so5386788edq.9
        for <selinux@vger.kernel.org>; Tue, 06 Apr 2021 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cDrL3Sk/KEeowsmOuS6ZZ7JpUzxFiqzpVhMbML6Iz0=;
        b=wHNgUPrH7Y4JZ8cvc8yv72egPEvDi0A2hlkToQ+ZNNLXkmKTh1qDVmTCuiJFP2YMFx
         RvhtZL8oAFoUYUCz6VzyZDZpRckybd/JVhoCQgkZdXNt3FsmlrEDNmKwgn00Zyv+eAM7
         wrGRMy9Q6VOy8+TWF+tHrgW1yqYABbYlgIiVmG1sXM2EavmW6MI7M4/bjO1zBayggAjr
         kS+Zxjy9TJB0wU9/c3UiSdAQAryU3Rn++LUbOuZ9HNBZFK/3bD/ifIJF+ljBTPZ4m+xj
         5VZo0KmmZNPXKtvpxzm4hQGw0COQgwvKjSC552U+RnyPF5VH2blHroUUUm/osuJKnEwH
         pVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cDrL3Sk/KEeowsmOuS6ZZ7JpUzxFiqzpVhMbML6Iz0=;
        b=Ori2UPHEh96rduPDANclAN8b6oa3NZOkEeCsxYlqt0TTEeKeabTLy3gCXvpJSfdIaa
         2GAPRWAUr4tNgT+CGHIfdZ+/t1KRYQ3j6QM4TlMqG253EcennvFwU7sYsmMIahUOHSYu
         cJiq8ZDyHahBsnh4IxvuPwqHedkRA3lf+WE7PFD5DUTy/DD1/YHvtVLE9kBJciZRRH3q
         5MCsm5LQPGJTh1GustW/r6ANz2eZaHhPuAtDfUn+I1Q9vjCYH2lR7kuzIMtsFEHzKK1T
         yp9MZUM+/ASp+gqM+UhdZELtf4DxzNBeYKb1wNnI/3So5t8wRRuMXGi7eWnPHuOkf6cj
         9vVw==
X-Gm-Message-State: AOAM531ZhBzV6uNBjODzHDCNDZ2+ugxqQjE5EIn2JOjRle672yjqUcze
        32oAHhurdv4eiEom2lao0Ncj7v8idJJaADB2Izi7ZoZLcQ==
X-Google-Smtp-Source: ABdhPJzC1KYsErwMD5pZ3Ew3gBw6Qfk18CWddXiZnFfp6h+31VQTpsWAHYgIexHyW9j5SxdTP3qc7ttPA8ePYnc3X38=
X-Received: by 2002:aa7:c952:: with SMTP id h18mr21905308edt.269.1617736496286;
 Tue, 06 Apr 2021 12:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210405091052.2296792-1-omosnace@redhat.com> <CAHC9VhSCSNvRE1JCjmYimifd4ip0Ar6mipouVqj2_zEGXij0Rg@mail.gmail.com>
 <CAFqZXNvd3dP1Wm6JFBJ+P+uttd=1Yg_MuaDdcyUizK6SWpMrbg@mail.gmail.com>
In-Reply-To: <CAFqZXNvd3dP1Wm6JFBJ+P+uttd=1Yg_MuaDdcyUizK6SWpMrbg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Apr 2021 15:14:45 -0400
Message-ID: <CAHC9VhS5NgCpXO5DO6W6VPRo2K2YenPAAaOX3KNnq-waNASe4g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race between old and new sidtab
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 6, 2021 at 5:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Apr 6, 2021 at 12:11 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Apr 5, 2021 at 5:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > @@ -2534,10 +2577,18 @@ int security_netif_sid(struct selinux_state *state,
> > >                 if (!c->sid[0] || !c->sid[1]) {
> > >                         rc = sidtab_context_to_sid(sidtab, &c->context[0],
> > >                                                    &c->sid[0]);
> > > +                       if (rc == -ESTALE) {
> > > +                               rcu_read_unlock();
> > > +                               goto retry;
> > > +                       }
> > >                         if (rc)
> > >                                 goto out;
> > >                         rc = sidtab_context_to_sid(sidtab, &c->context[1],
> > >                                                    &c->sid[1]);
> > > +                       if (rc == -ESTALE) {
> > > +                               rcu_read_unlock();
> > > +                               goto retry;
> > > +                       }
> >
> > If the first sidtab_context_to_sid() ran successfully we are not going
> > to see -ESTALE here, correct?  Assuming yes, perhaps we can drop this
> > -ESTALE check with a comment about how a frozen sidtab will be caught
> > by the call above.
>
> No, nothing really prevents the sidtab from becoming frozen between
> the two calls.

Yes, my mistake, I was focused on the RCU policy copies and not
looking at the spinlock for the freeze state.

> > > @@ -2676,18 +2732,20 @@ int security_get_user_sids(struct selinux_state *state,
> > >         struct sidtab *sidtab;
> > >         struct context *fromcon, usercon;
> > >         u32 *mysids = NULL, *mysids2, sid;
> > > -       u32 mynel = 0, maxnel = SIDS_NEL;
> > > +       u32 i, j, mynel, maxnel = SIDS_NEL;
> > >         struct user_datum *user;
> > >         struct role_datum *role;
> > >         struct ebitmap_node *rnode, *tnode;
> > > -       int rc = 0, i, j;
> > > +       int rc;
> > >
> > >         *sids = NULL;
> > >         *nel = 0;
> > >
> > >         if (!selinux_initialized(state))
> > > -               goto out;
> > > +               return 0;
> > >
> > > +retry:
> > > +       mynel = 0;
> > >         rcu_read_lock();
> > >         policy = rcu_dereference(state->policy);
> > >         policydb = &policy->policydb;
> > > @@ -2723,6 +2781,10 @@ int security_get_user_sids(struct selinux_state *state,
> > >                                 continue;
> > >
> > >                         rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
> > > +                       if (rc == -ESTALE) {
> > > +                               rcu_read_unlock();
> >
> > Don't we need to free and reset 'mysids' here?  'mynel' and 'maxnel'
> > are probably less critical since the -ESTALE condition should happen
> > before they are ever modified, but a constant assignment is pretty
> > cheap so it may make sense to reset those as well.
>
> No, we can keep "mysids" and "maxnel", since they represent an
> automatically growing vector, which we can keep and reuse in the retry
> path rather than starting from scratch. It is more efficient, since
> the new policy will likely have the same number of SIDs in the result.
> If it has more, we just grow the vector further as needed; if it has
> less, we just don't use the full capacity and the array will be freed
> after a while anyway (see "out_unlock"), so the extra memory shouldn't
> be held for too long. Not to mention that this is a deprecated
> interface that will hopefully be removed one day :)

I believe you are ignoring the case where mysids is non-NULL when an
-ESTALE occurs and the code jumps to 'retry' and that ends up calling
'mysids = kcalloc(...)' before the ebitmap loop.  Perhaps I'm
mistaken, but this looks like a memory leak to me.

> (And you're wrong that mynel/maxnel can't be modified - notice that
> the sidtab_context_to_sid() call is inside a loop ;)

My comments were correct if you work under the (faulty) assumption
that the sidtab isn't being frozen underneath you :-P

-- 
paul moore
www.paul-moore.com
