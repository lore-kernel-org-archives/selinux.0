Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30CEC3F2CE
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07E12084E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="LmiyyGak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbgCDVnA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:43:00 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42480 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDVnA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 16:43:00 -0500
Received: by mail-io1-f68.google.com with SMTP id q128so4103341iof.9
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kohTS0oWK3oyZBhVcjPYRmmZY/DbunQHq+ZzLRRCLIY=;
        b=LmiyyGakqqobO3ETEManfGMdkrcUfJ12WMnM2PO5xPm7xGxwNDWB+v+UkEMZdNJ5UW
         WDhLsFtGlzzsObfROfrK6LGL0d11U2xi9r4MNcmDthTAP7W+z08jWC79c7F/Zdqme0zB
         5lsY11KkvweYgwhXT7TXCdC2A+A55BxzhOLrr2+0Vh7KRZzCTAycvWMDfdmx1jI0aNOo
         RMo1xMttg1g9of9qUmLvz07H/Iq5BMcQrYoOXBhYS+da1YSRmJgtqwU9Qrsbu5xN62XG
         qRKJj5iylMd5itA/s8AT/4lgzzvRn2COvc8VFYVyjBAKZ39sH4DVc3HoM1oBILalCgfc
         60Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kohTS0oWK3oyZBhVcjPYRmmZY/DbunQHq+ZzLRRCLIY=;
        b=FcfxR9Coi6HNgVkonwRTX+hjAeYIGhBBylT1HCGzP+WaF534SF1hkP7NbrOUhcM4I5
         TwbCHfvD/SVGomuP49nT8PnUiWkxmdDe5R6w1Z+HL+t0uJLgr8pUk9FxYEjrk4ff16Oa
         fFplaUK9hUfvS1r9sEWCQGakPmbUv3uebcLUampDnya84YPyhNZfMm7apegM7G6Pge+0
         vEMr0fnxlfOojD5iuQfhm9WuCsdtYZNedqWMA88htT9675+a0V1OlgQs2hpmvaHvL9ZV
         3jZB8mHDF2D8ILGM4Zc1jof5xk/fGPX8kjiNZwrV6Ro7plficrl+GRwP2XeYr3vNScre
         Iwmg==
X-Gm-Message-State: ANhLgQ0B/eDp7x9h4n6ZeIgvvxEc4ZPAMRWu4kQ8BhAGt+u9N/W5aKOA
        FTO2i8kuEhfd7SmyTzcUzgoI9/wIQ947JAOKR8l1PA==
X-Google-Smtp-Source: ADFU+vv26fondIl0aupMpTlar3UE7b9ywX0JBVZnaNmbvNcp6RtoMvvZdUsYqkcFpsdbacTlfVUYykGsCvafoHfgrDU=
X-Received: by 2002:a5e:c11a:: with SMTP id v26mr3556909iol.34.1583358177858;
 Wed, 04 Mar 2020 13:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
 <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
 <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com> <CAEjxPJ6w+n=1XvA72FKPOnQSDjA+tKsUZRfY5HUd+_RxgBkosA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6w+n=1XvA72FKPOnQSDjA+tKsUZRfY5HUd+_RxgBkosA@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Wed, 4 Mar 2020 16:42:46 -0500
Message-ID: <CAGB+Vh6sup6enGinZXc6p3rf2JrmfDP1sAHyNh+5pREVFrQDvA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 3:56 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 4, 2020 at 12:18 PM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> > It's been a while so I'm just rereading mine, I also attempted to
> > differentiate between MLS and MCS policies on the system running the
> > tests so that they could run on the MLS policies directly (which is
> > where glblub support is utilized), and I also verify the default (non
> > glblub) behavior to ensure we didn't impact normal computations.
> >
> > Unless there is a compelling reason I think mine should be merged
> > rather than this one.
>
> Comparing the two:
> - As you said, yours in theory supports a system running mls or
> neither-mls-nor-mcs policy.
> However, I'm unclear that one can run the testsuite under anything
> other than targeted policy w/ mcs currently.
> Is that something you have actually done?

I think so but it has been a long time. Presumably I needed more
modules than come with the stock RHEL MLS policy.

> - As you said, yours tests non-glblub behavior too.  However this
> makes an assumption about the base policy default_range rules
> that might not be true?

They might not be true but I used an object class that doesn't have
defaults set in any policy that I've seen in public. I suppose another
tool to validate the assumption could be written.

> - Ondrej's uses the more compact (range c0 c1023) notation in the cil policy.

Easily fixed, obviously I didn't know range c0 c1023 was valid in
sensitivitycategory statements. Pretty nice actually.

> - Ondrej's checks that checkpolicy supports policy version 32 in
> addition to the kernel, necessary to build the policy.

I suppose that should be added.

I'm not currently set up to re-test this but could fix it up next week.
