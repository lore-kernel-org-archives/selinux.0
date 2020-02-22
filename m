Return-Path: <SRS0=hfZQ=4K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F418C35671
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 19:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC57206EF
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 19:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rRd3hbyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBVTie (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:38:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45469 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVTie (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Feb 2020 14:38:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so6775572edw.12
        for <selinux@vger.kernel.org>; Sat, 22 Feb 2020 11:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AP1lJfwBi7WE1wXpaphb+3Ga5Tdi7hUGV7laVsKby+s=;
        b=rRd3hbyupGs7Xo3agz+MVgLdgQ6bAUtCZrTde89poy8omUiJA7YkYOhBRu7oiYu3LW
         plKFcSn2mm9Z6vMiK4LZAUFvLouDvddwbADdgRG2ue7msSrQvqMZSdvFjd1+c0RRwK1Y
         NstX+zh00aDZ+HxvHuubSURrxRp5H/XOwWcuCcXmFhaNm0dvk+ue1mR5tilezev2zEuN
         7M/tm8VsbbtlQCmUalFrlGKvlHwBLAcRz6011KrJJa+0iNeJjyoZFms8ZA1lr2FRrnPE
         fz6gpmiWzEJ56aASFvjhagbMeqnTOGls8A7OUuIjbzykrJm7IVkAaEsCoGNRiy5EfASJ
         ZNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AP1lJfwBi7WE1wXpaphb+3Ga5Tdi7hUGV7laVsKby+s=;
        b=PpiENnPSFoqdLZK2oc9ZZ5Z1kf1q5ae8OIJ16/bnurVKjaWXv9EhdsCpc5ti/36PI9
         iyzIXij6/a+ZhJiYpnA8HgLFZuvh/imLdMXt4ZBQex5gouliSlPIjDh1sVFMzmFaf7SS
         Ch/s2HCPZzF0gwZba3UQ/HvKMeBcRrZITDiXQYoenKkW1dD/rE45ZAfHG2sEqF6atOHc
         0ZRFtyT8xrb32rwoZXy+dDU5pF0DL5rx3z4Sdj1dUI4lck2ZKx/E/AP7hSRNTd2zSHrw
         wMPDlxEds+hHsAbVDZ7ISNg+kb9JPZByRfeNtPahKym08LTzfubh/MONMuJ2qqSTPHeb
         PI9w==
X-Gm-Message-State: APjAAAXgbhpsUMRv0N3IqlBW5disb4D2EP0fhZLfytqpLgemKYqsWShT
        BSUKvRQSHnwzelgDNwLMKJFsDQeK5X9qfQDW34d9
X-Google-Smtp-Source: APXvYqz3R7ORVcuGHB0qiLlBF+hi7S3lq0ER1Gaczd0VYFDw/XumsbLbgRBa1PGWWbQEFtZHBtIvKQ0coyox7TZWz+s=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr40382901edc.128.1582400312379;
 Sat, 22 Feb 2020 11:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20200219093255.157758-1-omosnace@redhat.com>
In-Reply-To: <20200219093255.157758-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 22 Feb 2020 14:38:21 -0500
Message-ID: <CAHC9VhSCx=Xm_QeH70294RdDXq8JZoJ0aD9EQhw_fq601EcORw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 19, 2020 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Instead allocate hash tables with just the right size based on the
> actual number of elements (which is almost always known beforehand, we
> just need to defer the hashtab allocation to the right time). The only
> case when we don't know the size (with the current policy format) is the
> new filename transitions hashtable. Here I just left the existing value.
>
> After this patch, the time to load Fedora policy on x86_64 decreases
> from 950 ms to 220 ms. If the unconfined module is removed, it decreases
> from 870 ms to 170 ms. It is also likely that other operations are going
> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> but I didn't try to quantify that.
>
> The memory usage increases a bit after this patch, but only by ~1-2 MB
> (it is hard to measure precisely). I believe it is a small price to pay
> for the increased performance.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changed in v2:
>  - guard against h->size == 0 in hashtab_search() and hashtab_insert()
>
>  security/selinux/ss/hashtab.c  | 25 +++++++++++++---
>  security/selinux/ss/hashtab.h  |  2 +-
>  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
>  security/selinux/ss/policydb.h |  2 --
>  4 files changed, 42 insertions(+), 40 deletions(-)
>
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index ebfdaa31ee32..87ad83148cbd 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -12,12 +12,26 @@
>
>  static struct kmem_cache *hashtab_node_cachep;
>
> +static u32 hashtab_compute_size(u32 nel)
> +{
> +       u32 size;
> +
> +       if (nel <= 2)
> +               return nel;
> +
> +       /* use the nearest power of two to balance size and access time */
> +       size = roundup_pow_of_two(nel);
> +       if (size - nel > size / 4)
> +               size /= 2;

It would be nice if the commit description (and possibly the code
itself via a shorter version in the comments) gave some insight into
why you chose this particular adjustment to the hash table size.  Was
this based on observations with real world policies?  Just a gut
feeling?  Things like this are the sort of thing that one wonders
about five years later when modifying the code and by then no one can
remember if it is important or not.

Also, considering the adjustment above, why not use
rounddown_pow_of_two() instead (perhaps coupled with a minimum size
check)?

> +       return size;
> +}

-- 
paul moore
www.paul-moore.com
