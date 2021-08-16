Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171C3C4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E362560EFE
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 20:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhHPUjM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhHPUjK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 16:39:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962BC061764
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 13:38:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d11so34132444eja.8
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZPOl68Ndzvm/jlAcQLcOKVl2CP6rfKuQA3mCtKk+5Y=;
        b=EyJ0Pj0Plj9ahrMvvgiE4I5Ud6jufC7nuHPp7yJR6lkuufX81PlPc2m8REkMCTSuqp
         gnlLKI7fnj1Yl6ODMuR8nOii7Eimjti03Se/JP+9kGDBaJM1dYICIr+rFNkNxELeKDdA
         zIC7pIc7pTryZMAsmmvs/0gdI3eKcsGDrayHyjQX1zCwA/ORJlrrhFAVfNgWogL7qKOB
         b11wQLw2dSxGH9ZHbfySUYkUE9TW5+UyA23l13/fZnBjw+W/HLmbBhBtU9RxsmM4wRIl
         nXh0i5oLfaRVfVhp9e0hYloPRmHrxwtGmMCOYUUvZyJJ2K/Uy5N80QYKVvkpJhQwmiz2
         weaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZPOl68Ndzvm/jlAcQLcOKVl2CP6rfKuQA3mCtKk+5Y=;
        b=OY7sjI244U8kN40ugBBULuNuQNu2wSY3ZJ0L+X8Yxs0MoTmFQZcWia0OOMLIKlY0cs
         DzwHmWie2yc+TG2+J8YJzn+da9QNfQLFp51rUvFde4yUD+UdCazf/LvtUipU9y0FlvPh
         z4i9em7z+w3qe57dMXOl0ObvnYPTBjCaiN5cbPL0QTRsAqYOPS/wOzi7ygV+C2bKHt93
         lmIbzD6GqwrHJPuafP/Aa97mhD2ahn8/0ith8TZAV/VnjO6YLShV+8KdutWlnhdman1s
         ISOqrbXoSsvsZqsVXDwbDY6Kks7sqLZ9y92aVwGNfoAUJWItXAHywv3orGILLO/MX3JZ
         m10A==
X-Gm-Message-State: AOAM531vNzSCsQ34USNGlzU2blRApSCnHlYy6ewfzx6g6BoiWANzmnQ3
        joGVMy2v6EHcjZzbgAowVvs9ATxeEozm5sEe/UUo
X-Google-Smtp-Source: ABdhPJxH9kJEGkTnoGGI3uF5KPYORmjXaL2OKMsRAJztVGnqJddqlOz7APpEC/HJvR1f4elLyafcmXzM+9oX7Wcp2Cs=
X-Received: by 2002:a17:906:95c9:: with SMTP id n9mr335603ejy.178.1629146316874;
 Mon, 16 Aug 2021 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
 <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Aug 2021 16:38:25 -0400
Message-ID: <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 16, 2021 at 8:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Aug 5, 2021 at 10:48 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Jul 28, 2021 at 10:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> [...]
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index 0a5ce001609b..c8db8a3432e4 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -2369,6 +2369,43 @@ err_policy:
> > >         return rc;
> > >  }
> > >
> > > +/**
> > > + * ocontext_to_sid - Helper to safely get sid for an ocontext
> > > + * @sidtab: SID table
> > > + * @c: ocontext structure
> > > + * @index: index of the context entry (0 or 1)
> > > + * @out_sid: pointer to the resulting SID value
> > > + *
> > > + * For all ocontexts except OCON_ISID the SID fields are populated
> > > + * on-demand when needed. Since updating the SID value is an SMP-sensitive
> > > + * operation, this helper must be used to do that safely.
> > > + *
> > > + * WARNING: This function may return -ESTALE, indicating that the caller
> > > + * must retry the operation after re-acquiring the policy pointer!
> > > + */
> > > +static int ocontext_to_sid(struct sidtab *sidtab, struct ocontext *c,
> > > +                          size_t index, u32 *out_sid)
> > > +{
> > > +       int rc;
> > > +       u32 sid;
> > > +
> > > +       /* Ensure the associated sidtab entry is visible to this thread. */
> > > +       sid = smp_load_acquire(&c->sid[index]);
> >
> > Is there a reason why you decided to use smp_{load,store} to guard
> > ocontext.sid[] as opposed to RCU/spinlock?  RCU would allow us to
> > avoid the memory barrier in smp_load_acquire() on every call to
> > ocontext_to_sid() and it looks like all of the non-exclusive callers
> > are already in a RCU protected section so the additional impact on an
> > already cached value should be next to nothing.  The spinlock would
> > make things slightly more complicated (take the lock, recheck
> > ocontext.sid, set/bail, unlock, etc.) but we are already in the slow
> > path at that point.
>
> I don't see any sane way to use RCU here - the implicit data
> dependency that the memory barrier is guarding us against here is
> between the sid field(s) and the memory regions in sidtab that hold
> the struct context corresponding to the SID stored in the field. You'd
> have to put both the SID value and the sidtab pointer behind some
> dynamically allocated structure and that would just be horrible...

I'm jumping between the io_uring stuff, stacking/audit issues, and now
this today and I fear that context switches have taken their toll
already and I haven't resolve this in my own mind yet.  However, since
this patch has been languishing in inboxes with a week or so between
replies I wanted to at least impart this comment today ...

You need to start thinking more about how this code is going to be
maintained long term.  To clarify, when I say "long term" I'm talking
about +10 years from now when most everyone involved has forgotten the
subtle data dependencies you're talking about now.  While memory
barriers are sometimes necessary due to the unavoidable complexity in
the kernel, they shouldn't be an excuse for properly crafting, and
synchronizing access to data structures.  My initial take two weeks
ago was that this patch has some nice ideas, e.g. the consolidation
into ocontext_to_sid(), but the use of memory barriers as a solution
to synchronizing the cached SID and underlying context was just not a
good first option (especially considering the minimal comments
explaining need for the barrier).  Maybe we get back to this solution
eventually, but I'm really hoping there is a better way, and your
commit made no comment about what other options you may have explored.

Please try to come up with a better solution that leverages proper
locking primitives, and if that isn't possible please explain (in
detail) why.

> I assume that by using spinlock you mean something like:
>
> sid = READ_ONCE(c->sid);
> if (!sid) {
>         spin_lock(...);
>         sidtab_context_to_sid(..., &sid);
>         WRITE_ONCE(c->sid, sid);
>         spin_unlock(...);
> }
>
> ...because taking the spinlock every time would obviously be less
> efficient than this patch :)

I didn't think I needed to clarify that, but yes, that is what I meant.

-- 
paul moore
www.paul-moore.com
