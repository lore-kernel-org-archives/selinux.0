Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC7BC001DB
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHDSig (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHDSiG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:38:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E84EC1
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:38:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so37534211fa.2
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174282; x=1691779082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHZtizOUd7xDfNaQ3LcqzY/rj3IjewQATalyhq8LPNE=;
        b=cy0oo9e7hDMA4QGRWedubdot9b1g1K/cmZZJ+hYyqZRJuH+lYfkS3+nFyeHpTugN2p
         rdV9BlxfNm6xWip/e0nyOSG6PwMX6M+LZsKXu4i+6rWRUUdCEY0pY4ODkDkM3HHI/1UQ
         Yjh7R6VNmDXK+9b4jbeQ4jF3GVtTokIOzdTPWe3n01Pz6KwiJ7CrEI1EmZPkV+3Hhydd
         CTpgNXuuS0PArgyT4BT1vXP5YzvCkhulxu+97N9NlcaXAz7irKs/MWTtkPFx7uYaHLmw
         ep1If7KUA9XoX8wD9aBYoEPjAggqjd9Qr9ErX1lcyR3wut8dNDxIwvv93xco4Tenv/5t
         LBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174282; x=1691779082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHZtizOUd7xDfNaQ3LcqzY/rj3IjewQATalyhq8LPNE=;
        b=fL0tU699jynnuCOE64QoLZrZwAcSqVEjbDt4DwskwLy+G8dpAZTCAal+Jasy+tGup+
         C12Cqa6qLT25dJhoCz2OqqTD5bNVAewcqUFkwHey/1OH9UIlbbyZL10pCdC8ZcNIxCaZ
         dTDxI5VVdGtYuzgupDMvv8wbfSoKu8jfIrYFdvi73cy27grHvuhokTgVlG/dgOb1MUsS
         JnXWl546cZjXbdrSVot9XpbVcdPXSWeS1QiKIgEngTTBLLJ+9SqIXAERyNqW+tTNaBrg
         csOXyPF5X7nN5RhkYDmXSjGvqfbX7qYjloQyfng4NEd5/LMSKWoD+qLj486aYxu/fM+J
         55Lg==
X-Gm-Message-State: AOJu0YwS7KgEzgrNKaPKy3iNIFygAxb9EHl8HQtIjJQ3obXrC7coqSS6
        cFcrC4Nhvos9V3l913w7irfXqoGDH67ee4EXoQOlJ1ff
X-Google-Smtp-Source: AGHT+IGrfkE2recpt7MumqANC0bNmOWi2W7wftcraCdru/DrY8jz3t7gHuHxC4KI3ZiLePzyEkXTuDw5vIl6IlzwOnc=
X-Received: by 2002:a2e:7014:0:b0:2b6:c8ba:90dc with SMTP id
 l20-20020a2e7014000000b002b6c8ba90dcmr1995928ljc.36.1691174282536; Fri, 04
 Aug 2023 11:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230710224933.152174-1-luhuaxin1@huawei.com> <CAP+JOzTo+gQasdVPYMAY7+iasAm1JfMB=asq+DObKPSBuv9Zqw@mail.gmail.com>
In-Reply-To: <CAP+JOzTo+gQasdVPYMAY7+iasAm1JfMB=asq+DObKPSBuv9Zqw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:37:50 -0400
Message-ID: <CAP+JOzSRp0t1nDdw5C1wvPyOEfbE7Y3hKpO4NRtr7XKRnXnXYQ@mail.gmail.com>
Subject: Re: [PATCH] restorecond: add check for strdup in strings_list_add
To:     Huaxin Lu <luhuaxin1@huawei.com>
Cc:     selinux@vger.kernel.org, shenyining@huawei.com,
        fangxiuning@huawei.com, zhujianwei7@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 2:19=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jul 10, 2023 at 9:49=E2=80=AFPM Huaxin Lu <luhuaxin1@huawei.com> =
wrote:
> >
> > Check the return value of strdup() to avoid null pointer reference.
> >
> > Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

>
> > ---
> >  restorecond/stringslist.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/restorecond/stringslist.c b/restorecond/stringslist.c
> > index f9404b1..a76542a 100644
> > --- a/restorecond/stringslist.c
> > +++ b/restorecond/stringslist.c
> > @@ -48,6 +48,8 @@ void strings_list_add(struct stringsList **list, cons=
t char *string)
> >         if (!newptr)
> >                 exitApp("Out of Memory");
> >         newptr->string =3D strdup(string);
> > +       if (!newptr->string)
> > +               exitApp("Out of Memory");
> >         newptr->next =3D ptr;
> >         if (prev)
> >                 prev->next =3D newptr;
> > --
> > 2.33.0
> >
