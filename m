Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EDEC433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 01:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB972075E
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 01:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BQ/IoFaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHUB75 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgHUB75 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 21:59:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F7C061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 18:59:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l23so185954edv.11
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDekLfmSOlHClTvvvJm0t/VB/BYNDWYcuWZhaimgamA=;
        b=BQ/IoFaW5G7urzcnOreN5Dj7G0do2zd/dvh6Za/ME642N/XlGxjzZ7PObVVrOeIyfK
         Pe+irpClJ///RYYQzX0KeZUnhWl1QlqdAyH10ULc/fY0Iz1mfQhJn/nw7c7zDsDx8u2B
         HffaBRnl97Fptw4bQ2Z0lzZJFgXWe1zYUweFeNfBhQyPy45To/PgVlemHYBlfN8J7Qal
         JNhpi8OCeFRhdvon+9EFi7B2XCH1QLaVd73Hnxj7kYxuzIOokAK6Ab7HMHARYG3snyt0
         hfuma/jkvGV57VXGW6CScOk8Ps+ms9XM62K52Mp2GLn0/q0D17gxlCSF4xTOsiwwBACV
         QY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDekLfmSOlHClTvvvJm0t/VB/BYNDWYcuWZhaimgamA=;
        b=Iy/pMFspwd4RTlcNB/oAy8VtqCXunaz+7xk8jE5dEY12hMcro3pm85PwC2IiJHrVSi
         2aYpUrlxR8HX/rjnopxBbkQZ/TKsYObfsLErj/W8XHExbggBXjQmmcWtYUzScdIr4sST
         4JjFZUXqDwDmHBbeXeD1FTjQKxUpJJpFSb1B0eqwt2DMOhu5eHRu1X4wAVghXqzOSbdv
         AXvYYIkWKJZkG7UmR1Kvp9b1NDaq5RGkj+WWHxV5rd+lYYTcpl6NJ8dTlJngCek51Lp/
         IkUBRZ7cm4A462whZf1QZud9+y1TpcEg3Du4TcQfU2i09QNmFW6bBic+h6rk3NU8u0On
         yPsg==
X-Gm-Message-State: AOAM531RzXf6fJ4v+JptxB68Jxwfm2q0uKJAFFcTuVuk4lkt8Q9N6P0M
        90DErFunDKnK0WXyoV0QLnbeRDNQKht5X2TWRDf6
X-Google-Smtp-Source: ABdhPJzzYftDn+LJBCsK077+HUMsMumw41l2puTHGW2AbO3XpK2/gVxSqA9Lhl3bKISrCrKs7eK/uPidVJBZ+PV3Uxg=
X-Received: by 2002:aa7:db10:: with SMTP id t16mr689593eds.196.1597975195108;
 Thu, 20 Aug 2020 18:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200820170040.64664-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200820170040.64664-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Aug 2020 21:59:44 -0400
Message-ID: <CAHC9VhRSyZa7o1rSGBK0uLeGcGBL9N9aCBzsJ-HyeVGCFFfC9w@mail.gmail.com>
Subject: Re: [PATCH] selinux: permit removing security.selinux xattr before
 policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 1:00 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Currently SELinux denies attempts to remove the security.selinux xattr
> always, even when permissive or no policy is loaded.  This was originally
> motivated by the view that all files should be labeled, even if that label
> is unlabeled_t, and we shouldn't permit files that were once labeled to
> have their labels removed entirely.  This however prevents removing
> SELinux xattrs in the case where one "disables" SELinux by not loading
> a policy (e.g. a system where runtime disable is removed and selinux=0
> was not specified).  Allow removing the xattr before SELinux is
> initialized.  We could conceivably permit it even after initialization
> if permissive, or introduce a separate permission check here.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)

I'm in no rush to allow removing labels/xattrs if a policy is loaded,
but it does make sense if one isn't loaded, especially when one
considers the desire to get rid of the runtime disable.

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
