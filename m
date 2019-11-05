Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CABC17460
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 13:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C1121D7D
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 13:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eau8nJy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfKEN2x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:28:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46169 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389094AbfKEN2x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 08:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572960531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LhoqmyhJqCsPSRQIXlLyZJsiIE4KhcyTtZ6+CUDnIo=;
        b=Eau8nJy8+TUNT1Lj/ob0vZtHPTOT9sdXnb/d6WVxnmNI6SL7wASAoLdJN8b/ta/Yyw+V4P
        qcA79n02corWVXKf1aH8rsVbmbcNH3N+J1vc2oleThg6LebxwIOHFuubaaE6BZ7ne78Wna
        buCcHpq2rJ7Z6NJUDlKe+4vqj2WcLdU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-IYc4YRs8MJKwCWrPWiMnrw-1; Tue, 05 Nov 2019 08:28:50 -0500
Received: by mail-oi1-f200.google.com with SMTP id m82so7365744oif.3
        for <selinux@vger.kernel.org>; Tue, 05 Nov 2019 05:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCT4jUpno2Rka3euFh07TWc/EPxNC0qAYA5gDtWTNzw=;
        b=t+zYXw4XSgxmDTxMEekVVq/1rs5Fny/wOo2xIY0TPLcZjvIhUZNOm7YiWAd7ego+lW
         ob4QMp6ApXwbtmwQt8aHh6V3BRIacNX73LDEzmq0XmYoLovPsfAOyrvrEw+1X0xxN6n5
         KAAQoPKkUV2zh6lTKJzaQLJtkHe+PkOq2SrZkCR4WWIt5YaYu42bW+vOZVVXSicVOjJW
         qSVS3dMRBVrU/YMNUr0dY9VU2eByzr0x4LyZyuAM9Tp17I2odl+m9i91P4myan2wF8yp
         eislkTH4Ao8hypaN3pcSRmI6dKbcTxyInmYCmKU6RIsw5252G5jZkR+eDQ1DXdD/W/J5
         7Lzw==
X-Gm-Message-State: APjAAAWE218c6kFmcjmoPYzYqOKF/gVVmWRnwZUjCATj105wT7f3Wl4O
        XuUS4gmZ5gjz+d6iTaHrS5sgnzfG2wWIyYEckY4B15HqWupKdVaSTNfV1rKDBvI2vRUOXh5g+rF
        LrReBmPhKulgZ9/L+8DHV9Dnkh5JbkneZyQ==
X-Received: by 2002:a9d:4042:: with SMTP id o2mr4722023oti.22.1572960529132;
        Tue, 05 Nov 2019 05:28:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLhV5sTJTs4Hemz2EJqgLf1wqtaYWoxuzLxU6/b3TDyabRrnfSr2wNb8crSvfll1eu6C0DsHJypqFVVeSCrFw=
X-Received: by 2002:a9d:4042:: with SMTP id o2mr4721978oti.22.1572960528472;
 Tue, 05 Nov 2019 05:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20191104191535.23642-1-jeffv@google.com>
In-Reply-To: <20191104191535.23642-1-jeffv@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 5 Nov 2019 14:28:37 +0100
Message-ID: <CAFqZXNvgcnYDER9aoV5aUfLL=jwDdoTs3EroOYchK+6PMWsO+w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Jovana Knezevic <jovanak@google.com>
X-MC-Unique: IYc4YRs8MJKwCWrPWiMnrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 4, 2019 at 8:15 PM Jeff Vander Stoep <jeffv@google.com> wrote:
> This replaces the reverse table lookup and reverse cache with a
> hashtable which improves cache-miss reverese-lookup times from
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
> This change also maintains the improvement introduced in commit
> ee1a84fd which removed the need to keep the current sidtab locked
> during policy reload. It does however introduce periodic locking of
> the target sidtab while converting the hashtable. Sidtab entries
> are never modified or removed, so the context struct stored in the
> sid_to_context tree can also be used for the context_to_sid
> hashtable to reduce memory usage.
>
> This bug was reported by:
> - Stephen Smally on the selinux bug tracker.
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
> context_to_sid hashtable.
> -Move the hash_add() statement to after the smp_store_release()
> to ensure that the contents have been written before the object
> becomes available in the hashtable.
> -The new sidtab hash stats file in selinuxfs has been moved out of
> the avc dir and into a new "ss" dir.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Reported-by: Jovana Knezevic <jovanak@google.com>
> ---
>  security/selinux/Kconfig            |  12 ++
>  security/selinux/include/security.h |   1 +
>  security/selinux/selinuxfs.c        |  64 +++++++
>  security/selinux/ss/context.h       |  11 +-
>  security/selinux/ss/policydb.c      |   5 +
>  security/selinux/ss/services.c      |  87 +++++++---
>  security/selinux/ss/services.h      |   4 +-
>  security/selinux/ss/sidtab.c        | 249 +++++++++++++---------------
>  security/selinux/ss/sidtab.h        |  16 +-
>  9 files changed, 287 insertions(+), 162 deletions(-)
>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 5711689deb6a..2d9788ad2d77 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -85,3 +85,15 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>           via /selinux/checkreqprot if authorized by policy.
>
>           If you are unsure how to answer this question, answer 0.
> +
> +config SECURITY_SELINUX_SIDTAB_HASH_BITS
> +       int "NSA SELinux sidtab hashtable size"
> +       depends on SECURITY_SELINUX
> +       range 8 13
> +       default 9
> +       help
> +         This option sets the number of buckets used in the sitab hashta=
ble
> +         to 2^SECURITY_SELINUX_SIDTAB_HASH_BITS buckets. The number of h=
ash
> +         collisions may be viewed at /selinux/ss/sidtab_hash_stats. If c=
hain
> +         lengths are high (e.g. > 20) than selecting a higher value here=
 will

