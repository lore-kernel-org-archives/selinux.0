Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F3C4332B
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A32072D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 17:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6QWOEsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCSRtH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:49:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42223 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgCSRtG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 13:49:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id 13so3604418oiy.9
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nkp27KStR/cC3pEfIeQ0ETtdcnUtlRr2JGHe4P8t7Xg=;
        b=a6QWOEswVKUtE7xArL0JXOS5In9C5QVT8FeGWaTrnkbmhmpf6UYoTLGQEeJjb9Qz0e
         s8kPLNRX+Wson//jTejkNUMSDoeunz6/Lbn6cq8mqp7KaNaP422gEDnkyHnkDq3vRS4T
         0s1UoStSO98uCG9niby5Wt1isjGOV4lyKC+KPSzjJnGPuP+SlgJgmXMz9eR6XTDtr9PU
         uknlEByQQPCVIZGrkB7zXkPSeFg72lRA4JCliIwnjb83h0ZNLgOhiQ72AN1ynHHCV+hq
         Wkbb/MySIIqXuVlyTZZ/2o9vgz+FjiAu444l8cSSA4cOMqy5Uihh7N/w4engNRGoIYgF
         3O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nkp27KStR/cC3pEfIeQ0ETtdcnUtlRr2JGHe4P8t7Xg=;
        b=pWGgqlUZTNgHyJF2j3eqPLPoLr00LZzHE3+ouVMmScmnSHp7qYvJESY+7lJZ5REYkY
         FbtrqXg3poSJyUB5EvtmZbj1YthDKlasxaVWxOUl5KM8xszA9q+sj06NcPqgCVzH+wSw
         j2daFvbgOzAaXO24p89X+ZI9d5Jbw3g20lP6+GpVR6J1jWDt+dhECBQSEt4XNUO6Qd98
         94rd1pxq5nL9c6ToE4SznURnO3Lh6JxhC8nBkwPH8mIgIgYSa6p1Vkhv4MrCI+qaNSLM
         GclUeycDV5hEiT/nUCc8zTbrdNVdZBZTLUPzohxTKw6ArKluHVGDvnGj51E8lmdcKji3
         Jq+w==
X-Gm-Message-State: ANhLgQ2xEbYC07UTEFrAepbCubO0c7dqnRBqxj5V14Sodnje+QGb/j0P
        3coa4ewsY5oc6vCSuwpQMlQ8dwZMPGuztRNtG4Y=
X-Google-Smtp-Source: ADFU+vuw380jMzYL8/JUb6GF8eY6Zw+7UC9Rg89n6I/OGXViV3uJILEdPRr8vkCQF4RDp+3HQMRdxoHH+Fe6gK/5cS0=
X-Received: by 2002:aca:484c:: with SMTP id v73mr3121079oia.138.1584640146135;
 Thu, 19 Mar 2020 10:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2a_Df884P05jEnWmcKkwP4rb-RQoVMCkK7aS+fNqQyM3rZqA@mail.gmail.com>
 <20200319105327.17295-1-cgzones@googlemail.com>
In-Reply-To: <20200319105327.17295-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 19 Mar 2020 13:50:33 -0400
Message-ID: <CAP+JOzTnrSoU61pj06tMvLUM3_mOS_cV-FpMgjRxg=1eO8VCMg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: set correct second argument of (t1 == t2) constraint
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 19, 2020 at 6:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently a constraint `t1 =3D=3D t2` gets converted to the invalid cil s=
yntax `(mlsconstrain (class_name (perm_name)) (eq t1 ))` and fails to be lo=
aded into the kernel.
>
> Fixes: 893851c0a146ef392b8d77de737d52245345129e ("policycoreutils: add a =
HLL compiler to convert policy packages (.pp) to CIL")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Added Signed-off-by
>
>  libsepol/src/module_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 6fe7d336..a87bc15e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1745,7 +1745,7 @@ static int constraint_expr_to_string(struct policyd=
b *pdb, struct constraint_exp
>                         case CEXPR_ROLE:                 attr1 =3D "r1"; =
attr2 =3D "r2"; break;
>                         case CEXPR_ROLE | CEXPR_TARGET:  attr1 =3D "r2"; =
attr2 =3D "";   break;
>                         case CEXPR_ROLE | CEXPR_XTARGET: attr1 =3D "r3"; =
attr2 =3D "";   break;
> -                       case CEXPR_TYPE:                 attr1 =3D "t1"; =
attr2 =3D "";   break;
> +                       case CEXPR_TYPE:                 attr1 =3D "t1"; =
attr2 =3D "t2"; break;
>                         case CEXPR_TYPE | CEXPR_TARGET:  attr1 =3D "t2"; =
attr2 =3D "";   break;
>                         case CEXPR_TYPE | CEXPR_XTARGET: attr1 =3D "t3"; =
attr2 =3D "";   break;
>                         case CEXPR_L1L2:                 attr1 =3D "l1"; =
attr2 =3D "l2"; break;
> --
> 2.26.0.rc2
>
