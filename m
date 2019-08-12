Return-Path: <SRS0=1Vb5=WI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F8CC433FF
	for <selinux@archiver.kernel.org>; Mon, 12 Aug 2019 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119562067D
	for <selinux@archiver.kernel.org>; Mon, 12 Aug 2019 22:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OSj9mCXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfHLWey (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:34:54 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:45900 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLWey (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Aug 2019 18:34:54 -0400
Received: by mail-lj1-f177.google.com with SMTP id t3so11209627ljj.12
        for <selinux@vger.kernel.org>; Mon, 12 Aug 2019 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwahwQ+A0k7oIZYFs+9cz0bHKwTBYpfIxr1bi+4lplw=;
        b=OSj9mCXuL/81B4jQR3/dX3OQeuyxiHaILYWkxjZl3Vg3q2UfSX+eQ35XXTfdxX71il
         gT3lGRMj/dvSo2FXLCLck1h8PqIjG7Ol1WBympPn3W/dS41rXabZbfhD4l392+EXJ9jq
         nUCKLAZ/MaY+72ZSeEoGdwdlrIzpTxHwmfV5k7dRZOwGRT8PRoi0U8itVnP1FC9ZDsrH
         s0ojupno2qTVEfIZlAhE1gM1BiqC2wVLAAOuY2p1dY2iLssImEXcf725xvTbaWj261L+
         J2cIqEmYKgp7HmXQnFePkEm0NqxruYTNpf/Gc561TWFUz+plgkHC2tj7NSQ50ms2msh3
         6i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwahwQ+A0k7oIZYFs+9cz0bHKwTBYpfIxr1bi+4lplw=;
        b=hNr6QeMuw4/qOZgO2HVl7N+h3YgrRV8cDSM+Rd2MCcZIdMb3at60PzyBGtSCXzu/Jq
         9k/amAdiaEtClwGrq7sCOlhDaFs4hjRGHsfkAowXIUlIyGbj6KQt+hbercIGW29B2/90
         4Nc6x6h9+JFUz6yWXr7M3S6lL8jMlTYwspNs+aDVSKf6q9SWz4+Qidi0eRejKg5hwEXp
         2nRus1LwkFM4cszPdyn76uCBaizWZZiTta2TpUOxDJ9ZSNMXgohThvAWVqL+q9GSf4qm
         u61CNsXFwj6XX3pUmI0TwrPLorBMOgIKRvuSkXpdAPkHCvRyQyCLfod+8eBbFF/wZyyO
         24+A==
X-Gm-Message-State: APjAAAXF1DnluCXAqBxGfMaYZJwv1pht9gCpQNlihysc27rX60iJ/QMQ
        7VjqhWb+aE1Va1Pk2qYsb+23NwlLCE8iRMythEpT
X-Google-Smtp-Source: APXvYqzvDRUd81my768AnKszIg4BpE9jIkkFdb5CSEHRJpzBcIduiNVLBos9iEolB3Wtdu+IG0FclYXTAqGNra8//K4=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr7551013ljj.0.1565649292230;
 Mon, 12 Aug 2019 15:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111212.5536-1-richard_c_haines@btinternet.com>
 <CAHC9VhQzWUDuGdsDQ9VDrSbm6VvGGYoOz-dq3BVz_dE860WK3Q@mail.gmail.com> <28c7002e0482babaad5a56ea8ceeb26c11706364.camel@btinternet.com>
In-Reply-To: <28c7002e0482babaad5a56ea8ceeb26c11706364.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Aug 2019 18:34:41 -0400
Message-ID: <CAHC9VhQG9K5Vf7njcZwefgLKhsBL_1xrGeJmGG7LBTa-wYPV4w@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] selinux-testsuite: Add BPF tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 9, 2019 at 12:51 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2019-08-09 at 11:27 -0400, Paul Moore wrote:
> > On Thu, Aug 1, 2019 at 7:22 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > Patch 1 Runs basic checks for BPF with map_create, map_read,
> > > map_write,
> > > prog_load and prog_run permissions.
> > >
> > > Patch 2 Updates fdreceive to test BPF security_file_receive() path
> > > using
> > > the common BPF code in tests/bpf.
> > >
> > > If these are okay, I'll do the binder BPF tests for the
> > > security_binder_transfer_file() path.
>
> I've done the binder tests but will not send until you are full of
> happiness and light with these.

Several people have suggested I am full of various things, but oddly
enough no one has ever mentioned happiness and light ;)

> > Patch 1/2 seems to run fine on my test system, but I'm hitting some
> > errors with patch 2/2 ... although they appear to be gone now that I
> > run the test again to paste the error into my email :/
>
> Remember if running 2/2 locally after reboot, then need to set:
> setsebool allow_domain_fd_use=0

Playing with this some more I believe the problem I had last week was
due to not installing the necessary dependencies before building the
tests; let's attribute that to user error for the moment and move on.
We can revisit it if it keeps happening, but it looks to be okay now.

-- 
paul moore
www.paul-moore.com
