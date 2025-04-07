Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D321C9F8
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049211; cv=none; b=XJtrKc2W6cBtp6hFwUIRhFbxb73PLz+QwISR6jIAlDUA+MkQ8XFAUVvCilJsyOjWauk446s3VHh7egP6UYfAL0cnIe2P26HfQO2PWH4gIESS3OAUL3Qo0swNpAXq2k1FnmM1ibjhx0ONMlbfa3XQ828fJxASf2w1+Z3cYGNXT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049211; c=relaxed/simple;
	bh=QNEKz1gLT86OAugoI0bRpcqs+YNf47x54gm6uVfFyqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adSGB1FJLMi9T6sSd6ZNpv0MAvxPxuPSrwRQW0WhPYPUXZVpS4GsXOsxQOZ1VE5V7corSTu5hcmyVm2BvTV0qDSm8jUwsvu2u3LIHT3pAv+jl2cAcV2hQ6mAYZKwL1tHekhs73/Ie6dYWNXV5XENiSW1B6uD6Ia9IUAIFPmy9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIXgUm/3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIXgUm/3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5675dec99so515416085a.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049208; x=1744654008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF8vTdvVPnAE0INN8tUOgt7I1a/uQaZdAWSWo6vNsqU=;
        b=gIXgUm/3KSvBwC5V+DGuYMjYmZOCMzBFMNl9ipreT9C/3PRR2zCZP7yiERUGc+7JM9
         l9pTlsq+gGfp0PtI7pZCVZy4l0lC9FOdAFOohfm07KLIHUAGCalux32j/aussDc2Uv1k
         u65da0cdWmZ8QV2IAmwO8QxXmHmyuMyAyq4lkGzRyWQUTI1tyDV7aHQ+NUlG+AUNYfCV
         wG99aGD7VBV6YYiOICOTg7YGpojhaEiKJW0gqYm0dUHit5VSVjiklf9plTBN/Ovtpzy2
         JxZIIdhnIga4dsxGoE7FW8emIYKi1bZ0tdgm3adKjZ3O26wBwXU/FLxTQPK5i0hl7Vu9
         dGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049208; x=1744654008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF8vTdvVPnAE0INN8tUOgt7I1a/uQaZdAWSWo6vNsqU=;
        b=LE/DdA+gEMN1lXNY7MQfXeQ8DvCcC30lW7YN0UR7TCziZOS91a604Ulb96JUbbFPh2
         1gZD9UwZhCSmUvrIYnnUlB7dZnpxP4nPJaPoOatFl6+59REb67YERTSWbN79660NDSM4
         K28ViH0RV8n304UZNGj4mkxQA+kvNb9nlhzmz5CHcCW3wJecOvzl6AVmW6YYbA4sZRsH
         VYNGODnnaXXjBVdS0jjl8vcX02H3xyKh6p/tUQ7Q/wUsj8FojKFsLXYRgvbbN9Ty3nO7
         x73WsvHKYnN4+eXpLtdtUu+R15f3aadCElP7ItTqjKAYkEbzpX7H99s9O4uCBjZ3jVEs
         exaw==
X-Gm-Message-State: AOJu0YzkBwF53nRBAOH11EhWNZjbNVYHTsvlmEobwLo8Sb3SdMYgu6sO
	/GrXaDFN679UiX/6gsBQNRPDjPDXrrGQ9HoSC2qQRMzsC7L+vyRrCcFa/GmTedn2m6RkBA7QkGX
	E5e83NBLmf50sO4n3lCj0cYyv5aD49g==
X-Gm-Gg: ASbGncv4rpItMmSR6PfMy038mR+kCAVKZyzA2P8+oS/U9av9Oq8/kiwV9s/ngDt6qi/
	Ly4QgucxS+LeqFkIIGWvuijdOWkNQJmsWdooaur/zM8mWvcmcMwBTQRBryGLVzc9KkByPr9od50
	fyfrv36Kc0YyIClfIfL83b8YM=
