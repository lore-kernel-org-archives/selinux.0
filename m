Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E1C001DE
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 20:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHDUBj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDUBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 16:01:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC69BE6F
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 13:01:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso43908951fa.1
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179294; x=1691784094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvIEygZX+W1QerM3GiAp10ea5P366jEiwwptbMPY29g=;
        b=MbkC3q1oxju7m29hpzV/TnHPK899UfXJDWAIzruB2h128zmhn8YCHf+jMT91Fl5I+x
         wQnY+qC1mg2EO/+ZG5i2EXNMjL23q4e8OMGo3P8Za9NjAltswL6DTXuE9+ndkwLMf5Rn
         PlSoUxhQiUBZiPdx1lrcz53oJ+N70mpq4Fb/5nMV33SheAatU29c2DemwWjKYB0gNTme
         B/wNKwwgc1PVg6ouynQla79s2FkCer6SzJIUnBAmIbmnBk3SNolOsNbUTHjCRrxhgAo5
         BUCRW2Nioq7s3aJv1xVKcqxOlbSj+se0EZ+tVhqrnmP/g9YTTh0U1GmL0JLMRfR6F76c
         exUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179294; x=1691784094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvIEygZX+W1QerM3GiAp10ea5P366jEiwwptbMPY29g=;
        b=boPh/4Y777c+hr1OkWl+qnI4hgkmW5vZk9YddWgnCHZq0XHR+531+9P7Pdsp1ni1Jg
         DcNwtFQ/yzPbbu46Fe7nkOs7lPrsut6W4Eb84NXuqhnXSHkFIIPNlfLpU1WUISXkIl7e
         X1qO0jb7hX4/KPsj6eoGjdbD38Xmw32WUpt5wAsdRQQwP/yfQLlxN/mhW8epOe7LDUR0
         68i2zM8TCc+Tzi3IphEjFMjU3EWu5bdnWnxNDDZ27Y/eg/GICgNGl0HOvQAMFhwCxMka
         LrWYBTy2Ek7vP3DYyKCuV6NqmyLn63x+9HJfXZFXWPtOIwCG2deZfNwpdKJ2XoAYZaq3
         72MQ==
X-Gm-Message-State: AOJu0YxOJmk+ttH0QVPfVS4smlCyCuI6mrcuu8RpH0O8dgYEVBNnSg2V
        HLHHDwG1Kpg3jhRUmGPl2M1sYLqq0cuFWwQzcV6GfEfe
X-Google-Smtp-Source: AGHT+IFmb+vP3qfBItsPVuqi6XZIvtAW8g6mXWZ6W7jF5vllm0L8S9ycJ9HOa4sXKSmRnGZZi5H4nBoRLlH1G5y3y58=
X-Received: by 2002:a2e:9cd7:0:b0:2b6:d47f:2a4 with SMTP id
 g23-20020a2e9cd7000000b002b6d47f02a4mr216274ljj.13.1691179293818; Fri, 04 Aug
 2023 13:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230713180816.101924-1-cgzones@googlemail.com> <20230713180816.101924-5-cgzones@googlemail.com>
In-Reply-To: <20230713180816.101924-5-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 16:01:21 -0400
Message-ID: <CAP+JOzTMaYEEs5tnx=L6zFv69we=PYgdh3xzSzvUMEFTsF=2Lw@mail.gmail.com>
Subject: Re: [PATCH 5/5] libsepol: avtab: check read counts for saturation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 13, 2023 at 2:49=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Ensure counts are not set to the maximum value of their type.
> Also limit their size during fuzzing to prevent OOM reports.
>
> Reported-by: oss-fuzz (issue 60572)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/avtab.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 9c7daf8e..cb2ca06a 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -461,6 +461,8 @@ static int avtab_read_name_trans(policy_file_t *fp, s=
ymtab_t *target)
>         if (rc < 0)
>                 return rc;
>         nel =3D le32_to_cpu(buf32[0]);
> +       if (is_saturated(nel))
> +               return -1;
>
>         rc =3D symtab_init(target, nel);
>         if (rc < 0)
> @@ -736,7 +738,7 @@ int avtab_read(avtab_t * a, struct policy_file *fp, u=
int32_t vers)
>                 goto bad;
>         }
>         nel =3D le32_to_cpu(buf[0]);
> -       if (!nel) {
> +       if (zero_or_saturated(nel)) {
>                 ERR(fp->handle, "table is empty");
>                 goto bad;
>         }

The other three hunks depended on the prefix/suffix patches, but I
think that this hunk might still be applicable.
Jim

> @@ -909,6 +911,9 @@ static int filename_trans_comp_read_one(avtab_t *a, v=
oid *fp)
>         key.target_class =3D le32_to_cpu(buf[1]);
>
>         ndatum =3D le32_to_cpu(buf[2]);
> +       if (is_saturated(ndatum))
> +               goto err;
> +
>         for (i =3D 0; i < ndatum; i++) {
>                 rc =3D ebitmap_read(&stypes, fp);
>                 if (rc < 0)
> @@ -951,6 +956,8 @@ int avtab_filename_trans_read(void *fp, uint32_t vers=
, avtab_t *a)
>         if (rc < 0)
>                 return rc;
>         nel =3D le32_to_cpu(*buf);
> +       if (is_saturated(nel))
> +               return -1;
>
>         if (vers < POLICYDB_VERSION_COMP_FTRANS) {
>                 for (i =3D 0; i < nel; i++) {
> --
> 2.40.1
>
