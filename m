Return-Path: <SRS0=gAxo=SG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C2BC4360F
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54E2075E
	for <selinux@archiver.kernel.org>; Thu,  4 Apr 2019 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="xtHnlRo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfDDTWn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:22:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42019 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDTWn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 15:22:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so3402940otd.9
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cDWLs8EdBAYsiJMiCXr49J9YLlxB5hddv4/46+FmZw=;
        b=xtHnlRo+Fna6gMTetm9xseP+xDkIWWOgkivkf3OiIFRm+DOii/J0odpVNYbPJjMTcr
         4JRHkgm/A1UNHhiejyqVGpafFHtJ3Tbdd9+6DKmcd21m3pV0xlK4WO9kaXmIQO4WoRcA
         DfCyEAi4xAyzCxHtIDWsuMVrllALRVJiSxT8WjnaMNIpit/D1huTbJKZK0ssxj7/2opC
         D2kHaT2iMDzxi8RYXG7IhAJQimvU2B2gbGMU1eOlk1sNJNfBelxzQpAWTRDf5ynJIkaH
         sD9B0i1T12H7f1tsvbJP2puW7hbuQubEIOaWkXmEE5mzETddnNtjnUv+4XXsdh+CvZaO
         ixMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cDWLs8EdBAYsiJMiCXr49J9YLlxB5hddv4/46+FmZw=;
        b=YQGDQ/8Gmz7dlsd8MoMTq0wvjFNyDQXOBM/3zXzjXvMRBndoPHp9K/Jka0o568dnwY
         kxoFs6lSiyvJsefr3VUR4rqhIlTpOAFzgr9cv3uZve2GNcwJXYaVJfCnvqfzAcn7nPk1
         qGrvlk1NmrSGRfgTyXwCPsxH9u74Qu78gC25RY2Be6rOHMsHbEgIjVc2lfOhWAL3G+bC
         L9SqPGB4GydbsqW46ChrjCOGKcofup45LqrWNhEbk6WgqFYci/RyslrNVSn+c91mBUkx
         6Tn1E4ghtzQyFlarZ5l8JlBDltLdHe6xLd4BpRs1EMFmXoDbY94YXKqsCY0U9K4S40S9
         PTTA==
X-Gm-Message-State: APjAAAUh8jHcmBHtZc89HsIS40ND6BF4oxqanOr9Pc/ivC5/lQp4IONJ
        k61cRgcvrZDN+EFmvlYWY8UuptiWdSox8f9rrq/pNBxw
X-Google-Smtp-Source: APXvYqxQ5o70+1X1JZSzd3VFIMYAzhLrsuw3/iu51KtP2W9STKaA59z36QQtvzI//L7mZmRZYlGBMbwiIDsqXT+iw+E=
X-Received: by 2002:a9d:2924:: with SMTP id d33mr5580930otb.63.1554405762616;
 Thu, 04 Apr 2019 12:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190404153654.32122-1-joshua.brindle@crunchydata.com> <CAFftDdr2QMec9S9RdYij7yaTLbMZ-74aOsjjYS6T9ROT0D1b6w@mail.gmail.com>
In-Reply-To: <CAFftDdr2QMec9S9RdYij7yaTLbMZ-74aOsjjYS6T9ROT0D1b6w@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 4 Apr 2019 15:22:32 -0400
Message-ID: <CAGB+Vh4CTzgcW7jLEtRhzFVOWKouZdjjnanc3Wdyd1WmVD5rxw@mail.gmail.com>
Subject: Re: [PATCH] Add security_validatetrans support
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 4, 2019 at 2:43 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Thu, Apr 4, 2019 at 8:37 AM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> >
> > It seems validatetrans support was never added to libselinux, despite being added to
> > selinuxfs in kernel version 4.5
> >
> > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > ---

>
> I see things like selinux_status_open() not doing it, also it doesn't
> use selinux_page_size but calls
> sysconf() directly, so that might not be the best example. I just
> wonder if we're glossing over truncation
> bugs that might be hard to debug if they ever crop up without explicit errors.

Hrm.. I started off with a copy of compute_relabel.c or something, it
looks like none of these functions check. Checking the snprintf for
the path is probably not helpful, but now that you mention it, a
truncation of the last context could remove some categories and cause
an erroneous decision, and since we don't get the answer back from the
file like the compute_ functions it could cause a vulnerability.

Thanks, will update and resend.
