Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF34FC433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiA0Q0L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiA0Q0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 11:26:10 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936AAC061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 08:26:10 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so796326ooq.10
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kdcuf7WobbrFaPeTBlf07bnIEASTSnNqSgSYsnZmHzo=;
        b=d9M1s69m4xXOkbjlfU7l3xtxqzp/lECGybDJokEoXuJXhoXyv0rkqBfobj6Px5zr+S
         a4/kQkYdl5N2lfILyVBqyKGMAewu2dkrD9j9wzuxQUnorbFsvbyAqcAe+ipcj0ReEunk
         KyKH3Q7hgEgCmI9S8Th3IVC0JjVUaLhkUpeNBDA2bAYJnnHmupas+XsMK3TBGimlJ9jr
         yCrDf58hzHcMm8mw+U0vd9PVxJg99KcoyX1DWqNm6qwsMQxNaVJkVLexfBcTw5ZXnZOu
         8VNKuSzC3dFxup9R7Wz0yY20cPRNEvD0fx9e8R/5NP+zSZ06kRRCE0WIlZAbOU1TVCgP
         dEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kdcuf7WobbrFaPeTBlf07bnIEASTSnNqSgSYsnZmHzo=;
        b=D5dvscHRxyM8zC4u7GhUaR/kt3iIh7tb0YEfnqyi99YFeMJEOEYuFH0OWlzn0WJgjG
         9aJmLiktoWdXeYkrESl4UuVcbPZ8xvF7ekxC2Nm+9yk6P7y1hmNtezT/xeke21lVYdD2
         Bb5lZRYGGpQjdZNJ+MO0SEjGiDsDMhcNwN1ZzjoP5lJKkyiV+Io5sRAnd1SfDTSEc8Th
         wH2N2QgFdtadhvKbfo04rxbmzvPRglKuv8llUp+iByThhA7E71qgeQYEZ2Vv11rhAQlJ
         X2UQms2OpsfNwSbgXn3AYb7WBrTbzZ11IjfTCXuTe02JRD/Fr5a0SVtUFCd3XCwOPgL0
         xV4Q==
X-Gm-Message-State: AOAM531HyiBH51MhHGoQ05c3IJkmFkOySgPS+n7mRbGvuirBRZzw/AfQ
        WLGNeB2H3K4V/TrOeR58bThX1OzrfD3a32x0zbMlOmLI
X-Google-Smtp-Source: ABdhPJxskPNWIjO2/HN7v/UI+WEglKpOgD+1lZ0CjdC0FP7KpggX1VtiZqtOiuduWkjWAJO4vpWnsWg58JKbPIXKwrE=
X-Received: by 2002:a4a:a541:: with SMTP id s1mr2224855oom.49.1643300769516;
 Thu, 27 Jan 2022 08:26:09 -0800 (PST)
MIME-Version: 1.0
References: <164329905457.31174.9220154812163631144.stgit@olly>
In-Reply-To: <164329905457.31174.9220154812163631144.stgit@olly>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 27 Jan 2022 17:25:58 +0100
Message-ID: <CAJ2a_DcD+zCnLp5jqR0R48MZjmRsviucb6182S4OGpf_o0uw+g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a type cast problem in cred_init_security()
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 27 Jan 2022 at 16:57, Paul Moore <paul@paul-moore.com> wrote:
>
> In the process of removing an explicit type cast to preserve a cred
> const qualifier in cred_init_security() we ran into a problem where
> the task_struct::real_cred field is defined with the "__rcu"
> attribute but the selinux_cred() function parameter is not, leading
> to a sparse warning:
>
>   security/selinux/hooks.c:216:36: sparse: sparse:
>     incorrect type in argument 1 (different address spaces)
>     @@     expected struct cred const *cred
>     @@     got struct cred const [noderef] __rcu *real_cred
>
> As we don't want to add the "__rcu" attribute to the selinux_cred()
> parameter, we're going to add an explicit cast back to
> cred_init_security().
>
> Fixes: b084e189b01a ("selinux: simplify cred_init_security")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index eae7dbd62df1..c057896e7dcd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -213,7 +213,7 @@ static void cred_init_security(void)
>  {
>         struct task_security_struct *tsec;
>
> -       tsec = selinux_cred(current->real_cred);
> +       tsec = selinux_cred((__force const struct cred *)current->real_cred);
>         tsec->osid = tsec->sid = SECINITSID_KERNEL;
>  }
>

Thanks for cleaning up.
Just out of curiosity: the kernel doc[1] suggests using
prepare_creds() + commit_creds() to update creds.
Is is not required here because this is initialization code and the
members osid and sid are only used by initialized SELinux?


[1]: https://www.kernel.org/doc/html/v5.16/security/credentials.html#altering-credentials
