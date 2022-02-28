Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82FC43217
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 16:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiB1QNM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiB1QNK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 11:13:10 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565681263A
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 08:12:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so25774239eje.10
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7YxRKyreH48dZQ9Yk60m9yefrarInHQlSucfyX1K2c=;
        b=dytKXHw+tT3Dhd0aDmsdHtTQ6xXuj/mNxJogs8WbLKzqOu4qsyvH0GyZ4xkWtWw8gH
         dPejxY/E3QgnqEiCvNufipZss0cvtgzkPSCLR+i6luHumAwcDeOqAhtCRMg/aJPIdR6w
         9jS98MbQg4oI3x5yQ3RgLZHxhtWvyWv47ZuVix5koe5qTYoPi9hItK1fpfK+Kpeq2FbS
         YOnGG8E/v5J88ghaG0S/BIbvFE5aukRhLxBesUdOYDjf7z4Costh80kY8EY5xinm3WIG
         /5KFSLpnxXUa3lsMwFKNq6SJcca5swmpGpTS7vhNJKGN9r7MJdJI4/E36IM+u6hLNg+z
         q8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7YxRKyreH48dZQ9Yk60m9yefrarInHQlSucfyX1K2c=;
        b=Q7NWvkx7BWR3LCzFig4Xhgupl1aez9YG2pawQ8AUJ3bcseHtx69aGbar6HoE7Aq7UX
         nc9uvErEw9IBYNm+xXZPuHQ5OI36QprbrgBLq9Ndy5c2iRZ4wkGDis8/avAtYTXYcs0Y
         iuE7d/rmR31ynr3EDOJMCkc1oALFNLSlWyOdKrEMAOqpLOyzkd29tOXBTPiT7EwaOxrx
         06pDYxEI6QlNJJ66S2gcovyJy34eS8EzVboS8RFr4yYb4Jn/G5BaocSnFsfZ4iSno1tJ
         vzKM/MrkHtns+/RUCcMA8nlD9V64dMCtuIqbkFHr5CShWBXrWzZCToVOHnyxmWuOuDbz
         Hr6w==
X-Gm-Message-State: AOAM531n2s++/j/Zkt7fMpYFrtWu8eSc1dSRUZI3qkBfz3yBzN6H0jRJ
        dJdtDE4hPWN1weIcr965VDWJtVFpisNEei2pkoQe
X-Google-Smtp-Source: ABdhPJwmNFw9jVOzTMa+rnTNBvLLbYSTrhnzeA8q7epUUzrGh/oXw1/rmJAMVcVzlFpgDwpFXk216nyT5GA8CYCzPbg=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr15832693ejb.517.1646064748150; Mon, 28
 Feb 2022 08:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20220228025646.1665265-1-wanjiabing@vivo.com>
In-Reply-To: <20220228025646.1665265-1-wanjiabing@vivo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Feb 2022 11:12:17 -0500
Message-ID: <CAHC9VhTjKyfn5AJAOx6ZxDsFk7e8JTkV48JAk6PbHRyx=uy4HQ@mail.gmail.com>
Subject: Re: [PATCH] docs: fix 'make htmldocs' warning in SCTP.rst
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiabing.wan@qq.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 27, 2022 at 9:57 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix following 'make htmldocs' warnings:
> ./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
> security_sctp_assoc_established()
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 5e50f5d4ff31 ("security: add sctp_assoc_established hook")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  Documentation/security/SCTP.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks for the patch!

-- 
paul-moore.com
