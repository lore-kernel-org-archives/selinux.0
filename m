Return-Path: <SRS0=rNkQ=5R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3697CC43331
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 18:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327F2071A
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 18:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uMrNO+B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgDASMA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:12:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36315 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgDASMA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Apr 2020 14:12:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id i7so1052851edq.3
        for <selinux@vger.kernel.org>; Wed, 01 Apr 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARlJ0pEC0Ng76rfhEHLx5JjVfuJY5nlMFNNVSJ+jUak=;
        b=uMrNO+B1qxFu7JfKw8TXzjs7ZjufUVzE/AJSn/vrcxPqfI1ZN1orV7zpIH+sQEXQAX
         l1y2GuN7K5zDYMXRyRF8fSJesg+mYDXF7YpuCPjY/oNsnt3f4uchr70H2l6GXRrQcG6W
         g+w8mYbmLc7TZ+U8S9qpyR5fkmiCDwpW+WdP0RS3Gs0JXuVCpkXLFCBTV/fhU7nDF9x4
         XhL4MVMyxORtvzAMDi1nYeuvAWwCLFcpysBAB7KoBylcc5kPS5aBh5e0K23/J1t/ZkOb
         IR9HHi1rMbd/IL2Y4lKWKEhPaewWXQllQQJCX+4vQy6Mqwv7CVAdcQ6zRwKsM/3Y0rNy
         FXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARlJ0pEC0Ng76rfhEHLx5JjVfuJY5nlMFNNVSJ+jUak=;
        b=bp5DCMAKSS2FYp8oks931GnpA/QJ6Zlmul8XbWfBYSSAMAUHKT/95yUYTsUM1TJGIa
         rdQxQAt30AsODsg/EcMbaVkXoJ29Q+lp1oztIq1jy9DtajXxzWnG1g1mBqo37rno6bAI
         JxTjTc4rtnOZ2IrFgUN3iQMOX6P0qCRZtuhprZKuRFAWhrcWGYa95XuypNosLVNQH8dp
         XyllO9xmN9T35gHEYklhwsR+Nznw/zAAFWLotVt+U91OPxIF0ax0Iz2xFkf+UGhVyIPG
         DDQr9TnI/IdsjBbc0XplMPilqlJRY5uKkIjft6n7L3drltIAmsm+gVbimmUvIO7GBArE
         GA5w==
X-Gm-Message-State: ANhLgQ0pzxtM1f9Dj3zCx2XmMd/K8h6j74JZabkaMs5lsm0qyA2nvsq+
        1vUactQtZqkjCaTIpKAczw6coG32Oxx9yUwYjtxV
X-Google-Smtp-Source: ADFU+vsii+wte8KdQiUDO7oSGQEtbM+AJCzPR1eIDISrIygraxkwgH6reXFPmkD7foLio+C5xeoqc9j50sylSya+Jas=
X-Received: by 2002:a17:906:583:: with SMTP id 3mr18945544ejn.308.1585764718468;
 Wed, 01 Apr 2020 11:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200401180920.4655-1-sultan@kerneltoast.com>
In-Reply-To: <20200401180920.4655-1-sultan@kerneltoast.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Apr 2020 14:11:47 -0400
Message-ID: <CAHC9VhQzfJhioQ6sHkyTAmn1MKWYgBoEA6s9rzTNx3FLBnZXrw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix all those pesky denials breaking my computer
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 1, 2020 at 2:09 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
>
> I'm sure many of you have found yourself in a position where you've
> tried to increase the security of your system by enabling SELinux, only
> to discover that nothing worked anymore because of those darned 'denial'
> messages. It's clearly an overlooked bug in SELinux!
>
> With a bit of investigation, I discovered that the avc_denied() function
> would erroneously return a non-zero value when I saw those denial
> messages. After slapping in a `return 0;` at the top of that function,
> all was well and my machine with SELinux enforcing was working again!
>
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  security/selinux/avc.c | 1 +
>  1 file changed, 1 insertion(+)

This is clearly an April Fools joke, but still.  No.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index d18cb32a242a..b29f19471871 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1010,6 +1010,7 @@ static noinline int avc_denied(struct selinux_state *state,
>                                u8 driver, u8 xperm, unsigned int flags,
>                                struct av_decision *avd)
>  {
> +       return 0;
>         if (flags & AVC_STRICT)
>                 return -EACCES;
>
> --
> 2.26.0

-- 
paul moore
www.paul-moore.com
