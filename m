Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6E0EB64DA
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 19:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGTTSB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGTTR6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 15:17:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A550E171E
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 12:17:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9352ff1aeso17705071fa.1
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689880675; x=1690485475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1I3ivDk+hI6xWKKG8/G1dAeVZ7Rgcs2a3Shtc1k9pc=;
        b=AGG0oYtr4K2oYxejC3SrjFm7GtwUV1jnWsTg7PoryUr/1sgeLckZUqGnHcHHg3nsaz
         HheEBRJ3xQyPoqwJWP0cIHLhVXvIcZLebRf4xOJK75dSEpmUKGj+Y+tpmkXiCHV2McND
         RaCyLM4iDPMwhsGOTKQ8LU9zOIKyYEfNcU44Wlla6CJkoGLDJ2tfmAPzfQmQC5MWtpvn
         6PeXKzuYSuaFVOIt/MfcnW0GS8wIZrooAVW3IHIB3Yux2nJJsPXekCwXV31SiCp7Z54S
         VueXal0EFvE3tq4XAEAVucdclc7d5kzdmOFtew68qfB7gq9m5qJu9PJhMZfUX0Pi8mXz
         UkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880675; x=1690485475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1I3ivDk+hI6xWKKG8/G1dAeVZ7Rgcs2a3Shtc1k9pc=;
        b=leSjQyWTa8v2rPAUCbXGvufVsf5M0c3U27r+Q8k8d6Wm7VRc7oQuoNmVHhDIOcTSJ9
         0tyTqt+RPOCYNRx9UGLOk4T1wuI9TJ12ZU/doa7D9lVW6gA/2ID6P553GpoccwhXCE8q
         +GnQEnw6P6nEoqftCBM5B7i8jlzjPBKDY2oYDtNOZ4N1S/RBeTEG/vAQTonDkBiBTeCg
         kxfiZoFhzoXKw+xLMtTB0ypYlHrt4/4Rd7n0gc+KIK8HKwILBTbmNd5FItdKLNOfJ/Fo
         Io5bIgFsWhdsIFVLOYt+CbMVtACiacAPx/3fTZjjmqSr0r4OV6DYNV3iRvck6RySRN7j
         uIyA==
X-Gm-Message-State: ABy/qLa0PIusJpemuwG0iviPu4nyMGh3ihcfC+Aa1uxuPknsLl7yPqio
        b5OAWVyCKry5KQPYRVnQtV+Dh4yfT5hHiD06lWI=
X-Google-Smtp-Source: APBJJlH68c7jo0wCj/A9hgE4J9dKokG7P7VLaWs7ig0YSSBICDv9wo/ydpLM+vNnchn5yuqjGhdausGPD8KCh8tcYKE=
X-Received: by 2002:a2e:9e87:0:b0:2b5:7dd9:74f5 with SMTP id
 f7-20020a2e9e87000000b002b57dd974f5mr2679380ljk.21.1689880674604; Thu, 20 Jul
 2023 12:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230719165716.18285-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230719165716.18285-1-stephen.smalley.work@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Jul 2023 15:17:43 -0400
Message-ID: <CAP+JOzR5csG791GiEBLrXszmbaicuP4QH4FZZghC5gNXSyfAPw@mail.gmail.com>
Subject: Re: [PATCH userspace] libselinux,policycoreutils,python,semodule-utils:
 de-brand SELinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 1:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Change "NSA SELinux" to just "SELinux" and remove NSA from the
