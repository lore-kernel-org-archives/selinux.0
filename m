Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3347C20AF6C
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412553; cv=none; b=SW08brY9b6RIDWz1DBYNgjToRoJ+vtPihdVkbxB/9si0PZjyj1h4o+Obhr7xaeP82D2u4z9GDJPMsda37E23zsURJNZANdNXpsr8j0sGWHW6kCvQVuO+lRXgt1ARyZM8DoYN1eltusHEynMw3uqKRZ/siZ83Cipo6TIfMYoHAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412553; c=relaxed/simple;
	bh=PTxlk65y+bSdffm9Q5jQRHrvnM3CWff2d/GxLvNPCdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeLaq+5XeNgLNel6Md4/pxH7VxSqCchx6lAXZAQxG8IU6UcjsQd5ZBWi2tYiBKglvjrCdDaLhE+BA+gF/42DD8yjylCMcwgZ6sU1fcak1qKIkcyAdMNvKkxal0uAcA0DaORXXEOIjjIhQUMAhhYr92xtpUZEPBJkid3Td1xufmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD5sNZ62; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD5sNZ62"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so6568366241.2
        for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742412551; x=1743017351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t78hhsVc5vLASeyNrniWb0Z0CNW5Btrc4aKhwzVfXMw=;
        b=OD5sNZ62WoR/LyoFbYw209kR6cEzx+uBX/d998yQsRSi+VuvllSvaG/yYOHXi5QXg8
         qZvFZF3iW35K5D3LbQwaTXfzdhaWZ5NyrpnDiqVHbP4tmYnKZWfmHFxfk8uAlABdJSHI
         mpxa5ASiFTurT2JvI5b5yWJzUv1lYLN0NyNQT4cdrh81/aS0OOBw9rTu0TKozEmdFy/Y
         4WDRdCs8GX4CNxj8OElr/rXLd2QpkZHKaPPkfsqjkmfbx7E/TLLiZIPJBg2dfV6MaYwf
         zxfNZOMG83wyilh6Mz98Pqvu6EF72XkHB/BEOhrOwT17hUJUk9X584a1WB4jJ7p4SPcx
         5wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742412551; x=1743017351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t78hhsVc5vLASeyNrniWb0Z0CNW5Btrc4aKhwzVfXMw=;
        b=dJiZjGDs8uxLgLHMXS8FId9cUGHph2kiQVH7T83ul9FEYPGe76VJ089/3hgGsQgq7p
         ilgtMmctkf6Uy3MujCTahOj9vS7eytFYitdScQC7k2gewYtU2QMS/pNC3IDhg4XVufgG
         wWRVBZW+dG7+t6fiv3xHvVcdH4/XMfY5g0P4j39iChgBuPWUa2KVa8Ch95qyasmuukVb
         WI0nwH7OX8hxVX6hBwwGhD4TO1zeohziky0G5vW642r6hBbtrEMf/c8lCKclgyNXF/Re
         A1EThIlfP+GKoPVV+ctRBmJskKMDi9Y7bMz/sUlR3Vg+4Dj1Zx3la+18iwjDlQ8//52m
         kpsQ==
X-Gm-Message-State: AOJu0Ywog49DIdOvr90Vc4GeM/AQI3ogghn6mF1BYgU92wEOVrL2GYnE
	4Z7yGsVwmnFxidXqgAs3iWpckI4RTzZ7rb4kVus+q53fhDpsQ5tajdy75xQfHiUPcNUVALuoT4D
	m0Ow3dBgePLoz5YwycpcSWE073PLNs5JkdBU=
X-Gm-Gg: ASbGnct65F/u3LBG5MpXdtayynQGJJavTevOI1GGpnBmUv03DwvHN7SZkIr05O2vv4I
	UNQTyDBfLUML/d67CeoujtFjBaICX/VPMKUUYdx6K7OdAsb9zPWQkTDLtzqnF0n8r9Hhz0dkgTN
	PVcLqun7uY/Y/KZyb6RlZZiH8=
X-Google-Smtp-Source: AGHT+IFfAay0pjWYJMMAZcdUuLFUF5xuc0MkhXfOsctJe89mcALTj0ebm9OspzmdGWEb2hqAfMu0EI20i0WwTG4wc/Y=
X-Received: by 2002:a05:6102:5707:b0:4c1:869b:7db4 with SMTP id
 ada2fe7eead31-4c4ec650e82mr3609084137.9.1742412550839; Wed, 19 Mar 2025
 12:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D7Y03RIRQTEH.1SUBF6LGYYEM6@gmail.com> <20250221093910.657484-1-nvraxn@gmail.com>
