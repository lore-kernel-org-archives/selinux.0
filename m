Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E26CC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A1C21655
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FL2uJlJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfLLNxV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:53:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46113 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfLLNxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 08:53:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so1735977lfl.13
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHOO5tNBTRh50IXF+eMnCXm1lY/mHQXV7saezsYdUR0=;
        b=FL2uJlJjywo0EUt+HYlz1sHrWb6sJv6coEGpoTSC/xONlXq8azsm1AjeY7rG4CHI5D
         tPdPXpYQ3vR0cfXpaumDPnLcNKLak6G1mR5OpAXmXq9VALlj7uvORR0rjzavFQkXHVgS
         OG91imBmcoE9prb1IHzjCBUD06sC4keGW1GEr5Qo39Fpjxt1rd1yPX79GDDD1W8KpOLy
         dG0ihkhCu5M4CzUSZrfgk5iiIW0ZAnvGffNsr8ktH1GGDIAG4YB57gdm/jDisnnLG4/I
         iFMW/kJ+x8cLQh6w9TdoHhL2K35CYckllWNiHK7LhAhY7jdfbLjfg0pOmQ1ABjKvcdAP
         beOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHOO5tNBTRh50IXF+eMnCXm1lY/mHQXV7saezsYdUR0=;
        b=HRd7CDc5EaaDkoS2dK5UX8tGjXGGtxKvgea1nzv9wT7s/yvij/Yu36+gs7/2/VefjV
         q5jflt8LvZh9+gO5KaIQNnZO52SuWy0Xn9Ow8OQ7p3VI52xG49/SheHIR57sIXLGbDfo
         v0pVEfz26MGkIcjxi7BMVre+qFBGGW7OdA7aO9tf0GenHZj6Zp+WOd0az+H/sK+Hzpgb
         DTXuQVRCfPHsaevhdp8yNYoo4JZ870nkYx13WwNBZe/vc3i0BDRsSvKh9IoguFWk3Xeu
         EUVv2e5ULuYkyR8B+/i02e76GyYP0/ubK3Il0LqNwAEz1NUMxLD5pLBQOeDbMxvgOswx
         dryQ==
X-Gm-Message-State: APjAAAWC1cSR5nuREC56bPd+6JlGVju048fO0q6LVZ13WlKO7Bx6MPdt
        CdCCxaeuaUEEAeJZBaCwLHafl8Cal49Qxl5fkOXtFTI=
X-Google-Smtp-Source: APXvYqz0ixD9632G4dTPC3cpYmhIp0L+LBXylZTKlWEHpbrmCvZajO1MGt0m8cIxR6muzOkRYGBpDmbHS1ZsxApXJ5M=
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr5611236lfk.175.1576158799545;
 Thu, 12 Dec 2019 05:53:19 -0800 (PST)
MIME-Version: 1.0
References: <1576116144-55503-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1576116144-55503-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Dec 2019 08:53:08 -0500
Message-ID: <CAHC9VhSKnj6Te4px0ktdSopvf+N7WSQiYRjp_BT4+oox1VwAvw@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove unnecessary selinux cred request
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     selinux@vger.kernel.org, Yang Guo <guoyang2@huawei.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 11, 2019 at 9:02 PM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:
> From: Yang Guo <guoyang2@huawei.com>
>
> task_security_struct was obtained at the beginning of may_create
> and selinux_inode_init_security, no need to obtain again.
> may_create will be called very frequently when create dir and file.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Signed-off-by: Yang Guo <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  security/selinux/hooks.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
