Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783FC4338F
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB38B63275
	for <selinux@archiver.kernel.org>; Mon, 16 Aug 2021 12:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhHPMvk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhHPMvj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Aug 2021 08:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629118268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nF8rzVVgmDA9/DXrtxYuY3V4ctspk/z6daKpbRk0VmU=;
        b=WL95dOgAWRIhyG7bSo0Fu86ArORhTF1Xr99rHjb/32KtV2Ea/v/mJI0z4WnoXtQ5Dbk/xK
        3coDGckA19dkf15nyPZZ8rXSzDUj40baw9I4d6wTTkuzqAyetC8ht23Tj4aW3JxUyvqfR+
        qCja4+gqb6M+0YHXXYE0LLw52YXpc8g=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-3IQ9thhjN66Fg-hIv5Lpmw-1; Mon, 16 Aug 2021 08:51:06 -0400
X-MC-Unique: 3IQ9thhjN66Fg-hIv5Lpmw-1
Received: by mail-yb1-f197.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so16744984yba.1
        for <selinux@vger.kernel.org>; Mon, 16 Aug 2021 05:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nF8rzVVgmDA9/DXrtxYuY3V4ctspk/z6daKpbRk0VmU=;
        b=JAp4wLpgagTNdAM73kaq77Ql5qbmt1yV0KlQ/rW4Pn3eMkbAwH2/G6SfZM+cDXUH9o
         bVAOINLKMNO2+ImjfPLIXCftBC18aoHOysiWue+RpCFWZQ/EGxb/eLw7/yJqZ+pumos3
         2AKKWHJWZHtytArAkbkBK8eWLlMppOXf/Kz6gChogLhylHLwGgYZyvIzH4dhiV2MOFtS
         rVCfM9edvPtwBLN2fGcM3nluIjDRv3AqOzn4ptmCCsJH4Cqc5KdF9dLL53N7ricH8kBi
         aI8CiGO69Rscjrm+vQC4kNZpXshGep92bdOpkpGGxSlEMRbQnn1LbFyYmbQXPj0PXyD4
         QMzg==
X-Gm-Message-State: AOAM5317DE++d5gqbTfzFXerXWF74ZbIPYbIdch+qvzsloi6R5vTB1l7
        P0tb8owVFYBnU5QHmFek/uUGfa2SamsI61hUyCDwNdpGsyssAXSVdp1b4l7/C0dZhAtPzf4jip+
        Kmk/DDNr3JxmxHJ8agJGSgKM7uEEs6mAbEg==
X-Received: by 2002:a25:918c:: with SMTP id w12mr20448362ybl.226.1629118266238;
        Mon, 16 Aug 2021 05:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO2CZi/yMz2SQT9VJhdSzBgQWyF8aQq5hDbzLvGIGEALmWTyF70gplPielGfC6bW1l0+2PyfQ3qkPFZqo+Dj4=
X-Received: by 2002:a25:918c:: with SMTP id w12mr20448338ybl.226.1629118265994;
 Mon, 16 Aug 2021 05:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
In-Reply-To: <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 16 Aug 2021 14:50:55 +0200
Message-ID: <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 5, 2021 at 10:48 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jul 28, 2021 at 10:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
[...]
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 0a5ce001609b..c8db8a3432e4 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2369,6 +2369,43 @@ err_policy:
> >         return rc;
> >  }
> >
> > +/**
> > + * ocontext_to_sid - Helper to safely get sid for an ocontext
> > + * @sidtab: SID table
> > + * @c: ocontext structure
> > + * @index: index of the context entry (0 or 1)
> > + * @out_sid: pointer to the resulting SID value
> > + *
> > + * For all ocontexts except OCON_ISID the SID fields are populated
> > + * on-demand when needed. Since updating the SID value is an SMP-sensitive
> > + * operation, this helper must be used to do that safely.
> > + *
> > + * WARNING: This function may return -ESTALE, indicating that the caller
> > + * must retry the operation after re-acquiring the policy pointer!
> > + */
> > +static int ocontext_to_sid(struct sidtab *sidtab, struct ocontext *c,
> > +                          size_t index, u32 *out_sid)
> > +{
> > +       int rc;
> > +       u32 sid;
> > +
> > +       /* Ensure the associated sidtab entry is visible to this thread. */
> > +       sid = smp_load_acquire(&c->sid[index]);
>
> Is there a reason why you decided to use smp_{load,store} to guard
> ocontext.sid[] as opposed to RCU/spinlock?  RCU would allow us to
> avoid the memory barrier in smp_load_acquire() on every call to
> ocontext_to_sid() and it looks like all of the non-exclusive callers
> are already in a RCU protected section so the additional impact on an
> already cached value should be next to nothing.  The spinlock would
> make things slightly more complicated (take the lock, recheck
> ocontext.sid, set/bail, unlock, etc.) but we are already in the slow
> path at that point.

I don't see any sane way to use RCU here - the implicit data
dependency that the memory barrier is guarding us against here is
between the sid field(s) and the memory regions in sidtab that hold
the struct context corresponding to the SID stored in the field. You'd
have to put both the SID value and the sidtab pointer behind some
dynamically allocated structure and that would just be horrible...

I assume that by using spinlock you mean something like:

sid = READ_ONCE(c->sid);
if (!sid) {
        spin_lock(...);
        sidtab_context_to_sid(..., &sid);
        WRITE_ONCE(c->sid, sid);
        spin_unlock(...);
}

...because taking the spinlock every time would obviously be less
efficient than this patch :)

That would, however, not solve the data dependency problem, so you'd
still need smp_*() instead of *_ONCE() and at that point the spinlock
would be redundant (and you're back to exactly what this patch does).

>
> > +       if (!sid) {
> > +               rc = sidtab_context_to_sid(sidtab, &c->context[index], &sid);
> > +               if (rc)
> > +                       return rc;
> > +
> > +               /*
> > +                * Ensure the new sidtab entry is visible to other threads
> > +                * when they see the SID.
> > +                */
> > +               smp_store_release(&c->sid[index], sid);
> > +       }
> > +       *out_sid = sid;
> > +       return 0;
> > +}
>
> --
> paul moore
> www.paul-moore.com
>


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

