Return-Path: <SRS0=8r5V=ZZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA7C432C3
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 00:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2978420705
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 00:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FSQPX8B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLCAdA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:33:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33037 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLCAdA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 19:33:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so1426480lfl.0
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2019 16:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCug3Ppc9thpxmAFLjDKLldHZMpAgrzJKJFYoBGj+c8=;
        b=FSQPX8B16jV7y74bf+KYgX9sBkewBdA5TmeUx3igCbcPHRfcWnz9E6/HF5mIaiNtYK
         Kc5ZbptClIYnfw6qg+KDcCLrkJjMaJPb6O0qk7YQF2BSv9DSKimjEv4vw84gVuFTGaS7
         nnP39IrTBN+4dl4hfg4HxvkshPbPrJfGsWnc/j/Jhbsn8Vtvltjknkzhod961is8g+W+
         iMSXx/cNvhrOt7ekJyDF3ssLBB5MyjBYNzNoLVk7/nKQ2Kpm4Kz+KxEjxEp7leGfePGE
         mN6PyLRyriKey41IoHP1KGTPZV2TIbdhdGv8t9bjq9J/4cEU0M/QkbB+TYWjDPyAyYdn
         IUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCug3Ppc9thpxmAFLjDKLldHZMpAgrzJKJFYoBGj+c8=;
        b=kEotE6cUuZ5dtLr3gNbXlFMQ2kGqzHAGYvIDDdWU4QB2UywhQnLWD+KflKCbXdtqJA
         B2BMZ/9fvXUfAs+TfpTVpIaMSE0UbxLgvFjbUim3DbxCw9xcPEfH4R5kF+yn3Tc13XVG
         wW4dCDrCdaWGEZlKpqC7vaXrayZnNMGbg9oqJwCvoJqrGqyfY8mrlKmXRWL/lV7ZLWAr
         +DUwIz96CJ+QuVt08AFjxvoSiFKYJFIipSW8nsSZ5M9onxuch9YfLRC6l+Q6JnnPlK0l
         LVqGXBViJklyaiVjcr5zEV1GcxHHPi4hWmocMqXmad4RLks63GKBKfltIxASF9SrmYrF
         k4Ug==
X-Gm-Message-State: APjAAAXnOgEl0QSPBFdttYQsXI5LYz5G8/6eVPTxcAgNZ1dRCplsyV3e
        xyWiK6EVHkJ4u8QOgHKUdTcxbPvFeQtdY5g2Qp0t
X-Google-Smtp-Source: APXvYqzCArUpnJaRFf28mIWkJFV4CgAXhfssQ8Owlv2fld+XKT+wH71zxjQ2cyb07A3Szc6YgoXGv2pwwtsau7CvTGw=
X-Received: by 2002:a19:6553:: with SMTP id c19mr996691lfj.158.1575333177019;
 Mon, 02 Dec 2019 16:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com>
In-Reply-To: <20191122093306.17335-1-jeffv@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Dec 2019 19:32:45 -0500
Message-ID: <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>, will@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 22, 2019 at 4:33 AM Jeff Vander Stoep <jeffv@google.com> wrote:
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
> V4/V5:
> -Moved to *_rcu variants of the various hashtable functions
> as suggested by Will Deacon.
> -Naming/spelling fixups.
>
> V6
> -Remove nested locking. Use lock of active sidtab to gate
> access to the new sidtab.
> -Remove use of rcu_head/kfree_rcu(), they're unnecessary because
> hashtable objects are never removed when read/add operations are
> occurring. Why is this safe? Quoting Ondrej Mosnacek from the
> selinux mailing list:
> "It is not visible in this patch, but the sidtab (along with other
> policy-lifetime structures) is protected by a big fat read-write lock.
> The only places where sidtab_destroy() is called are (a) error paths
> when initializing a new sidtab (here the sidtab isn't shared yet, so
> no race) and (b) when freeing the old sidtab during policy reload - in
> this case it is happening after a policy write-locked critical
> section, which had removed the old sidtab pointer from the shared
> structures, so at that point all sidtab readers will already be
> accessing the new sidtab and the old one is visible only by the thread
> doing the destruction."
>
> V7
> -Change format of /sys/fs/selinux/ss/sidtab_hash_stats to match
> /sys/fs/selinux/avc/hash_stats.
> -Add __rcu annotation to rcu pointers.
> -Test with CONFIG_SPARSE_RCU_POINTER and CONFIG_PROVE_RCU.
> -Add rcu@vger.kernel.org and Paul McKenney to Cc for review of the
> RCU logic.
>
> V8
> -Removed the __rcu annotation used in V7. The annotation is
> intended to be applied to pointers to an object, however the
> objects referenced in the rcu hashtable are allocated in an
> array.
> -Fixed bug where multiple SIDs were receiving the same hash
> due to security_get_user_sids() reusing the same context
> struct without calling context_init() on it. This bug was
> discovered and root-caused by Stephen Smalley.
>
> V9
> -Do not compute the hash in string_to_context_struct
> because this string representation is non-canonical.
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
>  security/selinux/ss/services.c      |  96 +++++++---
>  security/selinux/ss/services.h      |   4 +-
>  security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
>  security/selinux/ss/sidtab.h        |  16 +-
>  9 files changed, 306 insertions(+), 167 deletions(-)

Thanks Jeff, as well as everyone else who contributed reviews and feedback.

I've pulled this into a working branch and I'll be merging it with the
other sidtab patches before posting it to a "next-queue" branch for
review later this week.  When done, I'll send a note to the list, as
well as the relevant patch authors; your help in reviewing the merge
would be greatly appreciated.

-- 
paul moore
www.paul-moore.com
