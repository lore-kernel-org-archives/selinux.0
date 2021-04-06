Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFD1C433ED
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 09:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3DA61380
	for <selinux@archiver.kernel.org>; Tue,  6 Apr 2021 09:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhDFJCK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Apr 2021 05:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233646AbhDFJCJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Apr 2021 05:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617699721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6RX5EjwvysNFxF74MVL6D95/nasVNyWERB4d5vjbrc=;
        b=PXdJspFT1nbFpMVM4eYQCD0q9HbwFq5E8aK3AXp8QERGUul8hG3o0hcSKyvOmk5oL9lDyo
        crgPZMKcXSORmMk8Q/CTuKxczTZfST0sPFNhZHvrTxXCOgcxk+i75W7yIn1qS9pdkoldFa
        i1swt+fsDljEUlODKQnlTwqBdDkBdHE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-vrxNUNs1NHOLgGKZ-ipsRA-1; Tue, 06 Apr 2021 05:01:59 -0400
X-MC-Unique: vrxNUNs1NHOLgGKZ-ipsRA-1
Received: by mail-yb1-f197.google.com with SMTP id b126so8603867ybg.19
        for <selinux@vger.kernel.org>; Tue, 06 Apr 2021 02:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6RX5EjwvysNFxF74MVL6D95/nasVNyWERB4d5vjbrc=;
        b=N4Ih0DpWmRtSV7LojH2Mh+BwfKr++TrfviAGtJOruWeZRmXethDBdgWdLp9GieqomK
         T981WL/e/Bc1PmOMfHs7lX5tdOia4Xz6mnG0yTwED45rA3AYTyhOrwb6sMkUws+2w7M2
         XO82j+scHfCFTZQ7GjWHb+JohLWuym74DE4nv9nZeOnWYMza3hv381zBvGcR+WCw6c/J
         LabaL1KzgSXeGXPW/WZcqzfaYuJHsEn2CNFOZ64df00TCcAKjhv6iQfbQf8KiJoXi4wj
         3S1buE0UvrIcIhK1ET7pc3oDQLKSihLTRCO4wI8s/Pgirb+xpha2+QwKpvyau+B6+QFR
         z64A==
X-Gm-Message-State: AOAM530aPGIfDypJ1Ei94cj12Sc37xO1mnwTJYQtONZKbCSKK6ZpZhli
        W4cogiCAA8tPIsSONPn6Dto6Vmd/3PBDboLEjkkz0c6RRcBAWz54xqfEc8vjEky7wqbkTnFmqin
        sir/DPkP76DBfMcFQiPMkDArZ31sp1kbJnw==
X-Received: by 2002:a25:c750:: with SMTP id w77mr40808340ybe.340.1617699718545;
        Tue, 06 Apr 2021 02:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1TS7CoXAY/UvXi2YfYIGEJKe3PL9vc6Ii+PNcHY1tTX/rqRx7/eC2pq35pfN3hx5Xi1G3ijv5S0Gz5Q5rLi4=
X-Received: by 2002:a25:c750:: with SMTP id w77mr40808303ybe.340.1617699718196;
 Tue, 06 Apr 2021 02:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210405091052.2296792-1-omosnace@redhat.com> <CAHC9VhSCSNvRE1JCjmYimifd4ip0Ar6mipouVqj2_zEGXij0Rg@mail.gmail.com>
