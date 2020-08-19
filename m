Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B4CC433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2980B206DA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIkvgLD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgHSMt0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgHSMtW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 08:49:22 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF93C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:49:22 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v13so20845525oiv.13
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvPbGLQ+EEqeS0Y4e1ppQ3ERAm0uOtXfH5K+jKT7Ypc=;
        b=BIkvgLD7Egi1TKQmoKdaSKy4m0NJSJSul4+5GCp1lX0Y2x2mUMXa0tsC+yAu3jO5nH
         2ewmpVH/SA0ZIXmlsMmf4Vu29ZCWQ90P/jl72tymEX5x+1UJDrwdjuXBMDLOP1DruppR
         QZmcm64gubvST+cBSsT0eEcQw63nVux5hARuNtN34GmWwJlF0BZyCuBPbKdneqrcXZGP
         Qa+6qfJW+PSq8KxWQnwyMIWmo7Num95OfTOqhfC2Eo/kwmPe+01PGuFq58CEcDNlPQQW
         nSLed8JPjBMkksP2GIYp6yECXw9kXupO4lDhTVdALhdPHSIaJ1gryrsAXj55fAQc3PeG
         twGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvPbGLQ+EEqeS0Y4e1ppQ3ERAm0uOtXfH5K+jKT7Ypc=;
        b=HjShpr7UHYUMtqOkAnBDzQ30OpOIAg3ae321yZfKGsInqSsrMCuOU/BBttar1aq/9V
         lAw4H+tPHoJhnWagH/YQzB8C4Kbyl/ep1O6cx6a7HLgNMSENrPjIgcYPqPIUbwd50Qrf
         iY4V7wrmEOH3MhvM/Lvv9TS5VBNt3vfWF++bZ+8opcm+Q+SDRMuZ4nSBK10tmnarcz8k
         lnvCLghFTTyUSalTuGowyLYk2IiSEz9Kqw3BAMxZBM8C8m/vT9InCmmcjVn+a2/sakwR
         BB8/edxnmxmrJH0l6j/pLIoEZu9ix919USroiGPfFE57c02HAHIfaD/hM97yBXV8zGUj
         y+hA==
X-Gm-Message-State: AOAM5330XCts3+q2XcoKbvu8ug9uZRl4lCyiS14qB6fZ2bZAPVXTtDzU
        0vou9ge+tsyuuiveVUNYkbv+pIeEOOMISK4G9AAPxSVSiGo=
X-Google-Smtp-Source: ABdhPJweOvkwSZf9qdA6R/aw3K86BPynPubULx+VqJUfOJYrVz9Kj/AgaxbPOylFYgMNMGzU3MZ1GYgfDrn/L15pCbQ=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr2962293oic.92.1597841360892;
 Wed, 19 Aug 2020 05:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200818181120.GA748671@imp.flyn.org> <20200818203731.GA1490393@imp.flyn.org>
In-Reply-To: <20200818203731.GA1490393@imp.flyn.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 19 Aug 2020 08:49:10 -0400
Message-ID: <CAEjxPJ6iBSu8Ts29yJVJH5rKNY0Qf1toTPLBk7_oN=F8MaEO6A@mail.gmail.com>
Subject: Re: Working to enable SELinux on OpenWrt
To:     "W. Michael Petullo" <mike@flyn.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 4:38 PM W. Michael Petullo <mike@flyn.org> wrote:
>
> > I am working with Thomas Petazzoni and the OpenWrt community to add
> > SELinux support to OpenWrt. OpenWrt is a Linux distribution tailored
> > for running routers and similar devices.
> >
> >       https://github.com/openwrt/openwrt/pull/3207
> >       https://github.com/openwrt/packages/pull/10664
> >
> > I am interested in enabling KERNEL_SECURITY_SELINUX_DEVELOP, which I
> > believe to be necessary if I am to enable and disable SELinux enforcement
> > at runtime. However, it seems that enabling this option in the kernel
> > causes the system to hang:
> >
> > [...]
> > [    1.668419] sd 0:0:0:0: [sda] Attached SCSI disk
> > [    1.675189] Waiting for root device PARTUUID=4ba37c2a-02...
> > [    2.100751] tsc: Refined TSC clocksource calibration: 1995.376 MHz
> > [    2.113719] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x39863c423f0, max_idle_ns: 881590675958 ns
> > [    2.122334] clocksource: Switched to clocksource tsc
> >
> > It is not clear to me whether the kernel or the init process is
> > hanging. Things boot fine when KERNEL_SECURITY_SELINUX_DEVELOP=n.
> >
> > I have tried a number of kernel command line parameters, thinking perhaps
> > SELinux is preventing the use of the console. This has not yet helped.
> >
> > The OpenWrt init is available at:
> >
> >       https://git.openwrt.org/?p=project/procd.git,
> >
> > and it now includes a commit from Thomas that calls
> > selinux_init_load_policy().
> >
> > Does anyone have any idea what might be causing this hang? Is there
> > a user-space requirement to finish the boot process when
> > KERNEL_SECURITY_SELINUX_DEVELOP=y?
> >
> > I would also very much appreciate any comments on the two GitHub merge
> > requests above. I think OpenWrt would provide a compelling use case for
> > SELinux, and thus I (along with Thomas) have invested a fair amount of
> > time trying to get this accepted by the OpenWrt team.
>
> Looks like my problem had to do with mangling grub.cfg. Things are
> working nicely now.

Great, thanks for working on this.  I agree that OpenWrt could be a
compelling use case for SELinux.  In the case of Android, we started
from scratch to create a policy tailored to its userspace and security
goals.  Have you considered doing the same for OpenWrt or are you just
trying to use refpolicy?
