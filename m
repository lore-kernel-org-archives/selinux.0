Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F239C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4815F2085A
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EuUGZ/iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfCYOIP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:08:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44213 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYOIO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:08:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so3469190ljg.11
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLlCCs0P0FKSIqhUMo6zNydQHHiiClp2yAxqD9+auHM=;
        b=EuUGZ/iwKOufgSpnrJceU2MrjE7lXWEhLaUlBXWeujXkMyDvgNq2L7cB5CF5RgOonO
         tbFn/XAM4kAls41AiItslw9IeohOjwTv0D4kz6CbdI64CbuW6p6ptWvX9+cTdoI15Stm
         cD6BtlVKNzaitn42vqgoyNUiGg0/LDEdlDAylOn2EHEiH091OOZEFLy0s5QqHfpPH88I
         YuY/Xh9SZAiYxnb0k+Hc+CtZt0OUskp06/qVooTRkO9kcvXdXIv3c9dGM4Vx/C0Lg2F5
         Yw01S+ANZSXTYAFUmflYqCKTx1O9yEaFRmW5IOJBJpG+jjht3QGK3hHTMMpJIlKGCTKs
         PwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLlCCs0P0FKSIqhUMo6zNydQHHiiClp2yAxqD9+auHM=;
        b=ogAwVLs2L0UP+zoyewTDuE6B0qm/qKs50oTwWiTvskGeVYjTr9jfm3cVexvyn6tXJ1
         +pWg/4BfbaPwBJWHWyZZ0l8nQqfoucBDBCqifKjM3wqd0q6sZkeSvgwgn3IuD0fQlXwd
         dMCgKwapJQydwV347PNHzXqjZa2EUcuIJGmm5WlohxsiKJT3iP7c5DXepI7DLR1CFIQW
         Fr7X2rQdlHJufyV4iJ49xhkjHIkA/mErV69ZltEaUhEVpih+9k96cJkV4/X7BRUw/CQK
         UAiYuR2HKynOf0XGwQ/fiziTPpvrL+EjTEM3MwcyQ3XGukh8vdDIT22be3OYE6kUh9y2
         FUhw==
X-Gm-Message-State: APjAAAXAh+vpCxQ8032KX8Wf4MbUfv4vigMYybkAoJ/224UXV3eMcMFG
        K6XueJiGUYfiNaWJ26q2AxzVG+5nyps2aJGYEhl9
X-Google-Smtp-Source: APXvYqzl0+CZ3K0oe5NfRXMHIeW+sP/ORzT9caFtvFlbkjCB3/N7jCWFoW6Ui42pErw+6LHbWbIgIad+cMeX7wUp2aA=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr13395071ljb.169.1553522892292;
 Mon, 25 Mar 2019 07:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <201903211834.Qtb0LJ32%lkp@intel.com> <20190325080535.19475-1-omosnace@redhat.com>
In-Reply-To: <20190325080535.19475-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 10:08:01 -0400
Message-ID: <CAHC9VhR0bSK2GXZZ1jCw=zzjKhGgxtueHLc7aUbHq_+MWFevuQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: lsm_hooks.h - fix missing colon in docstring
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, kbuild-all@01.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 4:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Apparently without it it is incorrect syntax and causes a warning about
> undocumented struct field.
>
> Fixes: b230d5aba2d1 ("LSM: add new hook for kernfs node initialization")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hooks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If it makes you feel any better, I didn't realize the colon was that
important either.  Thanks for the fix, merged into selinux/next.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0dd5bda719e6..b987dc282d63 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -447,7 +447,7 @@
>   *
>   * Security hooks for kernfs node operations
>   *
> - * @kernfs_init_security
> + * @kernfs_init_security:
>   *     Initialize the security context of a newly created kernfs node based
>   *     on its own and its parent's attributes.
>   *
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
