Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A8DC433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7A9206FA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGcnipP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHSNZi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:25:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728525AbgHSNYa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 09:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597843464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLZ9kuAR4ApOczR4t73Sc2mFlQLSkS+Nxvq8WdZaS4Y=;
        b=MGcnipP1+WWecFLXOlYTobmAnUOfROftuKrhQlgszL4jqoHGBb8jQVAgKni60Mv+xQoPCi
        89XjR1Yk9VP33z1NhoYuydHjjyX/+XLB7ckTvXUVP2eQr3JcBdbziUkQEdcjid/O3YwXcO
        dMFtR5S51SO7sAglw4hLjLX/6aT/LEI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-vyFGe-yqPTavdBPcTQmMng-1; Wed, 19 Aug 2020 09:24:23 -0400
X-MC-Unique: vyFGe-yqPTavdBPcTQmMng-1
Received: by mail-lj1-f198.google.com with SMTP id y11so3955959ljm.0
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 06:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLZ9kuAR4ApOczR4t73Sc2mFlQLSkS+Nxvq8WdZaS4Y=;
        b=TyOYZvEwQxgde+hPkLu3OUGuKRbWOsIN/8r1dgcsv+DnfMs5HNwvohF0PV7bIfLoAG
         Hw6KF/LcFSFv/uvCV6GuNXVlNlUKdcnD5YsNggMfI6gRWUXbWeTI6ANsx9js7+jvbZCH
         BjnTznd25S4z5m8gqGw7iSiNGlFreUF4CNG167ofi5pgpUiOlgYCiVeYyqQxaaHs6Bb0
         5OF9WMXKM/cWMXtVR9102PPFoLOyHh2kHamCKwaPR50j8HHvBMtfOaX43UhjfbPvTLky
         A+rlsPF8jgRBGID1X7nWQs1plyLlY1M63f/joKUuaodTrGd/KbIyQ8xuhg2X3DBmjmvS
         EUcQ==
X-Gm-Message-State: AOAM532ashd68769yS619MIA3DfaG1BpBoRuoW7sze+8RJJkWTApWgSK
        ErEgkDAumPao0dlMc/OhLij2RDvucMPhl2bWGZ16w5dJEQIEKNz1GBtnuIj/shGRpxXoN1t3mYG
        MPjZj+T9QKoRxiSmIuNPyUiwtovqtcNhtcA==
X-Received: by 2002:a2e:555:: with SMTP id 82mr12525372ljf.337.1597843461212;
        Wed, 19 Aug 2020 06:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHvFZLN8rVqFR/fban9z82Fo57xRkKZ9ydNxpgMaczSOj9LDXpw7pRxgSHaQRX1QJK2/GBsDIEUuny/7Ahyj4=
X-Received: by 2002:a2e:555:: with SMTP id 82mr12525356ljf.337.1597843460694;
 Wed, 19 Aug 2020 06:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
 <CAFqZXNtAXmOF30FGn-uD_ORUAWMaDdr6x2NC_scbYjhAbYD5Aw@mail.gmail.com> <cb65e1f1-8086-3ac4-077d-11541d40e464@gmail.com>