In-Reply-To: <CAHC9VhSCSNvRE1JCjmYimifd4ip0Ar6mipouVqj2_zEGXij0Rg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 6 Apr 2021 11:01:45 +0200
Message-ID: <CAFqZXNvd3dP1Wm6JFBJ+P+uttd=1Yg_MuaDdcyUizK6SWpMrbg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race between old and new sidtab
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 6, 2021 at 12:11 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Apr 5, 2021 at 5:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Since commit 1b8b31a2e612 ("selinux: convert policy read-write lock to
> > RCU"), there is a small window during policy load where the new policy
> > pointer has already been installed, but some threads may still be
> > holding the old policy pointer in their read-side RCU critical sections.
> > This means that there may be conflicting attempts to add a new SID entry
> > to both tables via sidtab_context_to_sid().
> >
> > See also (and the rest of the thread):
> > https://lore.kernel.org/selinux/CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com/
> >
> > Fix this by installing the new policy pointer under the old sidtab's
> > spinlock along with marking the old sidtab as "frozen". Then, if an
> > attempt to add new entry to a "frozen" sidtab is detected, make
> > sidtab_context_to_sid() return -ESTALE to indicate that a new policy
> > has been installed and that the caller will have to abort the policy
> > transaction and try again after re-taking the policy pointer (which is
> > guaranteed to be a newer policy). This requires adding a retry-on-ESTALE
> > logic to all callers of sidtab_context_to_sid(), but fortunately these
> > are easy to determine and aren't that many.
> >
> > This seems to be the simplest solution for this problem, even if it
> > looks somewhat ugly. Note that other places in the kernel (e.g.
> > do_mknodat() in fs/namei.c) use similar stale-retry patterns, so I think
> > it's reasonable.
> >
> > Fixes: 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/services.c | 145 ++++++++++++++++++++++++++-------
> >  security/selinux/ss/sidtab.c   |  21 +++++
> >  security/selinux/ss/sidtab.h   |   4 +
> >  3 files changed, 139 insertions(+), 31 deletions(-)
>
> I'm glad to see the retry approach here, that looks like a good
> solution to me.  I did have a few comments below.
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 08ac1d01c743..50abcfcdf242 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1736,6 +1746,7 @@ static int security_compute_sid(struct selinux_state *state,
> >                 goto out;
> >         }
> >
> > +retry:
> >         context_init(&newcontext);
> >
> >         rcu_read_lock();
> > @@ -1880,6 +1891,11 @@ static int security_compute_sid(struct selinux_state *state,
> >         }
> >         /* Obtain the sid for the context. */
> >         rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> > +       if (rc == -ESTALE) {
> > +               rcu_read_unlock();
> > +               context_destroy(&newcontext);
>
> Do we also need to reset 'cladatum' to NULL here as well?

Yep, good catch!

>
> > +               goto retry;
> > +       }
> >  out_unlock:
> >         rcu_read_unlock();
> >         context_destroy(&newcontext);
>
> ...
>
> > @@ -2510,7 +2551,7 @@ int security_netif_sid(struct selinux_state *state,
> >         struct selinux_policy *policy;
> >         struct policydb *policydb;
> >         struct sidtab *sidtab;
> > -       int rc = 0;
> > +       int rc;
> >         struct ocontext *c;
> >
> >         if (!selinux_initialized(state)) {
> > @@ -2518,6 +2559,8 @@ int security_netif_sid(struct selinux_state *state,
> >                 return 0;
> >         }
> >
> > +retry:
> > +       rc = 0;
> >         rcu_read_lock();
> >         policy = rcu_dereference(state->policy);
> >         policydb = &policy->policydb;
> > @@ -2534,10 +2577,18 @@ int security_netif_sid(struct selinux_state *state,
> >                 if (!c->sid[0] || !c->sid[1]) {
> >                         rc = sidtab_context_to_sid(sidtab, &c->context[0],
> >                                                    &c->sid[0]);
> > +                       if (rc == -ESTALE) {
> > +                               rcu_read_unlock();
> > +                               goto retry;
> > +                       }
> >                         if (rc)
> >                                 goto out;
> >                         rc = sidtab_context_to_sid(sidtab, &c->context[1],
> >                                                    &c->sid[1]);
> > +                       if (rc == -ESTALE) {
> > +                               rcu_read_unlock();
> > +                               goto retry;
> > +                       }
>
> If the first sidtab_context_to_sid() ran successfully we are not going
> to see -ESTALE here, correct?  Assuming yes, perhaps we can drop this
> -ESTALE check with a comment about how a frozen sidtab will be caught
> by the call above.

No, nothing really prevents the sidtab from becoming frozen between
the two calls.

>
> >                         if (rc)
> >                                 goto out;
> >                 }
>
> ...
>
> > @@ -2676,18 +2732,20 @@ int security_get_user_sids(struct selinux_state *state,
> >         struct sidtab *sidtab;
> >         struct context *fromcon, usercon;
> >         u32 *mysids = NULL, *mysids2, sid;
> > -       u32 mynel = 0, maxnel = SIDS_NEL;
> > +       u32 i, j, mynel, maxnel = SIDS_NEL;
> >         struct user_datum *user;
> >         struct role_datum *role;
> >         struct ebitmap_node *rnode, *tnode;
> > -       int rc = 0, i, j;
> > +       int rc;
> >
> >         *sids = NULL;
> >         *nel = 0;
> >
> >         if (!selinux_initialized(state))
> > -               goto out;
> > +               return 0;
> >
> > +retry:
> > +       mynel = 0;
> >         rcu_read_lock();
> >         policy = rcu_dereference(state->policy);
> >         policydb = &policy->policydb;
> > @@ -2723,6 +2781,10 @@ int security_get_user_sids(struct selinux_state *state,
> >                                 continue;
> >
> >                         rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
> > +                       if (rc == -ESTALE) {
> > +                               rcu_read_unlock();
>
> Don't we need to free and reset 'mysids' here?  'mynel' and 'maxnel'
> are probably less critical since the -ESTALE condition should happen
> before they are ever modified, but a constant assignment is pretty
> cheap so it may make sense to reset those as well.

No, we can keep "mysids" and "maxnel", since they represent an
automatically growing vector, which we can keep and reuse in the retry
path rather than starting from scratch. It is more efficient, since
the new policy will likely have the same number of SIDs in the result.
If it has more, we just grow the vector further as needed; if it has
less, we just don't use the full capacity and the array will be freed
after a while anyway (see "out_unlock"), so the extra memory shouldn't
be held for too long. Not to mention that this is a deprecated
interface that will hopefully be removed one day :)

(And you're wrong that mynel/maxnel can't be modified - notice that
the sidtab_context_to_sid() call is inside a loop ;)

>
> > +                               goto retry;
> > +                       }
> >                         if (rc)
> >                                 goto out_unlock;
> >                         if (mynel < maxnel) {
> > @@ -2745,14 +2807,14 @@ out_unlock:
> >         rcu_read_unlock();
> >         if (rc || !mynel) {
> >                 kfree(mysids);
> > -               goto out;
> > +               return rc;
> >         }
> >
> >         rc = -ENOMEM;
> >         mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
> >         if (!mysids2) {
> >                 kfree(mysids);
> > -               goto out;
> > +               return rc;
> >         }
> >         for (i = 0, j = 0; i < mynel; i++) {
> >                 struct av_decision dummy_avd;
> > @@ -2765,12 +2827,10 @@ out_unlock:
> >                         mysids2[j++] = mysids[i];
> >                 cond_resched();
> >         }
> > -       rc = 0;
> >         kfree(mysids);
> >         *sids = mysids2;
> >         *nel = j;
> > -out:
> > -       return rc;
> > +       return 0;
> >  }
> >
> >  /**
>
> --
> paul moore
> www.paul-moore.com
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

