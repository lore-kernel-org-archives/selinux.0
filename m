Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CEBC4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 20:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKBUEp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUEo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 16:04:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3719F
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 13:04:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a29c7eefso1624196e87.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698955479; x=1699560279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VjIBHcQ8S+FebDJGIk5ZZizZkRisgYPfx3/xZXIvOc=;
        b=MmP8oBAn8nWomR1C13Tf0GGR4abNY8OW3rIGNFHVjqMI+92itzPLy7fYhaSCYYnK9g
         IUVbEMvihjacyFJx6EgB/XmwWp/wmlYNwAOLzmyL8N1EvMBh5CHZ7Spf/4hd1bDY/AOu
         QfMIHI7OSsRKx1n5hpJVzXjrIbjqK5xbLbnYdQvBxOU1hJOpq5A4quN0e2cdyjjvFXHb
         +pmyzBjAwetqz7E0VIowqbn/g7gKcSNF7tPamKESnh/KpyDDP4L/Jv1RIDS4Xc0niw48
         7KuSVneaANxQfO4Nu7TSOaZjsNXu6Qk3sXpYnqhPeNcLeob3PQbmT8hynfiMkSSUmeLk
         HmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698955479; x=1699560279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VjIBHcQ8S+FebDJGIk5ZZizZkRisgYPfx3/xZXIvOc=;
        b=colN1PpAPvZ+5I0BM5iIxdyn+ksPdSIgAjaEPqU6KO9EiH2cM6BWLlgu6NNVkj1V3i
         ncfBGLQ6Wx42mJAXZmeJSCrV0wbDZL3JXlHqBp6ha3FuAcoN8u2/WFoE2lQ5wIdVLs9W
         JKrs+NAHwtQZHvGIGDB1tRN2xa7QifFdBT9ucPy1uyozfPdgVtSwuXVdz6g4ATuQTEhg
         P9hc5Tnj5PDvQWOXUo142YyvdO3orRl/kUFKjArHJgd6Teb9mR0mZT8FooYYzNXDpoY+
         esiN6+iLsVBkwcYiezE7YF4OwcKM7edvCPz3xC89CzjQbZa1JrHRPbDp9jtQPVDqhFuk
         CmIQ==
X-Gm-Message-State: AOJu0Yz9XzOaF4ZSAc9rkABA7MqJctjIgGqn73B+FYYqnaQ/mQ7HmWFU
        SFLf6WcTOzdi8hXLzom/LRPslPABnP4iVdXTsUc=
X-Google-Smtp-Source: AGHT+IHBlXRbpo54YYxwTE/r3NC4IQO7l2Jp0rFKH0o2slHOC0YG3LH3jEzQ7GWVlePD1/T8JJLQ3YBmghXFETl86Hg=
X-Received: by 2002:ac2:5449:0:b0:505:7371:ec83 with SMTP id
 d9-20020ac25449000000b005057371ec83mr13726508lfn.48.1698955478706; Thu, 02
 Nov 2023 13:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231101163852.177983-1-cgzones@googlemail.com>
In-Reply-To: <20231101163852.177983-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Nov 2023 16:04:27 -0400
Message-ID: <CAP+JOzRB2tuNvupoN8t2cchST8Bwy0mScQAmBfKV6VmXvT0DsA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: ignore writing invalid polcaps in fuzzer
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 12:39=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Kernel policies with unsupported policy capabilities enabled can
> currently be parsed, since they result just in a bit set inside an
> ebitmap.  Writing such a loaded policy into the traditional language or
> CIL will fail however, since unsupported policy capabilities can not
> be converted into names.
>
> This currently affects the fuzzer, since it generates such policies and
> then fails to write them.
>
> Ignore writing invalid policy capabilities only for the fuzzer.  Thus
> users can still use old libsepol versions to analyze (but not write)
> policies with new policy capabilities, since capabilities can be
> introduced without a new policy version.
>
> Reported-by: oss-fuzz (issue 60573)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/kernel_to_cil.c  | 4 ++++
>  libsepol/src/kernel_to_conf.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 8fcc385d..f94d67f5 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1198,9 +1198,13 @@ static int write_polcap_rules_to_cil(FILE *out, st=
ruct policydb *pdb)
>         ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
>                 name =3D sepol_polcap_getname(i);
>                 if (name =3D=3D NULL) {
> +#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> +                       continue;
> +#else
>                         ERR(NULL, "Unknown policy capability id: %i", i);
>                         rc =3D -1;
>                         goto exit;
> +#endif
>                 }
>
>                 rc =3D strs_create_and_add(strs, "(policycap %s)", 1, nam=
e);
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index b0ae16d9..a752667c 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1181,9 +1181,13 @@ static int write_polcap_rules_to_conf(FILE *out, s=
truct policydb *pdb)
>         ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
>                 name =3D sepol_polcap_getname(i);
>                 if (name =3D=3D NULL) {
> +#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
> +                       continue;
> +#else
>                         ERR(NULL, "Unknown policy capability id: %i", i);
>                         rc =3D -1;
>                         goto exit;
> +#endif
>                 }
>
>                 rc =3D strs_create_and_add(strs, "policycap %s;", 1, name=
);
> --
> 2.42.0
>

I don't understand this patch. The fuzzer is generating an invalid
policy, so, of course, there is an error. The kernel has to be
conservative because an older kernel might have to deal with a policy
generated by a newer userspace. We do not guarantee that an older
userspace can handle a new policy. Nothing in the userspace allows
invalid policy capabilities. These two functions are following the
example of checkpolicy and secilc and giving an error for an invalid
policy capability. I am not going to make an exception for the fuzzer.
Jim
