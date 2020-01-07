Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4255C32771
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCAB2064C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 03:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GfpURyQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgAGD3n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:29:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42618 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgAGD3n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 22:29:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so37793062lfl.9
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2020 19:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U85TOD1CNefbRaDTXZubd4MkL5i5NuUFlBK6ll/AnWc=;
        b=GfpURyQmT+bUCkwAIw9dXowtPpHQs6uj7/2y69fI6x9FCZidUF4LWjfrCaE4Ju2IXd
         ZQ3HG9uEnv22Iucf+GVtJAXXOCHB18+pE14o1WaeHN/vXPn+cO9sfOIW6GaX1SnqgaV9
         o6G/sBhxB3cu7AxaQ2Dx+lfXZQCofCQJxZ5DMCUEghrY/onl3p3WorfMGtCkt8wpCBPc
         OsHNWE8usuxbb9Go/bCO4AvdTZ1eT8EoFLdkqsmUXV85ujOxEpViYTNnZN7usR55VsL4
         ac60zibqlUqA697lnAnoUnDoIp5cVSeUeFIJG5UcpFKhhG7iGKcCiehHDCkl/KLaFLHH
         NOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U85TOD1CNefbRaDTXZubd4MkL5i5NuUFlBK6ll/AnWc=;
        b=tntIz29kPA/l0t8IcnPsg60a0MfGnberPz0brcBEy1ORFiZaMHVQ0wUAaFiD3FwLup
         +DSBukUvbwhQaymasF8/lRZI78n+6HN6UPUjjRHaO6TJH/nkC6KmaWjEpy0kciQRJi4Q
         nX8OyWr8hlTvjViqlfSm/f8IPt8xP7QDrEPoeL/jB0puRuPQuS5ROiMBE9s39BVJO/gc
         8v2UKQqG9CYu5fVlKntWZ8mG+znPTs7ZQCP7btwdm7i/gFSjYX7Ge1HKS4YykFa6uFSc
         y2J0HzvhdYP2TLxEctKLwn0wcbazqOqX5OEuGFPnBBQjB0Z+9wTqsKMpScKhM+xT51wk
         aeXw==
X-Gm-Message-State: APjAAAWxqoUwFbSywRMZuMDn7Z4UtC2zAMGbYPb2LEvx8mXIn6iKcrSq
        4/nsThgUgCcDthJo49WS+gtrQp5+tzoYPD/sn36b
X-Google-Smtp-Source: APXvYqw09UmfesxJdAdZg1IEJDH2/HyATRUjtdoscI5S9pFrjsiJNdaa9NBXLcoemaYtPBlzhCvsqBH23o25NaFnh/w=
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr57395558lfk.175.1578367780380;
 Mon, 06 Jan 2020 19:29:40 -0800 (PST)
MIME-Version: 1.0
References: <157678334821.158235.2125894638773393579.stgit@chester> <a5794ae2-d1e3-4ad3-6a16-2d479f33da16@tycho.nsa.gov>
In-Reply-To: <a5794ae2-d1e3-4ad3-6a16-2d479f33da16@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 6 Jan 2020 22:29:29 -0500
Message-ID: <CAHC9VhSuutROagQEbCL=3PTUxGz9wnhoodB_hT_t-i-rWpof7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 6, 2020 at 4:25 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/19/19 2:22 PM, Paul Moore wrote:
> > Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> > code was originally developed to make it easier for Linux
> > distributions to support architectures where adding parameters to the
> > kernel command line was difficult.  Unfortunately, supporting runtime
> > disable meant we had to make some security trade-offs when it came to
> > the LSM hooks, as documented in the Kconfig help text:
> >
> >    NOTE: selecting this option will disable the '__ro_after_init'
> >    kernel hardening feature for security hooks.   Please consider
> >    using the selinux=0 boot parameter instead of enabling this
> >    option.
> >
> > Fortunately it looks as if that the original motivation for the
> > runtime disable functionality is gone, and Fedora/RHEL appears to be
> > the only major distribution enabling this capability at build time
> > so we are now taking steps to remove it entirely from the kernel.
> > The first step is to mark the functionality as deprecated and print
> > an error when it is used (what this patch is doing).  As Fedora/RHEL
> > makes progress in transitioning the distribution away from runtime
> > disable, we will introduce follow-up patches over several kernel
> > releases which will block for increasing periods of time when the
> > runtime disable is used.  Finally we will remove the option entirely
> > once we believe all users have moved to the kernel cmdline approach.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   security/selinux/Kconfig     |    3 +++
> >   security/selinux/selinuxfs.c |    6 ++++++
> >   2 files changed, 9 insertions(+)
> >
> > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > index 996d35d950f7..580ac24c7aa1 100644
> > --- a/security/selinux/Kconfig
> > +++ b/security/selinux/Kconfig
> > @@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
> >         using the selinux=0 boot parameter instead of enabling this
> >         option.
> >
> > +       WARNING: this option is deprecated and will be removed in a future
> > +       kernel release.
> > +
> >         If you are unsure how to answer this question, answer N.
> >
> >   config SECURITY_SELINUX_DEVELOP
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 278417e67b4c..adbe2dd35202 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
> >       int new_value;
> >       int enforcing;
> >
> > +     /* NOTE: we are now officially considering runtime disable as
> > +      *       deprecated, and using it will become increasingly painful
> > +      *       (e.g. sleeping/blocking) as we progress through future
> > +      *       kernel releases until eventually it is removed */
> > +     pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
>
> Looking for examples of similar deprecations in the kernel, I notice
> that they often use pr_warn_once() or WARN_ONCE() to avoid spamming the
> kernel logs excessively.  They also often include the current process
> name to identify the offending process.  In this case, it probably
> matters little since this is only done (legitimately) by the init
> process and only once, so up to you whether you bother amending it.

Yes, I saw that too and decided we were better off printing something
each time since it really should only ever happen once on a well
behaved system.

> Also for some interfaces, they appear to document the intent to remove
> it in a file under Documentation/ABI/obsolete/ and then later move that
> to removed/ when fully removed.

Thanks, I wasn't aware of that, and couldn't find anything relevant
while grep'ing under Documentation/process.  There used to be a
Documentation/feature-removal.txt (or a file with a similar name)
which tracked these things, but I guess it migrated over to
Documentation/ABI during the last Documentation shuffle a couple of
years ago.

I'll send out an updated patch in just a moment.

-- 
paul moore
www.paul-moore.com
