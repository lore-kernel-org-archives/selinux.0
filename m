Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96DC433DB
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 14:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F0164E42
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 14:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBJOek (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 09:34:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhBJOei (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 09:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612967590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mAE7StcBSgollMY00HGhmTWuijqoXhv4hWnM57VF3k8=;
        b=QrDIpyZxlrI72jP9GNJ9MuirtU4I8kC3Efz/Qpq4EzAm2JAiocwaNaOCRn11waTfYOgx9Z
        Iz2lmv1dbDUYoUKdpeEEUfHwGwygYLdidFAuC1Hqsh+C2RFYuoT3cK8f//OBW0kdCOMKB6
        0tMC49gBvdnCyu53YhjO0qfjheFtJRU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-ecmb7uG5OwSjOeeAivYF7A-1; Wed, 10 Feb 2021 09:33:09 -0500
X-MC-Unique: ecmb7uG5OwSjOeeAivYF7A-1
Received: by mail-yb1-f197.google.com with SMTP id w11so2671711ybq.8
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 06:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAE7StcBSgollMY00HGhmTWuijqoXhv4hWnM57VF3k8=;
        b=ddlqx3OJXQR9+qIsSUNFUBVe67x/cwmho96Gf6Q0puvscI5Hr2rVPs7IO7IbGEy11B
         T6FAWhiDax9EWnkrNtgYWn6MB0ObXlEiKCbYc26J8iecv6w7OyTcAKvXeUIKEO8Nm0BS
         gtTBkvTliD3fkm2zWog2Ffgg8UCkIOO9ieO1xI5Yop8/o8T1M1d54g6pJZTMXDP11wC0
         pPlua+q40IhbrNi06v9qbGcxqLLyevZF1FK0mLBI9en3ErTbGnMuJuyFMlSlP7Mqs/hQ
         NIeGTdn8d2Z6hc3HK+JFjkRtWIVnX4/AnmtNZEaAZ4llEYT7ORk0L7i5i/K7StfTaZmY
         oCPg==
X-Gm-Message-State: AOAM533YhqdweIV2OhD9jbzMsr7mZGbf8b6QVKosfAzUDzABJZSuc4Bj
        zD3eHiGgy33WMWTCWgoL/dbVrvKKC2A4iQ4yo/SWDX1Ipym1C74KcCr7zrDi1xG42m5dC6eNeAJ
        Az1lOLtmVqs+ejhi5ZskhPvgtE14IbEMUMw==
X-Received: by 2002:a25:a241:: with SMTP id b59mr4652942ybi.289.1612967587422;
        Wed, 10 Feb 2021 06:33:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbtzw9BlMQip9ZIJdWx0u5wowz1EfeY2hJNe3kjFNEELczof9itBuk32vY+JVnXp7rpb4pgPiwnyHdFMAGqQg=
X-Received: by 2002:a25:a241:: with SMTP id b59mr4652915ybi.289.1612967587180;
 Wed, 10 Feb 2021 06:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20210208112736.247195-1-omosnace@redhat.com> <CAHC9VhTN+2kTxXvu2JtDGM1mATVT6PoBWojE=-xDMz1Mer85Lg@mail.gmail.com>
In-Reply-To: <CAHC9VhTN+2kTxXvu2JtDGM1mATVT6PoBWojE=-xDMz1Mer85Lg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 10 Feb 2021 15:32:52 +0100
Message-ID: <CAFqZXNuywOQfY4P=SFpB1szGf0x84S++2ArB_qGD2_8S1W2AfA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix variable scope issue in live sidtab conversion
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 9, 2021 at 3:20 AM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Feb 8, 2021 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> > selinuxfs") moved the selinux_policy_commit() call out of
> > security_load_policy() into sel_write_load(), which caused a subtle yet
> > rather serious bug.
> >
> > The problem is that security_load_policy() passes a reference to the
> > convert_params local variable to sidtab_convert(), which stores it in
> > the sidtab, where it may be accessed until the policy is swapped over
> > and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> > called directly from security_load_policy(), so the convert_params
> > pointer remained valid all the way until the old sidtab was destroyed,
> > but now that's no longer the case and calls to sidtab_context_to_sid()
> > on the old sidtab after security_load_policy() returns may cause invalid
> > memory accesses.
> >
> > This can be easily triggered using the stress test from commit
> > ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > performance"):
> > ```
> > function rand_cat() {
> >         echo $(( $RANDOM % 1024 ))
> > }
> >
> > function do_work() {
> >         while true; do
> >                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> >                         >/sys/fs/selinux/context 2>/dev/null || true
> >         done
> > }
> >
> > do_work >/dev/null &
> > do_work >/dev/null &
> > do_work >/dev/null &
> >
> > while load_policy; do echo -n .; sleep 0.1; done
> >
> > kill %1
> > kill %2
> > kill %3
> > ```
> >
> > There are several ways to fix this:
> > 1. Move the sidtab convert parameters to struct selinux_policy.
> >    Pros:
> >      * simple change
> >    Cons:
> >      * added fields not used during most of the object's lifetime
> > 2. Move the sidtab convert params to sel_write_load().
> >    Pros:
> >      * (nothing specific)
> >    Cons:
> >      * layering violation, a lot of types would have to be exposed to
> >        selinuxfs.c
> > 3. Merge policy load functions back into one and call
> >    sel_make_policy_nodes() as a callback.
> >    Pros:
> >      * results in simpler code
> >    Cons:
> >      * introduces an indirect call (not in hot path, so should be okay)
> >
> > I chose to implement option (3.), because IMHO it results in the least
> > ugly code and has the least bad drawback.
> >
> > Note that this commit also fixes the minor issue of logging a
> > MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> > which case the new policy isn't actually loaded).
> >
> > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/include/security.h |  10 +-
> >  security/selinux/selinuxfs.c        |  18 +---
> >  security/selinux/ss/services.c      | 159 ++++++++++++----------------
> >  3 files changed, 78 insertions(+), 109 deletions(-)
>
> My concern is that this is something that should be backported to
> -stable and I wonder if there is an easier way.

This would need to go only into 5.10 (and 5.11 depending on the
timing), so I think it should still apply cleanly. But there is
additional value in having small patches for stable (less likelihood
of mistake), so I'll try to revisit it...

> Since the core issue
> appears to be the scope/lifetime of the stdtab->convert field, and
> since the ->convert field is a struct with only three pointers, why
> not either embed a copy of the sidtab_convert_params struct in the
> sidtab struct (net increase in two pointers),

This has a hidden catch - also the convert_context_args would need to
be embedded and that has pointers to policydb and selinux_state, which
sidtab currently doesn't "know about" (i.e. it would slightly break
the abstraction).

> or do a memdup() (or
> similar) into the sidtab->convert in sidtab_convert().  There would
> need to be some minor additional work in the latter case, but I
> imagine adding a kfree() to sidtab_cancel_convert() and calling
> sidtab_cancel_convert() in selinux_policy_commit() should be the bulk
> of the changes.

This should be possible and relatively easy. I forgot to list it in
the options - my only problem with that was the unnecessary dynamic
allocation, but i concur that keeping the patch small is more
important in this case. I'll try to do it this way in v2.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

