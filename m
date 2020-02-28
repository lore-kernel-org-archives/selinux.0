Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55BC3F2C6
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 00:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80886246A0
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 00:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="NGAIqSEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgB1A1b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:27:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44276 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1A1b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 19:27:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so1222667eds.11
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hhk7PUuG2uwctHCYBLJrzlfm+pGgI2SDPKhJXoXTP4=;
        b=NGAIqSEprGyY+jxUHbj2Pc/AeO0/1IbJHZsDQzF3TK16dRsSaHiDWEpL2Q/z6/2Ljc
         KimNqbHiOZB2/z9ODuYJqzecpBQuUtt/94SrThff9opeqBis6St+4AHxk04gI85zkIuQ
         UzRzC4wSe5s1xg89dPKwFh/Fbn9+utPtWzK1tGnb7yaocOcSDL2quZRQDiIS1O5+KrE5
         cjUjmmIRoEYWnrcgPkdhblHW31AuDh0Z7mFv0y51kd7uy1aeaurI4+PL6oBIOi3hJ+yY
         aDajDcR9od2jcZXMW7rN8AJf8a+1E3M1TtrsALLPTZdicGb7ibOAr8oeTQyI2gTa4TNR
         pnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hhk7PUuG2uwctHCYBLJrzlfm+pGgI2SDPKhJXoXTP4=;
        b=aBlYKmit6BG6cna0JICQ9dvoICS6TntVYheITzHts4AvdSMJ9KypZoB7TvLkvvSU4J
         yruG/LEMa5+r8C6URINA9esvVHPIwYbFmdMW6UQvGbpWcik70n1jPBOpfpTwe5z3UQlm
         VilYcPveg3R15kP8LwZ29EUyZVTBITBpwti62ss07ve8HRs0JMuKA9E3ncMI3VxLHj6e
         soEOWOS1l+WjRz6Zmrx+ywfzry4gSN4Xo5g1t+wZYNxrOHaTIQj09gGmRfDl+hEF15J0
         iHQs7zj2HBdMdsp2x1Ne1Ch1yrVFlh0jPq6bqsMDR7kNCFJK1xqAPhhlTYlbVFQWKHqP
         teVg==
X-Gm-Message-State: APjAAAXWAt5OPr9Osc1EoZWR4u7I0wqdpqiwI1Hztgv9iga9yEzWKSkI
        m3ZPf+Xt4cicFBO/iEewuz0MHRHh32ENgw4fiqB/
X-Google-Smtp-Source: APXvYqyp+xCdohjXGZD7ZEjNdY/ANY+LKRa3CL9XE50ycy3NKe3E887xlMebyW7CDeKER1BgS6aPinQ3yeqrdXKIHF8=
X-Received: by 2002:a05:6402:309b:: with SMTP id de27mr1088079edb.269.1582849648082;
 Thu, 27 Feb 2020 16:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com>
In-Reply-To: <20200226155452.301544-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Feb 2020 19:27:17 -0500
Message-ID: <CAHC9VhRWx5r=7fzh1UmL4Pcn_tDMJYLWvakv8uSqr23jcZ5U_g@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Instead allocate hash tables with just the right size based on the
> actual number of elements (which is almost always known beforehand, we
> just need to defer the hashtab allocation to the right time). The only
> case when we don't know the size (with the current policy format) is the
> new filename transitions hashtable. Here I just left the existing value.
>
> After this patch, the time to load Fedora policy on x86_64 decreases
> from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> from 750 ms to 122 ms. It is also likely that other operations are going
> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> but I didn't try to quantify that.
>
> The memory usage of all hash table arrays increases from ~58 KB to
> ~163 KB (with Fedora policy on x86_64).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changed in v3:
>  - switch to simpler and more logical hash size heuristic
>  - add comment explaining the choice of the heuristic
>
> Changed in v2:
>  - guard against h->size == 0 in hashtab_search() and hashtab_insert()
>
>  security/selinux/ss/hashtab.c  | 28 +++++++++++++++---
>  security/selinux/ss/hashtab.h  |  2 +-
>  security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
>  security/selinux/ss/policydb.h |  2 --
>  4 files changed, 45 insertions(+), 40 deletions(-)

Thanks Ondrej, this looks better; merged into selinux/next.

Also, changing the hash heuristic in v3 really shrunk the memory usage
compared to v2 without much impact on performance - a ~100k increase
in memory is a small price to pay for the policy load improvement.
Well done.

-- 
paul moore
www.paul-moore.com
