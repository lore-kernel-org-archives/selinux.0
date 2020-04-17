Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD9CC2BB1D
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978BB20780
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 21:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cEaiUcjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgDQVrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbgDQVrq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 17:47:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2651C061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 14:47:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q16so2718552pje.1
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRt4C7/WIs1+VhAiCTH+4FeZZqGsnWCjU0PYJU0xZlU=;
        b=cEaiUcjsEoEQezIOvvYbZLC7IzMZ4gCGuoytG0HB6Ad7rkrKRFadck9+rVYc0raIAU
         rku10sD+Edqs2eBsi85GHr3/YpsIkEm+WalCUnwgSIBSCPOjj/Ux4I5JZ4hzGxBQUl1o
         o3Cinv4mLP8PSEuvMNel/cqY3Bm0LAuN6KnT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRt4C7/WIs1+VhAiCTH+4FeZZqGsnWCjU0PYJU0xZlU=;
        b=GVwl4BerLchja9A2SZT4ruQPJXzjGJO3204C+PQ0L54n56/7JhbcUgVh30+faoRut8
         2dTg6xrPiWqcxIooG6ObyKohSnlGjcUixxD08vEpKQxH6ErPI9utPc1e8Wexl0hHHv1X
         hrdIX0eRVyoNP7eyS6E0w5NcQ7exCUQFUL47LZ6aeunZhETUqj7WvvEgWnp61Zy069jv
         CfJidWb7beLukuJPYNAq+RdHzZ3Unrtx+LBugd2JZDb8X57gvZxYYStIw11/DF0eplVy
         XHeEnSQsqC3Aorr/sOhbE3ybZ+ulIfsetFD33Y3Ij/Mk0mxXXcTbJzV6hiuIvNXL16D/
         Q72g==
X-Gm-Message-State: AGi0PuZY11xxNAjjhQNI0AKkvB7M9oDxPd478gfKwrHLHa+gMvBGuJPO
        Odc4IzslMr2C58n1V9uHFrI9/2qEDc8=
X-Google-Smtp-Source: APiQypIloySeAL+eZWlJdo5HlPOyG9Fx62JVFixaP0TaW5Y0yMjZxzW0z2V12wH6lEDYBVQx38KvhA==
X-Received: by 2002:a17:90a:bf86:: with SMTP id d6mr6447069pjs.180.1587160064669;
        Fri, 17 Apr 2020 14:47:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j16sm18029517pgi.40.2020.04.17.14.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:47:43 -0700 (PDT)
Date:   Fri, 17 Apr 2020 14:47:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: free str on error in str_read()
Message-ID: <202004171446.B5B5647ED9@keescook>
References: <20200414142351.162526-1-omosnace@redhat.com>
 <CAHC9VhRZgntyb4SneJDmpSSvfLYiox1Bz-SYMs6V9ncyCZPqSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRZgntyb4SneJDmpSSvfLYiox1Bz-SYMs6V9ncyCZPqSw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 15, 2020 at 06:04:53PM -0400, Paul Moore wrote:
> On Tue, Apr 14, 2020 at 10:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In [see "Fixes:"] I missed the fact that str_read() may give back an
> > allocated pointer even if it returns an error, causing a potential
> > memory leak in filename_trans_read_one(). Fix this by making the
> > function free the allocated string whenever it returns a non-zero value,
> > which also makes its behavior more obvious and prevents repeating the
> > same mistake in the future.
> >
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1461665 ("Resource leaks")
> > Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/policydb.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> I just merged this into selinux/stable-5.7 and assuming all goes well
> in testing I'll send this up to Linus later this week.  Thanks Ondrej.
> 
> I also want to add my thanks to the "coverity bot", thanks Kees.  Are
> you only running this only on Linus tree?  If it's open to other trees
> it might be nice to get the selinux/next branch into the automated
> testing.

It's being run on linux-next. The free coverity scanner barely has the
resources is keep up with one tree, so I just feed it -next. They were
kind enough to let us upload daily now, so I've been trying to feed the
emailed reports back. It's all just the tip of the iceberg, of course.

-- 
Kees Cook
