Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE66CC48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2C61376
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFKBzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:55:20 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:38554 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFKBzS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 21:55:18 -0400
Received: by mail-ed1-f43.google.com with SMTP id d13so21769675edt.5
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvuDUFDcURZXNWhoPJKU/iTLatNhfdC842nxtPVgWZI=;
        b=NLa/HKY2FZXTJcBlZya/0cJtUeTxAckzBcz8Chq25eln4wHj4GSVjckYSslmyMp4w1
         kfFfCslK80zYiGfv7YMPZB48UTrZn5sfDMTF2Q6ei5ypR+HnhJ4fQ4fjSEB2MbRG9XFn
         UtLtT4MheRwoMhcwQ0VSt1wVFOzxm1dIB82xqfdGZDNGviNmhOHrXQzxyB5sgZeT1Ern
         SuqrWDjJtKU44eE/UaDQfpgc+GS4VPpTvdTEirLb458vl/Ev5I0k+7bKFb/5O78e2JzU
         wyNNvGk38wpDJnEQfPWPa5RbFXeNzdeEo0NhgNnq0RSGa44wmKh42gaGlc4/3SComD09
         pBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvuDUFDcURZXNWhoPJKU/iTLatNhfdC842nxtPVgWZI=;
        b=uO/zuksae27ub/dh81foRo/FUg4avi7ujVCaptjsRHzSSNx+imrlxwb7B1e5I9hs2X
         5rUmyYrUnv/OZJCbdSyG4JgsD7D0d6iOahbSbFjpKR5s4O6M/VBwcRYFAMltyyk2rLKy
         /Rozdhp38CGhZQ+AR8M5p5YWdyE2wattyd2EbeV8wBifFPrSMA9fuIAmex8GJecdWHFQ
         D2Gq17QKMpCpk0RKqR3g3oLn7j7jdDXxg8eXR2gWXXHCvwghE1L06IMroi1zI166rBTP
         0DpcRHDurgIFNxHSOscIOY8Wj+X9Sb2jXuIV1IXHgnBuRxJLOGZGuiO+GbGLcPO2tsKF
         X5OQ==
X-Gm-Message-State: AOAM531ce/eqczFCLpPTTMo3WynIxZwZ+cYR+n5HHeV+OUx6ueN7IxfR
        3g151skfve97gFRFMc95mBMioz0AyBSXo/N7UOAP0hqOhQ==
X-Google-Smtp-Source: ABdhPJyJpSFUvTfGwQ3UXjBDYDhlcBWbPvNy5bGcv7IXyOdDVSIPa26n4Ihnr9xtaR8cCa9aGUX0eW9ecIRX4J0R6IE=
X-Received: by 2002:a05:6402:348f:: with SMTP id v15mr1196639edc.135.1623376324239;
 Thu, 10 Jun 2021 18:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <YMI08apUwu1Y7Tc5@zeniv-ca.linux.org.uk> <CAHC9VhSo5wPdqyZ2i9rWgZJhRCw3jv7aNuUFZBwJysFpAW7Drg@mail.gmail.com>
 <YMLAHTAtjdgcvOl4@zeniv-ca.linux.org.uk>
In-Reply-To: <YMLAHTAtjdgcvOl4@zeniv-ca.linux.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 21:51:53 -0400
Message-ID: <CAHC9VhQuUA5hgv3ELwDReSe-43rtng8phBDuYoB4+8bJqtxqSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 9:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Jun 10, 2021 at 07:12:15PM -0400, Paul Moore wrote:
> > On Thu, Jun 10, 2021 at 11:51 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > [followup to dump_common_audit_data() changes from this winter; in vfs.git#work.audit]
> > > Does anybody have objections to the below?
> > >
> > > From 663a40ab49308b5acaba8a335190fce66e17d969 Mon Sep 17 00:00:00 2001
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > Date: Sat, 16 Jan 2021 15:40:54 -0500
> > > Subject: [PATCH 1/2] selinux: slow_avc_audit has become non-blocking
> > >
> > > dump_common_audit_data() is safe to use under rcu_read_lock() now;
> > > no need for AVC_NONBLOCKING and games around it
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  security/selinux/avc.c         | 28 ++++++++--------------------
> > >  security/selinux/hooks.c       | 13 ++-----------
> > >  security/selinux/include/avc.h |  4 ----
> > >  3 files changed, 10 insertions(+), 35 deletions(-)
> >
> > This looks okay to me, thanks Al.  If you want to fix patch 2/2 I can
> > pull both into selinux/next.
>
> Done and force-pushed into the same branch...  Do you want a formal pull request?

Thanks for the offer, but I can just pull those top two patches from
work.audit.  However, this mail came in just as I was shutting down
for the evening so I'll take care of it tomorrow.

-- 
paul moore
www.paul-moore.com
