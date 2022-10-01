Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C8C433F5
	for <selinux@archiver.kernel.org>; Sat,  1 Oct 2022 13:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJANrh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Oct 2022 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJANrg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Oct 2022 09:47:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27852FC0F
        for <selinux@vger.kernel.org>; Sat,  1 Oct 2022 06:47:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w13so7423412oiw.8
        for <selinux@vger.kernel.org>; Sat, 01 Oct 2022 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s1AnG7b0F9HoJsn04NU8iQKTlLOBff200VnBnLss9DA=;
        b=uWf7aOrdMp1pU5o747DuHlxwTK1xy1zFUtV9EQYyyUZANk1SZPrKCw8EcXjzaId41m
         zaQUaAnwaPPzHspUavXF+9fyAZB4iYzwhpJk6gZ2GrAqQ6FG/+t8mJSK74eJXgIA8KOR
         7loIR3Y+18acUsdH8XdcW531kervne83exaD2XscwL6QW0ijyl/TbDxiaL0nu3GDcyc5
         464iRjSBdw2HuTU7DKOPVTAofbOLYG3gpuDpmzIMBU5qWCrTDBMj6Iovkd3DqKUpg2iF
         RI7oVmjbQD8cqWU7O9gFHBmxv6WotoD3SMt0e2re8JrIc3EASZkgRWGKX2zmWqr+gn5r
         JAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s1AnG7b0F9HoJsn04NU8iQKTlLOBff200VnBnLss9DA=;
        b=uQ7ccIIGxeKdlJ/RxXIaeiQqvMG4iXCce3Og8d0TVi4SqsEUQhLpQzty/JfH1bz+rG
         yljh5lHNdZ+8Lh4YdoLC0bvt7q2CS9L/19lQhPTU+PjY7xjy2lKM4iarbWTi6+KKjGgr
         K67tqeYqYg/7W/t+uc8IXowk9qV38s0FTGXh8F+9XW/eIHjLxTcVgbNTZgG0SvJkGZCV
         oTWlsy7Jz95RhyCsA3Wz94v6jnMCe0YOCG2afOnb83gH+C4ze9hOGPotNOVU4jSfhFjl
         gykDwRqgvLSb0q+8bcizGIX6wEn//5a7GFK8HUbOeud+1aedhb5mmuXel/MCyvPB49te
         WcKA==
X-Gm-Message-State: ACrzQf2vO3tDRkxcqNORXGc3zTGCeoxXEiUW0PJwZrb80IUmWk9PqjQP
        RJUQ8tP4Th1kcnpNDFUjPliPXlXs4meePTBICXMrufnW3g==
X-Google-Smtp-Source: AMsMyM4qG4vVAPzAVFb1NxG8RglL3iUGJOe3kJpugPk5rdokyhAahY0n6j8wSOvpLVqVwMfoq8kQ/zBL+F1H0LeHJM0=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr1119177oiv.51.1664632052178; Sat, 01
 Oct 2022 06:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <166457327058.375622.15969426802353557144.stgit@olly> <584c2285-0c86-8e31-77ad-4ad2e31931b7@gmail.com>
In-Reply-To: <584c2285-0c86-8e31-77ad-4ad2e31931b7@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 1 Oct 2022 09:47:21 -0400
Message-ID: <CAHC9VhQuB3ZejJvYyB9A=R=ueU1iJvNEQUTAwrxUzq+pDEVEpg@mail.gmail.com>
Subject: Re: [PATCH] docs: update the README.md with a basic SELinux description
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 1, 2022 at 3:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 1.10.2022 0.27, Paul Moore wrote:
> > This is to help meet the OpenSSF Best Practices requirements.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   README.md |   19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)

...

> > +Please submit all bug reports and patches to the <selinux@vger.kernel.org>
> > +maling list.  You can subscribe by sending "subscribe selinux" in the body of
>
> s/maling/mailing/

Nice catch, thanks.  I'll post a v2 right now.

-- 
paul-moore.com
