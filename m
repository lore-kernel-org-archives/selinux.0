Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F505C433EF
	for <selinux@archiver.kernel.org>; Wed, 11 May 2022 20:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiEKUmT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 May 2022 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiEKUmT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 May 2022 16:42:19 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3FF29EC
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 13:42:17 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y63so4105595oia.7
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JTwQx5Pq8jDG2oN0kaW53lXhrSYU79TvYmxFpU+NprY=;
        b=QRXjuVZONfywsDQw9d8oPgSG59CvvkvVkMnskCDOiTuyXYi94s9sCXRqGllik0wH6z
         z1fkOWXfsUpiTPqaYhaTInk5ScJZ6I76i/H98DE1gC34pMF84z6a1wBnqmvp1gTfvids
         NcZlATU9s29a1a9AiQ0C6tPHRCH2xXaE9P3U7eoItXmxcYXbn/eytLWhfLYK4BCPU9/H
         Lx2JcjvgQjz+zBPkxnHS8L1yR48a2g6HOHCwaBYj9BOEWw6R5qc6YJ6MzRpStL9B9WWr
         QG2uWVJcG4DbmLf9tEw+7P1f+MV1Fn21W7JWIdDnSy63qPq21x+MgJJjHsUjviu1nMTP
         OUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JTwQx5Pq8jDG2oN0kaW53lXhrSYU79TvYmxFpU+NprY=;
        b=W9bUoFRrXryn+5tW1zAhfnDeeGuR4v0ubLG3PpLhHLw24risiGyhTM5XrNyRcDc8yM
         82bToyBQcWBNREw7TrQO+hycTFeAnT8f6QQyifa43ERil+UIIiu9z5hcRqyBFKkBHvi/
         75uLv0haQW0szXTHKeXZaS4p1CIBV+LUBRcU1Vg8x4eoQL/kivXpdGbgxIShamhaccVk
         Mesg+e1chK6WLTYbHEMdwTdeAlL83bS4sV7bwJwQPRF3sTZgFPFRLkNoArX7ZMyQchgq
         BCkQigGECl2ZMO/sHpF6d8SmZradQJm2srKtmU2GrI4XXEVx4PC25jAuWaB4I4wilQhc
         mSSQ==
X-Gm-Message-State: AOAM532o3t8XPCIjUKYlvtj/b1t+6/MceDcoCqvhyghrAYmQHR3Gomd7
        13kO2spRmW54eHD/hs3IUAXKUHod/KfvZ9M9F1x5mDZmki0=
X-Google-Smtp-Source: ABdhPJz3ZVxhTM5JigEG279zRaFfW/M45Ck3SH3YJjYuw0LjOeGT7+0I1u6tu8/gQF4BwDz/o5/xqJeIZS99Gkuik90=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr3541016oiv.156.1652301737363; Wed, 11
 May 2022 13:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220510174551.24679-1-cgzones@googlemail.com>
In-Reply-To: <20220510174551.24679-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 May 2022 16:42:06 -0400
Message-ID: <CAP+JOzQmA8JL6tLV+CW50xq4tXY6eQDGZuic2_QCQ2ZA0L-wnw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: free memory in error branch
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 10, 2022 at 5:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> In case the allocation for the filename fails, free the memory of the con=
text.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index e6192912..e160c06e 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -489,13 +489,15 @@ static int filespec_add(ino_t ino, const char *con,=
 const char *file,
>                 goto oom_freefl;
>         fl->file =3D strdup(file);
>         if (!fl->file)
> -               goto oom_freefl;
> +               goto oom_freeflcon;
>         fl->next =3D prevfl->next;
>         prevfl->next =3D fl;
>
>         __pthread_mutex_unlock(&fl_mutex);
>         return 0;
>
> +oom_freeflcon:
> +       free(fl->con);
>  oom_freefl:
>         free(fl);
>  oom:
> --
> 2.36.1
>
