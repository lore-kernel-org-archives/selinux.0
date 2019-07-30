Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF833C0650F
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED932064A
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 14:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hBeUaIqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfG3Oqs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:46:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40019 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbfG3Oqs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 10:46:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so28755821lji.7
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTn2zHzTGsV23R8PfnK2bEfR1JY+6QPYjwLon9erRjU=;
        b=hBeUaIqhseD30T/kpX1hoNwvnRCbM3S1m6yDtQB7VLs0UivG9u3T5LR4Opm1WuxXqZ
         55blUunXhFuYqN3Cw3xYSuTQA6tKmeObfaPXUMTJRuN7anKRjcG4hImSLYh5TH3Kn3ez
         T+FIDcSTmb5499dViX5mkjc38yXhUfqhlYhzEkAZvw/ENZfL9Lrjw0rh16AzHGQWNIGt
         DTXt0D92oatqoAGxNcEMYV+ziXj64jg1FnRZz+48Et9PEIpjVidbl9Dv0T/E3QbL5R4W
         ptXCuVQTKwsOUYc9vcFpwhrm7/Bg7nxIGLxOQ/Q878iIBnK9FLYPGMDuAyuC5fT3cuiI
         7IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTn2zHzTGsV23R8PfnK2bEfR1JY+6QPYjwLon9erRjU=;
        b=Mpfm6OayGN7JzrTjbWZUbr6bwLLbFhmkYj9zSUERhyptjsAvDJZDtWFvmiCoOVe7Jf
         uEr5k9RYipoafv2LtaYaq9qIXC6bKFxscqovuDl/G2kkQXtFqoIMyoAAvUl9bCNXu4pf
         /GRE17wQs9lK7ME92J1Mz/+gH94ieeW6KGgJ6NSizZeKzAuKVy7ItdO5+H7OBRkvOu/C
         2Kzy6Q4UeI9gzDKLzTpbWScK19G+GaN6kJbTFDyP2SdI4smzzLvTmUk1kHYyXct9QTur
         n5YcJ8YsNdHVb/wGOK8vkB8NhcNEvrc1FsTS417a1o9bxCMrkSKaIIvpSMe34Y1q8OFi
         ebdw==
X-Gm-Message-State: APjAAAVHoYrH3NJKE7Uxoj4EdNgEAzTVOi5YI98ksnZXOtgOdDU69f7w
        5OVysufbzi1gTrzEppFo+Z+8zT/17sq7BsE1+w==
X-Google-Smtp-Source: APXvYqwAY6IgvCaIpTsSp1PQ9UAgtAHB01qId5HOjBXGAy8qgGtjV6DMrDHBRNDTVjS6J++5Vk0xeKrQTwS99ZlLhZ4=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr37384190ljj.91.1564498005670;
 Tue, 30 Jul 2019 07:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190730124852.7670-1-omosnace@redhat.com>
In-Reply-To: <20190730124852.7670-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Jul 2019 10:46:34 -0400
Message-ID: <CAHC9VhTetPBY9keC5ps=XHvgzLOeZE7rDbeG00R4jz0mYaduhA@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize MLS context to string conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 30, 2019 at 8:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> When mls_compute_context_len() or mls_sid_to_context() encounters a
> context with large category ranges, it behaves suboptimally - it
> traverses each positive bit of the category bitmap, each time calling
> find_next_bit() again.
>
> This has a large performance impact on UNIX datagram sockets with
> SO_PASSSEC set, since here the peer context needs to be converted to
> string for each recieved datagram. See [1] for more information.
>
> This patch introduces a new helper for ebitmap traversal, which allows
> to efficiently iterate over positive ranges instead of bits -
> ebitmap_for_each_positive_range() - and converts the two mls_*()
> functions to leverage it.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259
>
> Reported-by: Michal Sekletar <msekleta@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

My current opinion is that this isn't the right way to solve the
problem, a SELinux sid->secctx cache would be a better choice.  With
that in mind, and the understanding that this patch is an optimization
and not a bug fix, I'm going to hold-off on doing anything with this
patch until there is a cache option we can use for comparison.

As Stephen mentioned in the RH BZ (linked in the description), there
are a couple of reasons why the code doesn't currently store the
string translations.  Ignoring the issue of aliasing for a moment, I
do want to stress that I agree with Stephen on the issue of memory
pressure and that to keep translated strings around indefinitely in
the kernel is going to be a problem (there are other issues beyond
just memory use).  I imagine any cache implementation would need to be
built to only store a subset of all the translations and there would
need to be a way to age-out those translations (as well as purge them
completely on events such as a policy load).

-- 
paul moore
www.paul-moore.com
