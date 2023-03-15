Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9241C6FD1D
	for <selinux@archiver.kernel.org>; Wed, 15 Mar 2023 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjCOMfi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 08:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjCOMfO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Mar 2023 08:35:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E638376157
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 05:33:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a2so19838172plm.4
        for <selinux@vger.kernel.org>; Wed, 15 Mar 2023 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678883628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH8yHCArLZSAnyJaX65SWWtNBfpANTd/8Hc+BenEC+I=;
        b=GQYnucr+aeW2M4iKnuROnuJI64//NH3UV5WYVgXW14cy+UdSD4+tZlE/kTyQKuYflG
         SMzPgrPqx+UOVx7MC9LiSKXghPKWeKF3N9bmt3gPXf3OioERi6LH0f1DQkRGbXhLpSOE
         nicxmpQeAFXwb/7H2IbLB87PhlIVs7cjIPgMwVBfh4fD7+dDKu8TuLIZvy9Eyk5SoQi7
         OCy2JCKLmWGl8pWVfzQkij3qX6gPWCj+Eo5X3/oRQtmFFxQpbDZ7B6LGLD9zg7u4f4uA
         gVvuD26FmJBOsXGPfF+Ht/Z7GqbMtUiKZONBqcRJ1i1LmVvujxUNkm+wr82UGJ8FpyyJ
         wczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH8yHCArLZSAnyJaX65SWWtNBfpANTd/8Hc+BenEC+I=;
        b=2MIN4l69o0fkpFtZAgIrF3aQuvIe+P68cfdEWiJYPPpI2lE5YE2pqk7Wzoe6/Ljiza
         OPrJKAMHQWM+jiZr9M+cXQSLawtmDq4War4LJeQCx8jFexMhJFRxDajrtx6GJXMQGFRz
         IREueOevUHc0t9UdeWU98QqPO4Rck14bz0RZLNwJkQiDwDr+VoGJS+GDzGp7XnzSOO6P
         zsuu+3HBpKdgu6K4uSRDUwRLMoQw8nttNhqXhUgYuKe+9oXJcKSvawqjayuRjc8adE1b
         lz/wTXhr/KAc4oXeSllvi0fxArS/qNySy9pIAEGjhHxdrNp10cWU4Pbm5u6el50cd9Ap
         RHfQ==
X-Gm-Message-State: AO0yUKUrfwqt20ZzTrw3RRLC/4LkkDacJPQ4OxnStsCly+NHlzuL/3Qq
        Y5kacjSitcJTZNliFizmixi9SWY7189PrkhpSUg=
X-Google-Smtp-Source: AK7set94NgfGcHH+/s4luzE5UteQTYNC5waC1UznE58ql5/23RrMrb5Ll06MX12IcKXaKDNDLWKH5Tc1kZJjRw+Ee34=
X-Received: by 2002:a17:902:c94a:b0:19a:f9d9:28d4 with SMTP id
 i10-20020a170902c94a00b0019af9d928d4mr1147434pla.3.1678883627746; Wed, 15 Mar
 2023 05:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230314125734.19896-1-stephen.smalley.work@gmail.com> <CAHC9VhQ77njhXPvEZ6-3WKVQtLtNXJw69NOGSoNktf7STgKjTQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ77njhXPvEZ6-3WKVQtLtNXJw69NOGSoNktf7STgKjTQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Mar 2023 08:33:36 -0400
Message-ID: <CAEjxPJ7ZVnGzWFfj051POA+gO2cVY_6vPgyNzPBFo=wr909xYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: cache access vector decisions in the
 inode security blob
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 14, 2023 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Mar 14, 2023 at 9:03=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I think Linus suggested this a long long time ago but I never got aroun=
d
> > to trying it. Better late than never. Compute the access vector decisio=
n
> > when the inode security blob is initialized and cache it in the blob.
> > Update it on file opens. In selinux_inode_permission and inode_has_perm=
,
> > use this cached decision unless invalidated.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > There is an obvious race here; we need some form of synchronization
> > to ensure consistency of isec->task_sid, isec->avdsid, and
> > isec->avd since otherwise we could end up using the wrong access
> > vector decision if e.g. two tasks with different SIDs are accessing
> > the same file. Doing so safely without ending up with worse
> > overhead for selinux_inode_permission and inode_has_perm requires
> > care; open to suggestions here.
>
> Unfortunately, I think we're stuck having to take the
> inode_security_struct's spinlock to synchronize updates; or rather,
> nothing clever is coming to mind that doesn't introduce a bunch of
> unwanted complexity/overhead.
>
> With that in mind, I'm thinking more about where we might do an update
> when we already have the spinlock held.  The obvious first candidate
> is inode_doinit_with_dentry(), but I believe you previously mentioned
> that inode_doinit_with_dentry() alone didn't have much of an impact.
> The other place that comes to mind is in __inode_security_revalidate()
> as this is already called from a fair number of places that I think we
> would care about, and it has the advantage of a parameter which
> signals if it is safe to sleep.  We already call
> inode_doinit_with_dentry() there when it is safe and the inode needs
> to be revalidated, why not update the cached AVC related fields if it
> is safe and the inode is already valid?  I'm not sure if this will
> result in too much cache thrashing in the inode_security_struct, or if
> the spinlock overhead will be unwanted in all the
> __inode_security_revalidate() callers, but I figured it was worth
> mentioning in case you hadn't already played with it.

