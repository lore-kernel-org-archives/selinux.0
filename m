Return-Path: <SRS0=5WGn=SH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6ABC4360F
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 00:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A951217D4
	for <selinux@archiver.kernel.org>; Fri,  5 Apr 2019 00:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="VmoK3Dln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDEAR7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:17:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42228 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDEAR7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Apr 2019 20:17:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so4056397otd.9
        for <selinux@vger.kernel.org>; Thu, 04 Apr 2019 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZwGfzpyOb6fAeZYu7fKZZLGBJpk7e3tAasoimiAbpo=;
        b=VmoK3Dln6gMb8AkDZCYaFR8TEBGbxm8FX5iLAD+DJd0+f/wr/OQT3cwpmWFviNOCAg
         J2IGrgD6B24b3sqw3VwFw6GJ+XR4bMbGMwt5n/JT1eu7vdDJkG9RZvafhwHWfrT2tiHX
         gbGzKVU4toMoxztHy9BbCYvG2DEv7VnRwQZTIf4bI5DQqjlngxz1zy55M8PP4S8r0EE4
         ex+pEkfAC9iNIR2soApNVXFpRpJeKpVod65wvLAKIqW27GHuyJJR14gOeZOmpYvJQZ8y
         Uqvw5L/plPESVn3HfW2b03XX1NRTYRlWAYDDrT/eTMBp4eckVlqmlhXf3yVslD1/gsdQ
         e/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZwGfzpyOb6fAeZYu7fKZZLGBJpk7e3tAasoimiAbpo=;
        b=S3etMgtRRYTfs8sXtFQp4nk7GWDyhC977n0xSaQStrGpQdga573wD2jRHSKuljFC79
         +zY9uHwhB49qHlhuvDejtkOinucIAgZ/kouV4jqjns6ZW1n+YeQ7t/3WIQtrKiCFYs7i
         TCIrJ4949UO8q+/LGmgESP7s9WXPgM4Yr4b4iCoeDcVXT9I5HX3Vn3MYWAoPy3+wbAzC
         svE5eouWWuBvrHnsm+lBKMCdpZm+myC037eihvq9vLcmKNqSY6GYK+B+XZ7pTM6x0XJC
         AL14+m2CvHARRSK8JgAyHUCxow+aDX/MxRaS6HcycztfirWI6tRuZPlMexb11VDHBMpx
         haeg==
X-Gm-Message-State: APjAAAVhAQ5LFqU4Vcz+LK47EEz96R3vePYo6aqwzxAhFD9B4YeWwlpe
        X+zgC7eo8BeNXBPt1GXMlMNu13V1+T+29HjReZubpg==
X-Google-Smtp-Source: APXvYqwaWKrgwvCNGPv1lzZ9dqkZwlShCQKe3aJZYIdSEssaHkmv1u8Nx7+Yzo4sWqb6ZgNCYzgwlI0JOyTWKIR0i1U=
X-Received: by 2002:a9d:2924:: with SMTP id d33mr6499751otb.63.1554423478994;
 Thu, 04 Apr 2019 17:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190404153654.32122-1-joshua.brindle@crunchydata.com>
 <CAFftDdr2QMec9S9RdYij7yaTLbMZ-74aOsjjYS6T9ROT0D1b6w@mail.gmail.com> <CAGB+Vh4CTzgcW7jLEtRhzFVOWKouZdjjnanc3Wdyd1WmVD5rxw@mail.gmail.com>
In-Reply-To: <CAGB+Vh4CTzgcW7jLEtRhzFVOWKouZdjjnanc3Wdyd1WmVD5rxw@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 4 Apr 2019 20:17:48 -0400
Message-ID: <CAGB+Vh5n3_+MvL_8XAvAV+L8cX_gO26yEp3ZJyzhhLURwXqV7A@mail.gmail.com>
Subject: Re: [PATCH] Add security_validatetrans support
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 4, 2019 at 3:22 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Thu, Apr 4, 2019 at 2:43 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Apr 4, 2019 at 8:37 AM Joshua Brindle
> > <joshua.brindle@crunchydata.com> wrote:
> > >
> > > It seems validatetrans support was never added to libselinux, despite being added to
> > > selinuxfs in kernel version 4.5
> > >
> > > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > > ---
>
> >
> > I see things like selinux_status_open() not doing it, also it doesn't
> > use selinux_page_size but calls
> > sysconf() directly, so that might not be the best example. I just
> > wonder if we're glossing over truncation
> > bugs that might be hard to debug if they ever crop up without explicit errors.
>
> Hrm.. I started off with a copy of compute_relabel.c or something, it
> looks like none of these functions check. Checking the snprintf for
> the path is probably not helpful, but now that you mention it, a
> truncation of the last context could remove some categories and cause
> an erroneous decision, and since we don't get the answer back from the
> file like the compute_ functions it could cause a vulnerability.
>
> Thanks, will update and resend.

Well, this was wrong anyway, I trusted the commit message from when
validatetrans was exposed in selinuxfs:
https://github.com/torvalds/linux/commit/f9df6458218f4fe8a1c3bf0af89c1fa9eaf0db39

but It was incorrect, 0 is not returned on success, the length written
is returned.

Will resend soon. Thanks again.
