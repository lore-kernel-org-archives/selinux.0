Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D78C4332D
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 20:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7720714
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 20:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugsf/hkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTUFs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:05:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42131 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUFr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Mar 2020 16:05:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id f66so1770299otf.9
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2020 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=077xJzQYcsC8sEIe4n0cLARbxbYmN+EJ1xESVk9Cfr0=;
        b=ugsf/hkM/bV1bh/DtW3KbK4oL3grzSJgiKtVM0Be97BOmDsZg64F/FzN3F+Ev4xXQX
         tBAmPN8i9oAaLXk7bD2x2z+AHmChUsZh6aQ34Vbq0Loa8snHpnUVun2qc3dWxEL+CNH0
         0igbcKlCRLgnWHLgxBADpGaJB2C2jaDTV160TMHskr7V1SjLXb4SO6vSGBstJsvzd6VN
         6/HnaH0XKLSCu2N8PUv4CbYVa0uoedGMVj0RsadIDN3fIQzuWR0ZdhsHJOPVcz5POnLM
         ktjc6V5JjJ8C/FUkUkIlotPLu/aX/wAkvz0KiiaLj/Gk9J5bRB8IJbBJ46M/tb+ozHAP
         kSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=077xJzQYcsC8sEIe4n0cLARbxbYmN+EJ1xESVk9Cfr0=;
        b=m2lMw6ur6//5Qa5RGQvAKl6Zd3YQrqusxZx/jlZvzCH5sTfwGkvY8rfFVa7NTYq+MI
         Y2rcqunyV20KgM76FbSrFNaUOGOU3SjK7Jm6b1Fnr6oYA2qNPX2s5sdzrx/v0gMBb9du
         rVI8QrWbjtPcAR1LXhoxBQy9iFst6Gg3cebH+xzcoQFgfyfXdEiyyEaRShwNyoVa7+xw
         Mjiww3ghwmhi+puybdgqJm5g0a5QSsXBJH3f2/tZt3n2amvBQtJK00Yo2nDEgzjhY+DO
         UvECOKrsqEInKoN1nAxTC2Tkv3W+KGRe1mGTTF1mg5o7Um5vdSkr8NAS0kQ6vt+chtNV
         RQMw==
X-Gm-Message-State: ANhLgQ3zbeKzeTQPC/XVfM41FkqpQjMoEfm0jGrLGKCX3ll+8HwQhuh9
        NidnWHD5zCGZuwDWAUv+fZZ7vFKHrhhWuIBX1ISuEg==
X-Google-Smtp-Source: ADFU+vsxO7IEjo8Crqn8bHmNaeoTGs1kcXxOzA1Ux83mBpGt+6T+BMc3FkKIQhWkJQ9iC9Sfwa6q3uMXKn6pbE0jLTQ=
X-Received: by 2002:a05:6830:1f0c:: with SMTP id u12mr8172750otg.59.1584734746534;
 Fri, 20 Mar 2020 13:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
 <20200319105327.17295-1-cgzones@googlemail.com> <CAP+JOzTnrSoU61pj06tMvLUM3_mOS_cV-FpMgjRxg=1eO8VCMg@mail.gmail.com>
In-Reply-To: <CAP+JOzTnrSoU61pj06tMvLUM3_mOS_cV-FpMgjRxg=1eO8VCMg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 20 Mar 2020 16:07:11 -0400
Message-ID: <CAP+JOzSA11kgZidohZu_1NFb2UQfpGuJu+aUVTAnuVoyiswzWg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: set correct second argument of (t1 == t2) constraint
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 19, 2020 at 1:50 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Mar 19, 2020 at 6:54 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Currently a constraint `t1 =3D=3D t2` gets converted to the invalid cil=
 syntax `(mlsconstrain (class_name (perm_name)) (eq t1 ))` and fails to be =
loaded into the kernel.
> >
> > Fixes: 893851c0a146ef392b8d77de737d52245345129e ("policycoreutils: add =
a HLL compiler to convert policy packages (.pp) to CIL")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Applied.

Thanks,
Jim

> > ---
> > Added Signed-off-by
> >
> >  libsepol/src/module_to_cil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 6fe7d336..a87bc15e 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1745,7 +1745,7 @@ static int constraint_expr_to_string(struct polic=
ydb *pdb, struct constraint_exp
> >                         case CEXPR_ROLE:                 attr1 =3D "r1"=
; attr2 =3D "r2"; break;
> >                         case CEXPR_ROLE | CEXPR_TARGET:  attr1 =3D "r2"=
; attr2 =3D "";   break;
> >                         case CEXPR_ROLE | CEXPR_XTARGET: attr1 =3D "r3"=
; attr2 =3D "";   break;
> > -                       case CEXPR_TYPE:                 attr1 =3D "t1"=
; attr2 =3D "";   break;
> > +                       case CEXPR_TYPE:                 attr1 =3D "t1"=
; attr2 =3D "t2"; break;
> >                         case CEXPR_TYPE | CEXPR_TARGET:  attr1 =3D "t2"=
; attr2 =3D "";   break;
> >                         case CEXPR_TYPE | CEXPR_XTARGET: attr1 =3D "t3"=
; attr2 =3D "";   break;
> >                         case CEXPR_L1L2:                 attr1 =3D "l1"=
; attr2 =3D "l2"; break;
> > --
> > 2.26.0.rc2
> >
