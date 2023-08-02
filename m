Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F2AC001DF
	for <selinux@archiver.kernel.org>; Wed,  2 Aug 2023 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHBTV3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Aug 2023 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHBTV3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Aug 2023 15:21:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC8FDA
        for <selinux@vger.kernel.org>; Wed,  2 Aug 2023 12:21:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so2218531fa.1
        for <selinux@vger.kernel.org>; Wed, 02 Aug 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691004086; x=1691608886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly7li3josvMD00ku3VCy6NIXLNlLKbGcfJ07OF09pQg=;
        b=dGWtrCqXoysPwZabLU3NLMXCuekg3jPfGBCR3Tyo1HMMBICEUSnkO/KyFuTbsysW+y
         93kedvJRzJkQzvgoRmIQHNtZ7ETGQnqa6J6D1kB8DmN6RNbIEyEX1I8xmwTKkvQ69Pz3
         dR6ceyczd04lTnZQud/YIJmajwKaJZCioNDGzEpH4Dqq7LvoTKJ4BmecUIP6BaI81LS1
         fAAo6NyH6q1EU7rXvSQD59/VgfqihRyAgA2ohIsnvA+lJuW5diPjQAbHYoWywGKc+dXw
         8lOspTWENQwFNQ4/cDVLY292gY4Avmfi7IYTtf7xsnJqMb8uSBkk9/v5D10dYYmEtNr4
         WaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004086; x=1691608886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly7li3josvMD00ku3VCy6NIXLNlLKbGcfJ07OF09pQg=;
        b=MSRvYMkY/RJdRLpK4ZsE46E6RnR81fM6QdBWT12EuDgEZze+tgDnTdu17UqkLgT1a8
         PGxujexiaE/VztV3USkatBLOtWxcWP4HsEdWhq0x/QB4hBQ5RTBq0Lv12Hjb1TyrSd/I
         5nnYGQwD8vGZc1e5htpkSzZZaU39nEjuOCP8OvehoNOlKmTX+9MGOaCg2QPbmeu1rSOo
         h2Dyiu1lK6AkALsQ4UI54iTI+1z0gT9laPCO3IoDXsC0VbWWxDjIl7vcIagNmWZ5L4S5
         knBzKlz/fGkGinYPQDeDmUqqsS4N+Chm7exUwtfCCyQBoFS/uqAUzJPhXt0RSDBCXG/0
         71mw==
X-Gm-Message-State: ABy/qLYlGkwgPzhL7JWjiBJilbdQpnvvz+YXGRIgoIiLJtHKmEVszDGq
        VCmcf0UqJ8G7td9RwbwIYzaKQUNKA8CUPntc02Y=
X-Google-Smtp-Source: APBJJlEj43YqAUAyOCoxnwBxUrLWEhpvSpWZpWD2p1/EAEmxfZyZ3qMod9/vFjQlVzZcKdP222jMBeGpaQJxQUQ5CW4=
X-Received: by 2002:a2e:870a:0:b0:2b8:36d4:7b0a with SMTP id
 m10-20020a2e870a000000b002b836d47b0amr5435481lji.29.1691004086131; Wed, 02
 Aug 2023 12:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230706141801.58737-1-cgzones@googlemail.com>
In-Reply-To: <20230706141801.58737-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 2 Aug 2023 15:21:14 -0400
Message-ID: <CAP+JOzR7zmVzTPdM5dBrbwKGuBZFw2C+Uxa_eLGV=RSjKiMUJw@mail.gmail.com>
Subject: Re: [PATCH] setsebool: drop unnecessary linking against libsepol
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 10:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> setsebool does not directly use any symbols from libsepol.  Any
> transitional ones, via libsemanage, are available by linking against
> libsemanage.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/setsebool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index 4b55046c..c1440c1c 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -6,7 +6,7 @@ MANDIR =3D $(PREFIX)/share/man
>  BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
>
>  CFLAGS ?=3D -Werror -Wall -W
> -override LDLIBS +=3D -lsepol -lselinux -lsemanage
> +override LDLIBS +=3D -lselinux -lsemanage
>  SETSEBOOL_OBJS =3D setsebool.o
>
>  BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
> --
> 2.40.1
>
