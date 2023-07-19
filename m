Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E6C0015E
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 18:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGSSTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSSTl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 14:19:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C5B6
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 11:19:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9338e4695so70731891fa.2
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689790778; x=1690395578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NM7k9DGAL3CqSUNq/elVYRl4JWhDW5IS6Q6vmMKl9M=;
        b=Ym7T5PrnyoA+n/rM1WUjPbsYlSe1RtMo7ZBymfmKDZvPvirWPZ1syd+TMqjkzsvCow
         JdRR3F+11DC9pzyRIXfi7JoTSri1pFB9mTE2a85EByjRacc9Zw/XXR45d/bnaCjdpwu7
         Ub8w2WU6rPuPIIBJx7VFAo/VfJh83QqkvxVKGJjgTdhaXf1+kI6NjZBaQ8uOuhlDMMyt
         ETInq9QgnbZHE8p47+GeA3FCualb+aO356TaPwH57axNHRnARXW/JW1gAmatVOTMEvjx
         V1oB8ivIU6KjM5KlVvyRK9BEj9yaQ/EOzVdznHE+htmafqnAX82mEfS+DR8I1pDy/Xf1
         Y/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790778; x=1690395578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NM7k9DGAL3CqSUNq/elVYRl4JWhDW5IS6Q6vmMKl9M=;
        b=AV6vhpPSCWSRy2ng4w2n1ZmhMsbv3OtPzDoOtBAEy6KFRHD8Muwq3FvXbmV5KqSlN4
         hK+sN09Lr+/4MtG9CWSGhWZ0GIkrz3qCR+CievvlwKP+AkKDIfw0K5gf1cajlLJwqAej
         DSMebDwbonbDMRkNLiqO4CcTylK0Qtk4XoI7lyoAKxY+01x2+tGzUtfco3dpLYbyg/zW
         wgLtGW4xXNUNAAYjjZ6HZUpKzLNT+L75L08chxUHN4nJi+Yr9DHqn4VnH08OA7N5eLy6
         sIUN+pdo2FH3D1lbc4AJ72yRKDUZrjM5gOcUmfFAE+FHxzv9vtIiiJW8mlE51GhyCFX0
         tziQ==
X-Gm-Message-State: ABy/qLaHTSzTHNE7nrNSDvTWictpkFkJhIOni5a6/fmjHYbEMrTItTJv
        6XL0aNEz4Y5nz49Dpnkkc1r3lomdUZIk0bnycB0=
X-Google-Smtp-Source: APBJJlGXyTbhbfH5NBRlbGIds4TOHabNY7dXeW00XKBfvyvu43Wb1ejmxBxBdfyoue5JPW8reESEBdiIm115+Wv995s=
X-Received: by 2002:a2e:960b:0:b0:2b9:4b2e:5420 with SMTP id
 v11-20020a2e960b000000b002b94b2e5420mr49085ljh.52.1689790778185; Wed, 19 Jul
 2023 11:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230710224933.152174-1-luhuaxin1@huawei.com>
In-Reply-To: <20230710224933.152174-1-luhuaxin1@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 19 Jul 2023 14:19:26 -0400
Message-ID: <CAP+JOzTo+gQasdVPYMAY7+iasAm1JfMB=asq+DObKPSBuv9Zqw@mail.gmail.com>
Subject: Re: [PATCH] restorecond: add check for strdup in strings_list_add
To:     Huaxin Lu <luhuaxin1@huawei.com>
Cc:     selinux@vger.kernel.org, shenyining@huawei.com,
        fangxiuning@huawei.com, zhujianwei7@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 10, 2023 at 9:49=E2=80=AFPM Huaxin Lu <luhuaxin1@huawei.com> wr=
ote:
>
> Check the return value of strdup() to avoid null pointer reference.
>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  restorecond/stringslist.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/restorecond/stringslist.c b/restorecond/stringslist.c
> index f9404b1..a76542a 100644
> --- a/restorecond/stringslist.c
> +++ b/restorecond/stringslist.c
> @@ -48,6 +48,8 @@ void strings_list_add(struct stringsList **list, const =
char *string)
>         if (!newptr)
>                 exitApp("Out of Memory");
>         newptr->string =3D strdup(string);
> +       if (!newptr->string)
> +               exitApp("Out of Memory");
>         newptr->next =3D ptr;
>         if (prev)
>                 prev->next =3D newptr;
> --
> 2.33.0
>
