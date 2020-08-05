Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356BC433DF
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 08:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07FA20792
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 08:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYAkQ6IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHEI3a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:29:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726563AbgHEI3R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 04:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596616155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRuPgP1FRA/Zkdf7t6ka9kYYl0KnRhs/+cuyOWpi3XA=;
        b=VYAkQ6IOAbVGlRrfVG1wSxNSC4ddvX9LVPjLRoa1E6HRI/8J2TndUVoA65nQAqOILu5UE3
        vyTCJyZ2n2WOr1kHp6fHc1kE+CFooZQ+23uTFBFPktl54TlBUhfZ/hAfBfGqiXQxArPKwg
        Dp6gezZEgNzxjHmenvu2XvENZU+CnUQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-zcYhOUEQPI-4KfpcyknlPA-1; Wed, 05 Aug 2020 04:29:14 -0400
X-MC-Unique: zcYhOUEQPI-4KfpcyknlPA-1
Received: by mail-lj1-f199.google.com with SMTP id t17so3605195ljg.16
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 01:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRuPgP1FRA/Zkdf7t6ka9kYYl0KnRhs/+cuyOWpi3XA=;
        b=gDyXyaGGDDwdTrq4WYTOAS+uCE1FHUhT3PHflDR/slusXEakdCokh8/P7axTlSEJ/B
         b24idRpgeIVM8rABHJuJrm7J0VEtqSJSG4F3cIDU+n9v2oJb0ON7T+A/UM4anbtB0rwY
         uZmqe9+85x222IuMKM/5bEIrBNBP9NMU3yQdI9to8eqQU/eD3sVII6CuKPd7ca98jNm8
         /BnTl3jWcDZDz/0pL8zHSLJUXDT4LotSd2iNjpRrgZWr78g2PeYMYMLCQejwyQdxsDcV
         fMuUOGuk39H4Cn7zg2vF6ZDzyPL2EcyXU4xfVmqsWIWg0TZB8k5A3W9EXd+36ABdpurs
         bL0w==
X-Gm-Message-State: AOAM533bcWOzlDG7nwFwBg90O+xSCF4HhC3RkpAvkjS6B/e33ouqy0BE
        pBqLEXuLLdsVbzT4KT2pqRqv4ETIXF8r4oYxo0G5z/umD/yvqKBwBzEgd+Cm11e/Q4kTe3SBdgE
        dh3dQRl5oK0oaZgYRJbV9/RFVotarct2wQw==
X-Received: by 2002:a2e:555:: with SMTP id 82mr909443ljf.337.1596616152596;
        Wed, 05 Aug 2020 01:29:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySdCjsfkXqxAVfCGWzDTU7EW3ejU+acVzsVjn4K1b277ngr1DfhGPjeB21E3Jk5LrIWw/fMeQ8NU4Nir+ToaE=
X-Received: by 2002:a2e:555:: with SMTP id 82mr909435ljf.337.1596616152328;
 Wed, 05 Aug 2020 01:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200803173948.17118-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200803173948.17118-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 5 Aug 2020 10:29:01 +0200
Message-ID: <CAFqZXNs5RjGkifBBVZm8zONx5fube4NZe6xFVAtZpuJjEePw+g@mail.gmail.com>
Subject: Re: [RFC PATCH v3] selinux: encapsulate policy state, refactor policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 3, 2020 at 7:40 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Encapsulate the policy state in its own structure (struct
> selinux_policy) that is separately allocated but referenced from the
> selinux_ss structure.  The policy state includes the SID table
> (particularly the context structures), the policy database, and the
> mapping between the kernel classes/permissions and the policy values.
> Refactor the security server portion of the policy load logic to
> cleanly separate loading of the new structures from committing the new
> policy.  Unify the initial policy load and reload code paths as much
> as possible, avoiding duplicated code.  Make sure we are taking the
> policy read-lock prior to any dereferencing of the policy.  Move the
> copying of the policy capability booleans into the state structure
> outside of the policy write-lock because they are separate from the
> policy and are read outside of any policy lock; possibly they should
> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
>
> These changes simplify the policy loading logic, reduce the size of
> the critical section while holding the policy write-lock, and should
> facilitate future changes to e.g. refactor the entire policy reload
> logic including the selinuxfs code to make the updating of the policy
> and the selinuxfs directory tree atomic and/or to convert the policy
> read-write lock to RCU.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 fixes a couple of instances where we should take the read-lock for
> consistency prior to dereferencing state->ss->policy, and updates
> sidtab_convert() and its helpers/callbacks to use GFP_ATOMIC
> allocations instead of GFP_KERNEL and to remove a call to
> cond_resched() since it is now called with the read-lock held and
> therefore cannot call sleeping functions.  Technically we know that
> state->ss->policy cannot be modified since selinuxfs is taking
> fsi->mutex for all policy-modifying operations (both
> security_load_policy and security_set_bools) but this provides
> consistency in the handling of the policy rwlock.

I must say I'm a little concerned about switching to GFP_ATOMIC here.
The sidtab table can become quite large on long-running systems (since
it's grow-only currently) and in such case the kernel could have a
hard time allocating everything atomically. Maybe we could instead
pass the fsi->mutex's lockdep_map to security_load_policy() and call
lockdep_is_held() inside as a sanity check? This would document that
the function is expected to be called in mutual exclusion and also
detect at runtime if someone accidentally moves the call outside of
the mutex's critical section. It's not perfect, since a careless
programmer can still abuse it, but at least the lockdep_map argument
would warn anyone calling that function (or reviewing a related patch)
that there is some locking constraint that needs to be respected.

Otherwise the patch looks good to me after a brief look.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