s/than/then/

> +         ensure that lookups times are fast and stable.

lookup times are short and stable

<snip>

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..31cdb4848d67 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -17,26 +17,37 @@
>  #include "security.h"
>  #include "sidtab.h"
>
> +#define index_to_sid(index) (index + SECINITSID_NUM + 1)
> +#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
> +
>  int sidtab_init(struct sidtab *s)
>  {
>         u32 i;
>
>         memset(s->roots, 0, sizeof(s->roots));
>
> -       /* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX =
*/
> -       for (i =3D 0; i < SIDTAB_RCACHE_SIZE; i++)
> -               s->rcache[i] =3D SIDTAB_MAX;
> -
>         for (i =3D 0; i < SECINITSID_NUM; i++)
>                 s->isids[i].set =3D 0;
>
>         s->count =3D 0;
>         s->convert =3D NULL;
> +       hash_init(s->context_to_sid);
>
>         spin_lock_init(&s->lock);
>         return 0;
>  }
>
> +static u32 context_to_sid(struct sidtab *s, struct context *context)
> +{
> +       struct sidtab_entry_leaf *entry;
> +
> +       hash_for_each_possible(s->context_to_sid, entry, list, context->h=
ash) {
> +               if (context_cmp(&entry->context, context))
> +                       return entry->sid;

For this to be semantically safe against entries being added, it would
need the hlist head -> first member to be read with
smp_load_acquire(). Probably in practice you would always get fresh
data when dereferencing a pointer, but I don't think we should rely on
that... In fact it looks like hash_for_each_possible() wasn't really
written with lockless traversal in mind - I checked a few random
places that call it and they all either do it under some lock or
expect the table to be immutable. I believe you will need to introduce
a new equivalents of hash_add()/hlist_add_head() (that does
smp_store_release() instead of WRITE_ONCE(), because the 'next'
pointer of the node being added must be written before the head's
first pointer is set to point to the new node) and
hash_for_each_possible()/hlist_for_each_entry() (that loads
(head)->first with smp_load_acquire()).

Then again, I'm not an expert on this synchronization stuff, so I
might be wrong... But you will have to prove it :)

> +       }
> +       return 0;
> +}
> +

I am a little uneasy about this function having the same name as the
context_to_sid() in security.c. It could be confusing when debugging.
Maybe you could name the security.c function to
context_struct_to_sid()?

>  int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *contex=
t)
>  {
>         struct sidtab_isid_entry *entry;

<snip>

> @@ -305,29 +275,35 @@ static int sidtab_reverse_lookup(struct sidtab *s, =
struct context *context,
>                 rc =3D -ENOMEM;
>                 dst_convert =3D sidtab_do_lookup(convert->target, count, =
1);
>                 if (!dst_convert) {
> -                       context_destroy(dst);
> +                       context_destroy(&dst->context);
>                         goto out_unlock;
>                 }
>
> -               rc =3D convert->func(context, dst_convert, convert->args)=
;
> +               rc =3D convert->func(context, &dst_convert->context,
> +                               convert->args);
>                 if (rc) {
> -                       context_destroy(dst);
> +                       context_destroy(&dst->context);
>                         goto out_unlock;
>                 }
> +               dst_convert->sid =3D index_to_sid(count);
>
>                 /* at this point we know the insert won't fail */
> +               spin_lock_irqsave(&convert->target->lock, flags);
>                 convert->target->count =3D count + 1;
> +               hash_add(convert->target->context_to_sid,
> +                        &dst_convert->list, dst_convert->context.hash);
> +               spin_unlock_irqrestore(&convert->target->lock, flags);

Do we really need to lock the conversion target here? The
(undocumented) contract here was that as long as the conversion is in
progress, the target sidtab is "owned" by the master sidtab and any
modifications of it would be done under the master's spinlock (the
target's spinlock wouldn't be used until it is swapped-in to be the
new master). Did this contract change with your patch? I think this
nested locking is the cause of the lock warning that Stephen is
getting so hopefully you can fix it by simply removing this extra
locking.

<snip>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