In-Reply-To: <20250221093910.657484-1-nvraxn@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 19 Mar 2025 15:29:00 -0400
X-Gm-Features: AQ5f1Jpogmn6GfxY05Cb7t7eLSYaaqTCoBBvTq1AWWK3V7FXVT7DHFu5eF79jJs
Message-ID: <CAP+JOzQP5kXVnURObRpV6HJ+pqZiBeS9AGrsArJKy50EhTcyDg@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: create semanage_basename to ensure posix compliance
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, bill.c.roberts@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:41=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Passing a const char * to basename(3) is a glibc-specific extension, so
> create our own basename implementation. As it's a trivial 2 LOC, always
> use our implementation of basename even if glibc is available to avoid
> the complications of attaining the non-posix glibc implementation of
> basename(3) as _GNU_SOURCE needs to be defined, but libgen.h also needs
> to have not been included.
>
> Also fix a missing check for selinux_policy_root(3). From the man page:
> On failure, selinux_policy_root returns NULL.
>
> As the glibc basename(3) (unlike posix basename(3)) does not support
> having a nullptr passed to it, only pass the policy_root to basename(3)
> if it is non-null.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/conf-parse.y       | 13 ++++++++++---
>  libsemanage/src/direct_api.c       |  1 +
>  libsemanage/src/utilities.c        |  9 +++++++++
>  libsemanage/src/utilities.h        | 13 +++++++++++++
>  libsemanage/tests/test_utilities.c | 26 ++++++++++++++++++++++++++
>  5 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index 6cb8a598..d3ca5f1f 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -21,6 +21,7 @@
>  %{
>
>  #include "semanage_conf.h"
> +#include "utilities.h"
>
>  #include <sepol/policydb.h>
>  #include <selinux/selinux.h>
> @@ -382,7 +383,10 @@ external_opt:   PROG_PATH '=3D' ARG  { PASSIGN(new_e=
xternal->path, $3); }
>  static int semanage_conf_init(semanage_conf_t * conf)
>  {
>         conf->store_type =3D SEMANAGE_CON_DIRECT;
> -       conf->store_path =3D strdup(basename(selinux_policy_root()));
> +       const char *policy_root =3D selinux_policy_root();
> +       if (policy_root !=3D NULL) {
> +               conf->store_path =3D strdup(semanage_basename(policy_root=
));
> +       }
>         conf->ignoredirs =3D NULL;
>         conf->store_root_path =3D strdup("/var/lib/selinux");
>         conf->compiler_directory_path =3D strdup("/usr/libexec/selinux/hl=
l");
> @@ -544,8 +548,11 @@ static int parse_module_store(char *arg)
>         free(current_conf->store_path);
>         if (strcmp(arg, "direct") =3D=3D 0) {
>                 current_conf->store_type =3D SEMANAGE_CON_DIRECT;
> -               current_conf->store_path =3D
> -                   strdup(basename(selinux_policy_root()));
> +               const char *policy_root =3D selinux_policy_root();
> +               if (policy_root !=3D NULL) {
> +                       current_conf->store_path =3D
> +                           strdup(semanage_basename(policy_root));
> +               }
>                 current_conf->server_port =3D -1;
>         } else if (*arg =3D=3D '/') {
>                 current_conf->store_type =3D SEMANAGE_CON_POLSERV_LOCAL;
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 99cba7f7..ce12ccaf 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -26,6 +26,7 @@
>
>  #include <assert.h>
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <stdio.h>
>  #include <stdio_ext.h>
>  #include <stdlib.h>
> diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
> index 70b5b677..004ffb62 100644
> --- a/libsemanage/src/utilities.c
> +++ b/libsemanage/src/utilities.c
> @@ -349,3 +349,12 @@ int write_full(int fd, const void *buf, size_t len)
>
>         return 0;
>  }
> +
> +#ifdef __GNUC__
> +__attribute__((nonnull))
> +#endif
> +char *semanage_basename(const char *filename)
> +{
> +       char *p =3D strrchr(filename, '/');
> +       return p ? p + 1 : (char *)filename;
> +}
> diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
> index c2d484a7..7481077a 100644
> --- a/libsemanage/src/utilities.h
> +++ b/libsemanage/src/utilities.h
> @@ -156,4 +156,17 @@ semanage_list_t *semanage_slurp_file_filter(FILE * f=
ile,
>
>  int write_full(int fd, const void *buf, size_t len) WARN_UNUSED;
>
> +/**
> + * Portable implementation of the glibc version of basename(3).
> + *
> + * @param filename  path to find basename of
> + *
> + * @return          basename of filename
> + */
> +
> +#ifdef __GNUC__
> +__attribute__((nonnull))
> +#endif
> +char *semanage_basename(const char *filename);
> +
>  #endif
> diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_=
utilities.c
> index bbd5af30..70a76fe7 100644
> --- a/libsemanage/tests/test_utilities.c
> +++ b/libsemanage/tests/test_utilities.c
> @@ -46,6 +46,7 @@ static void test_semanage_rtrim(void);
>  static void test_semanage_str_replace(void);
>  static void test_semanage_findval(void);
>  static void test_slurp_file_filter(void);
> +static void test_semanage_basename(void);
>
>  static char fname[] =3D {
>         'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', =
'X',
> @@ -117,6 +118,10 @@ int semanage_utilities_add_tests(CU_pSuite suite)
>                                 test_slurp_file_filter)) {
>                 goto err;
>         }
> +       if (NULL =3D=3D CU_add_test(suite, "semanage_basename",
> +                               test_semanage_basename)) {
> +               goto err;
> +       }
>         return 0;
>        err:
>         CU_cleanup_registry();
> @@ -346,3 +351,24 @@ static void test_slurp_file_filter(void)
>
>         semanage_list_destroy(&data);
>  }
> +
> +static void test_semanage_basename(void)
> +{
> +       char *basename1 =3D semanage_basename("/foo/bar");
> +       CU_ASSERT_STRING_EQUAL(basename1, "bar");
> +
> +       char *basename2 =3D semanage_basename("/foo/bar/");
> +       CU_ASSERT_STRING_EQUAL(basename2, "");
> +
> +       char *basename3 =3D semanage_basename("/foo.bar");
> +       CU_ASSERT_STRING_EQUAL(basename3, "foo.bar");
> +
> +       char *basename5 =3D semanage_basename(".");
> +       CU_ASSERT_STRING_EQUAL(basename5, ".");
> +
> +       char *basename6 =3D semanage_basename("");
> +       CU_ASSERT_STRING_EQUAL(basename6, "");
> +
> +       char *basename7 =3D semanage_basename("/");
> +       CU_ASSERT_STRING_EQUAL(basename7, "");
> +}
> --
> 2.48.1
>
>
