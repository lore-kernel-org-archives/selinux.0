Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D522CC433E0
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1464DD0
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 03:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhA1D3h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Jan 2021 22:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhA1D3c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Jan 2021 22:29:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76330C061573
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:28:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g1so4970683edu.4
        for <selinux@vger.kernel.org>; Wed, 27 Jan 2021 19:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0R275pBPiaX+mV2j4OTKnF6IRq9vnG44tRuZUIn1bk=;
        b=xxpxSxXkSzyEvlcrrp66EqyEOVIQH2HuGVtJUAMagwb7gUih/Mrw7DgKgknAwl2tRh
         v+1OWEa9I2GbIlflxD/ju8u4sEUymqLgG5eYTIe+/YwP3aB3tdr83FGcXbbIvnYKRV4Z
         Qo0itib0R1JsL2qGe6QkXfpFPkXjClOxw5EdEDNN0Sg4aUZXHxNCnNHSVGiyDQDd6bq9
         lSsgFys62Lz+sRnyZNHc17pFV4GPDi53/jmW/A+5W+T0VTl+GnT0dFybbILaPcM6IX/c
         d4Lkdq3H/noGlENCcq8m0LGq/CP7AJP5KaIHf8vRRVBu2njODahpJinbVFU1VPm/BxYp
         5dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0R275pBPiaX+mV2j4OTKnF6IRq9vnG44tRuZUIn1bk=;
        b=oNWBtTjK86kJpDlxyu62MLus1D2rQyVG186fhzuW3q256jfOF7XyGh+7soMcKD1iUl
         oHbnxXljN3LPOBFJSlOj1Lwt73U0rUdIbZVHPsIt439RDspsVEQRLIkc8U695Io3rcPa
         LYLwq9ja2scVSUhaCp89FgueCzCwPdy0F0yxJpIXUxq8Z3YX4Zgo+sbOCGQgEK6y2tuQ
         bVhUw2RZPpR6HE2aLirSZnLmNaL5z1RwN0MIYKxtm+Ku4XVyGpXZjU3D1OBnXiDyc7ZD
         vYjzD7IAqzM+TTI89H+xbi/bf99dzbP6jY6IcEdQZQAzwmh4WmMz1kGDW7Dhgtw+ZqLD
         hWeQ==
X-Gm-Message-State: AOAM533QQI5rg1pzxUiHUksRWIclBrDIrBlReHtcQIHPUZnXy/bx1ixZ
        uQOdq9+BkQ8c53OehQPQlN/39vAHH0mcGF5584HC
X-Google-Smtp-Source: ABdhPJwCkII/6GxQKADAZHi2asoVjKytPHEW25atSeeJnUi0/q8PT+2i0dWTXA0aBfu2m+VEsODa0GagC9kUQBm7LQA=
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr12012085edc.196.1611804531169;
 Wed, 27 Jan 2021 19:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20210127160212.135883-1-richard_c_haines@btinternet.com>
In-Reply-To: <20210127160212.135883-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 22:28:40 -0500
Message-ID: <CAHC9VhSEuwEfE6NkpnG6CFV69JG+iVc=0rOKbLpVrywb+EqFYA@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Add policy version 33 requirements
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 27, 2021 at 11:02 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Update types_of_policy.md for policy version 33.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/types_of_policy.md | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks Richard.  A good reminder that we need to update the notebook
on new policy versions :)

-- 
paul moore
www.paul-moore.com
