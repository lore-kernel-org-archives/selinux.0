Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C30C433EF
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbiEPRNp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbiEPRNm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:13:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D93337A
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:13:38 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w123so19402059oiw.5
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XcVN5BFz4jKdrU8PeE7AAGG+T9zoyOXwBAJeBZzUcl0=;
        b=W9VeP4tYvCrQbvuUj/bX1oM7aOQyRL/slaQpvy3yraQnNoSIzMXF7qA5APa5HTMLFM
         h/3rcQH0ginmqDUPthrcR8CejrFjnkEMIkVlcWI9SWb7mGHc4kGJbcA1V/qWVkYB8zGz
         W0v3eXz4DUQJJLtdiVd5iNb7PKexmMLLqqw8XXfZiUvIB/zZUjYRzr9ChARLw7GwwHJb
         vpq242SnjM/YOeVyKh0PQW4Iu/BLyPtIWXA1XkzqupAK2xxYLLIyn2DGkKhaVK5w4AIA
         v9dklQf2E7lDZRErZm6Cnz78S+gGE0y25QqhQSOA6tqWGF23p3CSmWuXjtVeqaiR0FsX
         nNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XcVN5BFz4jKdrU8PeE7AAGG+T9zoyOXwBAJeBZzUcl0=;
        b=b9vktWTk4tBkZMmc3FQJtltdFr+5K0dnllEN3FPMVNexJrs1jx/KhG+kh4TftKdXZS
         d0elpdqUhy6LSU6y79Y2cvvi621uBgUKejHULl7SNuLiLXMRyYXRnqAqOZm2+TNkPZP5
         iXdJnC29BpeIVD9HsnwxBeUlFBAEyQQvLpQoCGOQO6P68DOFgPrxNHRALJlHGcMZNPLw
         0YCAbrQ6Kb93sUYlVHRP/Loz4WMSPBceSQXLMIRf8M5iTLAZOa36YUgVvnogbwItzBjm
         NtxdyroH2uVwKbdAqy143tCK3x829XE08SzppRy4YTTnZoEJ3YYJ/ovDli9xZKLKiFH8
         Q+Pw==
X-Gm-Message-State: AOAM5317CzvaBOChhhcZLidvPf9O0Cy4QAiushu7KdLkNqZg/Z1uDfI2
        HiKizXOe5puh/+iJC3ehAaLymZGgciuRJOuE/vw=
X-Google-Smtp-Source: ABdhPJyLBtcc23wch0EZNvZumz9p92fEwdWV3oSJLqVMf2n0sP77QD9H9IRqFcIUE7oO6huD7s9VoMl/hvAjgjCQN/A=
X-Received: by 2002:a05:6808:2082:b0:326:9857:840b with SMTP id
 s2-20020a056808208200b003269857840bmr8482680oiw.182.1652721217519; Mon, 16
 May 2022 10:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220510174551.24679-1-cgzones@googlemail.com> <CAP+JOzQmA8JL6tLV+CW50xq4tXY6eQDGZuic2_QCQ2ZA0L-wnw@mail.gmail.com>
In-Reply-To: <CAP+JOzQmA8JL6tLV+CW50xq4tXY6eQDGZuic2_QCQ2ZA0L-wnw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:13:26 -0400
Message-ID: <CAP+JOzRzTnvXDTMEfHKUY+Cfoakc9fg-MvUMK3TCak=wgRRt8w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: free memory in error branch
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 11, 2022 at 4:42 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, May 10, 2022 at 5:02 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > In case the allocation for the filename fails, free the memory of the c=
ontext.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index e6192912..e160c06e 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -489,13 +489,15 @@ static int filespec_add(ino_t ino, const char *co=
n, const char *file,
> >                 goto oom_freefl;
> >         fl->file =3D strdup(file);
> >         if (!fl->file)
> > -               goto oom_freefl;
> > +               goto oom_freeflcon;
> >         fl->next =3D prevfl->next;
> >         prevfl->next =3D fl;
> >
> >         __pthread_mutex_unlock(&fl_mutex);
> >         return 0;
> >
> > +oom_freeflcon:
> > +       free(fl->con);
> >  oom_freefl:
> >         free(fl);
> >  oom:
> > --
> > 2.36.1
> >
