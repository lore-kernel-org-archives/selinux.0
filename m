Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E0C2BA19
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B89E20784
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 22:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gmoMEp6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgDOWFM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727839AbgDOWFG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 18:05:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271FC061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 15:05:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so3978205lff.2
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8M8dea2kzHDPXBaDQUWJxhuYGtEGebMxj1SNOHFPEM=;
        b=gmoMEp6rYnJK/aVrHcyqzpn7PSQOpf+lwmHPod3aV0H7kO6Os3XN58HI+EScShqVzG
         jTfAla+giEnQPqfdtOH1H5pZ58uUbPfxPgrv3Rj359V/AwKfaPNtLKX4Gov5ddOk4wwT
         2Go7nlHIEXn7NAuts98IzS4hVYQxGJyzF7VO526qiDmGct6Y1ouStOF0Ck8vryqvfatf
         9kNJduinhACyE8vHCQ2KnmVLafMu8aT1AVZ7Mfje1lxq1EhMkpLMib6EAejRrFs72lTs
         6ict9nhrpkMuy4/fF9ISWBwg7JBPSjC+0gB3Ui9b/HUiFRm4R8ZDeWRcmx55r67OrRHm
         3D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8M8dea2kzHDPXBaDQUWJxhuYGtEGebMxj1SNOHFPEM=;
        b=Bd6er7IvlbQtrM+yTGPzOSArUpR6UINux/khYZg3UrwaAUywPp1yi2kGUAVxIJdYRJ
         75gOCsOholQfew3m443UTYZP93q2rxxPdx2LeG8eERegm9XFjKPh5OairEhcU/SpJMn1
         f/dkDWCsNNcD+3KlyXZEotrVtrM5nSU2tbJX4Oybg/QEgrNIDj7vMXN8VQALaOtyeAJJ
         UEsWf9Euy9DrKDqbvdygyJLtagA0hV+8zcXrF963+xDWt4JMVERXaSPgZ9mpAEu8ErUU
         iUVUy19eU7GKltP+CdVgtnMiGlILqrC8Gt/wzy3qk2lDy3QY4ZjhcVZKXeeWCONpIUn3
         u2HA==
X-Gm-Message-State: AGi0Pub6L5qpiODvFGPmfuT555gFZxunR2OvjdNCFhrdqAEcbfYLj2Fc
        nbtllh1wuP5yjcmOHLBlYlF1NYKJf6UGQg3i8Vdwddw=
X-Google-Smtp-Source: APiQypJgcRLIKGSCsgd1/a2/E08ukF0npgDh+81OQ/7GZ3C5PnftS7OsZiTc58bIJj7iJ1tk5d+Bc6i0fbvTr2gO7ng=
X-Received: by 2002:a17:906:35d0:: with SMTP id p16mr6906510ejb.77.1586988304458;
 Wed, 15 Apr 2020 15:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200414142351.162526-1-omosnace@redhat.com>
In-Reply-To: <20200414142351.162526-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Apr 2020 18:04:53 -0400
Message-ID: <CAHC9VhRZgntyb4SneJDmpSSvfLYiox1Bz-SYMs6V9ncyCZPqSw@mail.gmail.com>
Subject: Re: [PATCH] selinux: free str on error in str_read()
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     selinux@vger.kernel.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 14, 2020 at 10:25 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In [see "Fixes:"] I missed the fact that str_read() may give back an
> allocated pointer even if it returns an error, causing a potential
> memory leak in filename_trans_read_one(). Fix this by making the
> function free the allocated string whenever it returns a non-zero value,
> which also makes its behavior more obvious and prevents repeating the
> same mistake in the future.
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1461665 ("Resource leaks")
> Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I just merged this into selinux/stable-5.7 and assuming all goes well
in testing I'll send this up to Linus later this week.  Thanks Ondrej.

I also want to add my thanks to the "coverity bot", thanks Kees.  Are
you only running this only on Linus tree?  If it's open to other trees
it might be nice to get the selinux/next branch into the automated
testing.

-- 
paul moore
www.paul-moore.com
