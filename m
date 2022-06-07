Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B6C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 00:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiFHAmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457219AbiFGXVb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 19:21:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7306155305
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 14:26:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m25so17328854lji.11
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ep1+a3HeOPpgu3hZd7BAShv2CX5jwkZf7oxyMYNwCV0=;
        b=LX4m06Etsnh22gUtFXJ+6gfUR93G9RlS8CVyCQJnfZWMA5+6xidFGiTebuujaWWZ0u
         JA5WLRJAKr8OepBXQ99AIbck5rnaiuu53AYagVE0FkP9bRf8kRugMGPP5t+hs1JzrqGS
         GVpLC+MLZXUpZJ4gQ+xCNaGytLafae9MlFQieeQMSysDHA25vvq/z2jRg1NsoZ7MpiJ5
         J2hmObMV+BqbD544TXQhT12OVKfqUfRXj3qxe0dVvaBuJmynduBMQtHBbQxA7UXLTrvF
         sycVHD/HaQoi7SJ/QEsSLii2BgkHOnkK4zgjoMm4im63+YtLKSge2qLXrPB484lpF4ck
         ZdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ep1+a3HeOPpgu3hZd7BAShv2CX5jwkZf7oxyMYNwCV0=;
        b=muilxy/1J6WPqXHohE9SUyQ+VY0NeVxM3EJC62VMlj+OqCkTROx469EklTK2CMy9vt
         vSL6mmfhWnHfIjkyRA+yzBTQlVn7I20XqovSVJkaY41p8v1edygBr8CU8wxy9A/dUizJ
         oXj/SB6wtbcWcMQIj9mVS0IxzTBOzCOhivQa00kDdknk8vqON//kbsryNWTqgYoDYiyo
         wZDragBbu4FDC52XZgBsr3QlYp4bwOssGsuvpLF32ChQeJz61cIxdgdtrPst+ZXlI96n
         /JhNX7GYt/M6JMile2X7VkCq/0D/Yj3uC+qEaRrBID3wQrABdLJwwYVkQYY9C/dCibsb
         fTsA==
X-Gm-Message-State: AOAM532IU5iXpM52ozbCta7JAk5DhiBWpLWQhr3dsJl9p1FI+RPLrmyj
        QtdBD/c6ywMApyzkNUsfjdUDZ7pdBy4V3TjneJY8iA==
X-Google-Smtp-Source: ABdhPJw86SeB6jsB+X5HMH4kpjqI05wOixA35dmBKOx3sOc/Z9yHcWliUzri8FWVCavoz8bRiYCR4sjn+Hu76zW572M=
X-Received: by 2002:a2e:8715:0:b0:255:a7e5:d50d with SMTP id
 m21-20020a2e8715000000b00255a7e5d50dmr4084745lji.26.1654637211947; Tue, 07
 Jun 2022 14:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-4-cgzones@googlemail.com> <CAHC9VhRatc13ZsBSsjZeGtBfz0ouUGL9n0LTjbQtuZtYv2M43w@mail.gmail.com>
In-Reply-To: <CAHC9VhRatc13ZsBSsjZeGtBfz0ouUGL9n0LTjbQtuZtYv2M43w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jun 2022 14:26:40 -0700
Message-ID: <CAKwvOdkpA-P5763rt39q4HRjOdqC2Ca_Wu4suHU-qxpz3FkO8Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 2:22 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:22 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> > introduced a NULL check on the context after a successful call to
> > security_sid_to_context().  This is on the one hand redundant after
> > checking for success and on the other hand insufficient on an actual
> > NULL pointer, since the context is passed to seq_escape() leading to a
> > call of strlen() on it.
> >
> > Reported by Clang analyzer:
> >
> >     In file included from security/selinux/hooks.c:28:
> >     In file included from ./include/linux/tracehook.h:50:
> >     In file included from ./include/linux/memcontrol.h:13:
> >     In file included from ./include/linux/cgroup.h:18:
> >     ./include/linux/seq_file.h:136:25: warning: Null pointer passed as =
1st argument to string length function [unix.cstring.NullArg]
> >             seq_escape_mem(m, src, strlen(src), flags, esc);
> >                                    ^~~~~~~~~~~
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I was waiting for Nick to reply, but he never did, and this looks good
> to me so I just merged it into selinux/next.  Thanks for your patience
> Christian.

LGTM; you can ping me on irc #ndesaulniers on most kernel channels if
you're waiting on me. ;)

>
> --
> paul-moore.com



--=20
Thanks,
~Nick Desaulniers
