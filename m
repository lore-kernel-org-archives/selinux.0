Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F262DC352A2
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09132082E
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oPS8osZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBEX26 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:28:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43924 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBEX25 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 18:28:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so3906409edb.10
        for <selinux@vger.kernel.org>; Wed, 05 Feb 2020 15:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UK0ExgKKOGyOpsemQU2AViotDWtj80+VuoiCalkImRY=;
        b=oPS8osZw1g++Pmjq8p8UXoZDOA5cZ7WS1ESEqERH9Ndsz7+CIHPYoe/yfbvSEGKDuQ
         y95g0ezYcUhzbSqjt5F3J79LHkbbOjVuviEP1Znzg2G8JR21g5hhZisgRqp6nihc/E+f
         +Cwl08Xk0iX5LM0CvVFpwr06GIVy62fpg3zmxN+j1ZYZxNPG9Ud2YoqcS+Ur+8Wb64GD
         1nlDqy1KVAHOETqEG7neR9mXEa9EJ7MWXwV2JbMUnGrpbKTMatKn4lXiu8YDaSY4qNsV
         XujCilD9asmbf2Abu9j7yL+xyd/K6aTPIpoReGRgn3evrDRJy1WOwOwbLwf6xdF6KkZD
         C6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UK0ExgKKOGyOpsemQU2AViotDWtj80+VuoiCalkImRY=;
        b=WHVI67FMkKsIAybgz49vDOpCy7hzNSjWBSnEjhaBvfJdhrpByzrEUdilNFn7quYhSL
         qBiWy14p/2JhcWRUcTedUJG8oZUHbc1C7NjbpqUlKcnAGM+niLIzzsh1GOfTFASN0Al+
         rZK2K5NdTQfwOHAwN7Ngq9WMyAKXIReO7vejJfbHkTKk4T9eEQzVmIWEqub1v73+4e4r
         uGaDDWrjTjmn86NxF9ijEHOa77w4nZXAqksyIMBF6zCDmsWURAgHe1m1sQKdC37uEz5S
         ji0B1leMudJSLWmvQLd38oO179vIRaDsvON9Yw09WBnE/Unk1rj4KpgPcztL9zcV/8og
         HoAA==
X-Gm-Message-State: APjAAAWmm7sCFXOIduhhLtaf/Yp4en05JnaOYs02gKM1TNZurajQJ6D2
        PAW6dukDYoNZoLxxtSPICNIxtcx7lnNMiAq6u7uy
X-Google-Smtp-Source: APXvYqwrEXuO0CA6z4mZfYBPxj1agTAsjGIV/vnCWm16MbQBVc3SMqd9qL0wwnG2Jxj9PwzYztkK9oCdKY2iOVSeLeQ=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr390499ejw.95.1580945335654;
 Wed, 05 Feb 2020 15:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20200202014624.75356-1-hridya@google.com>
In-Reply-To: <20200202014624.75356-1-hridya@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 18:28:44 -0500
Message-ID: <CAHC9VhR-aUtrU4PTibDLLG2S5GB9bx9MtwKuyH-x9eqSCmyP9w@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix typo in filesystem name
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 1, 2020 at 8:46 PM Hridya Valsaraju <hridya@google.com> wrote:
>
> Correct the filesystem name to "binder" to enable
> genfscon per-file labelling for binderfs.
>
> Fixes: 7a4b5194747 ("selinux: allow per-file labelling for binderfs")
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---
>
> Hello,
>
> I seem to have made the typo/mistake during a rebase. Sorry about that
> :(
>
> Thanks,
> Hridya
>
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ooops :/

Thanks for the fix.  I've merged this into selinux/stable-5.6, but due
to some personal scheduling issues on my end I'm going to refrain from
sending this to Linus until next week.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 89fe3a805129..d67a80b0d8a8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -699,7 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>
>         if (!strcmp(sb->s_type->name, "debugfs") ||
>             !strcmp(sb->s_type->name, "tracefs") ||
> -           !strcmp(sb->s_type->name, "binderfs") ||
> +           !strcmp(sb->s_type->name, "binder") ||
>             !strcmp(sb->s_type->name, "pstore"))
>                 sbsec->flags |= SE_SBGENFS;
>
> --
> 2.25.0.341.g760bfbb309-goog

-- 
paul moore
www.paul-moore.com
