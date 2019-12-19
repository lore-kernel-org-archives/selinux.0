Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E9EC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA8B21D7D
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XTQjl6Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLSCfg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:35:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41036 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSCfg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 21:35:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so3180838lfp.8
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 18:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11h5tAThVxxc17IlMhX2m4zOla7pmTdW/O6D4hGefHM=;
        b=XTQjl6CpupwpaKzrv82VB0zAjuZG6TNrZ2+khoLI7Vlq1ElbT7BcuiRcoBZDhjS7uI
         t6ji9Wz9riLI38NDGmxvj0CfNWJEjcIQJ8F+cxO7OT/6nAYacKNPixQD7eR7nqnJn7Ux
         AG4PCVS07J15hxhJs8PJgMcP940fJn3tBzZhE3TxT+p6Xh7fetruxDYqLfc+GH1pyoG7
         t5zPGMcTOThqhWRQiXGziomUZCohfxuVdvh0I5jLSCSqF06knLY0jN3IjHfBtYG8epqp
         XS4G7IWMWxlB6qKTWO104RED/rf2ZuHulEJPic2xJAFTOMZ7mjId1VXK7GkhuDE+i+Rs
         +WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11h5tAThVxxc17IlMhX2m4zOla7pmTdW/O6D4hGefHM=;
        b=RQ5+Npv9tYeCACVoao9NdHS29oDo1lP71PFYgbEOUaTzF+tUjFo86ZituiZ7p4TJFL
         WpbwfcKqCTH2geA2LavmEnkf2kZ/RckLbXI4qbKwMCpFipFWJC5JXsRxuUTq6swhzXMR
         zuDYSZeBGbdWxUbCvQmTwKRVmZnSuvzbZ1VkNY2sLpCYtRCTzcKMgg/cJBxKjWKThIzy
         oTEXaszt9L4DDx4lRpac58G12m4X04yDGpoBS6jXdVGGpqfKgXBdqn29ane8bpYCwhUB
         4sgLwIWPyvee2IBh0qYsRzWUZ82phFK+BNqsqByAwkNqHwMJW/tcoG7GCZF6zRuo/JcE
         UYsg==
X-Gm-Message-State: APjAAAVnkyWNjtqIuQnoo4J2/g/6FSuoiFNaWb352FRv9CXHNrt+8T9Y
        CZrzuh4Fs10SSdrEgZABhWz5L0GRfnVElb43DDXB
X-Google-Smtp-Source: APXvYqyL1ztR1wqRWnBzgdb80NvNTdCRyXCc52K71WdfBEFgpPiTn52DkrdkwgvZ0n9F1zU5Gf/pzXgRJwQdNpHQhBM=
X-Received: by 2002:a19:ae04:: with SMTP id f4mr3796479lfc.64.1576722933576;
 Wed, 18 Dec 2019 18:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20191213202838.7323-1-sds@tycho.nsa.gov> <20191214185002.GA8076@gmail.com>
 <e25e8aec-f3a2-1b35-ee6c-e2c9344db885@tycho.nsa.gov> <CAHC9VhQQQ15WjCZ5ijLhx5ttGeosqnwJ3TXcZYJouVqNPotpRw@mail.gmail.com>
 <707a7d03-b969-8409-5439-f649d10378db@tycho.nsa.gov>
In-Reply-To: <707a7d03-b969-8409-5439-f649d10378db@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Dec 2019 21:35:22 -0500
Message-ID: <CAHC9VhR+6q6tYDPc8z8emugWTs==cUiJFUZ6tVcKZ4OYte23qw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Dan Aloni <dan@kernelim.com>, selinux@vger.kernel.org,
        keescook@chromium.org, omosnace@redhat.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 17, 2019 at 8:43 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/16/19 6:46 PM, Paul Moore wrote:
> > On Mon, Dec 16, 2019 at 9:21 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/14/19 1:50 PM, Dan Aloni wrote:
> >>> On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
> >>>> I would have expected that two kernels built with the same config
> >>>> with this enabled would have yielded different struct layouts in
> >>>> pahole vmlinux output, but that doesn't appear to be the case. They
> >>>> do have different seeds.  Am I doing something wrong?
> >>>> Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
> >>>> change if enabled?
> >>>
> >>> There's currently a long-standing bug with the GCC plugin where the
> >>> generated debug info is in declaration order, not build order (see:
> >>> [1]).  So, to verify it, try looking at the generated machine code.
> >>
> >> Thanks for that clarification; I can see in the code that the struct
> >> layout has changed between the two kernel builds.
> >
> > This likely falls under the category of stupid questions, but I'm
> > assuming it passed the test suite w/o problems and the system
> > generally ran as expected?
>
> Yes, it tested fine for me. It did require a full rebuild to ensure that
> the randomized struct layouts were being used consistently throughout,
> and requires a make mrproper or distclean to remove the random seed
> before rebuilding if you want to generate a new random seed.
>
> > I've also heard some comments about performance concerns, have you
> > done any testing?  I'm guessing that isn't a major concern here
> > because I don't recall any of the structs marked in this patch going
> > through any optimizations, but I could be forgetting something (or
> > missing a performance concern with RANDSTRUCT).
>
> I haven't done any specific performance testing, but it will only impact
> users who enable RANDSTRUCT, so it is entirely opt-in, and as you say,
> these structs have not been especially optimized in the first place.
>
> I think these same structures (or at least significant subsets thereof)
> are good candidates for write-rare protections if those ever reach
> mainline.  Haven't seen any progress there in a while.

Okay, thanks.  I think it's worth getting this now, even if there is
some question about how widely they will be used.  At least they will
be there and we can use this as a starting point.

Thanks for putting this patch together, but as a FYI, I did take the
liberty to remove the double semi-colon during the merge ;)

-- 
paul moore
www.paul-moore.com
