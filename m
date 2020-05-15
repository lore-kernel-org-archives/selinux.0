Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7C1C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1112C206D8
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wOoXWX2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEORvi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEORvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 13:51:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7169DC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 10:51:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x20so2899850ejb.11
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09xkZrvC2hkumdf1MH2gYo/pVtJpX2qP0ZP4CIu6YfU=;
        b=wOoXWX2CER7YX5CVC6X3MGXwxOnWx8rgB0GUHkryfo9WeIW6xdWSF36HHr9YQ7Lvfk
         3F/SArSAvSYlSOTQW32ETUSmGhAuzCu6lzxP+QyQey+eeY63SPNf8a/m04d0rEkOCbtg
         bcWreT7x6B9gVy6YzIJVhgu3cbXfcmYUGZJENh7tSWcBih1Ui+IBlPiaY6P4u/f8jDJi
         WPAZk4gKjwbPotP5SQ8SOUw1Nvog8Gc4rf8G79gqU/RbDtVSqilskSQ0PkR+E3kGUhYd
         +HwOViwLULEFxVDDoPA18Y+CutZKZq+VUiLGMbLXII3u8CVpLRmcQ/JBsY24um7HyJkF
         LlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09xkZrvC2hkumdf1MH2gYo/pVtJpX2qP0ZP4CIu6YfU=;
        b=i1/n5YtWqu5mcW8nZcZP33nMfmKkId6Sfv6sUcnP2/WHue0KZMsUl5MhNG229SIG6E
         mWIqExK4ScZxSR0W8b4BaOVIBvTPDAcAH6k8EWjDIoCIPhOhuTQvXAL/eoXvdMWzy/bm
         oK/xjsY2GJWp1syWdmHotTrPG1A+exFQW3n80mMCWREA/5ibW35vUINhr9NUd8ZU+XZB
         EdIZLPBVJCeHNDhSK9NVbfBwrxtildkbNOFA+uVIGIrgYIdbKvqMHFCBHMR1jfetP1uh
         52ASrxsg83L7rbTr642H1Gior/jLwGOQPhzloS20vJxv5+ZPfQc8zyLz7TeJngOzYhX8
         wP7w==
X-Gm-Message-State: AOAM530/c/SK5lmBt2h3CAAO9hXbHJoR+t7W/tJ95KUfuEBUA41/OFFV
        iEfn8+pWZVFy18D+jI7A7w94e1iNL261dNdIHnJHe9U=
X-Google-Smtp-Source: ABdhPJzXLSrvBf2hMruU7ywWt13386fDmnaZXF7jLqsrwpvXDRKQRo80LwcY/c3Fyr6bcGxj2h0iHHae4O+l0QrS0tk=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr3807955ejf.308.1589565095690;
 Fri, 15 May 2020 10:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
In-Reply-To: <20200515173042.12666-1-william.c.roberts@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 May 2020 13:51:24 -0400
Message-ID: <CAHC9VhQ-MHqzRtJvLfCY7_PLtLE3Tjq6+AmKAZDs7NOx4XWXPg@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     william.c.roberts@intel.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 1:30 PM <william.c.roberts@intel.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> The text above states that kernel-devel is needed, but it's missing from
> the dnf command.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  README.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

It's not clear from the subject, diffstat, or your comments, but I'm
assuming this is for selinux-testsuite, yes?

> diff --git a/README.md b/README.md
> index 1f7e5d92a100..a73e9cc0c06d 100644
> --- a/README.md
> +++ b/README.md
> @@ -77,7 +77,8 @@ following command:
>                 kernel-devel \
>                 quota \
>                 xfsprogs-devel \
> -               libuuid-devel
> +               libuuid-devel \
> +               kernel-devel-$(uname -r)
>
>  #### Debian
>
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
