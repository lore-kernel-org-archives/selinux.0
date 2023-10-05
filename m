Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C5AE9270D
	for <selinux@archiver.kernel.org>; Thu,  5 Oct 2023 16:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjJEQM5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbjJEQMI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Oct 2023 12:12:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAC6A380
        for <selinux@vger.kernel.org>; Thu,  5 Oct 2023 08:49:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50307759b65so1492414e87.0
        for <selinux@vger.kernel.org>; Thu, 05 Oct 2023 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696520970; x=1697125770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U20ubP4IOTZ60HzNRiW2hI+3pmPYfqb3RkdsTNw+6No=;
        b=VY0loUy8qGsQV9On/lqBkgGkUAUWx7memkMg98mG/4MIrfNPs3zo6CpCOuAeb1IUS3
         HPYiEuCIgAh5BP6k/cw+joTiiyfw4cmkJYPH5nZM3Buylzi7YNQsl/2XezUcurfvXA7H
         c66+wXOEQ6RgiH35Hqy4WmOfiMAn4ixrIZKP5TOL6rNqi0M0NJkvkaRlVjtfuHBwXMvm
         ubo7FbihNfvDvhuqeT82qo7CmMJr2Dy6dlLz6BJR7AoVk+EA6CKo8LbDOVRKgdg7RETM
         rq7dpsAF1OvxGozYXdr3KmUJVgHQdmyDyfJc/gOkIZO82HWe/56hlOMlgeQXQ0fsPa8n
         B2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520970; x=1697125770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U20ubP4IOTZ60HzNRiW2hI+3pmPYfqb3RkdsTNw+6No=;
        b=hSCvk9CFk4Ir4SuPXZOr9kPRY4C3umjv44dxWZ0uAVXrgu1KmUFjQwNxzGG/D+K3X0
         YtUOYIMx1o2bov7ELC07Ps0HbQpPija/+ZPJzcQjtrF2FNiWcRne0+9v70IbqG2lnomh
         hZs4+aOJcAQ4+wrwt7S0PcwKMWw3XL9Ly8QE6Niv4WyR+f0fNZsligrcPHdpO2yQkCon
         0Z2USyaV6SmxeDMCVjtzGefUZjxLCHlDmmlDRkS3igo31UOkxZYB/hvKElWy7pHjM0y0
         vGCXdl9xvrh7yYI2KTDwcWBW+YOyb1cxGuvydjZ4lYUThB1ZazIL27HZp1sbo9AWBlbv
         64pg==
X-Gm-Message-State: AOJu0YzLiT8uGAcPwwwrg5r4VcaE/qcclBQyNLXOrlkLt8KbKm0nFGZ0
        mbVuHikStLFOAnIhXtFb5yc8hsrrgQ9drhzkCNoo3JoWiR8=
X-Google-Smtp-Source: AGHT+IFJayBwcpc7QMUXUe8hO5/6zkHqK3yrs6y8aECbcfUM7uRTNTVo7q61GEfdq7t84Vja/Zr55ypEsBVgDmJjl/s=
X-Received: by 2002:a05:6512:3f27:b0:504:7e90:e05b with SMTP id
 y39-20020a0565123f2700b005047e90e05bmr4844795lfa.14.1696520969769; Thu, 05
 Oct 2023 08:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-16-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-16-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 5 Oct 2023 11:49:18 -0400
Message-ID: <CAP+JOzQXnPoyO1bFS_n9WBYmUF83f5gZ=qDYp4hsNGtaEvwX4g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/27] libselinux/utils: use correct type for
 backend argument
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> selabel_open(3) expects the backend to be of type unsigned int.
>
> Also initialize with a macro flag instead raw 0.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/utils/selabel_digest.c | 3 ++-
>  libselinux/utils/selabel_lookup.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel=
_digest.c
> index 6a8313a2..bf22b472 100644
> --- a/libselinux/utils/selabel_digest.c
> +++ b/libselinux/utils/selabel_digest.c
> @@ -59,7 +59,8 @@ static int run_check_digest(char *cmd, char *selabel_di=
gest)
>
>  int main(int argc, char **argv)
>  {
> -       int backend =3D 0, rc, opt, validate =3D 0;
> +       unsigned int backend =3D SELABEL_CTX_FILE;
> +       int rc, opt, validate =3D 0;
>         char *baseonly =3D NULL, *file =3D NULL, *digest =3D (char *)1;
>         char **specfiles =3D NULL;
>         unsigned char *sha1_digest =3D NULL;
> diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel=
_lookup.c
> index 112ffda1..5dc32548 100644
> --- a/libselinux/utils/selabel_lookup.c
> +++ b/libselinux/utils/selabel_lookup.c
> @@ -32,7 +32,8 @@ static __attribute__ ((__noreturn__)) void usage(const =
char *progname)
>
>  int main(int argc, char **argv)
>  {
> -       int raw =3D 0, type =3D 0, backend =3D 0, rc, opt;
> +       int raw =3D 0, type =3D 0, rc, opt;
> +       unsigned int backend =3D SELABEL_CTX_FILE;
>         char *validate =3D NULL, *key =3D NULL, *context =3D NULL, *file =
=3D NULL;
>
>         struct selabel_handle *hnd;
> --
> 2.40.1
>
