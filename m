Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0BFC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1478F214F1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoNNJwoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHXNEk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbgHXNEk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598274277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYQ0JeotXZ2gB4JjI3e8K7INnT/nrRU9JSlyJgRLf8Q=;
        b=YoNNJwoeq+DQGVqmO6LzfV3XpMC0esaHVm+DuHfn/R+eqaB6X2rzYnOVmuPKbP0dloIrnK
        ht/P+NNIuNhjo6cnKGZmnSZxzGvkjEmSya8RTcURZn9TN2CikSr5rFOqNE6PtjhwzCP694
        wIRZ4kz9oHqsYiS1SLtTwcTbBIHNIJU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-hyZEUG6eMDWoXNlfkZOnfw-1; Mon, 24 Aug 2020 09:04:13 -0400
X-MC-Unique: hyZEUG6eMDWoXNlfkZOnfw-1
Received: by mail-lf1-f71.google.com with SMTP id x13so1059485lfr.15
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYQ0JeotXZ2gB4JjI3e8K7INnT/nrRU9JSlyJgRLf8Q=;
        b=a/gRtLcFWr+FnDT7sg+f+BBEtmLB9pDtAyKyiB0AhNGC1/UFPpzNY99pYR4peekyuZ
         V6dPGWRqwPwmRTOC1/qzvC0ChRY2sBPtwEUM4Ncjr8WOiJVwOkZIc9PNNt22WETLWRbG
         4JXSYFtKMx+59KWFY7OstwNnb6G+8z2XWcdNbhXVrcldNxprZxFe254Xfwe+BrzXE4aR
         Ed+rQbqeT7OXmRS0k0nRitf7593y3182D6eTVAldD/Wp6Vcvnr4NlJTN297s9FFEY2PU
         ZnBqOFEsqgZzQ2+uWi5QPyAW3dYxLLc1t8L4YijcxphTe4fl3eFEctnC41uP0Rzhzbyp
         sMig==
X-Gm-Message-State: AOAM533p1jTTxuBUJf8nAz+9slAfjSh96MePChVpca6Gt6oJL4BlkCh6
        2q3kCBr9smgzBPJ46e4VQ8GDJ0xb2kQSsxOwUkGwiNj2jHDe05TRiPUZhy3tZCNa9H13VRVzmZX
        FlcpOYnPrIH3S3EI9DStGzijvL3rl24pGdA==
X-Received: by 2002:a2e:7010:: with SMTP id l16mr2499066ljc.38.1598274251865;
        Mon, 24 Aug 2020 06:04:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTYB9jG1SYfVEP6UDPAaN4cw5nq+rJOnhV318VHQKz0Qq/yexBWHSKtZTzBZ3w36p34bvzdPyAHU770MZSdKg=
X-Received: by 2002:a2e:7010:: with SMTP id l16mr2499055ljc.38.1598274251626;
 Mon, 24 Aug 2020 06:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200824113015.1375857-1-omosnace@redhat.com> <20200824113015.1375857-2-omosnace@redhat.com>
 <CAEjxPJ6sTB+SCKQFg=4uMHMih1gAnCTYdcPUJ=FGMpYZwYYo5Q@mail.gmail.com> <CAEjxPJ4j3+C0tCCuMPc5a8Y9-Yp=n3Xc+217OkNV7i=CC6P=Uw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4j3+C0tCCuMPc5a8Y9-Yp=n3Xc+217OkNV7i=CC6P=Uw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 15:04:00 +0200
Message-ID: <CAFqZXNuMP+BJBPLLRd6ir8txvvKJAT1ryRkJQQjNOyhtq2uFhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: fix a race condition in security_read_policy()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 2:53 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 24, 2020 at 8:47 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Aug 24, 2020 at 7:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > In security_read_policy(), the policy length is computed using
> > > security_policydb_len(), which does a separate transaction, and then
> > > another transaction is done to write the policydb into a buffer of this
> > > length.
> > >
> > > The bug is that the policy might be re-loaded in between the two
> > > transactions and so the length can be wrong. In case the new length is
> > > lower than the old length, the length is corrected at the end of the
> > > function. In case the new length is higher than the old one, an error is
> > > returned.
> > >
> > > Since we can't call vmalloc_user() under read_lock(), fix it by checking
> > > if the allocated buffer is sufficiently large after doing the allocation
> > > and taking the read lock and if not, retry the whole operation with the
> > > new size.
> > >
> > > Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/services.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index a48fc1b337ba9..2c9072f095985 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -3849,14 +3849,22 @@ int security_read_policy(struct selinux_state *state,
> > >
> > >         *len = security_policydb_len(state);
> > >
> > > +again:
> > >         *data = vmalloc_user(*len);
> > >         if (!*data)
> > >                 return -ENOMEM;
> > >
> > > +       read_lock(&state->ss->policy_rwlock);
> > > +       if (*len < state->ss->policy->policydb.len) {
> > > +               *len = state->ss->policy->policydb.len;
> > > +               read_unlock(&state->ss->policy_rwlock);
> > > +               vfree(*data);
> > > +               goto again;
> > > +       }
> > > +
> > >         fp.data = *data;
> > >         fp.len = *len;
> > >
> > > -       read_lock(&state->ss->policy_rwlock);
> > >         rc = policydb_write(&state->ss->policy->policydb, &fp);
> > >         read_unlock(&state->ss->policy_rwlock);
> > >
> >
> > security_read_policy() is called with fsi->mutex held by selinuxfs, so
> > policy reload cannot occur in between the length computation and the
> > writing of the policydb.  Right?  It's another case where we could
> > pass down the mutex as in my rcu patches for a lockdep assertion.
>
> If my RCU patches are merged, we could modify security_read_policy()
> to take the mutex too and use rcu_dereference_protected() there,
> likewise getting rid of the separate security_policydb_len().  Or I
> could re-spin them to do that if any other changes are needed.
> Waiting to see if Paul wants any changes to either of those.

Oh, you're right, there is really no race condition thanks to the
mutex... So this patch isn't necessary then, but the second one should
still count as a simplification (with an updated commit message). I'm
fine with merging it into the RCU patch(es) if you want to do it. Or
I'll just send a rebased version if they get merged in the current
form.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

