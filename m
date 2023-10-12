Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDEECDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379651AbjJLRyr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379682AbjJLRyq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:54:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C249FD8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:54:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50308217223so1605948e87.3
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133283; x=1697738083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzSdTC2KXBigRZ9swF6WMKTVE1RkOI6icRiQUzKH+LY=;
        b=kAZWYaq0H10TT15Io1v9EAFcUE6aoiGx/hv7iD+e3U9q64Yu+Kj56JnVJnuCYOeP8u
         R7eP7SUuIkOS71tEIdX6+wdMpDyXccnRSzqxzkKkQI8jFn46Cm5C3zQXPwPwiyLrFq48
         LsoToZoR91agOc5nn41Zc8lYM4jZ9XLWvAYWlbK0zhQGa6gCwji5rXH3/jNq8Qkx+BdN
         mCXSWMEe/V6SnqP/0hXcM/8AofJASKRulsJWobefO3/wfKqizWqh9nPwMI5mg7kkWMXK
         A5UHIuZbG9+WQTrsJnc4G8KSeXB/eEW5HIK/ue97S/95JkAsZyO0oRDFoz9dhVQTmVbX
         Mzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133283; x=1697738083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzSdTC2KXBigRZ9swF6WMKTVE1RkOI6icRiQUzKH+LY=;
        b=aaze4S5Xoq0dabF/ymmRHEeJyY90JakyZP4DsZYJuYZfIqnyxEYayAeV6jdHQF2xVX
         mZqQYVC1EFaAix5qaNQuUDOWXWOCUqt90/bmSe90dh04WQs0IlVkiPs6/q6HnrtMnzHZ
         LEsmOgXHzsnPcIHKf8Ky3jq9AUFpGX06IHeK9HYoBijMCpCkqc1dFPjSndRBO0XN07rU
         hdy1WIuh39qeSK7w8ED8AUX7PRxQfnvsuVDsfT2zsbZlIjYGYFF7X65XrkhNDkde5nRT
         jH0168DgNsTmOp3gEJj87Fx7wzAolon1QxtNJQwReXpn8uAQJp0YWFObab3l8w+IowCQ
         t3PA==
X-Gm-Message-State: AOJu0Yw3xqE6iPe8hfEckQPP6o8bnJchLRz+d9cC7LsCyZ3kCmH874h9
        lNXunLTBdT2Vefi/aP8udFphns5Zq66AJXKeimU=
X-Google-Smtp-Source: AGHT+IFY4I5VexCyIgfgHiy0bO69tLAF0HTXEk5J+6yWfhywzE36qWZOvkJ1IrBZKa++qJ1rlyTz7EAgnt7lgmXV4D0=
X-Received: by 2002:a05:6512:1153:b0:4fb:7559:aea3 with SMTP id
 m19-20020a056512115300b004fb7559aea3mr25180090lfg.39.1697133282768; Thu, 12
 Oct 2023 10:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-13-cgzones@googlemail.com> <CAP+JOzR5_Ac8QFLk+V6XW9YBnqAxg+4rFkzii-sKi7ac74=ETA@mail.gmail.com>
In-Reply-To: <CAP+JOzR5_Ac8QFLk+V6XW9YBnqAxg+4rFkzii-sKi7ac74=ETA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:54:30 -0400
Message-ID: <CAP+JOzR=oD59ZDPSr0j_sKLVcsVi88vnccb5MEXVijE_YC5cLA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/27] libselinux: avoid regex serialization truncations
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 5, 2023 at 10:44=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Check (for the probably impossible) case the serialized data is longer
> > than the compiled fcontext format supports.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/regex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index 16df6790..88d82fed 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -176,7 +176,7 @@ int regex_writef(struct regex_data *regex, FILE *fp=
, int do_write_precompregex)
> >                 /* encode the pattern for serialization */
> >                 rc =3D pcre2_serialize_encode((const pcre2_code **)&reg=
ex->regex,
> >                                             1, &bytes, &serialized_size=
, NULL);
> > -               if (rc !=3D 1) {
> > +               if (rc !=3D 1 || serialized_size >=3D UINT32_MAX) {
> >                         rc =3D -1;
> >                         goto out;
> >                 }
> > --
> > 2.40.1
> >
