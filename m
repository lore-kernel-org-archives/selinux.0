Return-Path: <SRS0=DMlc=AK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B01AC433E0
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 23:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F4E20780
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 23:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wLW2pc2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgF2X3J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgF2X3H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jun 2020 19:29:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D9BC061755
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 16:29:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so8232090edb.13
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8FO2AYpTOp4/j4H0UgyWORPSDkPvKc/kn9Y+vJOxvg=;
        b=wLW2pc2WzOiPYCZK5gZxGJbvoAnPlKIxiwQbyLKAjKqkoFdINj1rk1LgD+sb1yUrYG
         71gUaX94/wbJ0ElZnhAGyPdVhO+4OS0iODQ2rEzn0xvHFt5PxsGxS8voK41wZGY86bPp
         +UXYi1WVuPuXI43rTX5/mGSvj5sGH7I+0Yru036FOPfrk24XT4oeh+eRVrRTBuYVFClO
         cJ6yS6BI5BVCCfbpdnogaPYOb9qiOnMrTpyQlODhYMUY8b4QFbcgm8fEZ3g1fpYGoolU
         O6jqUDdRCvRpzbb4T9mgvhKGK1TJcm9xkzh+BrXmPLCPSegaxn0VHATzJQiTu8dqz+NH
         9uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8FO2AYpTOp4/j4H0UgyWORPSDkPvKc/kn9Y+vJOxvg=;
        b=k2xXQsN3KH6n4OmLKTgAcrxM0zinp7OuAaQMdTWNT3rS2bKtAk8ER8e1XEcM+EH7H2
         soRn/fjRvNWDliXZXVqB/8VszImegrGAudtP1XD33HnK2NIqr1l1NxzpFOXsrAbrKBVc
         Z5QhEfN00mn/OoQYFtEQbWfILdZcDQ0DZ7G8j0ggWw8cuwbmAy3yJZnEIdmhiwM7/8Yw
         SHF9eZVM50lc5kgKTbt2j/omKUUrtmSCADvBiPd+SQfxkhZTKKzxHu62VpzuL3wDhjJ9
         BhMo9ZCnGHYFa6tcZD41fPTzLNw2rKfm4t1qFftVkQH9M16SATK0XfRQm9R9KU4ozLa7
         yMsw==
X-Gm-Message-State: AOAM532sYJObtYicLpQ8477rFyuFQ6e+j0GYf0jDwHw4gMjZJk2yinFW
        5lMXyeDmG16ro+c+RzekL//xLl7Cu5bfiSR2lumhgPoDAQ==
X-Google-Smtp-Source: ABdhPJwtHincEeVl8Zp10k/i6zMeQXaS1SToKEzlH3fHcXWxm59IZqB3JYJpEYHV2qcKTqFt387Xt98TblaQay2RFws=
X-Received: by 2002:a05:6402:13d0:: with SMTP id a16mr20044858edx.269.1593473346296;
 Mon, 29 Jun 2020 16:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161258.nbit7xlca5hkxtub@archlaptop.localdomain>
In-Reply-To: <20200624161258.nbit7xlca5hkxtub@archlaptop.localdomain>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Jun 2020 19:28:55 -0400
Message-ID: <CAHC9VhSakA7V99+tkvLLZHohiupWmjSFxSZLWZT4-Gwr5Cc-XA@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: ss: conditional.c fixed a checkpatch warning
To:     Ethan Edwards <ethancarteredwards@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 24, 2020 at 12:13 PM Ethan Edwards
<ethancarteredwards@gmail.com> wrote:
> `sizeof buf` changed to `sizeof(buf)`
>
> Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
> ---
>  security/selinux/ss/conditional.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next but I rewrote the subject line to "selinux:
fixed a checkpatch warning with the sizeof macro" so that it fit
better with convention.

--
paul moore
www.paul-moore.com
