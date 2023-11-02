Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D0EC4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 19:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjKBT3R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 15:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBT3R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 15:29:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0882E7
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 12:29:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507975d34e8so1788307e87.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698953353; x=1699558153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82GX5CMUKoJtOpxXE+yq9BPJ/N8W5vd6gSUzfXgyAKc=;
        b=H5yWcSBSiMsaD8DLsKRTpcS4LibfWtSgi7p8Di/fpuzdx+s+GbWOTayE60bG6hKn69
         0y+7OsjGjPFZQgEn3SBjYqPQ5XrA0pX0n1urIIcoNhrFWaazav5oPzyjjiNJNnUaJoCV
         0KFobI4QkAegmR6xInMsE6i0TEFe07/dATXgDBt8dkiYVEMEkvoXAn9zkc3JvC+C51Q4
         EuVAwODqr60gw9t1FdYS831SUsriYLdVRUGTFAz4eHuTMxPNcrE0iWUE46L97OfUiDhn
         tsjrjmcuYN+Y0L/SA/YGzCTxstSBExJ7x+MkdJntf6pPd1amsmKHxrjZhYOWKiJhMN8H
         zYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953353; x=1699558153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82GX5CMUKoJtOpxXE+yq9BPJ/N8W5vd6gSUzfXgyAKc=;
        b=iajm1ypWe1zj0kMJV9TEpz9KYxk91hxn8y7UAzQ794MD+9lP9xaYxF2WgYvtl3O91y
         SbhIxI96fr1EmhK432MACHTlbAx8Uqj0CO9HNjXMi8NFS4LRvF/gQyFKubBY9lt0dPrl
         TzKFDaw8O2r7+ke7oGR7PSxeOWg25eBVIKo7FCVONVVTShNlNjiVRuluBQrY0BS5DMJ5
         wptID/EG+3NZW90bHwgScdHfKPXA9O1BgkYVX+se82Nlfv6RwbxlguiXvOXr1IkPQm9M
         7eg+rRpWToL/GAkRWX29NF3HA675CNisGZbQ9OriB8LyJdfWplyBtE1smOOj7aPIYnyv
         4mEg==
X-Gm-Message-State: AOJu0YwJUQcq99ZHfpSUcjmackZAkTdMOsURX1bREbbBhyalbhcBwuGM
        5iVgIGc4l2P45lUntNDebCvlxGxdPa4MPFUgoPc=
X-Google-Smtp-Source: AGHT+IEbJXvTFkFyvHexQ+T027/4obyE/wy8k03vfb53qnSvQ9kmfVQx+T4RZUkz+v6ybSFu3qdGTV6CagNyUX7H2ZA=
X-Received: by 2002:a05:6512:3195:b0:508:269d:1342 with SMTP id
 i21-20020a056512319500b00508269d1342mr18490061lfe.35.1698953352689; Thu, 02
 Nov 2023 12:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231101163830.177769-1-cgzones@googlemail.com> <20231101163830.177769-2-cgzones@googlemail.com>
In-Reply-To: <20231101163830.177769-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Nov 2023 15:29:01 -0400
Message-ID: <CAP+JOzR2=Xic26Js1eZ-Nby_iox_LHRPHLJbTGB=mnkjBErRAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: validate constraint depth
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:38=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Ensure constraint expressions are complete and do not exceed the
> supported depth limit.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index d214bf09..c6a66fb3 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -228,6 +228,7 @@ bad:
>  static int validate_constraint_nodes(sepol_handle_t *handle, unsigned in=
t nperms, const constraint_node_t *cons, validate_t flavors[])
>  {
>         const constraint_expr_t *cexp;
> +       int depth;
>
>         for (; cons; cons =3D cons->next) {
>                 if (nperms =3D=3D 0 && cons->permissions !=3D 0)
> @@ -240,8 +241,14 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, unsigned int nperms
>                 if (!cons->expr)
>                         goto bad;
>
> +               depth =3D -1;
> +
>                 for (cexp =3D cons->expr; cexp; cexp =3D cexp->next) {
>                         if (cexp->expr_type =3D=3D CEXPR_NAMES) {
> +                               if (depth >=3D (CEXPR_MAXDEPTH - 1))
> +                                       goto bad;
> +                               depth++;
> +
>                                 if (cexp->attr & CEXPR_XTARGET && nperms =
!=3D 0)
>                                         goto bad;
>                                 if (!(cexp->attr & CEXPR_TYPE)) {
> @@ -282,6 +289,10 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, unsigned int nperms
>                                         goto bad;
>                                 }
>                         } else if (cexp->expr_type =3D=3D CEXPR_ATTR) {
> +                               if (depth >=3D (CEXPR_MAXDEPTH - 1))
> +                                       goto bad;
> +                               depth++;
> +
>                                 if (!ebitmap_is_empty(&cexp->names))
>                                         goto bad;
>                                 if (validate_empty_type_set(cexp->type_na=
mes))
> @@ -318,8 +329,14 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, unsigned int nperms
>                         } else {
>                                 switch (cexp->expr_type) {
>                                 case CEXPR_NOT:
> +                                       if (depth < 0)
> +                                               goto bad;
> +                                       break;
>                                 case CEXPR_AND:
>                                 case CEXPR_OR:
> +                                       if (depth < 1)
> +                                               goto bad;
> +                                       depth--;
>                                         break;
>                                 default:
>                                         goto bad;
> @@ -335,6 +352,9 @@ static int validate_constraint_nodes(sepol_handle_t *=
handle, unsigned int nperms
>                                         goto bad;
>                         }
>                 }
> +
> +               if (depth !=3D 0)
> +                       goto bad;
>         }
>
>         return 0;
> --
> 2.42.0
>
