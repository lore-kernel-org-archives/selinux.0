Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D20C433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18152076C
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGdEL+RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYRbB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgHYRav (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 13:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598376649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y34NfGULsziFK7YlrVTY2fh1C/O2yHc5XIhMFwMrJ6k=;
        b=HGdEL+RGCVZpVRC7FgFpW7iWgCszJjnHZRTcK1QovdczrAVClGsRLGYg3BBlhsD7n+dvT1
        Yy7X+9u8v1w8muBXB/rqFw4IO91wM9cnDzbJj1n2NaDvlt8viSaQZsN4KcGTABihRR+3l+
        WIIcHA7T69qiVBSUwOBdOC6hpvWEREs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-R1UmxgIlMLKdrriJTErHRA-1; Tue, 25 Aug 2020 13:30:46 -0400
X-MC-Unique: R1UmxgIlMLKdrriJTErHRA-1
Received: by mail-lf1-f72.google.com with SMTP id f203so1575539lfd.2
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 10:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y34NfGULsziFK7YlrVTY2fh1C/O2yHc5XIhMFwMrJ6k=;
        b=MWbsprJb0EuOE/AVcpLVjuwlkp6K/I6a9ZtDFcvVRCV7hxi1F4anwf/T0h9nClKcog
         6V/Oimo8OrnSnovzTOMfk3kRkGq0mgnFS6p2kBrw579EqjYbtmssOjbvpGxXWx5VHTkL
         o9/hiKZXFDZi4C3HCoK7oQGUzKBMUa8j2HMOib6MOaKMdeFWof19w/8f8xTESDcOeYpt
         qjBztMxZKD0Pl5efLV+nR28fQhBU8MOK/QvTaYnVic/44EDJoYxVeOxtL8HanPyRaQZB
         s7WmXJgcLZimC0ez7OGBVhjBUePZ8FkjrKBlg2OPpeJVD+1BQuF5Y055AL8QBoPZJ6gi
         j3jg==
X-Gm-Message-State: AOAM532t5PSPfVg2K9ZcW/9YEsSyIoyJWj65CNXNsRA3XqH0y/HOclIk
        YpCOE9938eYLVMLCkT/Lno5y+rPk5jZtg0TWDadgWqqxeoiq8TuTL56h5eLsp4ASEfL+qAyoMfH
        8Zder8djKGvjJvupjl6RtiaPu/lY5pEqT2w==
X-Received: by 2002:a19:4853:: with SMTP id v80mr1629522lfa.125.1598376644805;
        Tue, 25 Aug 2020 10:30:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCJZfPC7kWZuKIqsE3rYAdeYTE7680u3WAOU1q8Ilpz6c6aPznIGd8xtE8HPkO+T2Osj2FHmYCntF+wj7BT+M=
X-Received: by 2002:a19:4853:: with SMTP id v80mr1629515lfa.125.1598376644589;
 Tue, 25 Aug 2020 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-4-omosnace@redhat.com>
 <CAEjxPJ54cS+HOPxb839UWu3UiCbv=eMRAfyRHbCy_5bAxU0a6A@mail.gmail.com>
In-Reply-To: <CAEjxPJ54cS+HOPxb839UWu3UiCbv=eMRAfyRHbCy_5bAxU0a6A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Aug 2020 19:30:33 +0200
Message-ID: <CAFqZXNsfNDDoDFtZ7uJP9eKGjwZEwAtouJAWdAN124+nE7Uswg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] selinux: track policy lifetime with refcount
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 6:47 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Instead of holding the RCU read lock the whole time while accessing the
> > policy, add a simple refcount mechanism to track its lifetime. After
> > this, the RCU read lock is held only for a brief time when fetching the
> > policy pointer and incrementing the refcount. The policy struct is then
> > guaranteed to stay alive until the refcount is decremented.
> >
> > Freeing of the policy remains the responsibility of the task that does
> > the policy reload. In case the refcount drops to zero in a different
> > task, the policy load task is notified via a completion.
>
> That's an interesting pattern.  Is this approach used anywhere else in
> the kernel?  I didn't see any examples of it in the RCU documentation.

If you mean RCU + reference counting, that's actually mentioned in RCU
documentation in quite a few places as an option, e.g. [1] or [2].

As for the completion, I'm not aware if it's been used like this yet,
but it seems to fit the purpose nicely. At least I hope there are no
hidden gotchas, but I couldn't think of any. I know it from the crypto
subsystem, where it's often used to wait for the result of an
asynchronous operation.

[1] https://www.kernel.org/doc/html/latest/RCU/whatisRCU.html#rcu-read-lock
[2] https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?highlight=long_lived#c.rcu_pointer_handoff

>
> > The advantage of this change is that the operations that access the
> > policy can now do sleeping allocations, since they don't need to hold
> > the RCU read lock anymore. This patch so far only leverages this in
> > security_read_policy() for the vmalloc_user() allocation (although this
> > function is always called under fsi->mutex and could just access the
> > policy pointer directly). The conversion of affected GFP_ATOMIC
> > allocations to GFP_KERNEL is left for a later patch, since auditing
> > which code paths may still need GFP_ATOMIC is not very easy.
>
> Technically we don't need this patch for that purpose because
> rcu_read_lock() isn't actually needed at all in
> security_read_policy(), so I think we're better off just getting rid
> of it there and letting it use rcu_dereference_check(..., 1) or
> rcu_dereference_protected() instead.

Yes, I'll address that in the next revision.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

