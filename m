Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF5CC2BBC7
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD9E2085B
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 11:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV2R4iaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438954AbgDNLHf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:07:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438935AbgDNLHP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 07:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586862432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVLsjN92RzX5tGYRBSKQOTX9YW9kXbD4eJEJHprIvSs=;
        b=EV2R4iawEEnrT13fO2pCKGvNC7iF2NZO/RT02eeZPIG4Ewb8S7uJ6dhmKtpl2snxHdJd2t
        WIqTj+AGkZKz0DZU8J8Xpz8Qc+HG2udqyJLV/w34QX6P1Awe+FNqTPKiI/Bj+MKWj9jF+e
        x4KIjVIBJEwjVvIi51KVPfb5koLG+Bs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-C0ylyr9vNyGy2db_QWKi2A-1; Tue, 14 Apr 2020 07:07:06 -0400
X-MC-Unique: C0ylyr9vNyGy2db_QWKi2A-1
Received: by mail-ot1-f69.google.com with SMTP id a11so4273718otc.17
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 04:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVLsjN92RzX5tGYRBSKQOTX9YW9kXbD4eJEJHprIvSs=;
        b=JEjXp4+WxbH8krpuyivk+AIadhsiEApevjHGxwFaSas42Ru4GSXwtE+iiEaaIQ99q8
         XBmRbeosxD9jxHQFns5HCu27uBlVSCSM9Rd0aTgLrt0Um0b0tymrtTLOX5gtEUqUjDLd
         DWKb1NXui2xBkyCteHwwkFMlPIofkX7SFRLON5Xz+4rppjB0IMcc1VCvJGLWqC77hfdy
         R8CSHHNvi89Qk5WpE5jE65vlSnX/hW/CLa65HXqRV3sY9QVZDXsu3m0N/jpn/v8ZNw6C
         Tef0p59cMBJI0ivFV+/FYWxxf3mJoI3czNeANWS2gthVCYSwBQPuuoKxWBQL3nKxbK5z
         KMXw==
X-Gm-Message-State: AGi0Pua75jtTRFJB5/st0BOH8CN5AIZqqzFVZPP3LOUKjDv3HGNKF5A0
        zYgyF7N+lXiZxGYbdCPo3rwKqNhygOLlL5jYhzTxEykJUFAAXcpEWg4jzGgZaN4/FyLwM542WGV
        sLHKDpH8G6NFb1gf6iQNxOF2qZ1XYvTEOoQ==
X-Received: by 2002:a9d:6041:: with SMTP id v1mr7902989otj.66.1586862425738;
        Tue, 14 Apr 2020 04:07:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxurzfHW3WxzZAgWBkoK6CYSm8jSAdqbIpLxzOVXIfWCnt6st1GzRoCNjAiifDe3Vn5fV9cwvmaVgmpATCcKk=
X-Received: by 2002:a9d:6041:: with SMTP id v1mr7902978otj.66.1586862425501;
 Tue, 14 Apr 2020 04:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com> <20200408182416.30995-9-siarhei.liakh@concurrent-rt.com>
In-Reply-To: <20200408182416.30995-9-siarhei.liakh@concurrent-rt.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Apr 2020 13:06:54 +0200
Message-ID: <CAFqZXNsqHCeq8u_ieLb5-fk82bF47ook8yT-jMyBHYmE7m8CcA@mail.gmail.com>
Subject: Re: [PATCH 8/9] SELinux: Replace custom hash with generic lookup3 in symtab
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
> This patch replaces local copy of custom hash function with existing
> implementation of lookup3 from the standard Linux library. This change
> allows to reduce the amount of custom code with has to be maintained, while
> potentially improving overall performance of the hash table in question.
>
> Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> ---
> Please CC me directly in all replies.
>
>  security/selinux/ss/symtab.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
> index dc2ce94165d3..8d189d7683d1 100644
> --- a/security/selinux/ss/symtab.c
> +++ b/security/selinux/ss/symtab.c
> @@ -9,6 +9,16 @@
>  #include <linux/errno.h>
>  #include "symtab.h"
>
> +#ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING
> +#include <linux/jhash.h>
> +
> +static unsigned int symhash(struct hashtab *h, const void *key)
> +{
> +       return jhash(key, strlen((const char *) key), 0) & (h->size - 1);

Did you consider using full_name_hash() here instead? It is used in
other places (mainly filesystem code) to hash strings. I wonder how it
compares to jhash both in terms of speed and in terms of randomness of
the resulting hash. It would be nice if you could do some benchmarks
and provide some numbers to support the choice.

> +}
> +
> +#else /* #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
> +
>  static unsigned int symhash(struct hashtab *h, const void *key)
>  {
>         const char *p, *keyp;
> @@ -23,6 +33,8 @@ static unsigned int symhash(struct hashtab *h, const void *key)
>         return val & (h->size - 1);
>  }
>
> +#endif /* #else #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
> +
>  static int symcmp(struct hashtab *h, const void *key1, const void *key2)
>  {
>         const char *keyp1, *keyp2;
> --
> 2.17.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

