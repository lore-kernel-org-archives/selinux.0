Return-Path: <SRS0=nReO=7T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E25C433E0
	for <selinux@archiver.kernel.org>; Sat,  6 Jun 2020 13:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF91206A2
	for <selinux@archiver.kernel.org>; Sat,  6 Jun 2020 13:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EmGz88XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFFNGM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Jun 2020 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFNGL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Jun 2020 09:06:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A0C03E96A
        for <selinux@vger.kernel.org>; Sat,  6 Jun 2020 06:06:11 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m32so4457660ede.8
        for <selinux@vger.kernel.org>; Sat, 06 Jun 2020 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmxHy3g1sKDhQdTIGLF4OTNR2PGp6JqdtkMSKx4sbCM=;
        b=EmGz88XYlCbMHghJQMrUwBOWtmoEmkfGh50b/bJfrzcoUNWfpxMy0WzFdcceapd41+
         4tYICTfTQJeQKdy1/QG+M4FSs2O4FNDz2DOEe4EhefU4PEMxZugfdIaM1Iu087Bqx7ku
         v56BuS34+y01pjvLFRaglDm7o/AkOEnlvzynLElBqNo635X61fFgrUifW6elYCv97h9R
         sBDc2OL5I+EO8tSfpaAs3mOJBbvuEv3kKJ/1GctiWku5bvWRfEpDYmR9JLtvMd/vjdHW
         ANo5QtmANRzsF1bWVrTqCMrTRGm6LOtemtT9u/9c0+d4UXsuDRzxHS17tji8VgIWElMg
         lG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmxHy3g1sKDhQdTIGLF4OTNR2PGp6JqdtkMSKx4sbCM=;
        b=iXRkOPdkjeiPESBd0nq48YsC1KEr5B/ar7CKUiAPzPCeo7qWuHksk3VP4TU4fFkuXx
         SQRJn9kCvlAma9pDLqxogfWFIfwjDTYrrFVMeB3hNDG+WOymg1WWzEYjGrCXK6wOcvKm
         +8sx37X9CFm8UyxLtJ5NNt+UtFHbXbaVlvZhcyj1yQuVtCg5Tv6dsMqyApEJbkF9d8hk
         8kuHGMC9iyK2OBg4pURgR5bVjag3po65h/QAzn4glRpumt2JamIb9sx3XB3+in7y25f2
         VEfPp6Jl5kkWZm2RtDxYhQ5VFaYSVzMg6LZyFEfMx+frwVkXzlsKx4X0plKHMptKm7Dh
         Wvzw==
X-Gm-Message-State: AOAM531UAnyEXH0//noWcMZTK0YFLgJdtrl+NK16TFnuuodDb2zzDUmc
        xzZm/CZ8nDZTMepeukzUmtUu7MLA0LJufmYWw1Fl
X-Google-Smtp-Source: ABdhPJxtPvw4JDVLW3VyOPeWnF6ZC0BOEZvzVFz2Dg0EBuDyUSZkLWA4EGIeLgHPKi+nrA2ODqn6l/5sQernvGOPFKI=
X-Received: by 2002:aa7:da46:: with SMTP id w6mr13629751eds.31.1591448770155;
 Sat, 06 Jun 2020 06:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
 <20200429202941.18320-2-siarhei.liakh@concurrent-rt.com> <CAHC9VhRuYa2nA18tnQCwfAUW+whce1a84W802GKk135ztoN8Cw@mail.gmail.com>
 <20200602204214.GA29793@concurrent-rt.com>
In-Reply-To: <20200602204214.GA29793@concurrent-rt.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 6 Jun 2020 09:05:59 -0400
Message-ID: <CAHC9VhRYfvF_9H=67Hj06zu9hfYnM3SNZCGceFjXUEr3bt5o0Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Add median to debug output of hash table stats
To:     Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 4:42 PM Siarhei Liakh
<siarhei.liakh@concurrent-rt.com> wrote:
> The 05/13/2020 17:55, Paul Moore wrote:
> > On Wed, Apr 29, 2020 at 4:29 PM <siarhei.liakh@concurrent-rt.com> wrote:
> > >
> > > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> > >
> > > This change introduces a median() function which is then used to report
> > > 25th, 50th, and 75th percentile metrics within distributions of hash table
> > > bucket chain lengths. This allows to better assess and compare relative
> > > effectiveness of different hash functions. Specifically, it allows to
> > > ensure new functions not only reduce the maximum, but also improve (or, at
> > > least, have no negative impact) on the median.
> [ . . . ]
> > > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > > index 9e921fc72538..57c427e019c9 100644
> > > --- a/security/selinux/Kconfig
> > > +++ b/security/selinux/Kconfig
> > > @@ -115,3 +115,13 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
> > >           conversion.  Setting this option to 0 disables the cache completely.
> > >
> > >           If unsure, keep the default value.
> > > +
> > > +config SECURITY_SELINUX_DEBUG_HASHES
> > > +       bool "Print additional information about hash tables"
> > > +       depends on SECURITY_SELINUX
> > > +       default n
> > > +       help
> > > +         This option allows to gather and display additional information about
> > > +         some of the key hash tables within SELinux.
> > > +
> > > +         If unsure, keep the default value.
> >
> > I forgot to mention this earlier, but I think this is another case
> > where we don't need to add another Kconfig option.
>
> Right. What is your preferred way to control conditional inclusion of
> code spread out across several files?

Sorry for the delay.

Instead of talking about the mechanics of how to make the code
conditional, I would first like to have a discussion about if the code
should even be conditional, and if it is unconditional, do we need it?
 More on this below.

> My issue is that there already are two different symbols which require
> coordination to activate this functionality: DEBUG_HASHES defined and used
> locally within policydb.c and simple DEBUG which is needed for pr_debug()
> statements throughout the code.

My general thinking is that if the information is useful to a user to
manage and tune their system then we should include the code.  If the
information is only useful to kernel developers to play with different
designs or implementation then we can, and should, leave that code
out.  Developers are likely going to need to add their own
instrumentation anyway for testing, no sense in us cluttering up the
kernel for something that may never be useful to anyone.

> Personally, I prefer something global and controlled from a single well-known
> place, hence the Kconfig. However, I also see your point about reducing
> Kconfig... But if not Kconfig, then what? Should I just create an additional
> .h file with all SELinux-specific debug symbols and have it included
> everywhere in SELinux?
>
> How would you approach this?

I *think* the answers above should help, but if not let me know :)

--
paul moore
www.paul-moore.com
