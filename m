Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227ECDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441911AbjJLRyM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441906AbjJLRyL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:54:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57260B8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:54:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so1662620e87.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133248; x=1697738048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8S9rmm28TnDGhMiYmAlblOp4d1Wp1/ZXRFAdcReVTo=;
        b=fSe7rWeD6hTM4foASsv66b4so77rNqw3diVV/Ag/F6jF0jc1e8LQkpc5S2bVXBrWJj
         60wY3+D9hYjvcYuFWy/5BNQHlTikhqDHu0nsHu0cXNh8yfSfoI6A85PVeWrM3rXSkt3A
         75a8376pfdXjpc+PV8z6KE5LywRo7Y0qS6C6cWJH3H9QkAHi+NHTfZ09WIktmNPBCuae
         VRKRN28ghTcL7XZB4d6ZI3z6BZZ/+k5B+0efLV/dQuL9Zl8FefHBn/8Lh/rkLaevIrph
         1feUNJO4YJfQtHYB7v5G+cu6I5xA+0r7fAkTqVA9DovTGWAYH6Nm8r+2T3EX2cHLeh4j
         5flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133248; x=1697738048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8S9rmm28TnDGhMiYmAlblOp4d1Wp1/ZXRFAdcReVTo=;
        b=nj5/IU4WZOzppK0uszWxC+o3I/IIjgGe/PGxrJMYVHRWRdVjAxo3JpPrL6yz8hhqq/
         1+wjxTzSGNTrrzNZ6EyZ2/3wu9iSS2PYbjT1XSE3yDJ738FFFg2r6G4fJlpzzgMDao68
         Apgquaj3x9emi/wCIGso8q2jq2CMMkhMmxna+SXWtO0EwIPAkVtKoX6ribpAY3Ha9huE
         TVW0Aue9Nq/AEgBzHESNb+FF5yiB95b7BttC8hIAUBlrdbMRJwJ+oMl2ciOgsIeyOOqk
         uIARmfhGdxwCwoqyc0Mpl9dR7/dw9/RTFfkeFuGUUXClb/+LORQ7a+1PJubq2CgW36ME
         F/7g==
X-Gm-Message-State: AOJu0Yz0ZfeBzGcxva07fuv2rISammOk+3r159hmTYzABO1d6QFupXP9
        1+X8XcsSsedW9OrpB/vx+Eyc0IevfqXuzCBp79w=
X-Google-Smtp-Source: AGHT+IGxTyiEeNWevIAYe7Lcq4gRIZ8yedMUrQ3EJuBnEtO716y8keZsu/eq4fQD0eGDwAbRADBdr62b9VmNqLXYxCU=
X-Received: by 2002:a05:6512:3d29:b0:502:fd08:69f7 with SMTP id
 d41-20020a0565123d2900b00502fd0869f7mr2024515lfv.28.1697133248600; Thu, 12
 Oct 2023 10:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-10-cgzones@googlemail.com> <CAP+JOzRgAN+rGpchidjvMR=pXdPTzv5nbCvCU_8v-rmGAt7BOg@mail.gmail.com>
In-Reply-To: <CAP+JOzRgAN+rGpchidjvMR=pXdPTzv5nbCvCU_8v-rmGAt7BOg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:53:57 -0400
Message-ID: <CAP+JOzQX9Kvw_C5ictL62vVVQFBvf6g876PnHFo6d0wrxv_Fzw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/27] libselinux: simplify zeroing allocation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 2, 2023 at 4:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Merge malloc(3) plus memset(3) call into calloc(3).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_file.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 5ac23e1f..b9be1c9d 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -716,10 +716,9 @@ static int selabel_subs_init(const char *path, str=
uct selabel_digest *digest,
> >                 if (! *dst)
> >                         continue;
> >
> > -               sub =3D malloc(sizeof(*sub));
> > +               sub =3D calloc(1, sizeof(*sub));
> >                 if (! sub)
> >                         goto err;
> > -               memset(sub, 0, sizeof(*sub));
> >
> >                 sub->src =3D strdup(src);
> >                 if (! sub->src)
> > @@ -1357,10 +1356,9 @@ int selabel_file_init(struct selabel_handle *rec=
,
> >  {
> >         struct saved_data *data;
> >
> > -       data =3D (struct saved_data *)malloc(sizeof(*data));
> > +       data =3D (struct saved_data *)calloc(1, sizeof(*data));
> >         if (!data)
> >                 return -1;
> > -       memset(data, 0, sizeof(*data));
> >
> >         rec->data =3D data;
> >         rec->func_close =3D &closef;
> > --
> > 2.40.1
> >
