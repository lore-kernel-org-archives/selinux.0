Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9ACC432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 00:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55583206F0
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 00:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mSJTZOTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKOAE3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:04:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOAE2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 19:04:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so3724069ljj.8
        for <selinux@vger.kernel.org>; Thu, 14 Nov 2019 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITY0SvqXHY9IcmVShOSvYR0Fph2fUjQXtChSK3I2eg0=;
        b=mSJTZOTL1xCUBZe57/c4hIIPaH3kERGRqmEgl8e2AuyQqWcGKscs/ZRrmZBHZ3TSLs
         Va4ch/mc/atGvxAJ9BPKR3pr/0TuyUH5Oki+0CsKqtwyIf1ctRZaZadAaFXmyRMypuFN
         AcbtSaD7311oiBZvB00Fd9JQXoYcwmjAYVA3CmLpC7t3nTnxwx7+ZPIw+JN5S5f3cPuV
         yM5Xx6Vx/MhlI5bUpH7EIi6sCJBoYEjdKoFNqAEnj7vEQwqntu6+XIrLS75JHoexjUxB
         9YqxkNRexXqzahUAKGy/DP3+Idlbw+3tqJ65ZSXTr84H+kZO4qNAbzrKaer4mzzJzY7h
         fk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITY0SvqXHY9IcmVShOSvYR0Fph2fUjQXtChSK3I2eg0=;
        b=OASouLbB8pFhR0uAlCUID9AvU7rVIeISmJrbUhK67MiEN8JvkhuQVKUq5IO+LoYDV+
         FTaBL9nWC93qmh3z/uVLBxwSx5cjXT3p+UZvwF5ct2NXf8QYErlzlrbOkOYSrKa7XwQ0
         1/Av2B7Ws3cmZOt0WY4xDAbUL+y0OBDSWY2xwh1RdTvtFvl94GVVWifRmV9ytP9KHJsb
         lHMEi6FPTZK9X+nGaGY6px3aWoSk3cHKO2kMo+8HzgN5k9F8WUHomHXZc1yiIle9cyzn
         wuVvUyr1UFGlDgXeHCTalEhSZvs/9pQILV9wO5SPpBfcYhlZaTX7bK/vZp9J0NEZ+gQZ
         tDIw==
X-Gm-Message-State: APjAAAUf3mLseiSSf8n+uSmYdZsg5L4deiWdwqFF9sXMZ16z64WEhi+m
        mx9jyDElOVptVx5Yi4N5cgCe7/VKaS0C7Yqmuqyz
X-Google-Smtp-Source: APXvYqyOIyRZyVR9HHAAsjbRi3sE9WK2f8Kj2em7qDTOlwBw2hec0I/tg/PtS+uVkQHyqQt9q+7lqvG+ezv/4IIGdbY=
X-Received: by 2002:a2e:970e:: with SMTP id r14mr8631098lji.57.1573776265390;
 Thu, 14 Nov 2019 16:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20191107205221.222447-1-jeffv@google.com>
In-Reply-To: <20191107205221.222447-1-jeffv@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Nov 2019 19:04:13 -0500
Message-ID: <CAHC9VhSqLXMu2gTzSjrvnWshJKp3QVyPOv198vj_ZxwjbYU0uQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     selinux@vger.kernel.org, will@kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>, jovanak@google.com,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 7, 2019 at 3:52 PM Jeff Vander Stoep <jeffv@google.com> wrote:
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
> -Remove use of rcu_head/kfree_rcu(), they're unnecessary because
> hashtable objects are never removed when read/add operations are
> occurring.
> -Remove nested locking. Use lock of active sidtab to gate
> access to the new sidtab.
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
>  security/selinux/ss/sidtab.h        |  16 +-
>  9 files changed, 300 insertions(+), 161 deletions(-)

...

> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 513e67f48878..3ba044fe02ed 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -192,5 +196,10 @@ static inline int context_cmp(struct context *c1, struct context *c2)
>                 mls_context_cmp(c1, c2));
>  }
>
> +static inline unsigned int context_compute_hash(const char *s)
> +{
> +       return full_name_hash(NULL, s, strlen(s));

While we can obviously use any hash function we want here, is there
any value in sticking with an algorithm similar to symhash()?  Or
alternatively, and beyond the scope of this patch, it is worth
converting symhash() to use full_name_hash()?  Or should we just leave
everything well enough alone ;)

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..e705a3bc4d0d 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -47,14 +64,61 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>
>         entry = &s->isids[sid - 1];
>
> -       rc = context_cpy(&entry->context, context);
> +       rc = context_cpy(&entry->leaf.context, context);
>         if (rc)
>                 return rc;
>
>         entry->set = 1;
> +
> +       /*
> +        * Multiple initial sids may map to the same context. Check that this
> +        * context is not already represented in the context_to_sid hashtable
> +        * to avoid duplicate entries and long linked lists upon hash
> +        * collision.
> +        */
> +       if (!context_to_sid(s, context)) {
> +               entry->leaf.sid = sid;
> +               hash_add(s->context_to_sid, &entry->leaf.list, context->hash);
> +       }
> +
>         return 0;
>  }
>
> +int sidtab_hash_stats(struct sidtab *sidtab, char *page)
> +{
> +       int i;
> +       int chain_len = 0;
> +       int slots_used = 0;
> +       int entries = 0;
> +       int max_chain_len = 0;
> +       int cur_bucket = 0;
> +       struct sidtab_entry_leaf *entry;
> +
> +       rcu_read_lock();
> +       hash_for_each_rcu(sidtab->context_to_sid, i, entry, list) {
> +               entries++;
> +               if (i == cur_bucket) {
> +                       chain_len++;
> +                       if (chain_len == 1)
> +                               slots_used++;
> +               } else {
> +                       cur_bucket = i;
> +                       if (chain_len > max_chain_len)
> +                               max_chain_len = chain_len;
> +                       chain_len = 0;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       if (chain_len > max_chain_len)
> +               max_chain_len = chain_len;
> +
> +       return scnprintf(page, PAGE_SIZE, "context_to_sid:  %d entries and "
> +                        "%d/%d buckets used, longest chain length %d\n",
> +                        entries, slots_used, SIDTAB_HASH_BUCKETS,
> +                        max_chain_len);

I wonder if there is value in sticking to the format currently in use
with /sys/fs/selinux/avc/hash_stats?

-- 
paul moore
www.paul-moore.com
