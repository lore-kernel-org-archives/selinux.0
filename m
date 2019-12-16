Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF04EC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFA12064B
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 23:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iQWFjInD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfLPXqW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:46:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43435 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXqW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 18:46:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so8740590ljm.10
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2019 15:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBGG3FlFNAJBz4TcYFB50vekO3qw9gy+D8EyTajiU9g=;
        b=iQWFjInDQk86vbSrurK/W0zgi4n9n4QgMUa/CJ20mYL9wBPUHIJXp2P9+vA7LwBWQ2
         Z9VVpdaJ8IUWeaDcYMdzHaMWvJzhlOJTwT+VCv9hFo1g+s7SSKtDNHfnjKyO3zhEeNdr
         Zz91KDa1RCofiRVUHaHZtpeexLjeGfxLC+pvhH79bCghW7OJWT9FqW8DE6Z+hTqk/hPk
         7ecD695mm/zh6oYeB4ehzPWeSfbvmjmsXwXfsCZSmkKEIBMr7mekxNZ67wmlnbnBSXBq
         YyfM2SwiVwYujcCvcfSrN0WvkOrvfoXK92b3AgPsZ+P/N2UmnWemMUeRZmZZtM+Nxjg0
         q+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBGG3FlFNAJBz4TcYFB50vekO3qw9gy+D8EyTajiU9g=;
        b=kuXu43QNHa5FjKieXFKJnL7Brim3d/iQkzUs/OI2t0FsPAF2J1wLf9fywwFwKvcTvk
         a4GMTFvK05SSbrLgVbk5XLba1gPhnpmtsQd4m47Y+RAADV+Pk6TRHdyKs2fNWuD+BWPI
         W5ZsVYX+iq6aDqQMzrYHmZOiZ+iN4Hj+0RcsOxn2k/BU1hUkjUSmG+IGxYNlwqzpuf+2
         2IC/OIEg8rSr43SfWl8fUNJp2gQc+MDco1wHn1ro48JVYpnT2DJnEFI6w6pJd3WMgnbQ
         5j29heJdvl+G0KZZKBTm2llqnIZQXFA3mHNQ1NndYzfKNg3Tyj/Yl38HkLcEtNuaH11S
         ciAg==
X-Gm-Message-State: APjAAAXfXzJGwVepH9U9qLVu9QkPTjg2hKWQ8WfMphQ59VpSMAXD7qtH
        kLr3IeghcnOehavDV/TOgTK2v1VzqixyZMBGttqQ
X-Google-Smtp-Source: APXvYqxs9N07Pm9HqGuT3tPE0FGuV7SD5pGml+CbZhDNXhj+9MzDy4RNDbrig/nByMgXPJCpS4zlU18hOnfieMh5OxA=
X-Received: by 2002:a2e:3207:: with SMTP id y7mr1105598ljy.57.1576539980115;
 Mon, 16 Dec 2019 15:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20191213202838.7323-1-sds@tycho.nsa.gov> <20191214185002.GA8076@gmail.com>
 <e25e8aec-f3a2-1b35-ee6c-e2c9344db885@tycho.nsa.gov>
In-Reply-To: <e25e8aec-f3a2-1b35-ee6c-e2c9344db885@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Dec 2019 18:46:08 -0500
Message-ID: <CAHC9VhQQQ15WjCZ5ijLhx5ttGeosqnwJ3TXcZYJouVqNPotpRw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Dan Aloni <dan@kernelim.com>, selinux@vger.kernel.org,
        keescook@chromium.org, omosnace@redhat.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 16, 2019 at 9:21 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/14/19 1:50 PM, Dan Aloni wrote:
> > On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
> >> I would have expected that two kernels built with the same config
> >> with this enabled would have yielded different struct layouts in
> >> pahole vmlinux output, but that doesn't appear to be the case. They
> >> do have different seeds.  Am I doing something wrong?
> >> Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
> >> change if enabled?
> >
> > There's currently a long-standing bug with the GCC plugin where the
> > generated debug info is in declaration order, not build order (see:
> > [1]).  So, to verify it, try looking at the generated machine code.
>
> Thanks for that clarification; I can see in the code that the struct
> layout has changed between the two kernel builds.

This likely falls under the category of stupid questions, but I'm
assuming it passed the test suite w/o problems and the system
generally ran as expected?

I've also heard some comments about performance concerns, have you
done any testing?  I'm guessing that isn't a major concern here
because I don't recall any of the structs marked in this patch going
through any optimizations, but I could be forgetting something (or
missing a performance concern with RANDSTRUCT).

-- 
paul moore
www.paul-moore.com
