Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F2C433FE
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 01:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEDC23BC7
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 01:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgLJB5H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgLJB44 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 20:56:56 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8BC0613D6
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 17:56:15 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so3772327eda.12
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 17:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2XB0SGTvXw/a2TYynR97hw9F8Pet0KSbcWgAptITgo=;
        b=T2AOSosTRQ69BjxLlR+aK9n2BkjTD85aMJg1wlqmJWZZujPyw6rJcXrIyc6tT4gvoZ
         UpxPsMFa2xQL/zgPbgdvDh3iaBUlL7flqx7hSwDe4AvrqDYZwkVBvrRz+oWsg8wIuzF1
         XSxTR9de3WPvCzLas/dsScbP1lFpKvkh8vnsa9EeYCRgcD51YK6hNyTUywLKAUR/2eQr
         bZONCuO2bSa49rSSEpWOJwgd+kvsObrrW8fNnQCDld7krPUpf+jiFY6RIyHkrXCDqQPj
         EQG7Ys9Zd3bIuCPrfJBfQTiq14qZjYZ7iyhCChl75DmCoqFfs2lpWZLUEfqWj3oYeJ08
         QbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2XB0SGTvXw/a2TYynR97hw9F8Pet0KSbcWgAptITgo=;
        b=ldnPhwk2a3YPKGJTszfRjX1pE+HElDkqHiKPWhQetHYDzhOSS3mELc2QAiUYNF9ESN
         2LA0B3PIbUDVep6e6Kw2QsszHQYjl7pT83/IdY7zJE6wdtqciFPbfd4zrTKjzqJZ4wfO
         Ktg9nxrQCCY307A8POm9TU52O/OdEQKoxn2agdBl0EQdrNC+ouIsOfUaZ5Gq4EcCoDJb
         NHokS2dpFXQuHyCEWCpV1zlrAlN5PJn0Jc9ousNxNB+eRV4kAnVNMS8b6E7CtipKc62+
         OLSKuhsm0saFb+FpRm9syyyQDUi/S+NNYQuV4HZEcpQIZ/vdipXKfipDjg0Vt1AVYFk/
         R5Aw==
X-Gm-Message-State: AOAM533qQatkXXzNIgSrm87IT9SvnyBnEIbmcMJN1TLBD9gwnKP5C7zr
        FKOimJjAr/rtt5WYDU/+BM1AKoF7OT6VQbl76aNAH55AErNJ
X-Google-Smtp-Source: ABdhPJw09qnKeAhDjVUQTlSh2ntAXb4ym/fkFX/OO8JXX6TRnyJA8vdvyPGh8lCNRYT3I8iAkEM1DExZK0NC/UBA83o=
X-Received: by 2002:a05:6402:ca1:: with SMTP id cn1mr4605348edb.128.1607565374614;
 Wed, 09 Dec 2020 17:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20201206181818.103862-1-richard_c_haines@btinternet.com>
In-Reply-To: <20201206181818.103862-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Dec 2020 20:56:03 -0500
Message-ID: <CAHC9VhTkDDcvAbF+2wtnm2hVbUrXWaE-2C6PQGRc6Fep+XwkEg@mail.gmail.com>
Subject: Re: [PATCH] reference_policy.md: Remove Ref Policy 'contributed modules'
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 6, 2020 at 1:18 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Remove the references to 'contributed modules' in regard to the
> Reference Policy
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/reference_policy.md | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Just seeing a command line that starts with "git submodule" still
sends a chill down my spine.  Merged into main, with prejudice.

Thanks.

> diff --git a/src/reference_policy.md b/src/reference_policy.md
> index dd2de00..08e7744 100644
> --- a/src/reference_policy.md
> +++ b/src/reference_policy.md
> @@ -86,11 +86,6 @@ repository that can be checked out using the following:
>  ```
>  # Check out the core policy:
>  git clone https://github.com/SELinuxProject/refpolicy.git
> -
> -cd refpolicy
> -# Add the contibuted modules (policy/modules/contrib)
> -git submodule init
> -git submodule update
>  ```
>
>  A list of releases can be found at <https://github.com/SELinuxProject/refpolicy/releases>
> @@ -1265,16 +1260,11 @@ policy a copy of the source is installed at
>
>  The basic steps are:
>
> -- Install master Reference Policy Source and add the contributed modules:
> +- Install master Reference Policy Source:
>
>  ```
>  # Check out the core policy:
>  git clone https://github.com/SELinuxProject/refpolicy.git
> -
> -cd refpolicy
> -# Add the contibuted modules (policy/modules/contrib)
> -git submodule init
> -git submodule update
>  ```
>
>  - Edit the *build.conf* file to reflect the policy to be built, the
> --
> 2.28.0
>


-- 
paul moore
www.paul-moore.com
