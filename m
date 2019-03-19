Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55536C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8562083D
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YDzYjuuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCSRFt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:05:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSRFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 13:05:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so6619725ljb.1
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVAhgOH/b8OoKObejxKtxgtIQmUcAuTnKW+x5SJ8eiA=;
        b=YDzYjuuqpI0zME31F3xL8sg+ZHxYaznlJoSQqhye+r2RYcR7wZQJpmHvJ+rzdvEHO8
         DBWZ/DDobWX/S2CUbNdxRIG4MI4ATxBi2iOftjXcvE88dAUwRzeDJooYYTVHFFSHT7t5
         B4zZBGELNwrnBakfTqCKwvgezNohPxElqxOLTU2PsasicNUtx/rkoXqzKymqBV4Vbr1M
         MgSjWRfK3V122lJZhfgiWmQh0O1iabCqzGIii8DTnbvHqxu1bJR5hAU/hhdrsPu14dIG
         zd6qolhQueBzw1vANHVK8ggjB2BH4FdoW8MsNl46y/2lnjS4YVZWyn0VKo0lCZ8DlvPf
         VJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVAhgOH/b8OoKObejxKtxgtIQmUcAuTnKW+x5SJ8eiA=;
        b=aHe/nsoHd32pW3+sykC8eo54+MlHTohmMXfxzj8I2s3d+nCbi24WQaI/jtNVlFxQFG
         BBSP94Wv5M3BnLg3N8dczWg+sXgXYz4A8qUw0ggJlVCwobEFIoVf91hwYM3w99J32soc
         rea6zR/KTVDIVyHDeKf/CIlPJDc909P+4Kcus+RhVktaa3u9+6G8eMoLbWanDTnn60QF
         sNGQEj7a3uZ5cThwBJ6ZRU3kWexuHZ84FE6JfvXxCQ+bvIjFFMUBXWyL0qBfNJ/8ZIsz
         ObLsAMJVFf9/d4ZVhGn9+O0YGBgYIAIJTbdFJZQJ3wXY94pIRh8jpvbBqyX4JeH4MY+k
         Ow7Q==
X-Gm-Message-State: APjAAAULrze3JXOwrhx514v7FuJLd5TXP/I7r99QKAoPn2Fa/POcDG0F
        mw/V8/V9dISfbvyIAKKZrc06sDTt+deqIPFUZexipeE=
X-Google-Smtp-Source: APXvYqxwYSyoBeaRI0dlN+A6HgPWRuhPHLy5Ixr0mPq19CcfXB2ez4SIC1jLDPr399oSvvnT0ltgLKyoUnHLltIFs+s=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr14312030ljk.38.1553015147411;
 Tue, 19 Mar 2019 10:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190319132106.21127-1-sds@tycho.nsa.gov>
In-Reply-To: <20190319132106.21127-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Mar 2019 13:05:35 -0400
Message-ID: <CAHC9VhT+0d1Us9iU3HyZPuQFPKd4h417yJbzVawkm8a8Kk0UEg@mail.gmail.com>
Subject: Re: [PATCH] scripts/selinux: fix build
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 19, 2019 at 9:21 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> We need to add the object tree include directory to the include path
> for building mdp in order to pick up generated/autoconf.h. Otherwise,
> make O=/path/to/objtree breaks.
>
> Fixes: e37c1877ba5b ("scripts/selinux: modernize mdp")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  scripts/selinux/mdp/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I wouldn't have thought this would be necessary, but evidently it is,
and thankfully we aren't the only ones doing this.  Merged to
selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
