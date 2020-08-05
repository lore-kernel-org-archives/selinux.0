Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB094C433E3
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C35A21D95
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 19:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBa6fwuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgHETsJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:48:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgHEQ6X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 12:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596646701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2W0AOsKDDPmiUfOHTqeNQFNO/E6usqZ2j6WK5zWpjM=;
        b=gBa6fwuFjPrnA7VlPiztomzJyQHu5qJWJFx92yz5QcQqCrxwgTuP37cnATUzfz4MjtX6rR
        8Bv3qfwC1jr8MCFkXcrtF02QxhyZaiS7RPizOq8qM+12250upVaDMYISen8F3qYAQGdGYC
        n3MTleA3+IUfvWSecudKSwqf+9h08x0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-mozekt6fN6CqLz7rIJFDrg-1; Wed, 05 Aug 2020 09:27:44 -0400
X-MC-Unique: mozekt6fN6CqLz7rIJFDrg-1
Received: by mail-lj1-f200.google.com with SMTP id a20so2084051lji.17
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 06:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2W0AOsKDDPmiUfOHTqeNQFNO/E6usqZ2j6WK5zWpjM=;
        b=MMT7L1D6q8m2iGD66fI+Wo4lVXxFMGHUwmovjMlhXaBNCI3kRvtyU7Ub4dN7pPGPeS
         a2S2hktgtNGOt5brDV8q9iDRdFa4B3SttOklpOHtI6ifOgklTDEhx0Y7InwVl4p8BbwD
         iy9YaBq18mmzrQpoMe/3fVl3CY65ARTqEQt2/gRHokvkQD1i2p0iKNbch9mhmKhf2NLo
         Hz4cMeNgwUH4Zih8n9fv5DElsVL77f1RdAyOJH1DnvCkxPjXZHNSTeaiBnP2dsDsf/IN
         azmXDY7YPnLGuulCHJIHE3/NWjG1s+BC1u5AjvYPPOX5lPhJsntPCRhK4w5zbCY6Q5vg
         xmPw==
X-Gm-Message-State: AOAM533zTtL5uoTxzol4dipAmcgleE9I4MJFq9MvEfVPkmw9dmZ1aO4J
        UkwfBuJheSxxbugKcXDRLiYIPYn+RWk0HREvlrjW/ukPJcWnI8FpJIL0nZlUIoU137D+KGgLv7p
        5uuWyeP022dtPmXtIvKbDYcbvA67V+YEmMw==
X-Received: by 2002:a2e:9550:: with SMTP id t16mr1390634ljh.372.1596634062929;
        Wed, 05 Aug 2020 06:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTlcfHi/bqFFUB9ztfa8M/ggC1Zf0aYpDvapKa6+fPN4fJk9t3Sis9o9a0Q0GO6QWANIOlgfIeWxymtVJQ49A=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr1390622ljh.372.1596634062583;
 Wed, 05 Aug 2020 06:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200803173948.17118-1-stephen.smalley.work@gmail.com>
 <CAFqZXNs5RjGkifBBVZm8zONx5fube4NZe6xFVAtZpuJjEePw+g@mail.gmail.com> <b4333d41-de9e-96a7-7ef8-39e14513c370@gmail.com>
In-Reply-To: <b4333d41-de9e-96a7-7ef8-39e14513c370@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 5 Aug 2020 15:27:31 +0200
Message-ID: <CAFqZXNuM2ZXQj+b33aFCQxAN447MOqzkSEGyYT5rWgkMqtOv=A@mail.gmail.com>
Subject: Re: [RFC PATCH v3] selinux: encapsulate policy state, refactor policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 5, 2020 at 2:19 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On 8/5/20 4:29 AM, Ondrej Mosnacek wrote:
>
> > On Mon, Aug 3, 2020 at 7:40 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> Encapsulate the policy state in its own structure (struct
> >> selinux_policy) that is separately allocated but referenced from the
> >> selinux_ss structure.  The policy state includes the SID table
> >> (particularly the context structures), the policy database, and the
> >> mapping between the kernel classes/permissions and the policy values.
> >> Refactor the security server portion of the policy load logic to
> >> cleanly separate loading of the new structures from committing the new
> >> policy.  Unify the initial policy load and reload code paths as much
> >> as possible, avoiding duplicated code.  Make sure we are taking the
> >> policy read-lock prior to any dereferencing of the policy.  Move the
> >> copying of the policy capability booleans into the state structure
> >> outside of the policy write-lock because they are separate from the
> >> policy and are read outside of any policy lock; possibly they should
> >> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
> >>
> >> These changes simplify the policy loading logic, reduce the size of
> >> the critical section while holding the policy write-lock, and should
> >> facilitate future changes to e.g. refactor the entire policy reload
> >> logic including the selinuxfs code to make the updating of the policy
> >> and the selinuxfs directory tree atomic and/or to convert the policy
> >> read-write lock to RCU.
> >>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> ---
> >> v3 fixes a couple of instances where we should take the read-lock for
> >> consistency prior to dereferencing state->ss->policy, and updates
> >> sidtab_convert() and its helpers/callbacks to use GFP_ATOMIC
> >> allocations instead of GFP_KERNEL and to remove a call to
> >> cond_resched() since it is now called with the read-lock held and
> >> therefore cannot call sleeping functions.  Technically we know that
> >> state->ss->policy cannot be modified since selinuxfs is taking
> >> fsi->mutex for all policy-modifying operations (both
> >> security_load_policy and security_set_bools) but this provides
> >> consistency in the handling of the policy rwlock.
> > I must say I'm a little concerned about switching to GFP_ATOMIC here.
> > The sidtab table can become quite large on long-running systems (since
> > it's grow-only currently) and in such case the kernel could have a
> > hard time allocating everything atomically. Maybe we could instead
> > pass the fsi->mutex's lockdep_map to security_load_policy() and call
> > lockdep_is_held() inside as a sanity check? This would document that
> > the function is expected to be called in mutual exclusion and also
> > detect at runtime if someone accidentally moves the call outside of
> > the mutex's critical section. It's not perfect, since a careless
> > programmer can still abuse it, but at least the lockdep_map argument
> > would warn anyone calling that function (or reviewing a related patch)
> > that there is some locking constraint that needs to be respected.

> Is that done anywhere else in the kernel currently?  If so, then I have
> no problem with doing so. Otherwise, I'd rather just drop the
> read_lock() here and add a comment explaining why it is currently safe
> without it.

I guess the closest thing is the "c" argument of
rcu_dereference_protected(), which should be passed a
lock[dep]_is_held() check on the lock/mutex that provides the mutual
exclusion that is needed for the operation to be safe. If we ever do
conver the rwlock to RCU, we will need something to pass to
rcu_dereference_protected() anyway. (I mean we could cheat and just
pass 1 + a comment, but it would be nicer to put an actual
lock[dep]_held() check there.)

But it just occurred to me that we could make it even more explicit by
simply adding another "policy_load" mutex to security_ss and do most
of security_load_policy() with that mutex locked. Since there will
never be any contention on it, the extra overhead should be
negligible.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

