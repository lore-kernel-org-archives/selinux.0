Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE6C28CC3
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 02:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A4D2781E
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 02:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwdgG4KW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFBC4h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:56:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34291 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFBC4g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Jun 2019 22:56:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so2999752pgg.1
        for <selinux@vger.kernel.org>; Sat, 01 Jun 2019 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYBkyqo/yPlkXuPi+qAPWY5xhttsminToU3/+row8eo=;
        b=EwdgG4KWs0WFC0g2qGgDlx/QQfY8z8TRahYLL3PS2bjslsQ3YxJuNetJlygU0Y/rW2
         k7Yv+nzeS/fjPzpBajA6CHQjp1j4AZjImizUFdTznKz6VYnS6uGHDREju9E75zfJzmKt
         TBv/3YDHw8zVShT8PFpmjjeZ+upKwT5fZRg+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYBkyqo/yPlkXuPi+qAPWY5xhttsminToU3/+row8eo=;
        b=SSJNjj3Aw35GwtXv60s3lUhEO1KSPjP4lFXyffYUKrGKJTbSJlUcesjbpsYxHrcH/2
         iEwQK1pI0Xn+klkgOFas4DkFtuy29ox+iYG3ottsy5HBnt14ithN7LEmW7stvGlU64kX
         gK14LWuO+pDiMmzwVRpXtZ4X/6H/ZFQbvyjcPbuCR8goRcJCFym2C7NMXhhsJUt9Fp6m
         /KucAVGISU2nE2L+m37TZOv9bGbZrcQZXcmhBlG1/JR5ukFLPZM2gKhYAjl9uBMfOoQX
         Q4z8i1FAeylpGVJDW8XyDY0It3INg9hWFNxiTNC+JaPLPFDMlxNXW91F5VovgqHL4FXN
         nDyQ==
X-Gm-Message-State: APjAAAUKw4hBbcuDOPG12hOwXz/jKTtZqEw7Tlgn0wmNvAHb3Kw8A/jF
        3Oh15psPurzsScdXRiW0xsvXcQ==
X-Google-Smtp-Source: APXvYqwLYD7HaXO7AVb9B/ZrQ2U36ePix1eevfw6eGQxR4xL3hXDj7WGuJRc2xewYGlFTBsLDGm/Bg==
X-Received: by 2002:a65:4209:: with SMTP id c9mr11005489pgq.111.1559444196405;
        Sat, 01 Jun 2019 19:56:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c6sm21303749pfm.163.2019.06.01.19.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 19:56:35 -0700 (PDT)
Date:   Sat, 1 Jun 2019 19:56:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
Message-ID: <201906011954.1153EF675@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 04:09:22PM -0700, Casey Schaufler wrote:
> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor

I will go read 51-58 from here :)

I'd really love to see summaries of the series broken down because I
think there are some separable parts:

First several patch: more blobs -- send this part again separately,
let's get some more review and land it. It's distinct from the other
changes.

rest until 35: secids work (is this actually separable from secctx?)

36-?: security context

-- 
Kees Cook