> SELinux manual pages.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/man/man8/selinux.8                           | 4 ++--
>  libselinux/man/ru/man8/selinux.8                        | 4 ++--
>  policycoreutils/load_policy/load_policy.8               | 2 +-
>  policycoreutils/load_policy/ru/load_policy.8            | 2 +-
>  policycoreutils/newrole/newrole.1                       | 2 +-
>  policycoreutils/newrole/ru/newrole.1                    | 2 +-
>  policycoreutils/run_init/open_init_pty.8                | 2 +-
>  policycoreutils/run_init/ru/open_init_pty.8             | 2 +-
>  policycoreutils/run_init/ru/run_init.8                  | 2 +-
>  policycoreutils/run_init/run_init.8                     | 2 +-
>  policycoreutils/secon/ru/secon.1                        | 2 +-
>  policycoreutils/secon/secon.1                           | 2 +-
>  policycoreutils/semodule/ru/semodule.8                  | 2 +-
>  policycoreutils/semodule/semodule.8                     | 2 +-
>  python/audit2allow/audit2allow.1                        | 2 +-
>  python/audit2allow/ru/audit2allow.1                     | 2 +-
>  semodule-utils/semodule_expand/ru/semodule_expand.8     | 2 +-
>  semodule-utils/semodule_expand/semodule_expand.8        | 2 +-
>  semodule-utils/semodule_link/ru/semodule_link.8         | 2 +-
>  semodule-utils/semodule_link/semodule_link.8            | 2 +-
>  semodule-utils/semodule_package/ru/semodule_package.8   | 2 +-
>  semodule-utils/semodule_package/ru/semodule_unpackage.8 | 2 +-
>  semodule-utils/semodule_package/semodule_package.8      | 2 +-
>  semodule-utils/semodule_package/semodule_unpackage.8    | 2 +-
>  24 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.=
8
> index 5842150b..9c466d57 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -1,9 +1,9 @@
>  .TH  "selinux"  "8"  "29 Apr 2005" "dwalsh@redhat.com" "SELinux Command =
Line documentation"
>  .SH "NAME"
> -SELinux \- NSA Security-Enhanced Linux (SELinux)
> +SELinux \- Security-Enhanced Linux (SELinux)
>  .
>  .SH "DESCRIPTION"
> -NSA Security-Enhanced Linux (SELinux) is an implementation of a
> +Security-Enhanced Linux (SELinux) is an implementation of a
>  flexible mandatory access control architecture in the Linux operating
>  system.  The SELinux architecture provides general support for the
>  enforcement of many kinds of mandatory access control policies,
> diff --git a/libselinux/man/ru/man8/selinux.8 b/libselinux/man/ru/man8/se=
linux.8
> index 271809de..4ab64276 100644
> --- a/libselinux/man/ru/man8/selinux.8
> +++ b/libselinux/man/ru/man8/selinux.8
> @@ -1,9 +1,9 @@
>  .TH  "selinux"  "8"  "29 =D0=B0=D0=BF=D1=80=D0=B5=D0=BB=D1=8F 2005" "dwa=
lsh@redhat.com" "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BF=D0=BE =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=
=BE=D0=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B5 SELinux"
>  .SH "=D0=98=D0=9C=D0=AF"
> -SELinux \- Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=
=D1=82=D1=8C=D1=8E =D0=BE=D1=82 NSA (SELinux)
> +SELinux \- Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=
=D1=82=D1=8C=D1=8E =D0=BE=D1=82 (SELinux)
>  .
>  .SH "=D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95"
> -Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D0=BE=D1=82 NSA - =D1=8D=D1=82=D0=BE =D1=80=D0=B5=D0=B0=D0=BB=D0=
=B8=D0=B7=D0=B0=D1=86=D0=B8=D1=8F =D0=B3=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9 =D0=
=B0=D1=80=D1=85=D0=B8=D1=82=D0=B5=D0=BA=D1=82=D1=83=D1=80=D1=8B =D0=BC=D0=
=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=BD=D0=BE=D0=B3=D0=BE
> +Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D0=BE=D1=82 - =D1=8D=D1=82=D0=BE =D1=80=D0=B5=D0=B0=D0=BB=D0=B8=
=D0=B7=D0=B0=D1=86=D0=B8=D1=8F =D0=B3=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9 =D0=B0=
=D1=80=D1=85=D0=B8=D1=82=D0=B5=D0=BA=D1=82=D1=83=D1=80=D1=8B =D0=BC=D0=B0=
=D0=BD=D0=B4=D0=B0=D1=82=D0=BD=D0=BE=D0=B3=D0=BE
>  =D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=
=BE=D1=81=D1=82=D1=83=D0=BF=D0=BE=D0=BC =D0=B2 =D0=BE=D0=BF=D0=B5=D1=80=D0=
=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=BE=D0=B9 =D1=81=D0=B8=D1=81=D1=82=D0=
=B5=D0=BC=D0=B5 Linux. =D0=90=D1=80=D1=85=D0=B8=D1=82=D0=B5=D0=BA=D1=82=D1=
=83=D1=80=D0=B0 SELinux =D0=BF=D1=80=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=
=B2=D0=BB=D1=8F=D0=B5=D1=82
>  =D0=BE=D0=B1=D1=89=D1=83=D1=8E =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D1=83 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D1=8B=D1=
=85 =D0=B2=D0=B8=D0=B4=D0=BE=D0=B2 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=
=BA =D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=BD=D0=BE=D0=B3=D0=BE =D1=83=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BE=D1=81=D1=
=82=D1=83=D0=BF=D0=BE=D0=BC,
>  =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B0=D1=8F =D0=BE=D1=81=D0=BD=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=86=D0=
=B5=D0=BF=D1=86=D0=B8=D1=8F=D1=85 Type Enforcement=C2=AE (=D0=BF=D1=80=D0=
=B8=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=
=BF=D1=80=D0=B8=D1=81=D0=B2=D0=BE=D0=B5=D0=BD=D0=B8=D0=B5 =D1=82=D0=B8=D0=
=BF=D0=BE=D0=B2),
> diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/=
load_policy/load_policy.8
> index 0810995c..867c35e4 100644
> --- a/policycoreutils/load_policy/load_policy.8
> +++ b/policycoreutils/load_policy/load_policy.8
> @@ -1,4 +1,4 @@
> -.TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux" NSA
> +.TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux"
>  .SH NAME
>  load_policy \- load a new SELinux policy into the kernel
>
> diff --git a/policycoreutils/load_policy/ru/load_policy.8 b/policycoreuti=
ls/load_policy/ru/load_policy.8
> index db3d9f65..25140b2e 100644
> --- a/policycoreutils/load_policy/ru/load_policy.8
> +++ b/policycoreutils/load_policy/ru/load_policy.8
> @@ -1,4 +1,4 @@
> -.TH LOAD_POLICY "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux" =
NSA
> +.TH LOAD_POLICY "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  load_policy \- =D0=B7=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=B8=D1=82=D1=8C =
=D0=BD=D0=BE=D0=B2=D1=83=D1=8E =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D1=83 SELinux =D0=B2 =D1=8F=D0=B4=D1=80=D0=BE
>
> diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/=
newrole.1
> index 893c42f7..544274d7 100644
> --- a/policycoreutils/newrole/newrole.1
> +++ b/policycoreutils/newrole/newrole.1
> @@ -1,4 +1,4 @@
> -.TH NEWROLE "1" "October 2000" "Security Enhanced Linux" NSA
> +.TH NEWROLE "1" "October 2000" "Security Enhanced Linux"
>  .SH NAME
>  newrole \- run a shell with a new SELinux role
>  .SH SYNOPSIS
> diff --git a/policycoreutils/newrole/ru/newrole.1 b/policycoreutils/newro=
le/ru/newrole.1
> index c4078789..6d9c6dd0 100644
> --- a/policycoreutils/newrole/ru/newrole.1
> +++ b/policycoreutils/newrole/ru/newrole.1
> @@ -1,4 +1,4 @@
> -.TH NEWROLE "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2000" "Secur=
ity Enhanced Linux" NSA
> +.TH NEWROLE "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2000" "Secur=
ity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  newrole \- =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D0=BE=
=D0=B1=D0=BE=D0=BB=D0=BE=D1=87=D0=BA=D1=83 =D1=81 =D0=BD=D0=BE=D0=B2=D0=BE=
=D0=B9 =D1=80=D0=BE=D0=BB=D1=8C=D1=8E SELinux
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/run_init/open_init_pty.8 b/policycoreutils/r=
un_init/open_init_pty.8
> index 4b0a2f3c..8bfb9d69 100644
> --- a/policycoreutils/run_init/open_init_pty.8
> +++ b/policycoreutils/run_init/open_init_pty.8
> @@ -22,7 +22,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux" NSA
> +.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux"
>  .SH NAME
>  open_init_pty \- run an program under a pseudo terminal
>  .SH SYNOPSIS
> diff --git a/policycoreutils/run_init/ru/open_init_pty.8 b/policycoreutil=
s/run_init/ru/open_init_pty.8
> index bac4fd94..143941e1 100644
> --- a/policycoreutils/run_init/ru/open_init_pty.8
> +++ b/policycoreutils/run_init/ru/open_init_pty.8
> @@ -22,7 +22,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH OPEN_INIT_PTY "8" "=D0=AF=D0=BD=D0=B2=D0=B0=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux" NSA
> +.TH OPEN_INIT_PTY "8" "=D0=AF=D0=BD=D0=B2=D0=B0=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  open_init_pty \- =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =
=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83 =D0=BF=D0=BE=D0=B4 =
=D0=BF=D1=81=D0=B5=D0=B2=D0=B4=D0=BE=D1=82=D0=B5=D1=80=D0=BC=D0=B8=D0=BD=D0=
=B0=D0=BB=D0=BE=D0=BC
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/run_init/ru/run_init.8 b/policycoreutils/run=
_init/ru/run_init.8
> index 174d9c53..26b767ce 100644
> --- a/policycoreutils/run_init/ru/run_init.8
> +++ b/policycoreutils/run_init/ru/run_init.8
> @@ -1,4 +1,4 @@
> -.TH RUN_INIT "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux" NSA
> +.TH RUN_INIT "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  run_init \- =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D1=
=81=D1=86=D0=B5=D0=BD=D0=B0=D1=80=D0=B8=D0=B9 init =D0=B2 =D0=BF=D1=80=D0=
=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B5 SELinux
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/run_init/run_init.8 b/policycoreutils/run_in=
it/run_init.8
> index a031d5d2..d7ff45d0 100644
> --- a/policycoreutils/run_init/run_init.8
> +++ b/policycoreutils/run_init/run_init.8
> @@ -1,4 +1,4 @@
> -.TH RUN_INIT "8" "May 2003" "Security Enhanced Linux" NSA
> +.TH RUN_INIT "8" "May 2003" "Security Enhanced Linux"
>  .SH NAME
>  run_init \- run an init script in the proper SELinux context
>  .SH SYNOPSIS
> diff --git a/policycoreutils/secon/ru/secon.1 b/policycoreutils/secon/ru/=
secon.1
> index acbc14fb..3c9aa535 100644
> --- a/policycoreutils/secon/ru/secon.1
> +++ b/policycoreutils/secon/ru/secon.1
> @@ -1,4 +1,4 @@
> -.TH SECON "1" "=D0=90=D0=BF=D1=80=D0=B5=D0=BB=D1=8C 2006" "Security Enha=
nced Linux" NSA
> +.TH SECON "1" "=D0=90=D0=BF=D1=80=D0=B5=D0=BB=D1=8C 2006" "Security Enha=
nced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  secon \- =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=
=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 SELinux =D0=B4=D0=BB=D1=8F =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0, =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=
=8B =D0=B8=D0=BB=D0=B8 =D0=B2=D0=B2=D0=BE=D0=B4=D0=B0 =D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8F.
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.=
1
> index c0e8b05a..1a454edc 100644
> --- a/policycoreutils/secon/secon.1
> +++ b/policycoreutils/secon/secon.1
> @@ -1,4 +1,4 @@
> -.TH SECON "1" "April 2006" "Security Enhanced Linux" NSA
> +.TH SECON "1" "April 2006" "Security Enhanced Linux"
>  .SH NAME
>  secon \- See an SELinux context, from a file, program or user input.
>  .SH SYNOPSIS
> diff --git a/policycoreutils/semodule/ru/semodule.8 b/policycoreutils/sem=
odule/ru/semodule.8
> index 26515201..d7ff9b56 100644
> --- a/policycoreutils/semodule/ru/semodule.8
> +++ b/policycoreutils/semodule/ru/semodule.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Security E=
nhanced Linux" NSA
> +.TH SEMODULE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Security E=
nhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  semodule \- =D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F=D0=BC=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B8=
=D1=82=D0=B8=D0=BA=D0=B8 SELinux.
>
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodu=
le/semodule.8
> index 01757b00..00c60c1e 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule \- Manage SELinux policy modules.
>
> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2=
allow.1
> index c31021d3..c208b3b2 100644
> --- a/python/audit2allow/audit2allow.1
> +++ b/python/audit2allow/audit2allow.1
> @@ -23,7 +23,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux" NSA
> +.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux"
>  .SH NAME
>  .BR audit2allow
>  \- generate SELinux policy allow/dontaudit rules from logs of denied ope=
rations
> diff --git a/python/audit2allow/ru/audit2allow.1 b/python/audit2allow/ru/=
audit2allow.1
> index 1633fa3b..b631895d 100644
> --- a/python/audit2allow/ru/audit2allow.1
> +++ b/python/audit2allow/ru/audit2allow.1
> @@ -23,7 +23,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH AUDIT2ALLOW "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2010" "S=
ecurity Enhanced Linux" NSA
> +.TH AUDIT2ALLOW "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2010" "S=
ecurity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  .BR audit2allow
>  \- =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=91=D1=82 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=B8=D0=BB=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux=
 allow/dontaudit =D0=B8=D0=B7 =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=BE=D0=
