Return-Path: <SRS0=zGJ6=5Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DFC2BA2B
	for <selinux@archiver.kernel.org>; Thu,  9 Apr 2020 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C721020A8B
	for <selinux@archiver.kernel.org>; Thu,  9 Apr 2020 13:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FEQHfFUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgDINlQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:41:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34829 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgDINlQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Apr 2020 09:41:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id c7so13339376edl.2
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2020 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZSFCF7UDOavR1ffftRWjBuvGSeOKrYbeFisnr7xCMc=;
        b=FEQHfFUTcfXYR1HuYsSITH5uAaeZkewtWC2I2z+HLk/9fZwceui5Uq7yxB1z/KFYm3
         ZpCWrXDJIVtXWx0vWLEEMrHTI4SBmnHmWyoTM6tFze/zKLhHJ+4iF/7nuk96pF7yoKq7
         ZrIBWy+lxHC13uRr5fGSRv84o1ed9iKRraRvJ/BcbgpsKp6LEip4mVrkyM3aohtKdUdH
         Hm30m2Krl4bOGp0j69AZAJUOKPZOYruNRpdvaQdsqqLvhXyW0a/LAbCqiGtRvZxWR8rs
         UG85bcPjzo/aN+rqF0krYkctOjGxQ2Hcd5KLV7TLGPUpq1kXr4yaP1/XD1ltYVRhzsrT
         NeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZSFCF7UDOavR1ffftRWjBuvGSeOKrYbeFisnr7xCMc=;
        b=ucDcUyl1K8VBp7UJ00HYZRbQEMnEkELwVzWXAs0Ey+yZOs0dCVPDYL7Wuufu9BiYOT
         pYn4zkEZ/sesr0JTfx8lH5gMKsxEjEB54IZc2go5Qe/qjFwDE79DHkWPEtDKUsJta29d
         K+Z6mE50czdqZM1jbdkndTG6DS3g6Et7fhkf2WRgZPWEEv88TcCsE49spOmjBnLuXtQ0
         NBJ4Vf2QQOeCcTRuatfdyzq7pUqTgLBSdEGe4qYSgtOkz5AYwSaOsg97eK7Oz43Sp7Hv
         5u7Sa3Ogfh1q0HEBxtlDEtOkVs8nlSkvtc7zb3wwUov7qYuJNV2s05KpZC1EroykPl2q
         pF2Q==
X-Gm-Message-State: AGi0PuaLb6uiyAG1m7mAeNi5DaNmiq2D1fwEgkkp//SN+djivARyTg6r
        H5xVQPg0paY6oYfUdWalj7fiy1TD1lP8aAGzTwCTnkE=
X-Google-Smtp-Source: APiQypJFACFrw6arr0gXQPpij3u548z4AG+HaobX8HkVXZ5C+r+S3lUWeaGnds2Gm0/0OrhWZ0vsoFNsWxzGcK/7rBw=
X-Received: by 2002:a17:906:583:: with SMTP id 3mr11207428ejn.308.1586439673718;
 Thu, 09 Apr 2020 06:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Apr 2020 09:41:02 -0400
Message-ID: <CAHC9VhRJ=b-dTVwgTE1TKezqY8KWoGFoHSU1XdfMNjP6uoHQFg@mail.gmail.com>
Subject: Re: [PATCH 0/9] SELinux: Improve hash functions and sizing of hash tables
To:     siarhei.liakh@concurrent-rt.com
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 8, 2020 at 2:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
> From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
>
> This patch set is the result of an actual customer support case where a client
> of ours observed unacceptable variability of timings while sending UDP packets
> via sendto() with SELinux enabled. The initial investigation centered around
> kernel 3.10.108 in CentOS 6.5 environment. Combination of these patches with
> some substantial tuning of newly added Kconfig options was able to reduce
> *maximum* sendto() latency to about 160us, down from well over 2ms. Worst
> latency was typically observed when a new SSH login was initiated concurrently
> with the test program running a sendto() loop, thus causing an AVC miss with a
> subsequent call to security_compute_av(), which would spend most of its time
> iterating through policydb within context_struct_compute_av().
>
> The original patch set was developed for linux kernel 3.10.108 and later ported
> to newer versions. The patch set presented here is based off Linus' tree as of
> April 7, 2020 and contains only a subset of the changes which are still relevant
> to 5.6+ as many of the issues had already been addressed in different ways.
>
> The patch set consists of 9 patches total and is meant to achieve two goals:
> 1. Replace most local copies of custom hash functions with generic hash
>    functions already available in inlude/linux/*.h.
>
> 2. Replace hard-coded hash table sizing parameters with Kconfig tunables.
>
> "Advanced Hashing" Kconfig option is the only dependency between the patches,
> but other than that and any combination of them can be used.

I haven't yet looked at these patches in detail, but a few quick thoughts:

* I would be very curious to see what the performance improvement is
on a current kernel build from either selinux/next or Linus' tree.
Performance numbers from an extremely old commercial distribution
aren't of much interest to mainline development.

* In general I'm a fan of reducing the number of Kconfig options
whenever possible in favor of the system auto-tuning based on usage
(e.g. the loaded policy).  Obviously this isn't possible in some
cases, but I worry that there is always a risk that if we expose a
build knob there is a risk it will be mis-configured.  My initial
reaction is that this patch set exposes way too many things as Kconfig
knobs.  As an aside, I also worry about runtime tunables, but to a
much lesser extent (the risk is less, the benefits greater, etc.).

* The AVC hash table improvement doesn't exactly look like a
sea-change, have you tried it on multiple policies and work loads?  I
wonder if the small improvement you saw changes on different workloads
and/or policies.

* In general I agree with your statement about using common code, e.g.
hash functions, to improve code quality, maintenance, etc. but the
hashing functions you are replacing are rather trivial and easily
maintained.  Not to mention their performance in the SELinux code is a
well known quantity at this point.

I'll take a closer look at these patches, likely next week after the
merge window closes, but in the meantime if you could provide some
more current performance numbers with a better explanation of the
workloads I think it would be helpful.

Thank you.

-- 
paul moore
www.paul-moore.com
