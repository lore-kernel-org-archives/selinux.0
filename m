Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4AC433ED
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001F46162E
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhEKBh3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 21:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhEKBh3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 21:37:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C4C061574
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:36:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gx5so27273446ejb.11
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4y9mRbTc3PZn2/dLr9BQkpDZblFapqpB9t0gbDEudvg=;
        b=AWLLJ24fPEd5sQH+sAWQN0mnc/TWhOKxkUYNOhOf1vHtrEnH4XawGf0UOmZeja9w/D
         KAmjheML3NkjGKig/trVFn4XksFAf2k/M1+thszhYFhp3bdgnkh7NWECF5+8Mo+0lakp
         ez3bAJMOzRHuiY8ieJ29NoHZNgvqR5SU2FpKUQijJXS+KdS8f3YEyqZih31Xg7FkjpBb
         GYOLqcsaoVJT7Nboy79fmK5H9a8R4vnly3fWFt4M9lr3uZg+ryk3IngQFhnmKRG8S6ml
         R46j3EdPd0QcW6CT1QCkB3xu3AP7bUlpCY+nG7tdHwVginbO7b3lAfD1arEJVue2wYAm
         420w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4y9mRbTc3PZn2/dLr9BQkpDZblFapqpB9t0gbDEudvg=;
        b=IA2FXBUzPqI+QUUe3BMtEYgrMBdoZz5l5v6eh+yluyT6cngFAB7rBKAcjt6Fy2bGMX
         s4s8wHgFGoT0ABOanvi8jmG6du1WRdVCz8Iog2CBDlfKDnaCgY8i7+uJR2m3O//74BWP
         MzTB31doFjHG28/YMsUSaG+9GzmLXdS2kXxNw1DqH28/fixph2YznEbWtMkur5X3TVSO
         gIMjgNug9Kg+YaBRNLpBcgawjWsHScHEqx6/pluiApCIBNGuJDzvjV/pU3A8GMPdxtu9
         bhohNomQs8kQJQjjclRh3Uw8PDYGd9lzCsofnceBjuSTq5dgdTkjCdEWsQH3bXytFiql
         HleQ==
X-Gm-Message-State: AOAM532gN44KSK7wNsppc93Ld2uSXGfZ62cDaGnvrzDgAE4po5DwLeGz
        HxkNhok35HIbwgayOdAak4vWpvZ35GnbeuZMyHhk
X-Google-Smtp-Source: ABdhPJxcsDZshiNY2t1VSIvwLEUAHHsXTMhJzFhnChEM6dq6dGToshDz7ekKDs1c6ORcGuwbBPognWv+dRX3bXoob18=
X-Received: by 2002:a17:906:bce7:: with SMTP id op7mr27775673ejb.398.1620696981330;
 Mon, 10 May 2021 18:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-4-omosnace@redhat.com>
In-Reply-To: <20210330131646.1401838-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:36:10 -0400
Message-ID: <CAHC9VhTHEd-y+3WKRyX8x=ydD=+cum-_5CXiH=NYv=jAR4N8mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: constify some avtab function arguments
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This makes the code a bit easier to reason about.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/avtab.c       | 28 +++++++++++++++-------------
>  security/selinux/ss/avtab.h       | 16 +++++++++-------
>  security/selinux/ss/conditional.c |  3 ++-
>  3 files changed, 26 insertions(+), 21 deletions(-)

Mered into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
