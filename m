Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BAE784AB
	for <selinux@archiver.kernel.org>; Mon,  2 Oct 2023 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbjJBRPh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbjJBRPg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Oct 2023 13:15:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E56A4
        for <selinux@vger.kernel.org>; Mon,  2 Oct 2023 10:15:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50567477b29so5738413e87.3
        for <selinux@vger.kernel.org>; Mon, 02 Oct 2023 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266932; x=1696871732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7roTXpxjXD0Qza9iRt86qJbyVGIyZr7CSEyB8eswW8=;
        b=TTRa3oNTVTS88gGn1dGulrUQYkwaLISGSUU/R4YK3QFKYjXG1cRT2OOSsb1Vfw7XEZ
         bFDkZAH4F8mc+5xV9PBYmmnL7kv2l6AOGNAjD+usjl6z2MHSmODSwDKK3laokzF+/1y8
         O5LdsJKIKAzUcJBcFyxd9kfEcUocoCRE7/pTFVl888DtCFuDQwnfgPZcoTmK0xYhzTg4
         g9wltjJc/bf4VbvlySWpq1U/TiD8VYqFij8uWHnQV3gmVBDd8g8vI1PQlxl1qaS111Br
         cxukE2e2gi2NOfn4kEvSpaos3ibXkRXXmhb+LW15iViUKcmgdZlWXd63PxWrgaSBhgkB
         X7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266932; x=1696871732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7roTXpxjXD0Qza9iRt86qJbyVGIyZr7CSEyB8eswW8=;
        b=Mnlxj+mTP7FsKDFZVNoZHiXhllLvjJmKZABmCUbf4BGbTynCqZWCey8U75sCsyYOpL
         oRIRuSVJvLRoIu8kAmNKuLJYDF/xwA3KvvG69o3wWaoD0WfLTTSzFzqwNcjcBxmzjKYP
         FvlGFf+Gr59HJA8uQmFpkXAnd1siyA6PXYEN1Qq6jbSStX7SQRGvNjTvv5iKtLyAG1D7
         jRYSlp6SCGdzn88wDekh9D/f6uGbQlk0RwgVhiItl9AaanLH/SuLDDAHhLviUoAACELi
         5W96W4HSTavqAAF2hqwR7g7MzR7eiyE9sPf6/+NFJ/Hznxm7R6ln/esiZCqzmr9rZ1yB
         e6lQ==
X-Gm-Message-State: AOJu0Yx5+lcCgIArJ5t2lSXer635zZieSHQi0tOrUV0f9Akiv3yyXirf
        ZKiHDb7wrf7ElcCcmQrLe5ulWm8IDtM3kaeu9Bi6Yd6e1fI=
X-Google-Smtp-Source: AGHT+IHXrBbssuemNdVLiY3FvT2SdG+lnXsGKPIxh4GthqXOzk/T/S5rp1IdDKBi6M3L9f1TjccmiEfmTTHwfEmv69A=
X-Received: by 2002:a05:6512:5c9:b0:503:c51:74df with SMTP id
 o9-20020a05651205c900b005030c5174dfmr9045403lfo.48.1696266931497; Mon, 02 Oct
 2023 10:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-6-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-6-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Oct 2023 13:15:20 -0400
Message-ID: <CAP+JOzQrN5jK3f3fYYbh_fpcm4ycFBMZbmD3p_UpGmX-nnEDLg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/27] setfiles: do not issue AUDIT_FS_RELABEL on
 dry run
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not issue an audit event of type AUDIT_FS_RELABEL in case of a
> passive check.
>
> Print the reason for an audit_open(3) failure.
>
> Do not prematurely exit in case audit_open(3) fails, since all important
> work is already done, but proceed with cleanup tasks.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/setfiles/setfiles.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 4dd0d0dc..88a27241 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -86,23 +86,20 @@ static int canoncon(char **contextp)
>  }
>
>  #ifndef USE_AUDIT
> -static void maybe_audit_mass_relabel(int mass_relabel __attribute__((unu=
sed)),
> -                               int mass_relabel_errs __attribute__((unus=
ed)))
> +static void audit_mass_relabel(int mass_relabel_errs __attribute__((unus=
ed)))
>  {
>  #else
> -static void maybe_audit_mass_relabel(int mass_relabel, int mass_relabel_=
errs)
> +static void audit_mass_relabel(int mass_relabel_errs)
>  {
>         int audit_fd =3D -1;
>         int rc =3D 0;
>
> -       if (!mass_relabel)              /* only audit a forced full relab=
el */
> -               return;
> -
>         audit_fd =3D audit_open();
>
>         if (audit_fd < 0) {
> -               fprintf(stderr, "Error connecting to audit system.\n");
> -               exit(-1);
> +               fprintf(stderr, "Error connecting to audit system: %s.\n"=
,
> +                       strerror(errno));
> +               return;
>         }
>
>         rc =3D audit_log_user_message(audit_fd, AUDIT_FS_RELABEL,
> @@ -463,7 +460,8 @@ int main(int argc, char **argv)
>                                                &skipped_errors) < 0;
>         }
>
> -       maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
> +       if (r_opts.mass_relabel && !r_opts.nochange)
> +               audit_mass_relabel(errors);
>
>         if (warn_no_match)
>                 selabel_stats(r_opts.hnd);
> --
> 2.40.1
>
