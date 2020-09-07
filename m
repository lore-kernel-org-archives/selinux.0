Return-Path: <SRS0=D1eb=CQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2483C43461
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 07:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C1B208C7
	for <selinux@archiver.kernel.org>; Mon,  7 Sep 2020 07:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4zKHMnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgIGHrc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:47:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgIGHrb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Sep 2020 03:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599464849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSkC+o85tT3mopq/vD3wqS/Hx6bdZc8OO0xROVJeNAk=;
        b=J4zKHMnDpgWEQzWZA8DLBIGmN4BLdb8gaFIE21xgLouZsMiIiztAe0GpRChlssSWIw56eY
        tmOIQuUm78F2KiB5sBS6jlR13DLPBXb8pzcMesX6UG3bw/PRZluAWNjEb+Ljuoj8PCzK6F
        +PIq46kitZk72nSeA2AXO5/ZfXmv2tI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-VgKuTug_Na-OccNJfD5msQ-1; Mon, 07 Sep 2020 03:47:28 -0400
X-MC-Unique: VgKuTug_Na-OccNJfD5msQ-1
Received: by mail-lj1-f199.google.com with SMTP id n24so1192686ljc.9
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2020 00:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSkC+o85tT3mopq/vD3wqS/Hx6bdZc8OO0xROVJeNAk=;
        b=TJQU9+cF7ztsRfNso/dC+hbbM5t9dQe+e1BtKES2yNcKj/XbVUYIRuAM/rgW+K4fjV
         t5+6Yt2tj1/V3SDfePPJquOj8a8oUcX+mU78f8GEVXMmGUDvSTmsjILmXTfWiAwgLXmi
         xBkY/+jkszgnKc87mWJko6LqNVaqwRO+V+CeenIVjfO5ZN/yaEp9g2SG47PmcMih06+H
         CQfeNxiF8sbyv+x7lP+MxoKMm1VSt3/g3VtHNyOW/BJ8ZjYmqxrLrobTmANjpuzfVkS6
         bSDzYIahepEFweilITw6A4AyH+TG2Er9I9o2keosyQ5ywtiaLvUwf2Jw2LFKwBFkwxXD
         2tyw==
X-Gm-Message-State: AOAM533ySMFg7uYRbw6G0fDmBKxgYijwT8d/IEYbb3uEeT9ksgzSIXzi
        dFU3v++nVTAfDb9ILLKnCZpEeAOO6WPLRbPcKzW2boVskwhlAVAnzxUq3qiZgfzK2SoeEaC3RG9
        m2d8nS1xio+cjF7hysL7vaKFgKMI5Zdx8tA==
X-Received: by 2002:a19:8446:: with SMTP id g67mr9418296lfd.87.1599464846517;
        Mon, 07 Sep 2020 00:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQw8B9Clp5KWxgZavXyiHZGT9U/yoZhBxsmGj96p029H0B7ONs1Zjau3sG20u87SVWk3YmhKkUDkRJ6Rs291o=
X-Received: by 2002:a19:8446:: with SMTP id g67mr9418282lfd.87.1599464846172;
 Mon, 07 Sep 2020 00:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-4-omosnace@redhat.com>
 <d82b0a33-6e52-0dda-2f74-cc5b7bdb898a@linux.microsoft.com>
In-Reply-To: <d82b0a33-6e52-0dda-2f74-cc5b7bdb898a@linux.microsoft.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 7 Sep 2020 09:47:15 +0200
Message-ID: <CAFqZXNs+eQL7H54BbbeO-Ra4RtQKwQN6gBPAniMmUHmr4RGyBw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 5, 2020 at 11:33 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 8/25/20 8:20 AM, Ondrej Mosnacek wrote:
>
> Hi Ondrej,
>
> I am just trying understand the expected behavior w.r.t the usage of
> rcu_dereference_protected() for accessing SELinux policy. Could you
> please clarify?
>
> > Instead of holding the RCU read lock the whole time while accessing the
> > policy, add a simple refcount mechanism to track its lifetime. After
> > this, the RCU read lock is held only for a brief time when fetching the
> > policy pointer and incrementing the refcount. The policy struct is then
> > guaranteed to stay alive until the refcount is decremented.
> >
> > Freeing of the policy remains the responsibility of the task that does
> > the policy reload. In case the refcount drops to zero in a different
> > task, the policy load task is notified via a completion.
> >
> > The advantage of this change is that the operations that access the
> > policy can now do sleeping allocations, since they don't need to hold
> > the RCU read lock anymore. This patch so far only leverages this in
> > security_read_policy() for the vmalloc_user() allocation (although this
> > function is always called under fsi->mutex and could just access the
> > policy pointer directly). The conversion of affected GFP_ATOMIC
> > allocations to GFP_KERNEL is left for a later patch, since auditing
> > which code paths may still need GFP_ATOMIC is not very easy.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/ss/services.c | 286 ++++++++++++++++-----------------
> >   security/selinux/ss/services.h |   6 +
> >   2 files changed, 147 insertions(+), 145 deletions(-)
>
> int security_read_policy(struct selinux_state *state,
>                          void **data, size_t *len)
> {
>         struct selinux_policy *policy;
>
>         policy = rcu_dereference_protected(
>                         state->policy,
>                          lockdep_is_held(&state->policy_mutex));
>         if (!policy)
>                 return -EINVAL;
> ...
> }
>
> If "policy_mutex" is not held by the caller of security_read_policy() I
> was expecting the above rcu_dereference_protected() call to return NULL,

No, that's not how rcu_dereference_protected() works. You should only
call it when you know for sure that you are in a section that is
mutually exclusive with anything that might change the pointer. The
check argument is only used for sanity checking that this is indeed
true, but other than triggering a warning when RCU debugging is
enabled the result of the check is ignored.

If the returned pointer is NULL, it just means that the pointer hasn't
been assigned yet, i.e. that no policy has been loaded yet (this was
checked using selinux_initialized() before, but when we're under
policy_mutex, checking the pointer for NULL is possible and simpler).

BTW, you should've replied to [1], which is the merged patch that
introduced the code you are referencing :)

[1] https://patchwork.kernel.org/patch/11741025/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?h=next&id=9ff9abc4c6be27ff27b6df625501a46711730520
[3] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?h=next&id=66ccd2560affc6e653ef7372ea36fb825743d186

> but policy is non-NULL and I see the following messages in "dmesg" log.
>
> Is this expected?

Yes, that's expected. The caller of security_read_policy() in this
case needs to ensure that state->policy_mutex is being held.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

