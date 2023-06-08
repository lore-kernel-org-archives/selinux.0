Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F0C7EE25
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjFHTvM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjFHTvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 15:51:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D52210D
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 12:51:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso10033421fa.2
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686253868; x=1688845868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85E1BvNIUfJAM7uM8kb+7qN/EczF1R4b8LoMEaGs+1I=;
        b=AtIyPEpemjxmQ18lDL7TiwvfS799KeSn248BLwdvGgfo6gM2N7KWggUtKDH7kabhUS
         oFKaQBS2GqGyDp/BCf1dOuve+XIMYPvTJeEsj7rlFNs7A2cLEtvTqCBIaXNkXqfXpe7V
         ySnPu+DvZ7w4OnLbclcIQ72oHBpRP4sFdePStXEyGioSxfPq3BhtR7Pb9YFPCIac8NYb
         evLTJ9r31ePg93k8nRtf/KVJM5SJDxzuuaBrrkUmwX24tzGtjHo/cVROn3usmu8HsA35
         5Lv7Ccsk4VKwJSwccm4hdWAS3UIvdUsVxjQlViqz/52y4tPAsljoCRoGJK487CJH/gfj
         f+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253868; x=1688845868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85E1BvNIUfJAM7uM8kb+7qN/EczF1R4b8LoMEaGs+1I=;
        b=VbE+GQrprRabonUY8LfFy2P3JWgMsKiKPMitfgf/4Zf3iTEOPvBenOD58S0e3Cvz++
         Lwpt2wH2ED7TPeep8+27LaLeTGdethqmvmB6Z4vPUaXnubQRe/gi/rApRoOrLDu/0oeJ
         M7vcxqAtUOpEcWc1PHoHIyYeZJqQBpwgIBPtVCVueHWQAbirU9CdC6xVBXA1Uw/eCld8
         s/OfZEkxaDvKY0BSngI6caPRFYMXK/rsJemykAWu2120+E7n4eG/SFY/yCD61CUUtt2w
         QxHObA0L1hU/Fm0t3atEF6pNUgaH7jFe8eWBfFGeuKpPQCZbZHtKr/+KtyENcNsVFYfe
         +T7A==
X-Gm-Message-State: AC+VfDwniQFYcI5ASZkb/LiigcvCyLJbUo3mAiZD1VMbt23H5+ar69Eu
        HpFspu1bGelg6oFIESZmTe9NpIYhPIbmsDlFcjI=
X-Google-Smtp-Source: ACHHUZ7IXAZuMzAg9m4Yh1jMiGmvk//+cI0oIsKu9xaFkHpDnysjE6QeVmzIaanJ29Ck3Ozpyf5nMx87uXiLfHBdGEg=
X-Received: by 2002:a2e:9b47:0:b0:2b2:34b:8421 with SMTP id
 o7-20020a2e9b47000000b002b2034b8421mr2413393ljj.30.1686253868137; Thu, 08 Jun
 2023 12:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230531013224.1135775-1-yamato@redhat.com> <CAP+JOzTypfDmj1jF8o28dWUABuFyEUjq4DVMefTzwL-BkHVnDA@mail.gmail.com>
In-Reply-To: <CAP+JOzTypfDmj1jF8o28dWUABuFyEUjq4DVMefTzwL-BkHVnDA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 15:50:56 -0400
Message-ID: <CAP+JOzTP8Lj=egK8JOtX4d0o48zG87af1fBgvNFCmusfCtXaFA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dismod: add --help option
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 7, 2023 at 9:22=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, May 30, 2023 at 9:36=E2=80=AFPM Masatake YAMATO <yamato@redhat.co=
m> wrote:
> >
> > Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>
> It might make sense to add the actions option to dispol as well, but I
> am not sure how much dismod and dispol are actually used.
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/test/dismod.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> > index 929ee308..eb090a36 100644
> > --- a/checkpolicy/test/dismod.c
> > +++ b/checkpolicy/test/dismod.c
> > @@ -66,7 +66,11 @@ static const char *symbol_labels[9] =3D {
> >
> >  static __attribute__((__noreturn__)) void usage(const char *progname)
> >  {
> > -       printf("usage:  %s binary_pol_file\n\n", progname);
> > +       puts("Usage:");
> > +       printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
> > +       puts("Options:");
> > +       puts(" -h, --help       print this help message");
> > +       puts("\n");
> >         exit(1);
> >  }
> >
> > @@ -872,7 +876,7 @@ int main(int argc, char **argv)
> >         FILE *out_fp =3D stdout;
> >         char ans[81], OutfileName[121];
> >
> > -       if (argc !=3D 2)
> > +       if (argc < 2 || strcmp(argv[1], "-h") =3D=3D 0 || strcmp(argv[1=
], "--help") =3D=3D 0)
> >                 usage(argv[0]);
> >
> >         /* read the binary policy */
> > --
> > 2.40.1
> >
