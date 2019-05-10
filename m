Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78242C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486442070D
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UoXbYZBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfEJQJp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 12:09:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41232 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfEJQJp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 12:09:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so4532492lfb.8
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwByoG+2KJJOu9bdBKneGBX0TAj7lOo2YxgtVuyszPo=;
        b=UoXbYZBkuEFgvhwcfj++EliekDW41YWhROKVd4Hr95y4JLgzHGzwV2YcwtGoG4Zh/X
         00dJWWSLVqK+jBsg91cY3A05CbY8K4l0ZSBATllQ0LySN/FncIFHr6F+syC5dcZczPn9
         wrb90jD56EKlueLws58iNabhIsmW9eKuHnQaKWqMv2anORrXUIEGU3vIiY6O64jLdrQ1
         jGQ3o08H5fIs9e8t6uB7eCr06ohEJVsSmzfRKanaenA2r0/JthPWl0pg4N1QsrhzZ0L1
         7eD78tj5+wq/gOJ9mxJXFD8f4bMykArTWfu2laon4bd/YMFy/FSVmLIucq6Nc4be2J8K
         1oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwByoG+2KJJOu9bdBKneGBX0TAj7lOo2YxgtVuyszPo=;
        b=b+On+LPEOq0QSFml75jpgkZUl5FUkJciBNdJuLshAATxZHkRMH3sU4TL8IeRhr6F4l
         NTL1zT3U9hjfG7LKGIHI14DVWxQW9Fc32R7n2f/DCoU1CdiX/okQTGMnpiUNVjJSlGUD
         bl8CzsadUHCBI6xdrP5wV5xpIOYVyn8ecmRRhiamdecHukN8k8XRvV7TamPju+3EpS2G
         1KkfI9uRng/nmXekMhMS7S64Iw+huFulzRQ3cOk6ksajJvKDRqZNuygUrdL6992+979f
         ZOlVTVZYYjHczf9Fcp0aluPOCmmhQ8/KhahV43+lqmhe1qj5mAtQh+eSfSJ1AAFcIOuK
         XbIw==
X-Gm-Message-State: APjAAAUsAomu6UWGyiWByNFmr9CGQaM47yt9he50aA0YqMLk0KOgm32I
        bqn4iASVSs8mVBdUC2F56AGfydoBGysoT04gBLHZ
X-Google-Smtp-Source: APXvYqyKTERw0+PxRgQXOLiMfzEfwKldnX8poOczfWrCh44svsKjDkxb8Zyan2L+O/gZddbc5pt25PX8om+my0qsc6o=
X-Received: by 2002:a19:6b0d:: with SMTP id d13mr6418415lfa.79.1557504583398;
 Fri, 10 May 2019 09:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <34870696b95f9cf48b5436df46e27dddd054858c.1557492319.git.pabeni@redhat.com>
 <CAHC9VhRCdSPB8LuFTtBjLqrZAc3h8UsDJPJnYnMZmU3x_zWkTQ@mail.gmail.com> <8edfb95424cdf4bac06adbeb6b4204e5cc86f643.camel@redhat.com>
In-Reply-To: <8edfb95424cdf4bac06adbeb6b4204e5cc86f643.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 May 2019 12:09:31 -0400
Message-ID: <CAHC9VhQ3acCnoQP=eoERg64gyDo56xJ5dnPrkg20d8cdVuz2AQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: do not report error on connect(AF_UNSPEC)
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     selinux@vger.kernel.org, Tom Deseyn <tdeseyn@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 11:52 AM Paolo Abeni <pabeni@redhat.com> wrote:
> On Fri, 2019-05-10 at 11:32 -0400, Paul Moore wrote:
> > On Fri, May 10, 2019 at 9:49 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > calling connect(AF_UNSPEC) on an already connected TCP socket is an
> > > established way to disconnect() such socket. After commit 68741a8adab9
> > > ("selinux: Fix ltp test connect-syscall failure") it no longer works
> > > and, in the above scenario connect() fails with EAFNOSUPPORT.
> > >
> > > Fix the above skipping the checks when the address family is not
> > > AF_INET{4,6} - we don't have any port to validate, but leave the
> > > SCTP code path untouched, as it has specific constraints.
> > >
> > > Fixes: 68741a8adab9 ("selinux: Fix ltp test connect-syscall failure")
> > > Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > >  - avoid validation for AF_UNSPEC
> > > ---
> > >  security/selinux/hooks.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > What was wrong with explicitly checking for AF_UNSPEC as I mentioned
> > in my last email?
>
> Whoops sorry, I missed a relevant part of that email.
>
> Reading it now.
>
> To me, the 2 options look quite similar, and I have a slighter
> preference for this one, being a smaller change possibly more suited to
> a stable fix.
>
> But if you have strong different opinions I can post the code you
> suggested. I don't see any performance related issue with that.

My thinking is that this patch affects address families other than
AF_UNSPEC, whereas the fix I suggested only affects AF_UNSPEC.  Given
the compatibility problems we have had with this code recently, I
would prefer what I suggested since it has the least impact to
userspace.  It also has the benefit of solving AF_UNSPEC regardless of
the SELinux socket class and moving the addrlen check higher up the
function; these things alone aren't really a big deal, but they are
nice side effects.

-- 
paul moore
www.paul-moore.com
