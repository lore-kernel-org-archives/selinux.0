Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76592C3F2CF
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5B724695
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 08:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boO8Ev4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgB1IsF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:48:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1IsE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 03:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582879684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lDJxJ0MF5866GYNUm2CRydwds5PGZRCDgfE6J4lKs7s=;
        b=boO8Ev4xmICD6NGxuFj1X6/r5G1PssGQK2KVLlgoMbZf7ma6YQGr0xvumdeb7HOA9hva3t
        4bYn64FrAM1vKW8Ky+ePjwAt+o+F+lfdT0J7KPHdb96JCgt/KEmRjZY0gpz8UXaqsqUq3q
        Q4T6XfEzT8o5tTV0NHWpETXt7PZjmmc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-tqeEVVpRNnm2G56fGzzgjA-1; Fri, 28 Feb 2020 03:48:02 -0500
X-MC-Unique: tqeEVVpRNnm2G56fGzzgjA-1
Received: by mail-oi1-f197.google.com with SMTP id v198so1162158oia.15
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 00:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDJxJ0MF5866GYNUm2CRydwds5PGZRCDgfE6J4lKs7s=;
        b=Lqm2N8/GoZIBywhnMVPP4JKeNNqc4L6lTfDqWWgiRryvKjOJH3U8hMf6fzHF18+yEJ
         cEQP+Q8WE9y12+6somHkxbUo3KA+NV8GjWwO61uH+6yz21DH6vu6WAaWZzRJ3kgfsD7E
         LG22FfSYUD4Ho17XuIEpMZUKYgOl6hHBpzK0R66sRQLRZ9hAiG+L9w+pT2Wz8jE6hJpQ
         AHVy5s2hxOcKXS+QnogXeVAl3W5GQu9NVECITEiasqWAtHAMx8FYDGAZXx/iX/4uz5R8
         XGr5VWBFgV3VcqAQ76K4fB2KXYASOV+mv+tmVukxt0IZQ8fFN4FOzQkijHjiOQoab1sA
         H0CQ==
X-Gm-Message-State: APjAAAWFXQOZRq6yp8UxxwHk8duY6GSMG0+3ktwq6R7Fe/aUsles+vL5
        SPwQqaZBHebviOsPbyyM226cCNfuJcv7Ax224rkbUSMEwRpEvjLRQY0E4fc8tejVNWidug72TGF
        P8zQFfXlneMiXfTriUv0qqsgB4VyDO6ZG8g==
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr2460168oto.197.1582879681492;
        Fri, 28 Feb 2020 00:48:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1J95U7s4PxKdEZkdYWu50YP2fproAZ2m/JHvFd0pyfJZTZUBVrELFdSGj2AvIAYt7CesuQnHcH5FcLM/sNdk=
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr2460161oto.197.1582879681206;
 Fri, 28 Feb 2020 00:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com> <CAHC9VhRWx5r=7fzh1UmL4Pcn_tDMJYLWvakv8uSqr23jcZ5U_g@mail.gmail.com>
In-Reply-To: <CAHC9VhRWx5r=7fzh1UmL4Pcn_tDMJYLWvakv8uSqr23jcZ5U_g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Feb 2020 09:47:51 +0100
Message-ID: <CAFqZXNv9kHWfPYWRJy9wXE+OehP8q8Zbokk9DB_pSMwrhNx4Gw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Instead allocate hash tables with just the right size based on the
> > actual number of elements (which is almost always known beforehand, we
> > just need to defer the hashtab allocation to the right time). The only
> > case when we don't know the size (with the current policy format) is the
> > new filename transitions hashtable. Here I just left the existing value.
> >
> > After this patch, the time to load Fedora policy on x86_64 decreases
> > from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> > from 750 ms to 122 ms. It is also likely that other operations are going
> > to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> > but I didn't try to quantify that.
> >
> > The memory usage of all hash table arrays increases from ~58 KB to
> > ~163 KB (with Fedora policy on x86_64).
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Changed in v3:
> >  - switch to simpler and more logical hash size heuristic
> >  - add comment explaining the choice of the heuristic
> >
> > Changed in v2:
> >  - guard against h->size == 0 in hashtab_search() and hashtab_insert()
> >
> >  security/selinux/ss/hashtab.c  | 28 +++++++++++++++---
> >  security/selinux/ss/hashtab.h  |  2 +-
> >  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
> >  security/selinux/ss/policydb.h |  2 --
> >  4 files changed, 45 insertions(+), 40 deletions(-)
>
> Thanks Ondrej, this looks better; merged into selinux/next.
>
> Also, changing the hash heuristic in v3 really shrunk the memory usage
> compared to v2 without much impact on performance - a ~100k increase
> in memory is a small price to pay for the policy load improvement.
> Well done.

Er... sorry, I forgot to document it clearly in the e-mails, but the
usage didn't actually drop between the last two versions (it actually
increased by ~36 KB). It's just that In the previous version I
"measured" the memory usage just by looking at the total memory usage
reported by top, which is however fluctuating a lot and I was
apparently just measuring noise... For this patch I actually printk'd
the sizes of the tables exactly (since that's the only thing this
patch touches) and this showed these much smaller numbers. So please
disregard the 1-2 MB from the previous patch versions - they were
bogus.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