In-Reply-To: <cb65e1f1-8086-3ac4-077d-11541d40e464@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Aug 2020 15:24:09 +0200
Message-ID: <CAFqZXNt0Ary6nRs67s=jGVKcqH8gU7qD6N8mGrwtKUuzxvkmKw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: convert policy read-write lock to RCU
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 2:18 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On 8/19/20 4:40 AM, Ondrej Mosnacek wrote:
>
> > A few comments inline after a quick glance...
> >
> > On Wed, Aug 19, 2020 at 12:17 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> Convert the policy read-write lock to RCU.  This is significantly
> >> simplified by the earlier work to encapsulate the policy data
> >> structures and refactor the policy load and boolean setting logic.
> >> Move the latest_granting sequence number into the selinux_policy
> >> structure so that it can be updated atomically with the policy.
> >> Since the removal of the policy rwlock and this move of
> >> latest_granting reduces the selinux_ss structure to nothing more than
> >> a wrapper around the selinux_policy pointer, get rid of the extra
> >> layer of indirection.
> >>
> >> At present this change merely passes a hardcoded 1 to
> >> rcu_dereference_check() in the cases where we know we do not need to
> >> take rcu_read_lock(), with the preceding comment explaining why.
> >> Alternatively we could pass fsi->mutex down from selinuxfs and
> >> apply a lockdep check on it instead.
> >>
> >> This change does not specifically do anything special with respect
> >> to the sidtab live convert; I am unclear as to whether it is safe
> >> as a result.  Comments welcome.
> >>
> >> Based in part on earlier attempts to convert the policy rwlock
> >> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
> >>
> >> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> >> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
> >>
> >> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> ---
> >> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> >> index f6f78c65f53f..ba9347517e5b 100644
> >> --- a/security/selinux/ss/services.c
> >> +++ b/security/selinux/ss/services.c
> > [...]
> >
> > @@ -722,8 +716,9 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
> >                                             struct sidtab_entry *tentry,
> >                                             u16 tclass)
> >   {
> > -       struct policydb *p = &state->ss->policy->policydb;
> > -       struct sidtab *sidtab = state->ss->policy->sidtab;
> > +       struct selinux_policy *policy = rcu_dereference(state->policy);
> > This looks dangerous - you might get a newer policy pointer here than
> > the one you dereferenced in security_compute_validatetrans(), which
> > wouldn't be good. Instead of double-dereferencing you should always
> > pass the struct selinux_policy pointer as an argument to functions
> > like this. Please double-check if there are other cases like this, I
> > didn't go over the patch in detail yet.
> Is that true even though the entire function is called with
> rcu_read_lock() held? In any event, I can fix this for clarity.

AFAIK, holding an RCU read lock does not guarantee that the pointer
doesn't change during the critical section (when you unwrap
rcu_asign_pointer() and rcu_dereference(), they are really just a
plain atomic read with some memory barriers, there is no extra magic
there), it only guarantees that any object that you rcu_dereference
will remain valid (i.e. it is not free'd/destroyed) for the duration
of the critical section.

> > @@ -2174,11 +2206,16 @@ void selinux_policy_commit(struct
> > selinux_state *state,
> >>                          pr_info("SELinux: Enabling MLS support...\n");
> >>          }
> >>
> >> +
> >> +       /* Set latest granting seqno for new policy. */
> >> +       if (oldpolicy)
> >> +               newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> >> +       else
> >> +               newpolicy->latest_granting = 1;
> >> +       seqno = newpolicy->latest_granting;
> >> +
> >>          /* Install the new policy. */
> >> -       write_lock_irq(&state->ss->policy_rwlock);
> >> -       state->ss->policy = newpolicy;
> >> -       seqno = ++state->ss->latest_granting;
> >> -       write_unlock_irq(&state->ss->policy_rwlock);
> >> +       rcu_assign_pointer(state->policy, newpolicy);
> > This is probably a pre-existing thing, but I noticed that there is a
> > small window of inconsistency between policy (re)load / bool change
> > and AV cache. Between the rcu_assign_pointer() (or the write lock
> > section before) and avc_ss_reset(), there might be AVC lookups, which
> > in case of cache hit would decide based on the old policy, but in case
> > of a miss, they would decide based on the new one. I think it might be
> > fixed by moving avc_ss_reset() before rcu_assign_pointer() (but no
> > earlier than when it is guaranteed that the policy reload will
> > complete successfully).
> We can't move the avc_ss_reset() before we have installed the new policy
> or else the AVC will update to the new seqno but possibly still get avd
> entries with the old seqno on security_compute_av() calls.

If I understand the code correctly, then avc_latest_notif_update()
should reject inserts with old seqno, so it should become "frozen" so
from that point it should only receive the new access vectors.
Probably avc_flush() and avc_latest_notif_update() would also need to
be reordered to make sure no old entries are added in between, but
then it should be good.

> It is not
> unexpected that the AVC will keep seeing old decisions for a brief
> window; it is just as if they happened before the policy change.  Since
> we aren't providing a higher level synchronization in hooks.c to ensure
> that all permission checks made in a single hook (or at an even higher
> level, in a single system call) are done against the same policy, I
> don't think we gain anything by changing this. In any event, as you say,
> this is pre-existing and thus I don't want to change it as part of this
> patch.

It's definitely not unexpected to see (sequentially on one task) decisions like:

..., old, old, old, new, new, ...

but currently you could also get a pattern like:

..., old, old, new, old, new, new, ...

which I wouldn't say is expected. It is unlikely to be a big deal in
practice, but it just feels wrong...

Anyway, I concur that this is somewhat off-topic for this patch... I
raised it because I initially thought that it wasn't possible before
RCU conversion, only after, but then I realized it was possible before
as well.

> > Anyway, since we need to flush the AVC at each policy reload, it might
> > be more logical now to move the AVC under struct selinux_policy as
> > well, and avoid the seqno logic altogether. After the RCU conversion,
> > accessing a consistent struct selinux_policy becomes really cheap, so
> > integrating the AVC should allow for code simplification for (almost)
> > zero performance impact. A similar thing could be probably done also
> > with the netlabel/xfrm cache (not really familiar with those). Also
> > the duplicit policycap array in struct selinux_state could be replaced
> > with queries to struct selinux_policy instead (but I have a hunch
> > there are some pre-existing logical race conditions around the
> > handling of policycaps...).
>
> This might be possible in the kernel but the design was to permit the
> security server and AVC to potentially live in different components /
> address spaces, with the original implementation in a microkernel where
> the security server was a userspace task.  Even now, the security server
> is providing decisions to userspace policy enforcers with their own AVC
> (from libselinux) and therefore still needs a way to synchronize policy
> changes (it sends policyload notifications via netlink with the seqno,
> and /sys/fs/selinux/access provides the seqno for the decision). Some
> improvements are certainly possible here but again I'd make those separate.

Okay, I agree that this is out of scope, too. This loosely
synchronized system of kernel policy data + kernel AVC + userspace AVC
still feels weird to me, but I don't have a better solution at this
point, so I'll just have to live with it...

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

