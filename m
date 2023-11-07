Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7947C4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbjKGVnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344128AbjKGVnS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:43:18 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B35510E6
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:43:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso7846584e87.1
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393394; x=1699998194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRD5IfFujnsND1Se0cry+oAV5XnQftGLsT2Y4V8pXAA=;
        b=cnGRHadH6gAJKtE0VDWWHHvK9WZd/aua7BmLqKRax61fmX1xTPDXT8KqU9LETAFcLd
         ykvyzVN9nRM9C6t3qwsY7opBTEwLiXv1Ix9BsDrihTSVIedGpfCbYLkUXOsdR4i/rahD
         Do8nXCt4dNTL20+7P1kFFCnPWEMgYb//jgeZ5y+drpHhemX37nE1jLsdMtgTWdref4Xj
         gpIzENizenXjTlieg3U2xHu2arI7svFFwMGmXzS0WchVRjCNVOuVFH2uVX9nKlMoULK8
         av0dzjzcnSEfsEa+JVDnWXD/+lcJHrae1pufw27ZaunFKPEEqdAFbtZXHmVPRlW2alS/
         iOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393394; x=1699998194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRD5IfFujnsND1Se0cry+oAV5XnQftGLsT2Y4V8pXAA=;
        b=APaYgEB+8fAaN0K9kOJ1g6jS6z/GI31I+T0OX3rdz0yl3ZKXak/Ijcj0NDhGD6Xzah
         vOYtpR/WoTELmA2y89MrzwGV/rUKUvvVMrLZZywXNtwVmX9DFYQBWzCABPR2MFGDPIdw
         f5jqHNbsWpxVK+4FmHpZdMGfY/6GhcwlvLJCbul2ceNx4T74NEFFlgYuORM45crBX+sx
         fwRP6SHWidHb3H0P5Do2JQuHxmWeeLrDMOXMt4oXKItXw4fAiyAbCTBEdVio0Xp7scnQ
         9xSxFpkYm9hlTImLG972Vjts81jdJ6byXyYOH3Ut/Nza4K8uyFWHJIfFg0TCzkw6x5Ct
         6ezA==
X-Gm-Message-State: AOJu0YxXBrlBdkfVdeyBoVIEb6YUcfrcdT23xlZ6fw7pi014Zz0xQnKQ
        v5LPWWK/aQV1/K6I0vEv7GkvmHHlD0I+KTVi5sc3Bb7G
X-Google-Smtp-Source: AGHT+IFCAgRwXfn6TFLA+Qvon+/8o5V1qg00Ur92//dhI2j6VjOIMBGkTAPXvNoi8lzGcuaqgS3GuLP5SZu7dARyo64=
X-Received: by 2002:a05:6512:ba7:b0:509:2b82:385c with SMTP id
 b39-20020a0565120ba700b005092b82385cmr24153039lfv.61.1699393394434; Tue, 07
 Nov 2023 13:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20231103182612.84821-1-cgzones@googlemail.com> <CAP+JOzTBHhe8vAwOZQaVnBONma4r8LWJVHywa2BHKkvtO4_pcA@mail.gmail.com>
In-Reply-To: <CAP+JOzTBHhe8vAwOZQaVnBONma4r8LWJVHywa2BHKkvtO4_pcA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:43:03 -0500
Message-ID: <CAP+JOzQU5ZF7mHP+QRTmRNy5E02RQ_V9XmYD1JhHTtCNBaEN0A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject unsupported policy capabilities
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 6, 2023 at 10:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Nov 3, 2023 at 2:27=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Kernel policies with unsupported policy capabilities enabled can
> > currently be parsed, since they result just in a bit set inside an
> > ebitmap.  Writing such a loaded policy into the traditional language or
> > CIL will fail however, since the unsupported policy capabilities can no=
t
> > be converted into a name.
> >
> > Reject kernel policies with invalid policy capabilities.
> >
> > Reported-by: oss-fuzz (issue 60573)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > Alternative to ("libsepol: ignore writing invalid polcaps in fuzzer"):
> > https://patchwork.kernel.org/project/selinux/patch/20231101163852.17798=
3-1-cgzones@googlemail.com/
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libsepol/src/policydb_validate.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 892a0ffd..1acaa74f 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1,6 +1,7 @@
> >
> >  #include <sepol/policydb/conditional.h>
> >  #include <sepol/policydb/ebitmap.h>
> > +#include <sepol/policydb/polcaps.h>
> >  #include <sepol/policydb/policydb.h>
> >  #include <sepol/policydb/services.h>
> >
> > @@ -1522,6 +1523,23 @@ bad:
> >         return -1;
> >  }
> >
> > +static int validate_policycaps(sepol_handle_t *handle, const policydb_=
t *p)
> > +{
> > +       ebitmap_node_t *node;
> > +       uint32_t i;
> > +
> > +       ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
> > +               if (!sepol_polcap_getname(i))
> > +                       goto bad;
> > +       }
> > +
> > +       return 0;
> > +
> > +bad:
> > +       ERR(handle, "Invalid policy capability");
> > +       return -1;
> > +}
> > +
> >  static void validate_array_destroy(validate_t flavors[])
> >  {
> >         unsigned int i;
> > @@ -1544,6 +1562,9 @@ int policydb_validate(sepol_handle_t *handle, con=
st policydb_t *p)
> >         if (validate_properties(handle, p))
> >                 goto bad;
> >
> > +       if (validate_policycaps(handle, p))
> > +               goto bad;
> > +
> >         if (p->policy_type =3D=3D POLICY_KERN) {
> >                 if (validate_avtab(handle, &p->te_avtab, p, flavors))
> >                         goto bad;
> > --
> > 2.42.0
> >
