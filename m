Return-Path: <SRS0=bvjE=52=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFF4C2D0EC
	for <selinux@archiver.kernel.org>; Fri, 10 Apr 2020 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA6B207FF
	for <selinux@archiver.kernel.org>; Fri, 10 Apr 2020 21:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlccEwT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJVpj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:45:39 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38182 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJVpj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Apr 2020 17:45:39 -0400
Received: by mail-il1-f193.google.com with SMTP id n13so3099716ilm.5
        for <selinux@vger.kernel.org>; Fri, 10 Apr 2020 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ayvkT1MHfHe1uATm16WB6orEpbVrEceLipUDimz1I0=;
        b=rlccEwT2scF2+ekhY8gEoUZNCXbx0BuHaFJsmkLb19Zw3H0Q280MYF8zagJiWjc1wf
         aBaAE/38ingGPTHwGfbzIT97Jyc28A+muBLUWTQeAXeMlk02kHSTbn8mjeLCwBiLOcwW
         WEvEbfUqjyY+QZjP3MB1jvLyP/hz1edXWv9NyFN1neon1bmaVFeQrIBl4sPlPFrY9xXO
         5zRMGjsoViaMTww3vLMAeqAf5tr6MjIjZgb4/QqUAe4ZX4XlfkwPnTx4ANKYiEArPAqy
         clG+rNWfUkXghZspeHWhE9PC+9cF/M+2aXqTLciZJ1qjLrbxGMHQ7lEcxSQ4vo62SaD+
         GcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ayvkT1MHfHe1uATm16WB6orEpbVrEceLipUDimz1I0=;
        b=m0kGJ052mSytSzutPP1GKAKKSJQlKJ4D0lBN+iNrbQXQhCFEg3vZ6zvivA5hHE0vBJ
         IXxAEBP+zOuai8Ba+KRvawylFMP6Q6sLEI9Ylqh2GbMLJ0OYxWwnKMPbtlizfDKBqa+t
         ri2JYzuxyj8Etw/yY081/0ZX7+PodrrBRajX/SKlS7ZOXIrHvmS2AHcYe9Yk8kyRS+6e
         xjekhthcR5/IyahHB9dxnLQprZq5lP1ZFL+iL27PvVKb8Qf0f2ZWw0+lJVNWdM9e7IIo
         fNV7i1WMXIitS3k/XNP1zgCTewXgEq9YEnMXoZATWRQzssWRACsSOxsb8FK2J3lBfWX6
         5N/A==
X-Gm-Message-State: AGi0PubnJUYAI+q0JEdkxf8GF8Tbs4rQ//HLs79flUyi7NvBtdGPbWny
        rmX7eNLqLXDPqYl/37Lx64gTEbpQILLco28fZ9g=
X-Google-Smtp-Source: APiQypKPgM/IL7pypu5aQRg1sBnGFmVWOceHa6TJY76Cb6xkdjE/EWVC8+mGfn+N/9p/AmGO1qFTCu43s+B4AEtW5/s=
X-Received: by 2002:a92:c6c8:: with SMTP id v8mr785914ilm.129.1586555138925;
 Fri, 10 Apr 2020 14:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200407184239.2700998-1-aduskett@gmail.com> <476DC76E7D1DF2438D32BFADF679FC5649EBB79F@ORSMSX101.amr.corp.intel.com>
 <CAFSsvmpmhuRD2gWj8ZaRkmZ42DoUM0evfb4tfJTgm8yu=qf2Jg@mail.gmail.com>
 <CAFSsvmrcyhA2xdyAp2vQwN+pqwtK8Tj4uGKicKZfiBCy5pf8BQ@mail.gmail.com> <CAFftDdqN5hXaRZN2LStJkkmfsW-D0b1jeUowwDwr==oaybVOSg@mail.gmail.com>
In-Reply-To: <CAFftDdqN5hXaRZN2LStJkkmfsW-D0b1jeUowwDwr==oaybVOSg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 10 Apr 2020 16:45:27 -0500
Message-ID: <CAFftDdqDzSFY-Gh8hQgDchG56=0gPnEHDi4QOvxFZbESQ=NJvQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fix building against musl and uClibc libc libraries.
To:     Adam Duskett <aduskett@gmail.com>
Cc:     "Roberts, William C" <william.c.roberts@intel.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 4:02 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Tue, Apr 7, 2020 at 3:54 PM Adam Duskett <aduskett@gmail.com> wrote:
> >
> > I just ended up making a new branch that has the latest updated
> > commits and a new PR with an SOB line.
> >
> > https://github.com/SELinuxProject/selinux/pull/218

merged:
https://github.com/SELinuxProject/selinux/pull/218
