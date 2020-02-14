Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B87C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8465E222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 20:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL1/ZQBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgBNUUF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:20:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729633AbgBNUUE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 15:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581711603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Swg5bN/S0w1leiTAdFN0CpCxxYP10dOwCWFGIFUlRo4=;
        b=GL1/ZQBclaZ/l7JTnRW4lNvltd6OIZXKVirT2kdIbQCXWP8Bhmv0IKmJex5OGAZUlLJtul
        jhI5F5YMFnJG7eAuEgq8ZqymhK9Ze3C3yzSLs3sMZhgB7BM9JODlo313CRd9InZQV9GO/b
        XE3eKeZRBOi3aUf2nF6MSvDA8qd04N4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-dcYIPyYMMwKdagk5ZEhnMA-1; Fri, 14 Feb 2020 15:19:58 -0500
X-MC-Unique: dcYIPyYMMwKdagk5ZEhnMA-1
Received: by mail-oi1-f197.google.com with SMTP id c4so5273764oiy.0
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 12:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Swg5bN/S0w1leiTAdFN0CpCxxYP10dOwCWFGIFUlRo4=;
        b=oAedK0WV2F36i0b/vq6n8Vo1OicKu9dW2EHnkxG3j5cCj/MP2Q8nugWbBwIs8efoby
         njPIXN3N4jOsniJXcUxGg7pKcn9gy/owh0Hx+1k/uTWK4Up/9hrINILRpqRy7o0Utcb6
         Y9kWYe3nNK8r8R9yBdGHu2ioEA+qB3Vy72YWyzYRZt1ziDtTvDwqgqfkLXpA5VEGQx5j
         reEW9BKm2CtHNFCykMxCUrXeTR1g4jwGFpUAolo1subYlY1FWsRwQkB56ZG1w6flvKQQ
         xDpFFglcgWmhrLe6jj+ez2l8Poj0owc0tn1+YsnlqlB+KFc69Ot6OFP2Vz2xDCmUBmnu
         u5LQ==
X-Gm-Message-State: APjAAAVGwMXxKKKY8WL9EExpKT1nwlNGxvFRHd/+WKi1l5FV7PKdwcmt
        e1/VDlza1DYA7Fw6m6U9qXsB7JKKA8uBFc04/s84NH15+sw8TX+LyEjH/+UwkuPCnGH9ay26SWU
        cKHWNHw5vNfQU5X1wOewh/8tjcnEbAPLHvg==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr3727350oth.197.1581711597619;
        Fri, 14 Feb 2020 12:19:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaagG7hZEV/A2IbX/5H1BV6E1flPMqq3xhv1FHbTIgqD3C77VuqRpjgxzx+FDKDhnhzcMnU3E9XyNEoBydIrU=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr3727331oth.197.1581711597333;
 Fri, 14 Feb 2020 12:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
 <CAFqZXNtpqOszQ5a2s86TTHtQGK_c+vqmtaRPBv04+vFAqExEmg@mail.gmail.com>
In-Reply-To: <CAFqZXNtpqOszQ5a2s86TTHtQGK_c+vqmtaRPBv04+vFAqExEmg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Feb 2020 21:19:46 +0100
Message-ID: <CAFqZXNsybfes26org68zTEgxqSFu9RT4V8+bT+W57Gr39JovjQ@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 8:51 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Feb 14, 2020 at 6:37 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 2/13/20 8:39 AM, Ondrej Mosnacek wrote:
> > > According to profiling of semodule -BN, ebitmap_cardinality() is called
> > > quite often and contributes a lot to the total runtime. Cache its result
> > > in the ebitmap struct to reduce this overhead. The cached value is
> > > invalidated on most modifying operations, but ebitmap_cardinality() is
> > > usually called once the ebitmap doesn't change any more.
> > >
> > > After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> > > decreased from ~14.6s to ~12.4s (2.2s saved).
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > This seems fine but I was wondering how many of the callers of
> > ebitmap_cardinality() actually need anything more than ebitmap_length()?
>
> The caller that calls it the most (>99%) during a 'semodule -B' is
> __cil_should_expand_attribute(), which logically needs the actual
> cardinality. It might be possible to cache the decision directly in
> 'struct cil_typeattribute', but I don't know the CIL code well enough
> to attempt that...

BTW, in case anyone is wondering how I'm getting these numbers/facts -
I use Callgrind [1] to profile a program's run and then analyze it
with KCachegrind [2]. It is a surprisingly nice and easy to use GUI
for analyzing where the program spends most of its time.

Collecting the profile data is as simple as:

LD_BIND_NOW=1 valgrind --tool=callgrind <your_command> <args>...

(The LD_BIND_NOW=1 is to prevent the dynamic linker's lazy binding
from messing with the results.)

Then you can just open the generated "callgrind.out.<pid>" file with
KCachegrind and click around... Note that to see the function names,
you need to compile the program with -g (but you should keep -O2 et
al. to get the same optimized code as an actual build). Alternatively,
Callgrind will also auto-detect and use debug symbols provided by
distributions in their -debug/-debuginfo packages.

Maybe this is common knowledge for most, but perhaps someone here will
be one of today's lucky 10000 :) [3]

[1] https://valgrind.org/docs/manual/cl-manual.html
[2] https://kcachegrind.github.io/html/Home.html
[3] https://xkcd.com/1053/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

