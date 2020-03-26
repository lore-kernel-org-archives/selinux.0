Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D8AC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20061208E0
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="ic/CKU7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCZQFi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:05:38 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:43341 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZQFi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:05:38 -0400
Received: by mail-io1-f41.google.com with SMTP id x9so181229iom.10
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=do5nlNQ7IVcwfV7IOQLQUD04KBEaue0q53A614X9wpA=;
        b=ic/CKU7OTrbvd+5B9K7T4XPmilmqLHF4IdRXXALIuG7XGUZb6mDsi1wPp3WYnbGzF2
         kFGKFec+KbXyu+qgRugEJ+fzLdBgFx/zduEZGLv1TrnoV33RX51KgZhnnKKqwHVwvYBQ
         RrUV4iviQynEEkxp97gP7w1w407sHfxg19HQWoJajW4bpMj4sLjgep6XZXMVfm6eCLpY
         nZHVRkpl8WU51xqNwXWjhpKIoAABGsteI7RJK1JlABp+eVRjuvLtyKZI12UpnAOAKI+Y
         KyttmTS17oseWnKul52JR4qSYry3Ya+E8Ax7TZBuTnGyPw7DrNSEa8TggEdM2M2zSkeN
         knnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=do5nlNQ7IVcwfV7IOQLQUD04KBEaue0q53A614X9wpA=;
        b=A4IzHw8bAOQABbLdNBLyd+rNYCSvQL7bTwCGGnUBr85SCkvCSPo2tndSuH1kRxDMvY
         rBay2RRPFVy2b5SO8n7Jk6WGNZsn+HI4hObu8So9u+6wr/9F2Pm0K/ETEwC3HikYy7iq
         kR+bfBvnK07IOzSEmdNS81+VPrl+fsfmyfR0f7PPB9HGQ2U2nWvyg1eduUNGGrrFDu9y
         25FcEzg1mTUR9XtefUivXevPuiBu4cHa/OdXLJzySJlWSel5rY/s+jqsFLtv0O9HPZAn
         2N/RvclR6XxWaOOKh4nKcwXUFEA9DVspuRtn0p9DwP7fabO38DutUJ4lX6804btCOpAI
         ooiA==
X-Gm-Message-State: ANhLgQ0HbXtZp4ilPwmRL639Hl+vQM57a4Z3TlRKUJwMdB7YSOhNaT8d
        L5LWevjQ7CwvGbvtQB9h3vGuXXJ93d8msW3QayD8sw==
X-Google-Smtp-Source: ADFU+vsrsnm8vOJdold84UN4Vxs2NOIvtgSYhNinmaC+4VocJJ2HOE84FKKN2skPIPK7aiDbrOBVv41va+UGP6qM8AU=
X-Received: by 2002:a05:6602:2242:: with SMTP id o2mr8449861ioo.22.1585238735676;
 Thu, 26 Mar 2020 09:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
 <20200326154641.7253-1-william.c.roberts@intel.com> <CAFftDdp8Us2aSmAD5Q+MR3y6WvR2QAbC+_tFGmCwZbWh+0CBTA@mail.gmail.com>
In-Reply-To: <CAFftDdp8Us2aSmAD5Q+MR3y6WvR2QAbC+_tFGmCwZbWh+0CBTA@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 26 Mar 2020 12:05:24 -0400
Message-ID: <CAGB+Vh5P-VKru1-ztYRBe4sr7OdeOpAzATGEBHkj6Q6i6s3mYw@mail.gmail.com>
Subject: Re: cil: Fix DISABLE_SYMVER support and drop last dso.h
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:48 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Josh can you run this on Mac build, I don't have one anymore.
>

LGTM

Acked-by: Joshua Brindle <joshua.brindle@crunchydata.com>


> On Thu, Mar 26, 2020 at 10:46 AM <bill.c.roberts@gmail.com> wrote:
> >
> > I missed a dso.h file in cil code, and broke the DISABLE_SYMVER support.
> > this deletes that file and restores DISABLE_SYMVER support.
> >
> > Sorry...
> >
> > [PATCH 1/2] cil: rm dead dso.h file
> > [PATCH 2/2] cil: re-enable DISABLE_SYMVER define
> >
