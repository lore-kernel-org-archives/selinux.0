Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE6C43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8344C214D8
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goywMFUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfKGQNJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:13:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729953AbfKGQNJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 11:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573143187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1v4mEVbeZoDq8YSIhudBoiKncb5G85zJBRJGndSxloQ=;
        b=goywMFUFFcm4xTvXxKGMOmmrUoLX7YHl8cQs8pASAKu52wHgfsWARAIMY+YNXRgnSt6AES
        NpJT+LVVZjVqykxSgL7FXUVVX2BtH9DmGk5Jl+byceWdOsUjqph0RBJRq5e57Par1aiL8H
        iUvn34P5tnU13U+xKSz+KNs0gbQJ2W0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-ymRMFaSkMii0TfPz5Mvinw-1; Thu, 07 Nov 2019 11:13:06 -0500
Received: by mail-ot1-f72.google.com with SMTP id l1so2395213otr.2
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 08:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cD6vVrFE3T3d0Mx0pqzqj1EAHJjCq9qhpnJ8SEm2qDk=;
        b=j+SOHoDWBaJSm0dPsckknJgoXw9x33A/Zaqq3PogaJyXW8mj58N8wI/+W3ZMhp+LXc
         iDXv3m0l8saMZDaXgkS6dpeiC7lWDsOvrLBp9cmttIkxrGkXST3AGILlfiaFmtg6tMrL
         TnzUwvVc3lS5g2+2vzfslOnVRhGmW1vEu51+32L9e2JpX774W9h2oJgUMWp+sDZgaBJX
         9/SRxH5ZQkl63tucm4CekAuucnplI7kfgy3a0+/k0rYIYgby3vJpXaGGb6dNI6BtRsJZ
         OM/UOwMJIcXKcT3Vug7pS1WgxFW02w9j5eRsrB3y+oV8OXT4Y0hOoCgPMbPZp6/Wnq9u
         x9BA==
X-Gm-Message-State: APjAAAVVQvKL0r4uTTj04Jd8XYjnVJj2l1sFGBYAEHkVx8+9WGvVhmzi
        DRJQ3DyV2ug3CrGtx4LhA2G2PLwtGcwSKIzKe8SOYbD+RwdfsGBVWyACLUjo/KaONhyKTWef5CH
        +bulqFMPpxkrHEL9mVC+bix8LEU1W70Y6aw==
X-Received: by 2002:a9d:7642:: with SMTP id o2mr3738614otl.66.1573143185419;
        Thu, 07 Nov 2019 08:13:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLrUOCpi+2ww6VJIled8c9TuoRHOOCmZIjqwdA9Kr6yZkNieWRzS0kS6MHZOFPKRmPfXYoHd+qf2xRtviXPjg=
X-Received: by 2002:a9d:7642:: with SMTP id o2mr3738573otl.66.1573143184945;
 Thu, 07 Nov 2019 08:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20191107101743.203699-1-jeffv@google.com>
In-Reply-To: <20191107101743.203699-1-jeffv@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Nov 2019 17:12:53 +0100
Message-ID: <CAFqZXNvn4tTgNcQ3-fFE5QN7dS93h2VNznZ-D=3m2gZ26di9hA@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, will@kernel.org,
        Jovana Knezevic <jovanak@google.com>
X-MC-Unique: ymRMFaSkMii0TfPz5Mvinw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 7, 2019 at 11:17 AM Jeff Vander Stoep <jeffv@google.com> wrote:
> This replaces the reverse table lookup and reverse cache with a
> hashtable which improves cache-miss reverse-lookup times from
> O(n) to O(1)* and maintains the same performance as a reverse
> cache hit.
>
> This reduces the time needed to add a new sidtab entry from ~500us
> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
>
> The implementation uses the kernel's generic hashtable API,
> It uses the context's string represtation as the hash source,
> and the kernels generic string hashing algorithm full_name_hash()
> to reduce the string to a 32 bit value.
>
> This change also maintains the improvement introduced in
> commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> performance") which removed the need to keep the current sidtab
> locked during policy reload. It does however introduce periodic
> locking of the target sidtab while converting the hashtable. Sidtab
> entries are never modified or removed, so the context struct stored
> in the sid_to_context tree can also be used for the context_to_sid
> hashtable to reduce memory usage.
>
> This bug was reported by:
> - On the selinux bug tracker.
>   BUG: kernel softlockup due to too many SIDs/contexts #37
>   https://github.com/SELinuxProject/selinux-kernel/issues/37
> - Jovana Knezevic on Android's bugtracker.
>   Bug: 140252993
>   "During multi-user performance testing, we create and remove users
>   many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>   20ms after about 200 user creations and removals. Accumulated over
>   ~280 packages, that adds a significant time to user creation,
>   making perf benchmarks unreliable."
>
> * Hashtable lookup is only O(1) when n < the number of buckets.
>
> Changes in V2:
> -The hashtable uses sidtab_entry_leaf objects directly so these
> objects are shared between the sid_to_context lookup tree and the
> context_to_sid hashtable. This simplifies memory allocation and
> was suggested by Ondrej Mosnacek.
> -The new sidtab hash stats file in selinuxfs has been moved out of
> the avc dir and into a new "ss" dir.
>
> V3:
> -Add lock nesting notation.
>
> V4:
> -Moved to *_rcu variants of the various hashtable functions
> as suggested by Ondrej Mosnacek and Will Deacon.

I may be misunderstanding the purpose of RCU, but isn't all this RCU
stuff a big overkill when these entries are never removed? (Well, they
are removed when the sidtab is being destroyed, at which point however
no other threads are accessing them any more.) In my understanding,
RCU basically makes sure that objects that you dereference in an RCU
critical section are not destroyed until you leave it. Yes, it also
helps you to dereference/update them safely, but that can be achieved
on its own in a simpler way. Instead of using RCU here, I would
instead suggest looking into adding an equivalent of
list_for_each_entry_lockless()* for hlist and maybe introduce some
suitable hlist_add_something() function that ensures consistency
w.r.t. the lockless traversal (perhaps the WRITE_ONCE() in hlist_add()
is already sufficient, but I'm not sure...).

> -Naming/spelling fixups.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Reported-by: Jovana Knezevic <jovanak@google.com>
> ---
>  security/selinux/Kconfig            |  12 ++
>  security/selinux/include/security.h |   1 +
>  security/selinux/selinuxfs.c        |  65 +++++++
>  security/selinux/ss/context.h       |  11 +-
>  security/selinux/ss/policydb.c      |   5 +
>  security/selinux/ss/services.c      |  83 +++++++--
>  security/selinux/ss/services.h      |   4 +-
>  security/selinux/ss/sidtab.c        | 264 ++++++++++++++--------------
>  security/selinux/ss/sidtab.h        |  17 +-
>  9 files changed, 302 insertions(+), 160 deletions(-)

<snip>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

