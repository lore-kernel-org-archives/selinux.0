Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C704C433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbiDDVzF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387210AbiDDVmz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 17:42:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFD3B548
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 14:35:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qh7so12673251ejb.11
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tf1D4Xbki6A0dJIf0PMTMKbNakwNw9muVlMNpce32D8=;
        b=jdYyKRHl9ZEUEywy84LuNQBNUtN7FR1Nwlh4mMbDkTKeDljRMaGYjtM6RVtaOzJQkc
         rVyOzZWfO9XP57+yYo/Ev+xxWbmbyxU3vnGw9uJ/Jzsbpfdt4xwApqyKpxL1xKAmMd5b
         6paHwTtYlcchP8RmRuONdztBLRxCnIEwzY0DirQbCUTD34oHjNTxIKeeFbLbEQYzXgJy
         LMdIk8+OHKVIK0Nks9jIX3kXBY6iT7RMqJtLzzO6K2+dwAYXrf4a6PHK/8vjJdzOAt6Q
         wdR7rwacYb9TDZ4t6/JZZs+CdPGCHPm56kTTqoaOG1W+T4y+n2LOR+5vpyWmGHHTLKRI
         /Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tf1D4Xbki6A0dJIf0PMTMKbNakwNw9muVlMNpce32D8=;
        b=XfmG/2yLVWDbWs/7ttiwEglk1Uh6ZN95/m/98CBVW7Lfd1P5lqZB8pXaf+aLVHOf6l
         BeUFe+UNwnXMihuIxUUus5WJViwmrbOKQGWo32PX7J9SnUJC2hPWshpysxICajMYypxY
         gz1a5fJLt/v/BiVzxJ3WHJ2ZPLIUFh+vulNGFRQ+cyaKsDHgtrcPuPvTOnH10UzISAS3
         mbCIuDpzIAlYiYYxETf80T6hI2u4WWBVzj0xjqYP4TucYc9wCd7FuBz/4jmoLnAxc3TY
         6K+0lB9f2zcXxd66PcefK0duDZSboByh+tx/AxSaVXTXahJ7cMrRbuZeQZdQIhUGOSs3
         Tt1w==
X-Gm-Message-State: AOAM531sb98rbCAAj0BtNkTuFNHUF87DEt4eRjpofQCcSrzP/ZWE0aJz
        nvm9CuWgKs/3Yd0iSE4aw2pptN5f0zuF16GbOlz+
X-Google-Smtp-Source: ABdhPJw9FJvqpRAnEIROp0fCJxKcHKxNF8Eu99KdEZdU93wEInPS47S3syk/XytRwV5qjOyCyJhh5QXA6FaXk4Aumr4=
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id
 dr2-20020a170907720200b006df83a967d2mr184807ejc.327.1649108142542; Mon, 04
 Apr 2022 14:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220404092900.6400-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220404092900.6400-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 17:35:31 -0400
Message-ID: <CAHC9VhSUrcDNCjk9p7tbfxc_rXOkjeuMgJ8Bpw_guoaD2e+0wg@mail.gmail.com>
Subject: Re: [PATCH Notebook] SELINUX=disabled is being deprecated
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 4, 2022 at 5:29 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> The existing kernel command line switch selinux=0, which allows users to
> disable SELinux at system boot should be used instead.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/core_components.md     | 6 +++++-
>  src/embedded_systems.md    | 6 ++++++
>  src/global_config_files.md | 5 +++++
>  3 files changed, 16 insertions(+), 1 deletion(-)

Merged, thanks!

-- 
paul-moore.com
