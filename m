Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EDFC34050
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CA724656
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/gFVqQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBSPHh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:07:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36014 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbgBSPHh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 10:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582124856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+2iG/WpAPPIXkll1Ll7tiNCUjBVGDS/DVEIz3lgHIA=;
        b=K/gFVqQLSVpZCFm6rgu0Z8IhLg9UEar3bcGr67CHMjC8m+KbK+Zd1IElGj4t5/Xgx6/YO4
        SryNd3AJyOkUvtJrIhcAli9CH4ZVaDeYqs8xH01BtFVovcgomXKjXRfZ4v2/zeLvD2uDi9
        PeJYPyyWNPLoQmYskeAVNNtgIWkCSoc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-q6VjTt6uMv-i_tR_CgRjqQ-1; Wed, 19 Feb 2020 10:07:33 -0500
X-MC-Unique: q6VjTt6uMv-i_tR_CgRjqQ-1
Received: by mail-ot1-f69.google.com with SMTP id q13so298243otm.18
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 07:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+2iG/WpAPPIXkll1Ll7tiNCUjBVGDS/DVEIz3lgHIA=;
        b=Lqu0bIkhIhY++I1OMiqDg2Pt4Wmn0NNmdDIfhP0XIBLAHXIhaIrbJxsCXl+IXhxi6v
         1m6Ipgx9KaEOlZiY6QiowwKdyphRC0C44huTHv8v3gy1EY5E+cfPBQ5UmYTHIdKbyR88
         46OY4i6hS7/pyhnNnfBxTJc3JYOuQ3I7i7J8NyvfQeMPtMfJd0X/n5lg37ai3qMFvS/r
         8yLfPIe5es65VlUIU+Ho4+nEP7R7dyhCHWohoOQgeSutb+mh4BYqihxzNzcYOhQ2U7A0
         VgoH/XTNEbTi6T4X3g8SjQ/hke/zHbIWAhMAS2EDqgyhkx8T3+B3Ittuey3AR6OyGuqv
         glxw==
X-Gm-Message-State: APjAAAXEWrRFzodK/DQkgcY+E5OedMywdhYlqLVF9w49Y1JPF4gVpF81
        bYgF/kCIn7/3pS0KbwD01tFsgM/kmPkIuMXLsqzQ3xjJQyX6XLwzCmoz1N7X3g0VlA4YylMQtL8
        p8uvikSed1S+fzzHz22Z0Mkt+SN3obkkgXA==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr20264645oth.197.1582124851694;
        Wed, 19 Feb 2020 07:07:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzg3XONCu339dHWgVcd245QJOMQa7/iw0TOsRbJgRwpZ9nsxBNttyEKtOGIVYKS5hagGcnlNXZKWFrUHVtZSRg=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr20264624oth.197.1582124851397;
 Wed, 19 Feb 2020 07:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20200218203911.30502-1-jwcart2@tycho.nsa.gov> <CAFqZXNth6mpsSJ1--czyyfSXCbHTD26MzR+u3UhF5Qn8meHKLg@mail.gmail.com>
 <3f4796be-3dd1-1f4f-fbb9-93f358f9ba33@tycho.nsa.gov>
In-Reply-To: <3f4796be-3dd1-1f4f-fbb9-93f358f9ba33@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Feb 2020 16:07:20 +0100
Message-ID: <CAFqZXNuprke2fOUxGVx8KiO+9Jj31TTNUPbbz8Vu1ZHwWCYhPQ@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [PATCH] libsepol: Use ebitmap_length() to
 check for an empty ebitmap
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 19, 2020 at 3:54 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 2/19/20 3:25 AM, Ondrej Mosnacek wrote:
> > On Tue, Feb 18, 2020 at 9:45 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
> >> When checking whether or not an ebitmap has any bits set, use
> >> ebitmap_length() instead of ebitmap_cardinality().
> >>
> >> There is no need to find out how many bits are set, if all that is
> >> needed is to determine if any bits are set at all.
> >>
> >> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> >> ---
> >>   libsepol/src/kernel_to_cil.c  | 10 +++++-----
> >>   libsepol/src/kernel_to_conf.c |  8 ++++----
> >>   libsepol/src/module_to_cil.c  | 16 ++++++++--------
> >>   3 files changed, 17 insertions(+), 17 deletions(-)
> >
> > Thanks, this looks good! Although I'm thinking if we shouldn't add a
> > specific function for this, e.g.:
> >
> > static inline bool ebitmap_is_empty(ebitmap_t *e)
> > {
> >          return ebitmap_length(e) == 0;
> > }
> >
> > ...because ebitmap_length() is kind of an implementation detail and it
> > is easy to confuse ebitmap_length() and ebitmap_cardinality(). Note
> > there are already some existing callers of ebitmap_length() that would
> > also need converting to ebitmap_is_empty() in that case.
> >
> > <diff snipped>
> >
>
> I think ebitmap_is_empty() is a good idea, but I think a macro will work fine.
>
> #define ebitmap_is_empty(e) (((e)->highbit) == 0)

I personally try to use inline functions rather than macros whenever
possible - they are type-checked and consistent with the rest of the C
code. Using macro where a function would suffice is kind of a hack,
IMO. But in this very simple case it doesn't make much practical
difference, so I'll leave it to your decision (unless other
maintainers also object).

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