We are already taking the isec->lock (or otherwise have exclusive
access to a newly initialized isec) in all the places where we are
updating the isec->avd and isec->avdsid. The issue is not the updates
but rather the reads in inode_has_perm() and
selinux_inode_permission(). Would prefer some lockless synchronization
there as otherwise I fear we are making things worse rather than
better. Need to ensure that the (isec->task_sid, isec->avdsid,
isec->avd) triple is consistent (i.e. that the isec->avd represents
the access vector decisions computed based on the isec->task_sid and
isec->avdsid) and that the (sid, isec->sid, avc_policy_seqno()) triple
matches the (isec->task_sid, isec->avdsid, isec->avd.seqno) triple in
order to use that avd.

> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index c162e51fb43c..c74bdd76b38a 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -357,6 +357,8 @@ static int avc_xperms_populate(struct avc_node *nod=
e,
> >         struct avc_xperms_decision_node *dest_xpd;
> >         struct avc_xperms_decision_node *src_xpd;
> >
> > +       if (!src)
> > +               return 0;
>
> This feels like something that we might want to do anyway, although I
> would probably combine it with the check immediately below:
>
>   if (!src || src->xp.len =3D=3D 0)
>     return 0;

Yes, can do that in the next revision.

> > @@ -1121,6 +1125,35 @@ static noinline int avc_perm_nonode(u32 ssid, u3=
2 tsid, u16 tclass,
> >         return 0;
> >  }
> >
> > +/**
> > + * avc_get_avd - Get access vector decisions
> > + * @ssid: source security identifier
> > + * @tsid: target security identifier
> > + * @tclass: target security class
> > + * @avd: access vector decisions
> > + *
> > + * Get access vector decisions for the specified (@ssid, @tsid, @tclas=
s)
> > + * triple, fetching them from the access vector cache if present or
> > + * calling the security server to compute them on a miss. Unlike
> > + * avc_has_perm_noaudit(), this function does not check any
> > + * requested permission; it just returns the entire decision vector.
> > + */
> > +void avc_get_avd(u32 ssid, u32 tsid, u16 tclass, struct av_decision *a=
vd)
> > +{
> > +       struct avc_node *node;
> > +
> > +       rcu_read_lock();
> > +       node =3D avc_lookup(ssid, tsid, tclass);
> > +       if (unlikely(!node)) {
> > +               rcu_read_unlock();
> > +               avc_compute_av(ssid, tsid, tclass, avd, NULL);
> > +               return;
>
> Out of curiosity, did you do any measurements without the
> avc_compute_av() call, relying solely on a previously computed entry
> in the AVC?

The approach here is to call avc_get_avd() on isec
initialization/update and upon file open to cache the access vector
decisions at that time for later use upon inode_has_perm and
selinux_inode_permission. So avc_get_avd() is just
avc_has_perm_noaudit() w/o actually checking any specific requested
permissions. Like avc_has_perm_noaudit(), it first tries to look up
the entry in the AVC and only falls back to avc_compute_av() on a
cache miss. avc_get_avd() is not getting called during
selinux_inode_permission itself. If we don't call avc_compute_av() in
the cache miss case, then we'll have to do so at
selinux_inode_permission and inode_has_perm() time, in which case
we'll pay a higher cost there and that's the more performance-critical
path.

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index f14d1ffe54c5..7353c027c389 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1107,7 +1107,8 @@ void security_compute_av(u32 ssid,
> >         rcu_read_lock();
> >         policy =3D rcu_dereference(selinux_state.policy);
> >         avd_init(policy, avd);
> > -       xperms->len =3D 0;
> > +       if (xperms)
> > +               xperms->len =3D 0;
>
> Similar to the comment for avc_xperms_populate(), I wonder if this is
> something we want to check regardless.

Agree, just wasn't needed until this change.
