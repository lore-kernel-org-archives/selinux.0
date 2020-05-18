Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA51EC433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78568207C4
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 18:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="TDhJZa7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgERS6y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgERS6x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 14:58:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E70C061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 11:58:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so9022457qts.9
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rr5CptuJkdKm38++X4o+xh4WcMePWri182jsEvDM/04=;
        b=TDhJZa7DcuAc9vDPDkyYUc3tTqOyWCU5hD0KyMMgoRIvLMCVm830Y/QuVDNyV0V0x+
         MkyINIz1ZsocxwGtABsLNXsP0VGJc5mVga8RvwcYVhiVMED0orbwcluHrEapEiDsPiXx
         +fEA7tmKSDpetWaIMiXTK5yom3SQrUGlm4qNqK7Fc00wZJgxjmvz2bqxc3hPo81dZL0t
         IIVUWzbjBthiLmumrXAr1zRxURKy9KLCqkSCzANQValxzTuOTau2+0VM5VuyNb6SsP4w
         58J1+cCt2DXWLGQqrAxbCANkB8IQTSUTq9Pc3Odr9GN2jWfh1nfpqFgmrhKnhT6TV5lS
         PJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rr5CptuJkdKm38++X4o+xh4WcMePWri182jsEvDM/04=;
        b=I6G2bJ4ly6/kIXyApZCO2lIw+ARjiTmgAjyIe2p9wXiFquQ+ZK3XGXUPqKz3sCcTuJ
         OwFBpk3higbPhdLyTdmTC7LrlLYudsLlzs2X+OHKcghUy6SZt6IVQn1L/XjKzS2I9Gf0
         ItQHU6Cdp1ySL6WO1TMuSJg3OA7a7doogBocjoEGy1hfhkjMQSLcd34AUAgWZcAYV3/L
         IJi6vLp9euOxVnpj7W5dVG7allvLV+RzMmK4K157QYJtRdjJSW9ZgL4a9kxBT7w5zyJl
         owIWXDPLD68xVSmNkuzHVebLE8irOZRpiwTSBxDB1i0U/ehst9yFm/65R48GByNG7cZ7
         vT4w==
X-Gm-Message-State: AOAM533DRyALEP0jMJZenHZNqs7oe9CebJC7Xs2yhZb7I9n6kFn62uLn
        U0ToE8P60syaPGq8+IYEQYeAKRypPVB2XVJ2v5TAk2HShE0=
X-Google-Smtp-Source: ABdhPJwJda1F2W202s89dJGDHZhVZKunf64s5QzOK0DaFL4IJ5fj9qphuTE11Xv0Ff2ijBdXCDtK2nOQYbfzbkPg3pg=
X-Received: by 2002:ac8:f4f:: with SMTP id l15mr10837658qtk.86.1589828332712;
 Mon, 18 May 2020 11:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeouKHKm+Bzk6=gX_GEJc=faTB8tzwQ7txKVEhdbzK1sf-Z1A@mail.gmail.com>
 <CAEjxPJ5_4z+O6fthtjLFLncR0Q2ETdfhcdtqOGj8eBSZ5sBt=Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5_4z+O6fthtjLFLncR0Q2ETdfhcdtqOGj8eBSZ5sBt=Q@mail.gmail.com>
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Mon, 18 May 2020 14:58:26 -0400
Message-ID: <CAGeouKHcCZoCQbb3x=uOBh5_TxduzV2P1V1tOT-6fzXTa=fAnA@mail.gmail.com>
Subject: Re: [PATCH] Add restorecon -x to not cross FS boundaries
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks, Stephen, I will give that a shot. Don't use an email client
generally, good to have the instructions.

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP


Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP



On Mon, May 18, 2020 at 11:20 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 4:09 PM Peter Whittaker <pww@edgekeep.com> wrote:
> >
> > Folks, the following patch adds a -x option to restorecon to prevent
> > it from crossing filesystem boundaries, as requested in
> > https://github.com/SELinuxProject/selinux/issues/208.
> >
> > As per Stephen Smalley's suggestion, this is accomplished using
> > r_opts.xdev = SELINUX_RESTORECON_XDEV;
> >
> > Please do let me know if there are any errors in this, it's been over
> > two decades since I've lurked in majordomo lists and about as long
> > since I've contributed a patch via email. (In particular, I am having
> > issues with sending plaintext, so spaces in the patch are munged; any
> > pointers on correcting than in the gmail web client would be more than
> > welcome.)
>
> Send your patch via git send-email instead.  You can have it send via
> gmail's smtp server as per the documentation
> (https://git-scm.com/docs/git-send-email).  Alternatively use a mail
> client that is known to work,
> https://www.kernel.org/doc/html/latest/process/email-clients.html.
