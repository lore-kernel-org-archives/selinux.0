Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA3C4742C
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE1920786
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbM2x4Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgKBTwq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgKBTwp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 14:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604346764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SwhuIJZQ8fF5aScyLJAa3v6F4/Eti8Rq8PlXGuTuuYA=;
        b=BbM2x4ZgAcs73eysB+o51+zQXltX+OHMd4aNQ4Z+Ail1MjTP+U/uVB0a5T8/Hcjb14toc7
        vacOLuJ+dGZoHd5d5KlZGC4b+h/ufl2jrJ3CBkrPPMYoS5ME64stYa9Ix30ULKbroiOeEa
        Pls14gIMm0VK5UL8LKhj0JCJyFYQALo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-cpT-kikSP0O3LEAplRsfng-1; Mon, 02 Nov 2020 14:52:42 -0500
X-MC-Unique: cpT-kikSP0O3LEAplRsfng-1
Received: by mail-lf1-f70.google.com with SMTP id o27so1267536lfc.23
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 11:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwhuIJZQ8fF5aScyLJAa3v6F4/Eti8Rq8PlXGuTuuYA=;
        b=Qie5pUFXs0jQQSPDbqOsYR1XwEM+0wYRbjYxKRsZQNM5fG7C/3tFe2YYdR+wJ1hYpz
         N0gEUkEsEiIS8+klntlFLRflcflH45Trn8mecAWRbkEo3nkVjdsY3CdKBvFqHWs9e0GI
         R0Mny20TUCo6QQr18QFHWjYxxADNpd0j1EeT2V7mVRlFgn3fjlSMZPLCDr0XONcssu7l
         aynzDESfYSdMYp7Ma8a3m90BkyegYP9eDzQafmv4/XlL80bK3OXJpYV00Z3bcDZfXbt1
         c/K9Y7Fq8ToEwBV4RcWOHOfLj3BgICGe+SZobOXoh9VGF9gLitWKCJ8mKte9HSMqQLGX
         Jw8Q==
X-Gm-Message-State: AOAM531hagBW7M5+JVahvnM7fouF/djXsc9j6KGfSknxIZjfZg/9f/d5
        FZNCdih/tpvRqRmquBva8yoTywSnPzfojmL/MT2uOE463MlnkQU9+IlZ505ouO173kQfnTyaKx6
        umOYxrRH2M9f7vKS6Pn7Okj+8ke3u4tWGcA==
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr612728ljb.123.1604346760718;
        Mon, 02 Nov 2020 11:52:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyOdCxU0u2Eednyq4WaRn9qK0C5qAsb8boDEUv0RUHei35cBaic1E2yNzGyt4ATNZBkWej8UYZmbA7haBHwk4=
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr612725ljb.123.1604346760522;
 Mon, 02 Nov 2020 11:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
 <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com> <CAEjxPJ6U=sAHRaeND==ioJp=SOaWQ9ok4Va+ne=Eiii5Fo1-QA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6U=sAHRaeND==ioJp=SOaWQ9ok4Va+ne=Eiii5Fo1-QA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Nov 2020 20:52:29 +0100
Message-ID: <CAFqZXNtcNgc3_FCeTR_UNte9+QsSSLZxrfpsG2hW3b9sW=yDCw@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 8:20 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Oct 30, 2020 at 5:56 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 4:55 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > These fs_filesystem failures are caused by a bug when using the fsmount(2)
> > > type calls that was reported in [1].
> >
> > I'll try to dig into this a little bit. It seems that FS maintainers
> > are not interested :(
>
> For further context and the corresponding fix for nfs, see
> https://github.com/SELinuxProject/selinux-kernel/issues/49.

Hm... I was running the reproducer a few days ago on a kernel that
should have that fix (I think), and yet I'd swear I was still able to
reproduce the bug... It's possible I made a mistake somewhere, but it
might be that it's still not actually fixed (or reappeared again).
I'll continue investigating it hopefully sometime this week.

I also dug into the btrfs bug and it seems to have a slightly
different (albeit similar) cause. I think I have a possible fix, but I
haven't yet had time to fully finalize it and test it. I'll report
back once I have something final.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

