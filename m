Return-Path: <SRS0=mDct=7F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C0BC433E0
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF33206B6
	for <selinux@archiver.kernel.org>; Sat, 23 May 2020 00:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHio+Inr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgEWAV5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 20:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWAV5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 20:21:57 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB2CC061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 17:21:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h10so13369386iob.10
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 17:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCx0FfqetixWif5qk7qrFMHW45bSSNTvuLkoMOeZI5Q=;
        b=lHio+InrOM2Ja1zkpAMKd/iWlepSCmQZNUtUFaQdyaGzqAHm7UfEnmvx3d5RhZuFAN
         0L9p8Vln6l0+1PLzgo1bL9BGLWJMn/vq1FeIjpkNTrKyGDPvodLRUUgiZaZ+QjfFbK7a
         s7iUnruQZxROpGq+GC6v1xTK7PsVsFIvje95MLEWuS4wPbYl5ame1A4/pXdq2VJmydY+
         ZMv4a/3JKL3Q3mEXu061PE6vGCSNuvugH9GEThEjn+5cEL+A0CdahGqtamWW1B7YZd86
         J8fSZ8ig2DbGcEChLPka4ii2fuUDej3n4sWGSh26fs4pb6zGUTMTFn36aOE0500rk9Ix
         VpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCx0FfqetixWif5qk7qrFMHW45bSSNTvuLkoMOeZI5Q=;
        b=Z0Co+Q0uvwuq635PIaXbukDLSEwDbHy5TQqzLsEiSoktq40y7IdfarKn0/q4pVj0c5
         sojs3sr6TbrmrXGKN7XLhNocBR/JdTIXN1iZiXfYSY5CrexZN+cB0GE3Iw1DXa3wz0PV
         ZU2cKeA/WEh5RzHtaoHGoa0TMy/LINivg9OXWSZYeb/BN0lpMCeU2B0DQpSkFoztV1y8
         VmMSQj81aiEuhokN+3m2flftcsKeq6O305t0vZmJNhmFAQffRfVTUA7cUyebPcFy4Yv+
         tqBsZe6oJeecCJvfV2+/8UI7Upj32sWM00RlRaBB0GnLQvkje1qjgxgRJOJdXv9Vix78
         d3aQ==
X-Gm-Message-State: AOAM531bVsNO00hhdOxG7YoApng5H16zKJdwRf3hLnC4v2w1HN2nLTeI
        G53aPeIS1rtCl9a5h1SgSCYP4mYpQFlUIaOC1u8lT77B
X-Google-Smtp-Source: ABdhPJzFHw+eMqMifeCRropaAH3wkck35zhKRvcOjqg1adky0vd+PolRr5KYXzHg6ct6CEKpwIoqKJ0iWigtWO//DMg=
X-Received: by 2002:a02:cce6:: with SMTP id l6mr10803920jaq.116.1590193316247;
 Fri, 22 May 2020 17:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAJfZ7==gpPvF5eKJLFK=ky=UEXtbnX-r6WyB1zh6NfvRFHEHtA@mail.gmail.com>
 <CAFftDdpDpAw6W0d6OaCcaWYSO6g_zguO-D8u+fLYAW45nyGukA@mail.gmail.com> <CAJfZ7=mEC4hHT8AdPGhO7RoX+DUrO2y+7g_3OX-W2y09+uKKMA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mEC4hHT8AdPGhO7RoX+DUrO2y+7g_3OX-W2y09+uKKMA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 22 May 2020 19:21:45 -0500
Message-ID: <CAFftDdpT=G68hCAqmMLMufOGe_9oDJQmUPhoWXYoVzNqzMk3nw@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 2:07 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, May 22, 2020 at 12:39 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > <snip>
> > > * fedora-test-runner.sh uses ~, which is expanded to /root as it does
> > > not make sense to run this script as non-root user. In my humble
> > > opinion, using /root instead of ~ makes the script even easier to
> > > read.
> >
> > I forgot to mention this in my previous email, this is the only thing
> > I really don't
> > want to change. You could, in theory, configure any user to run this.
> >
> > <snip>
>
> The script executes "setenforce 0", runs dnf to install packages and
> overwrites binaries and libraries in system directories (/usr/bin,
> /usr/sbin, /usr/lib64, etc.). How do you allow any user to perform
> these actions, without being root?

Its called capabilities. I could build you a box where root is neutered and
cannot do anything.

>
> Anyway, if you do not want to hardcode /root, to could use "$HOME"
> instead of ~. It makes things appear less magical, in my humble
> opinion.

Sure, it actually makes it consistent with the other script.

>
> Nicolas
>
