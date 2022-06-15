Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DBC433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 01:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiFOBSu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbiFOBSm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 21:18:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB512B1A8
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 18:18:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so299125wma.1
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K7pGdzJdqHuYwS1bYbVurI6uCtk6tWf/NxPbeZGPiKk=;
        b=GJSIGAWb4wWJ8zVfW/PVsPdfLVoxFfdu+fX7vMMLELUREnwZiwyQ63nvuzC4+1dz/J
         atxtgSdFQZlpQffy1/MdOu+imIksqdVQVno/DmT95AU2hx80ZyxLX1LBxM8Hhwkg4Q+i
         fDbskaRzFIkDCRNqr9wjyHTFmGon1p/QhKDN0Gp1pjo2PFxXfrIrnthi6MqS70DykRMw
         qlsV5DUsfLB1NzaOOIGp4I5B9yjAVqWbKQCVjJqDfO3DMX/WbZnwqj2FTd25oyCcJuNQ
         9mhHNH9tgK7JGoAzzzXpitwQcA9W+KyO0Tc6hK5tE4NrIafd2trDuR8hf9SgSP7R4fF9
         srqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K7pGdzJdqHuYwS1bYbVurI6uCtk6tWf/NxPbeZGPiKk=;
        b=JOZ+kGgrU9tj6sCewSVRlDzfTdVaZYHXo+NVu3FqbjjOQPNgeTXEZSKMUtpYRNg4/W
         ta59QeKL37bRAp3A9fCBXLATyBRigLVsKNHyRkcx2VsBtxkcT3YPF+13+Fr/93WG8hb4
         M1zyDMo+e2gCNVXn66puMVbzoxCZLnn7paYUD36/I3v80Dz7i/r/dqzwRMNmVcjHBJ8l
         87oDl0F1kJ5UnNY2rUaVB7+uY3Xq1a2msicgTdYYC2haSf1hssqvgCzoZ2HP/7ykXlcr
         +5Dqg02Zw/joVUQ4Mn6O3GZqsdGaJmxdhGXbfX2sy0NfyXr79UAuYjebbM+7Q3T4EAaM
         Mmew==
X-Gm-Message-State: AOAM533EBqQdkxZfEj2Z2DxlQqWfWQnoAyWBd6ZTvwaZnAWYzopGGFUb
        g9VdZvChTIEoEIYkI4yqmq8UYCY1tYsD3hddvAQh
X-Google-Smtp-Source: ABdhPJzq0py4jwRNDajc+XMV6fU5cc1yxRWaEgccOkiLbfpdOU8rMLWl3D6nw1mmBwN641Lc+w/Ngmp6j05FQilyTWU=
X-Received: by 2002:a7b:c38b:0:b0:39c:6964:34a2 with SMTP id
 s11-20020a7bc38b000000b0039c696434a2mr6921750wmj.165.1655255881271; Tue, 14
 Jun 2022 18:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220611090550.135674-1-xiujianfeng@huawei.com>
 <CAHC9VhSwYdrHw8jNYxWApPYMjnmX-ZDN1=CzmRBeS1HoL-KOOA@mail.gmail.com> <c54658e5-f0bd-b3f6-3cf8-d7d0e8b1c4df@huawei.com>
In-Reply-To: <c54658e5-f0bd-b3f6-3cf8-d7d0e8b1c4df@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 21:17:50 -0400
Message-ID: <CAHC9VhTkfBm8zCDw=m+jaDZW15LB+bRJ5+ymxsSJKW=V645S2g@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix potential memory leak in selinux_add_opt
To:     xiujianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 13, 2022 at 9:18 PM xiujianfeng <xiujianfeng@huawei.com> wrote:
> =E5=9C=A8 2022/6/14 4:22, Paul Moore =E5=86=99=E9=81=93:
> > On Sat, Jun 11, 2022 at 5:07 AM Xiu Jianfeng <xiujianfeng@huawei.com> w=
rote:
> >> In the entry of selinux_add_opt, *mnt_opts may be assigned to new
> >> allocated memory, and also may be freed and reset at the end of the
> >> function. however, if security_context_str_to_sid failed, it returns
> >> directly and skips the procedure for free and reset, even if it may be
> >> handled at the caller of this function, It is better to handle it
> >> inside.
> >>
> >> Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early"=
)
> >> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >> ---
> >>   security/selinux/hooks.c | 12 +++++++-----
> >>   1 file changed, 7 insertions(+), 5 deletions(-)
> > Have you actually observed a memory leak from the selinux_mnt_opts
> > allocation in selinux_add_opt()?
> >
> > The selinux_add_opt() function has two callers:
> > selinux_sb_eat_lsm_opts() and selinux_fs_context_parse_param().  The
> > former cleans up the selinux_mnt_opts allocation it its error handler
> > while the latter will end up calling
> > security_free_mnt_opts()/selinux_free_mnt_opts() to free the
> > fs_context:security when the fs_context is destroyed.
> >
> > This patch shouldn't be necessary.
>
> I may not have made it clear, I said potential means may have a third
> caller in the future.

Let's not worry about it.  If you wanted to add a comment header to
the function (see selinux_skb_peerlbl_sid() for an example) to make it
clear that callers are responsible for cleaning up @mnt_opts on error
I think that would be okay ... although even that is going to be a
problem in the new mount API case where selinux_add_opt() is going to
be called multiple times.

> I think the error handler as following is not necessary:
>
> err:
>          if (is_alloc_opts) {
>                  kfree(opts);
>                  *mnt_opts =3D NULL;
>          }
>
> otherwise, some error paths goto err label while others don't, It's
> confusing.

That's a fair point.  Looking at the patch which added it, we should
probably also return EINVAL when @s is NULL instead of ENOMEM.  In
fact, in all the cases where we currently jump to @err, I think we are
guaranteed that @is_alloc_opts is false as it requires a previously
populated @opts.

If you want to submit another patch, I would suggest doing the
following in the patch:

1. Change the @s NULL check to return -EINVAL when @s is NULL.
2. Allocate @opts/@mnt_opts if NULL, but don't call kfree() on the
object in case of error.  The new mount API will cleanup when it is
done and selinux_sb_eat_lsm_opts() will cleanup on error.

If you don't have time to put together a patch for this, let me know and I =
will.

--=20
paul-moore.com
