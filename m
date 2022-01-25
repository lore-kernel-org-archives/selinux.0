Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B1EC5DF62
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 23:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiAYXui (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiAYXui (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 18:50:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A1C06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 15:50:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n10so50554773edv.2
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USNExYWp3361I7M07jIQSN/VZoL7IzCuon8xkUYCdfA=;
        b=3YHhVGMvbMJ5KqJVxOaKftPjrvrornfJNeBWMYcqTKk62w+sH9NPF1bNFoZEtCbPxW
         uiVEMzew6L82looBczIGluuxNIrClP5zWOSQNm2swDmNvUP/NgZ8RZV/w4WMS2kiFQTG
         OeWdqKQxdHk4FsSRGI6arDWLrLpwL5CzjjLt3LkngK1yv5q+oAVl1g3ntaQmM7Ycpijz
         TUmCRmmjHOKqIHDDG+LW0eqLpEuYQjq0nBSEV3EWuBQLk4YKK7PQ69NzJBJdoLlOqMYZ
         hzGIZk+N659TwN8103fdm52uEdTdRUexhgFYqm+gDAOTc3i0NOj+myKI2U2V04NPa6Xc
         k3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USNExYWp3361I7M07jIQSN/VZoL7IzCuon8xkUYCdfA=;
        b=aYSpolR55MgYACaNFjdX+SHF2BYGPWd68T2SIwr+/GZ7yxmhLGe73AWU8PEkGep7jY
         T0/DkfsirxkzUedIOQjGijp7fqaFqkbPAbSdPYzi4QxTlltNvK+eWnv+3UcC3s1Pn+gw
         9jPsNc1PWQJZTHRWDlPNlZG53Lk13YhTy5i5fokvuKdka05BFjTbfdcM/bBekEWDyrsB
         9fRCMiQBJ/y6Dg8J2cOozOcoyRguepcmqzsG0zBlOLX/vvJmDARrJEmfYyRGbIFRT0/B
         Qtgqvo7mwdCnL4WUg3LiEtJqFqf1Vn4SwM6xQGm7O3/AA0r6Upy4hYZVIkWlMGeIedk4
         fjIA==
X-Gm-Message-State: AOAM530Sf0zIKcziHM5edotCgc5uBWY0nuiSO728QPLX0LNnS7oH/aQM
        BcjUaWykhLnaCJDJT/ee1W81Pm4nCzsL/4wRtxVa
X-Google-Smtp-Source: ABdhPJyRVLXwCvcQxhtAL5twAIP5suqqJRAgDwxsEkwim3aXYm+zJk02C+BBHIKWPd6B1aeNgCLhdnINYQFwwYffOuA=
X-Received: by 2002:a05:6402:2794:: with SMTP id b20mr12105534ede.340.1643154636527;
 Tue, 25 Jan 2022 15:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20220125071133.188172-1-gongruiqi1@huawei.com>
In-Reply-To: <20220125071133.188172-1-gongruiqi1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 18:50:25 -0500
Message-ID: <CAHC9VhQ=p2=tz2ZE9SrkRzYUcDpwHQ9bRiNW980M3S4FEhY-qA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: access superblock_security_struct in LSM
 blob way
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Olga Kornievskaia <kolga@netapp.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 2:12 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>
> LSM blob has been involved for superblock's security struct. So fix the
> remaining direct access to sb->s_security by using the LSM blob
> mechanism.
>
> Fixes: 08abe46b2cfc ("selinux: fall back to SECURITY_FS_USE_GENFS if no xattr support")
> Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for the patch!  I just merged this into selinux/next.

-- 
paul-moore.com