X-Google-Smtp-Source: AGHT+IHQ3JWmWoBgKX5RuZvklJOmsoZdaubmcwWipepk5MxeFhm6valc2kbM/I6gBavRiV3LVGBE/CXWL1vya9hz45I=
X-Received: by 2002:a05:620a:2616:b0:7c5:5585:6c83 with SMTP id
 af79cd13be357-7c775b18a8fmr2490822285a.54.1744049208219; Mon, 07 Apr 2025
 11:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D7Y03RIRQTEH.1SUBF6LGYYEM6@gmail.com> <20250221093910.657484-1-nvraxn@gmail.com>
 <CAP+JOzQP5kXVnURObRpV6HJ+pqZiBeS9AGrsArJKy50EhTcyDg@mail.gmail.com>
In-Reply-To: <CAP+JOzQP5kXVnURObRpV6HJ+pqZiBeS9AGrsArJKy50EhTcyDg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:06:37 -0400
X-Gm-Features: ATxdqUFIXh4Z5kYjptzWzJkoNU7Dt7OGVNq_iG5uITNs9GuuE-9cOpLbEHfWEzY
Message-ID: <CAP+JOzR6hiH_vUm0SEyA_DsxXqurz53gQ-J7fk-gq-2QTjAb1w@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: create semanage_basename to ensure posix compliance
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org, bill.c.roberts@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:29=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Feb 21, 2025 at 4:41=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > Passing a const char * to basename(3) is a glibc-specific extension, so
> > create our own basename implementation. As it's a trivial 2 LOC, always
> > use our implementation of basename even if glibc is available to avoid
> > the complications of attaining the non-posix glibc implementation of
> > basename(3) as _GNU_SOURCE needs to be defined, but libgen.h also needs
> > to have not been included.
> >
> > Also fix a missing check for selinux_policy_root(3). From the man page:
> > On failure, selinux_policy_root returns NULL.
> >
> > As the glibc basename(3) (unlike posix basename(3)) does not support
> > having a nullptr passed to it, only pass the policy_root to basename(3)
> > if it is non-null.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/conf-parse.y       | 13 ++++++++++---
> >  libsemanage/src/direct_api.c       |  1 +
> >  libsemanage/src/utilities.c        |  9 +++++++++
> >  libsemanage/src/utilities.h        | 13 +++++++++++++
> >  libsemanage/tests/test_utilities.c | 26 ++++++++++++++++++++++++++
> >  5 files changed, 59 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.=
y
> > index 6cb8a598..d3ca5f1f 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -21,6 +21,7 @@
> >  %{
> >
> >  #include "semanage_conf.h"
> > +#include "utilities.h"
> >
> >  #include <sepol/policydb.h>
> >  #include <selinux/selinux.h>
> > @@ -382,7 +383,10 @@ external_opt:   PROG_PATH '=3D' ARG  { PASSIGN(new=
_external->path, $3); }
> >  static int semanage_conf_init(semanage_conf_t * conf)
> >  {
> >         conf->store_type =3D SEMANAGE_CON_DIRECT;
> > -       conf->store_path =3D strdup(basename(selinux_policy_root()));
> > +       const char *policy_root =3D selinux_policy_root();
> > +       if (policy_root !=3D NULL) {
> > +               conf->store_path =3D strdup(semanage_basename(policy_ro=
ot));
> > +       }
> >         conf->ignoredirs =3D NULL;
> >         conf->store_root_path =3D strdup("/var/lib/selinux");
> >         conf->compiler_directory_path =3D strdup("/usr/libexec/selinux/=
hll");
> > @@ -544,8 +548,11 @@ static int parse_module_store(char *arg)
> >         free(current_conf->store_path);
> >         if (strcmp(arg, "direct") =3D=3D 0) {
> >                 current_conf->store_type =3D SEMANAGE_CON_DIRECT;
> > -               current_conf->store_path =3D
> > -                   strdup(basename(selinux_policy_root()));
> > +               const char *policy_root =3D selinux_policy_root();
> > +               if (policy_root !=3D NULL) {
> > +                       current_conf->store_path =3D
> > +                           strdup(semanage_basename(policy_root));
> > +               }
> >                 current_conf->server_port =3D -1;
> >         } else if (*arg =3D=3D '/') {
> >                 current_conf->store_type =3D SEMANAGE_CON_POLSERV_LOCAL=
;
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 99cba7f7..ce12ccaf 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -26,6 +26,7 @@
> >
> >  #include <assert.h>
> >  #include <fcntl.h>
> > +#include <libgen.h>
> >  #include <stdio.h>
> >  #include <stdio_ext.h>
> >  #include <stdlib.h>
> > diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
> > index 70b5b677..004ffb62 100644
> > --- a/libsemanage/src/utilities.c
> > +++ b/libsemanage/src/utilities.c
> > @@ -349,3 +349,12 @@ int write_full(int fd, const void *buf, size_t len=
)
> >
> >         return 0;
> >  }
> > +
> > +#ifdef __GNUC__
> > +__attribute__((nonnull))
> > +#endif
> > +char *semanage_basename(const char *filename)
> > +{
> > +       char *p =3D strrchr(filename, '/');
> > +       return p ? p + 1 : (char *)filename;
> > +}
> > diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
> > index c2d484a7..7481077a 100644
> > --- a/libsemanage/src/utilities.h
> > +++ b/libsemanage/src/utilities.h
> > @@ -156,4 +156,17 @@ semanage_list_t *semanage_slurp_file_filter(FILE *=
 file,
> >
> >  int write_full(int fd, const void *buf, size_t len) WARN_UNUSED;
> >
> > +/**
> > + * Portable implementation of the glibc version of basename(3).
> > + *
> > + * @param filename  path to find basename of
> > + *
> > + * @return          basename of filename
> > + */
> > +
> > +#ifdef __GNUC__
> > +__attribute__((nonnull))
> > +#endif
> > +char *semanage_basename(const char *filename);
> > +
> >  #endif
> > diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/tes=
t_utilities.c
> > index bbd5af30..70a76fe7 100644
> > --- a/libsemanage/tests/test_utilities.c
> > +++ b/libsemanage/tests/test_utilities.c
> > @@ -46,6 +46,7 @@ static void test_semanage_rtrim(void);
> >  static void test_semanage_str_replace(void);
> >  static void test_semanage_findval(void);
> >  static void test_slurp_file_filter(void);
> > +static void test_semanage_basename(void);
> >
> >  static char fname[] =3D {
> >         'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X'=
, 'X',
> > @@ -117,6 +118,10 @@ int semanage_utilities_add_tests(CU_pSuite suite)
> >                                 test_slurp_file_filter)) {
> >                 goto err;
> >         }
> > +       if (NULL =3D=3D CU_add_test(suite, "semanage_basename",
> > +                               test_semanage_basename)) {
> > +               goto err;
> > +       }
> >         return 0;
> >        err:
> >         CU_cleanup_registry();
> > @@ -346,3 +351,24 @@ static void test_slurp_file_filter(void)
> >
> >         semanage_list_destroy(&data);
> >  }
> > +
> > +static void test_semanage_basename(void)
> > +{
> > +       char *basename1 =3D semanage_basename("/foo/bar");
> > +       CU_ASSERT_STRING_EQUAL(basename1, "bar");
> > +
> > +       char *basename2 =3D semanage_basename("/foo/bar/");
> > +       CU_ASSERT_STRING_EQUAL(basename2, "");
> > +
> > +       char *basename3 =3D semanage_basename("/foo.bar");
> > +       CU_ASSERT_STRING_EQUAL(basename3, "foo.bar");
> > +
> > +       char *basename5 =3D semanage_basename(".");
> > +       CU_ASSERT_STRING_EQUAL(basename5, ".");
> > +
> > +       char *basename6 =3D semanage_basename("");
> > +       CU_ASSERT_STRING_EQUAL(basename6, "");
> > +
> > +       char *basename7 =3D semanage_basename("/");
> > +       CU_ASSERT_STRING_EQUAL(basename7, "");
> > +}
> > --
> > 2.48.1
> >
> >
