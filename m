Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA397C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 15:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiA0PaE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiA0PaC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 10:30:02 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21AC061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:30:02 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so2887821otp.4
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 07:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZUeU41wOIxeylKgKB/Rbh8+qO/s+iq5/QO8czdUfFO4=;
        b=XN/xzg1cX2epjFRGBRdsi1EDt2t15lT1gbCY7xHcKKe2pk+HYlL1YkXh1CCNiiWzvF
         lJ6yKydDPSrargrKsmmoQhU/q4LICZ2k8Q7ODTGkHCcU76VhOjm/x74CI+ytD9PDS8om
         XqI6ChBnG3pD4DjMSy9ivuWkfIWjf4+8YvgPh8hZ2pwmClp+geA4lpIQalPTgCLjNpbC
         iygjd23Od1d0FNdrIlhtqPIHW+AxOBixnnxcNL/xTukYuDOOMIenvOw2u4l3LwBIh2BD
         s76wbRchctTf0p+1pX0pMJJ2I3GobYvJGpGPiDHr7ACUXYBRHZW+pSpGfFXFm50pKWw5
         1ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZUeU41wOIxeylKgKB/Rbh8+qO/s+iq5/QO8czdUfFO4=;
        b=f4DfI+M1hGsjviakKJDkVn4lElHbTbCeZRhVXFNa/uULjf5fKunnnmQ9tI03AVb/th
         HAHAwn81ahCJ0U78iLwyNkwxTsmPymzYXtcY74oOzKbL2lAa4wdRVO94b9rPOsD941oT
         iaUQ1LLltwDjaS+rXcwZX/L8lfB1jXstcMcxCzFoTBW6tbKhfbikZ/XVucfzIliB5vDL
         Tj04Fo6sjRzX1a1Twrcff8Xv2uN5S+UveA6vZ3UHpErIjZc7qB3/j+xO/ZmUwdonPCfi
         VCgLt/JrydQJl/jE7bXC6XX8GSdW+uYCvJ1yRRgkJ4aNDboroWY5VF73QJH8IMF2iyOa
         /e0A==
X-Gm-Message-State: AOAM533+VQ78DPleTRoE54Q7yMlWNrFoyt5toir6ItoQUZJidZqLaAgM
        BXQklgSM76T4hPQaSVbBHNXUROKtuzGcESiVc4w=
X-Google-Smtp-Source: ABdhPJzxvPr3D5OPhtJhs+IojuTHDQkrakRagQX0se/NC8akvmoxawGUGjpGEoR1ERTZxGKQZmQ+9ainNoBc++H7CJk=
X-Received: by 2002:a05:6830:1049:: with SMTP id b9mr2397833otp.139.1643297401491;
 Thu, 27 Jan 2022 07:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20220119143926.5464-1-cgzones@googlemail.com> <CAP+JOzRbmA=3kfHpCn-JwuuDKrBz5_Hpendk3JDFv-Y=RrBBbA@mail.gmail.com>
In-Reply-To: <CAP+JOzRbmA=3kfHpCn-JwuuDKrBz5_Hpendk3JDFv-Y=RrBBbA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 27 Jan 2022 10:29:50 -0500
Message-ID: <CAP+JOzRJwm2GzL4AUUSf9GUvCe0ujDO9MPPJVCTz+GTb74kZbg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: return failure on saturated class name length
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:44 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jan 21, 2022 at 2:18 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Do not return success if the class name length is saturated (or too big
> > in the fuzzer build).
> >
> > Fixes: c3d52a6a ("libsepol: check for saturated class name length")
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 562e044e..fc71463e 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -3937,7 +3937,9 @@ static int scope_index_read(scope_index_t * scope=
_index,
> >         if (rc < 0)
> >                 return -1;
> >         scope_index->class_perms_len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(scope_index->class_perms_len)) {
> > +       if (is_saturated(scope_index->class_perms_len))
> > +               return -1;
> > +       if (scope_index->class_perms_len =3D=3D 0) {
> >                 scope_index->class_perms_map =3D NULL;
> >                 return 0;
> >         }
> > --
> > 2.34.1
> >