=B2 =D0=BE=D1=82=D0=BA=D0=BB=D0=BE=D0=BD=D1=91=D0=BD=D0=BD=D1=8B=D1=85 =D0=
=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B9
> diff --git a/semodule-utils/semodule_expand/ru/semodule_expand.8 b/semodu=
le-utils/semodule_expand/ru/semodule_expand.8
> index afdc129e..28b381af 100644
> --- a/semodule-utils/semodule_expand/ru/semodule_expand.8
> +++ b/semodule-utils/semodule_expand/ru/semodule_expand.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_EXPAND "8" "=D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Sec=
urity Enhanced Linux" NSA
> +.TH SEMODULE_EXPAND "8" "=D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Sec=
urity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  semodule_expand \- =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B8=D1=82=D1=
=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=
=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>
> diff --git a/semodule-utils/semodule_expand/semodule_expand.8 b/semodule-=
utils/semodule_expand/semodule_expand.8
> index 1b482a1f..eba7b40e 100644
> --- a/semodule-utils/semodule_expand/semodule_expand.8
> +++ b/semodule-utils/semodule_expand/semodule_expand.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_EXPAND "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_EXPAND "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule_expand \- Expand a SELinux policy module package.
>
> diff --git a/semodule-utils/semodule_link/ru/semodule_link.8 b/semodule-u=
tils/semodule_link/ru/semodule_link.8
> index 31d81206..4a8f414e 100644
> --- a/semodule-utils/semodule_link/ru/semodule_link.8
> +++ b/semodule-utils/semodule_link/ru/semodule_link.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_LINK "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux" NSA
> +.TH SEMODULE_LINK "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  semodule_link \- =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=BC=
=D0=B5=D1=81=D1=82=D0=B5 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=BC=D0=BE=
=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B8 SELinux
>
> diff --git a/semodule-utils/semodule_link/semodule_link.8 b/semodule-util=
s/semodule_link/semodule_link.8
> index a2bda3f9..95a9ba19 100644
> --- a/semodule-utils/semodule_link/semodule_link.8
> +++ b/semodule-utils/semodule_link/semodule_link.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_LINK "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_LINK "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule_link \- Link SELinux policy module packages together
>
> diff --git a/semodule-utils/semodule_package/ru/semodule_package.8 b/semo=
dule-utils/semodule_package/ru/semodule_package.8
> index 6af67b29..3f4b16a9 100644
> --- a/semodule-utils/semodule_package/ru/semodule_package.8
> +++ b/semodule-utils/semodule_package/ru/semodule_package.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  semodule_package \- =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BF=D0=
=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>
> diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8 b/se=
module-utils/semodule_package/ru/semodule_unpackage.8
> index 910fee02..6c7e234b 100644
> --- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
> +++ b/semodule-utils/semodule_package/ru/semodule_unpackage.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  semodule_unpackage \- =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=BC=
=D0=BE=D0=B4=D1=83=D0=BB=D1=8C =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B8 =D0=B8 =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=
=D1=81=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B8=D0=B7 =
=D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =
=D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>
> diff --git a/semodule-utils/semodule_package/semodule_package.8 b/semodul=
e-utils/semodule_package/semodule_package.8
> index 9697cc55..1d64bad3 100644
> --- a/semodule-utils/semodule_package/semodule_package.8
> +++ b/semodule-utils/semodule_package/semodule_package.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule_package \- Create a SELinux policy module package.
>
> diff --git a/semodule-utils/semodule_package/semodule_unpackage.8 b/semod=
ule-utils/semodule_package/semodule_unpackage.8
> index 5c92bf51..0432f7a1 100644
> --- a/semodule-utils/semodule_package/semodule_unpackage.8
> +++ b/semodule-utils/semodule_package/semodule_unpackage.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule_unpackage \- Extract policy module and file context file from a=
n SELinux policy module package.
>
> --
> 2.40.1
>
