Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE0BC2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B47620732
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGcJnOE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438845AbgDNK7X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:59:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438850AbgDNK7O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 06:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586861948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XijXHPvk3wM0yu015daqXBYEZibjzz5FxDDKtNrsac8=;
        b=JGcJnOE3xpE5QYMbqURHDej5qNKn9qi3V5aqWS9ZQSjPa9rVGlBywIlo6VmVCKYWxSb1sY
        UWUhx0jZOO+9vsGT5NhLIom2ARRMTn7Eqe2pfkH6sb40V4PJ6v7DUvNXu9gYMdrozPXLZi
        O9UPAueT/TMJUt6Dz+U/z0MPRVDdmhk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-s_4aTQzzOAmVK1rSOP-xGw-1; Tue, 14 Apr 2020 06:59:07 -0400
X-MC-Unique: s_4aTQzzOAmVK1rSOP-xGw-1
Received: by mail-oi1-f200.google.com with SMTP id l2so4826388oih.19
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XijXHPvk3wM0yu015daqXBYEZibjzz5FxDDKtNrsac8=;
        b=m16cwA5IXkSWfpGY09FHTCCg0adZ12Y4aUJkIOjWBhesEE5IsTWE/dSxD81ESqmIaN
         SktwRHJy9ZRbCsV89RfPcw7X2DqwdO/cBXg2f4ukx2H66CZ/vM3iCkxf4HnnVk/iZxqI
         rG32cI8mYNk+Dz/rpSGz8TD9S3bvy1uBB5vCYBHg6j8WhvNuy4DbLlb/mlktMYydjaRS
         df4nCPpVV14sixR1+dWxvYJcpCgnUusYg7waaZwiB313BN9z4xlByJThi+GWYH3GkE2O
         5HRUR0SuNq3bXUXUkkNElS0mnAik8pWl16e9Xk2Y8feYQu4H0vRgjzJcQtM6nODTTHjh
         Glnw==
X-Gm-Message-State: AGi0PuYkfC15r9kIaaIm9s0nd0DnvnUJI0PZYmTn68w+lYyRQfb/I161
        oBHVS16mNcjtXGJgABIFDmFqA41Wj9Uhs5WIzXPkNQVojJo0m3N6SfuJq2b4HGU2indXyOxrXQn
        Ci0TgdY1sN02J7rJdkr7IHfnYV/ncuB27eA==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr4701720otb.367.1586861946398;
        Tue, 14 Apr 2020 03:59:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypIWmG42klsiMPcsLgLc5bamxHlDtCEHoU/TgJPyttGQv1KsPasnpNZdd5uonkfylI2QK0X5XMUlBSXVAqvGuvs=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr4701699otb.367.1586861946078;
 Tue, 14 Apr 2020 03:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com> <20200408182416.30995-5-siarhei.liakh@concurrent-rt.com>
In-Reply-To: <20200408182416.30995-5-siarhei.liakh@concurrent-rt.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Apr 2020 12:58:54 +0200
Message-ID: <CAFqZXNt9nAzzEFps8PafP8zC7sE7Q4YuST67xiSezPzz3ofApQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] SELinux: Replace custom hash in avtab with generic
 lookup3 from the library
To:     siarhei.liakh@concurrent-rt.com
Cc:     SElinux list <selinux@vger.kernel.org>, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On Wed, Apr 8, 2020 at 8:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
>
> From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
>
> This patch replaces local copy of custom implementation of MurmurHash3 in
> avtab.c with existing generic implementation of lookup3 from the standard
> Linux library. The library version of hash used to mix 3 x u32 values is
> comparable to the custom implementation in run time complexity and bit
> avalanche. This change allows to reduce the amount of custom code with has
> to be maintained, while preserving overall performance of the hash table
> in question.
>
> Before (MurmurHash3):
> rules:  282731 entries and 64534/65536 buckets used, longest chain length 17
> sum of chain length^2 1522043
>
> After (lookup3):
> rules:  282731 entries and 64572/65536 buckets used, longest chain length 16
> sum of chain length^2 1517651
>
> Please note that either hash can show a slight [dis]advantage over the other
> depending purely on actual rule sets loaded and number of buckets configured.

FWIW, I did a quick check comparing the duration of
context_struct_compute_av() (triggered by forcing AVC misses) with and
without this patch (i.e. its fixed version - see below) and there
seems to be no measurable difference. I didn't compare the bucket
occupancy stats, but I expect them to be equivalent or slightly
better, as data from your commit message also shows. So considering
that it removes a chunk of ugly code while not regressing in
performance, I'm in favor of this patch (assuming issues below are
fixed).

>
> Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> ---
> Please CC me directly in all replies.
>
>  security/selinux/ss/avtab.c | 39 +++++--------------------------------
>  1 file changed, 5 insertions(+), 34 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 01b300a4a882..58f0de17e463 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -20,49 +20,20 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> +#include <linux/jhash.h>
>  #include "avtab.h"
>  #include "policydb.h"
>
>  static struct kmem_cache *avtab_node_cachep;
>  static struct kmem_cache *avtab_xperms_cachep;
>
> -/* Based on MurmurHash3, written by Austin Appleby and placed in the
> - * public domain.
> +/*

Your patch has a trailing space after the '*' in the above line.
Please remove it.

> + * Use existing Bob Jenkins' lookup3 hash from the library
>   */
>  static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
>  {
> -       static const u32 c1 = 0xcc9e2d51;
> -       static const u32 c2 = 0x1b873593;
> -       static const u32 r1 = 15;
> -       static const u32 r2 = 13;
> -       static const u32 m  = 5;
> -       static const u32 n  = 0xe6546b64;
> -
> -       u32 hash = 0;
> -
> -#define mix(input) { \
> -       u32 v = input; \
> -       v *= c1; \
> -       v = (v << r1) | (v >> (32 - r1)); \
> -       v *= c2; \
> -       hash ^= v; \
> -       hash = (hash << r2) | (hash >> (32 - r2)); \
> -       hash = hash * m + n; \
> -}
> -
> -       mix(keyp->target_class);
> -       mix(keyp->target_type);
> -       mix(keyp->source_type);
> -
> -#undef mix
> -
> -       hash ^= hash >> 16;
> -       hash *= 0x85ebca6b;
> -       hash ^= hash >> 13;
> -       hash *= 0xc2b2ae35;
> -       hash ^= hash >> 16;
> -
> -       return hash & mask;
> +       return jhash_3words(keyp->target_class, keyp->target_type,
> +                               keyp->source_type) & mask;

This function takes 4 arguments, not 3. (I can see you mentioned in
your reply to Paul that you accidentally sent an older version of the
patches, so I hope you have this already fixed in the final version.)

Also, please align the second line properly (start of
"keyp->source_type" should be aligned with the end of "jhash_3words("
on the previous line). Please also check for similar whitespace issues
in the rest of the patches, since I didn't have a closer look at those
yet.

Thanks,

>  }
>
>  static struct avtab_node*
> --
> 2.17.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

