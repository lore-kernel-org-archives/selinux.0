Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C03C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 14:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCAOf0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCAOfX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 09:35:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759242BE9
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 06:35:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u9so5131542edd.2
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677681321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsyuIlAHlcPoa8hj39bUYOYBSw8PX65hE4GNQDXAw3U=;
        b=pu1QNl8hF4jlbsVAZfU+i4vGExs6nrDXGK1W9cxP6HVTSHpbDf8AR7dxCEOAVIiRRh
         +zZAMECXhr+K8dMpR9CsuR82iBQR7ELwB5ZtDOu25c2Dn28/dFwOHg6ZzMC1tl7fSmkY
         26bszrv+Wd7nnZp/lln5teODRQLFR7LpR3Fq5o1cF8tRJDv0xu8D+OBupooj5SJ9CobH
         fbPdWhy+zxqUgYsWARZ5+kOISIgq/BQXnc6acgYlvw+nZlKeYSxBWyHmUob8uHDY2pQk
         ZVYW+dJlOZq7TasFQiiU9FrIpYDMUlh6WYehyNHoim3TWbgKgr4xPde0AH5c+glcTEO4
         8qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677681321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsyuIlAHlcPoa8hj39bUYOYBSw8PX65hE4GNQDXAw3U=;
        b=wimbFLNrYhshT/FNjprcC/tld3fYoeGDcK8wi6yCSl/COvl3NPQEAFKXTckFwWwxPs
         zU6vqWriK3EbAg4sgq0xKujz196VnuIdD8IQQ1llmzhPCKWkcVW4tzCIJjXoynr+U5GE
         eyMLL42l1Zls6YF/DPIR+Jtj+hICU4a/0bP4DhjR6aSP8rg8YLAT2IzjA2ZYDsctZ8lh
         lzTnd8mMOl2vCQLLwciLJW3S3Q7DlC4Edoy4z9Lt+g0Qxss1Xap2eOFuom1pTQbDPAVw
         ZSlOcVEqFf7HwYSOSDc8OHgSRvwJ20LbP/XuubwjPYBrlneSKEF24pQ1CC0U8S4SoHdQ
         WzLw==
X-Gm-Message-State: AO0yUKWoYrZUgweUgklbSHWpP7V09YnGpcsd5oyk7FL+78OOdqyMg2+b
        uMZWrM4dNXWtGFdNG8HGNcjBcre38eMn2MBaFCs4id6xHiY=
X-Google-Smtp-Source: AK7set+Daf7wcCLjgxTKo3Z62Jb8jdezGOceD5J7cjNh7/oP/RSKrQMV0utrORBiHn0RqmRLo3PU5YktrbtsP64tNrI=
X-Received: by 2002:a50:9f61:0:b0:4bc:edde:14ff with SMTP id
 b88-20020a509f61000000b004bcedde14ffmr1107347edf.0.1677681320953; Wed, 01 Mar
 2023 06:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com> <20221125154952.20910-7-cgzones@googlemail.com>
In-Reply-To: <20221125154952.20910-7-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Mar 2023 09:35:10 -0500
Message-ID: <CAP+JOzSat=AeeMC4T5DJY=RiJW7HgUEvJ-0r9==RSET6RB404Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/6] libsepol: update CIL generation for trivial
 not-self rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Convert trivial not-self neverallow rules to CIL, e.g.
>
>     neverallow TYPE1 ~self:CLASS1 PERM1;
>
> into
>
>     (neverallow TYPE1 notself (CLASS1 (PERM1)))
>
> More complex targets are not yet supported in CIL and will fail to
> convert, e.g.:
>
>     neverallow TYPE1 ~{ self ATTR1 } : CLASS1 PERM1;
>     neverallow TYPE2 { ATTR2 -self } : CLASS2 PERM2;
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I know what is needed to translate these rules to CIL, but it is going
to require some reworking of how attributes are handled, so I think
that it is better to take this patch for now.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index b900290a..2d5d1d6d 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1201,10 +1201,23 @@ static int avrule_list_to_cil(int indent, struct =
policydb *pdb, struct avrule *a
>                         goto exit;
>                 }
>
> -               ts =3D &avrule->ttypes;
> -               rc =3D process_typeset(pdb, ts, attr_list, &tnames, &num_=
tnames);
> -               if (rc !=3D 0) {
> -                       goto exit;
> +               if (avrule->flags & RULE_NOTSELF) {
> +                       if (!ebitmap_is_empty(&avrule->ttypes.types) || !=
ebitmap_is_empty(&avrule->ttypes.negset)) {
> +                               if (avrule->source_filename) {
> +                                       log_err("%s:%lu: Non-trivial neve=
rallow rules with targets containing not or minus self not yet supported",
> +                                               avrule->source_filename, =
avrule->source_line);
> +                               } else {
> +                                       log_err("Non-trivial neverallow r=
ules with targets containing not or minus self not yet supported");
> +                               }
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +               } else {
> +                       ts =3D &avrule->ttypes;
> +                       rc =3D process_typeset(pdb, ts, attr_list, &tname=
s, &num_tnames);
> +                       if (rc !=3D 0) {
> +                               goto exit;
> +                       }
>                 }
>
>                 for (s =3D 0; s < num_snames; s++) {
> @@ -1228,6 +1241,15 @@ static int avrule_list_to_cil(int indent, struct p=
olicydb *pdb, struct avrule *a
>                                 if (rc !=3D 0) {
>                                         goto exit;
>                                 }
> +                       } else if (avrule->flags & RULE_NOTSELF) {
> +                               if (avrule->specified & AVRULE_XPERMS) {
> +                                       rc =3D avrulex_to_cil(indent, pdb=
, avrule->specified, snames[s], "notself", avrule->perms, avrule->xperms);
> +                               } else {
> +                                       rc =3D avrule_to_cil(indent, pdb,=
 avrule->specified, snames[s], "notself", avrule->perms);
> +                               }
> +                               if (rc !=3D 0) {
> +                                       goto exit;
> +                               }
>                         }
>                 }
>
> --
> 2.38.1
>
