Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4141A930
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159098; cv=pass; b=gMypg1chd6FWI2zP5uAq2uQXbRCbUNUFIWULh3O7IT5OvRrVnTevd9hasvr8nxHY4IqTdcZKvwKl2AfIxUJlR5uzJg1yavMFHC/SneRGFIeLaIW9Xv8+EmMNyK8ikkjgUZSTTfFUkXWC1tXNokEoKd1bdsahOek7CtoRV9RsHUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159098; c=relaxed/simple;
	bh=AnMfxMVC3rzBB6Ztxf80C795LVZGq0K5bFN8RgVSBSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bso9XhJKraeU2IrYJm6Y+3yiD3km8UfYhALeFQ1282oG88tGkBgaTgWrctOgwDWriiZUiCPpigKxuD0gKcV9dRg+tTb8CBhKQ6aChnZobYIRNwTDEHPcIyOuyyqlqmud/wl2K3FCJd1z6kl9DnPxfcJVYRge9VNsVIck3nt7Uqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtfEspnp; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtfEspnp"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-44aeefa1c00so2138437fac.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159095; cv=none;
        d=google.com; s=arc-20260327;
        b=Rptl61Y0UAZgqhSESFD7L6Avxhg9kgnp2wBxNvVfm8/cmykYdeaq1S4h21Oqxe4/Tt
         BanKwr6eZ33v0V8Q5sGksw8PHqY25tMe4ZIfredlK5TWkg/s3EkbEJnvKSJ+cejFnsp2
         1c6tOWZUub3QZnGt/bLoyeIROH4+5gkscxDCV+KiXj6XdemPuQ3c7of0hOZO6HB9deO1
         z71MV4J8q2ZyYMZ9r9d3Uufoe84J4Odqi9NxKJe/YyvfSLhKlsofBjltxRCUyaKh+bRU
         9X73TxmJEL+Oscz11eBmXTvl35MjQzpR3jfh1gRLLtVSEf2MCPU9lPk4NSKUZwY7LO3c
         40JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDImc1KgB1JMns0zAlkksCZQhOEr9FnKaAbKeUjNu9M=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=kaKY8LK2JVqw43x5kCJojlqbDbtwJr/03eXdl0cTjmDe13DNT5pudyIIKdnARzBw/M
         +omKyeQySI6/bRbS4ueQpB2SPcapmp/lK47m+AVuI/HWrfXAyYvvy7tweQFL2X1eczjo
         Cd46NqPz0M3KZq+SM0D/XnuNyOeSR+4Y3jW8Wanp7tot9dbAS1/a4Bv2xekOsa/gvPAa
         FmWxqn39pb8FQU1fMom5w+wLU9u8KFgJ7pA9LjywpWhQth2qVMFRNLP+8pTJ5gy+hlBG
         Pb0iVyjtzjGMJmxxVMPGOpWxPX/VALbLIEFKbrpg+jTXz1EwsWJd3G1MwoGdKhiMe7//
         zZTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159095; x=1785763895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDImc1KgB1JMns0zAlkksCZQhOEr9FnKaAbKeUjNu9M=;
        b=YtfEspnpeTWtFLKP8OtAmaPXo3fgWz8uK59i3vDbXEiVr0cvXxhldDgNWWx2THtRoU
         vCjC4lcxsdPKqtUr5rV7glCZCep1zOarDZwe9F9Zzz5dkV7VCEwPY85ixkld5FeBtnaV
         ZkDoHqPanUV5Xfpv+j9xXaGTvIVT4y43XrhO9KTYxYIcA/tlDvy8EZ5158NVvhufYNT4
         45lABFsHapJV+Rpj5flpErv/YbP5ukXSs76DbtwnvIUxA+oumDyr6i0Uw+g9DL9nymMJ
         nMtWE/XFKINaDLupTu2vOhl6boJHsBxmK+HEWi3S5f8kEncmxuvsas1B2N4l4vkUE1uK
         scdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159095; x=1785763895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDImc1KgB1JMns0zAlkksCZQhOEr9FnKaAbKeUjNu9M=;
        b=IKt4aB2GRCnvlyetqBJR+jSTEHVTKsTMwnyl/r3rpK/YxUUIXAqVj+F+GV4nWk7zRe
         imxiTA6CWeH2bd7CZJaME4tk4vKYkv/A3n2T8VBWfmg4XSZkofiyM5qgUYngBFAEMIj6
         xNUe7VaShRvZ10Gz7Qwii1+9JxblOVU4VEmlcunaAPg/hueIkxpvAc9CU+nFj5Uheou0
         UfU3J0+vJtCvMwUule9Kyf0HWxoj6A4KyfEi9bJ2jMUwIEW1a0RhYEmaOdgHW7h9R6/I
         /E1eDiMkhSmHyATiu2eoYGy9YcZhiXGKl0CAHjY/zAWOEYxHOTB2gCjtdP4EbwgE+aWt
         hhSg==
X-Gm-Message-State: AOJu0YzpkzNhrBX2f8BMSefb1Hqb72gcWtUzQakYf5vIBRXgjp76UqSm
	T+rDGsB7LrNwH/pOtJ7SbWGYUNYsJMAbJ9UfoWBQL7nsENbUOJJGHsgT7gfiU3nqRNG/uMcQvam
	1XHb8ZbFCxiU8FJJqd29LSKE5j3OyUZM=
X-Gm-Gg: AR+sD12IBvGI93RAjND1RRrE0v5PhUmFz/rGOGzt5CRQ993U4mvdFsH0P4BkcFJg69L
	0uSHDspJq1o+2b6Y4lU6VMoAj584TRy10dDGreKUuYO9sw+FuOA4mLFjaaKtIA2XMphlw7H7xwW
	L20tnANppo9XrMgRuX7r6u7Fa2aaGeeKebrBbfwJTnQo++/bpHi7KPXN5ZWnFWwU9f1iWf2gXHS
	vhzks0AqOcADNL60WK2bJrzYX2yf2Jx8vsZKJ1I7M3+QD5a+r9/7jYWN+t3xf9aL+bgYc9M
X-Received: by 2002:a05:6870:e6cc:b0:451:cbb6:fc45 with SMTP id
 586e51a60fabf-457f592ba81mr6199145fac.19.1785159095109; Mon, 27 Jul 2026
 06:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727025214.2534071-1-tweek@google.com>
In-Reply-To: <20260727025214.2534071-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:31:23 -0400
X-Gm-Features: AUfX_mzhWmSg6xvyptDSlZ8wj5XPNfso2TdQJqYWeJSilRTunhO5RNtyNB21ESk
Message-ID: <CAEjxPJ6bZRx02r_vMqENRdvw0uoBOz+5D+qw3zfeB6+1V+2Rhw@mail.gmail.com>
Subject: Re: [PATCH testsuite v3 1/2] tests/file_contexts: refactor existing tests
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 10:52=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Change the logging format when reporting an error to better capture the
> location and context of the error.
>
> Split tests into functions to better isolate the tested behaviour.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes since v2:
> - Call test functions in test_validate.c
>
>  tests/file_contexts/internal.c       | 16 ++---
>  tests/file_contexts/internal.h       | 20 +++++-
>  tests/file_contexts/test_lookup.c    | 60 ++++++++++++------
>  tests/file_contexts/test_open.c      | 94 +++++++++++++++++-----------
>  tests/file_contexts/test_open_base.c | 46 ++++++++++----
>  tests/file_contexts/test_validate.c  | 40 +++++++-----
>  6 files changed, 181 insertions(+), 95 deletions(-)
>
> diff --git a/tests/file_contexts/internal.c b/tests/file_contexts/interna=
l.c
> index 22b5790..ba45dd6 100644
> --- a/tests/file_contexts/internal.c
> +++ b/tests/file_contexts/internal.c
> @@ -10,8 +10,8 @@
>
>  #include "internal.h"
>
> -void assertContextsMatch(struct selabel_handle *hnd, struct test_t *test=
s,
> -                        size_t n)
> +void assertContextsMatch(struct selabel_handle *hnd, const char *log_pre=
fix,
> +                        struct test_t *tests, size_t n)
>  {
>         for (int i =3D 0; i < n; i++) {
>                 char *context =3D NULL;
> @@ -19,20 +19,22 @@ void assertContextsMatch(struct selabel_handle *hnd, =
struct test_t *tests,
>
>                 if (selabel_lookup(hnd, &context, test.path, S_IFREG)) {
>                         if (test.context) {
> -                               perror("file_contexts:selabel_lookup");
> -                               fprintf(stderr, "Lookup for %s failed\n",=
 test.path);
> +                               log_errno("Lookup for %s from %s failed",
> +                                         test.path, log_prefix);
>                                 exit(2);
>                         }
>                         // Expected failure. Continue to the next test.
>                         continue;
>                 } else if (!test.context) {
> -                       fprintf(stderr, "Lookup for %s was supposed to fa=
iled\n", test.path);
> +                       log_err("Lookup for %s from %s was supposed to fa=
iled but got %s",
> +                               test.path, log_prefix, context);
>                         exit(2);
>                 }
>
>                 if (strcmp(context, tests[i].context)) {
> -                       fprintf(stderr, "Lookup for %s returned %s, expec=
ted %s\n",
> -                               tests[i].path, context, tests[i].context)=
;
> +                       log_err("Lookup for %s from %s returned %s, expec=
ted %s",
> +                               tests[i].path, log_prefix, context,
> +                               tests[i].context);
>                         exit(2);
>                 }
>
> diff --git a/tests/file_contexts/internal.h b/tests/file_contexts/interna=
l.h
> index a07548f..c51bbc6 100644
> --- a/tests/file_contexts/internal.h
> +++ b/tests/file_contexts/internal.h
> @@ -1,8 +1,21 @@
> +#include <errno.h>
> +#include <string.h>
> +
>  #include <selinux/label.h>
>  #include <selinux/selinux.h>
>
>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>
> +/* Log an error message with the file name, function name and line */
> +#define log_err(fmt, ...)                                               =
     \
> +       fprintf(stderr, "%s:%s:%d: " fmt "\n", __FILE__, __func__, __LINE=
__, \
> +               ##__VA_ARGS__)
> +
> +/* Log an error message as well as errno */
> +#define log_errno(fmt, ...)                                            \
> +       fprintf(stderr, "%s:%s:%d " fmt " (%s)\n", __FILE__, __func__, \
> +               __LINE__, ##__VA_ARGS__, strerror(errno))
> +
>  /* Structure to capture a test. The |path| will be resolved and expected=
 to
>   * match the |context|. If |context| is NULL, the lookup is expected to =
fail. */
>  struct test_t {
> @@ -11,6 +24,7 @@ struct test_t {
>  };
>
>  /* Assert that all paths described in |tests| resolve appropriately. |hn=
d| must
> - * be opened. |n| is the number of tests in |tests|. */
> -void assertContextsMatch(struct selabel_handle *hnd, struct test_t *test=
s,
> -                        size_t n);
> + * be opened. |n| is the number of tests in |tests|. |log_prefix| is add=
ed to
> + * any log message */
> +void assertContextsMatch(struct selabel_handle *hnd, const char *log_pre=
fix,
> +                        struct test_t *tests, size_t n);
> diff --git a/tests/file_contexts/test_lookup.c b/tests/file_contexts/test=
_lookup.c
> index 9a54d1d..5957db4 100644
> --- a/tests/file_contexts/test_lookup.c
> +++ b/tests/file_contexts/test_lookup.c
> @@ -9,38 +9,58 @@
>
>  #include "internal.h"
>
> -int main(int argc, char **argv)
> +void test_lookup(const char *basedir)
>  {
> -       struct selabel_handle *hnd;
> -
> -       if (argc !=3D 2) {
> -               fprintf(stderr, "basedir not provided\n");
> -               exit(1);
> -       }
> -
>         char *path;
> -       asprintf(&path, "%s/f2.fc", argv[1]);
> -       struct selinux_opt f2_opts[] =3D {
> -               { .type =3D SELABEL_OPT_PATH, .value =3D path }
> +       asprintf(&path, "%s/f2.fc", basedir);
> +       struct selinux_opt f2_opts[] =3D { {
> +                       .type =3D SELABEL_OPT_PATH,
> +                       .value =3D path
> +               }
>         };
>
> -       hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opt=
s));
> -
> +       struct selabel_handle *hnd =3D
> +               selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opt=
s));
>         free(path);
>
>         if (!hnd) {
> -               perror("file_context:f2_options");
> +               log_errno("Unable to open file backend");
>                 exit(2);
>         }
>
>         struct test_t tests[] =3D {
> -               { .path =3D "/base", .context =3D "system_u:object_r:test=
_base_t:s0" },
> -               { .path =3D "/base/unkown", .context =3D "system_u:object=
_r:test_base_wildcard_t:s0" },
> -               { .path =3D "/base/sub", .context =3D "system_u:object_r:=
test_base_sub_t:s0" },
> -               { .path =3D "/base/file.list", .context =3D "system_u:obj=
ect_r:test_file_list_t:s0" },
> -               { .path =3D "/base/file_list", .context =3D "system_u:obj=
ect_r:test_base_wildcard_t:s0" },
> +               {
> +                       .path =3D "/base",
> +                       .context =3D "system_u:object_r:test_base_t:s0"
> +               },
> +               {
> +                       .path =3D "/base/unkown",
> +                       .context =3D "system_u:object_r:test_base_wildcar=
d_t:s0"
> +               },
> +               {
> +                       .path =3D "/base/sub",
> +                       .context =3D "system_u:object_r:test_base_sub_t:s=
0"
> +               },
> +               {
> +                       .path =3D "/base/file.list",
> +                       .context =3D "system_u:object_r:test_file_list_t:=
s0"
> +               },
> +               {
> +                       .path =3D "/base/file_list",
> +                       .context =3D "system_u:object_r:test_base_wildcar=
d_t:s0"
> +               },
>         };
> -       assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       if (argc !=3D 2) {
> +               log_err("basedir not provided");
> +               exit(1);
> +       }
> +
> +       test_lookup(argv[1]);
>
>         return 0;
>  }
> diff --git a/tests/file_contexts/test_open.c b/tests/file_contexts/test_o=
pen.c
> index eae5691..4dd3300 100644
> --- a/tests/file_contexts/test_open.c
> +++ b/tests/file_contexts/test_open.c
> @@ -1,6 +1,5 @@
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <string.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> @@ -8,75 +7,96 @@
>  #include <selinux/label.h>
>  #include <selinux/selinux.h>
>
> -int main(int argc, char **argv)
> +#include "internal.h"
> +
> +void test_no_options(void)
>  {
> -       bool has_default_path =3D false;
> -       struct selabel_handle *hnd;
>         struct stat default_stat;
> +       if (stat(selinux_file_context_path(), &default_stat))
> +               return;
>
> -       if (argc !=3D 2) {
> -               fprintf(stderr, "basedir not provided\n");
> -               exit(1);
> -       }
> +       /* Empty options */
> +       struct selabel_handle *hnd =3D selabel_open(
> +                                            SELABEL_CTX_FILE, /* options=
=3D */ NULL, /* nopt=3D */ 0);
>
> -       const char *default_path =3D selinux_file_context_path();
> -       if (!stat(default_path, &default_stat)) {
> -               has_default_path =3D true;
> +       if (!hnd) {
> +               log_errno("Unable to open default content file");
> +               exit(2);
>         }
> +       selabel_close(hnd);
> +}
>
> -       if (has_default_path) {
> -               /* Empty options */
> -               hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ N=
ULL, /* nopt=3D */ 0);
> +void test_null_path(void)
> +{
> +       struct stat default_stat;
> +       if (stat(selinux_file_context_path(), &default_stat))
> +               return;
>
> -               if (!hnd) {
> -                       perror("file_context:no_options");
> -                       exit(2);
> +       /* Default options */
> +       struct selinux_opt null_opts[] =3D { {
> +                       .type =3D SELABEL_OPT_PATH,
> +                       .value =3D NULL
>                 }
> -               selabel_close(hnd);
> -
> -               /* Default options */
> -               struct selinux_opt null_opts[] =3D {
> -                       { .type =3D SELABEL_OPT_PATH, .value =3D NULL }
> -               };
> +       };
>
> -               hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ n=
ull_opts, /* nopt=3D */ 1);
> +       struct selabel_handle *hnd =3D selabel_open(SELABEL_CTX_FILE, nul=
l_opts,
> +                                                 ARRAY_SIZE(null_opts));
>
> -               if (!hnd) {
> -                       perror("file_context:default_options");
> -                       exit(2);
> -               }
> -               selabel_close(hnd);
> +       if (!hnd) {
> +               log_errno("Unable to open default content file");
> +               exit(2);
>         }
> +       selabel_close(hnd);
> +}
>
> +void test_valid_path(const char *basedir)
> +{
>         /* f1.fc file */
>         char *path;
> -       asprintf(&path, "%s/f1.fc", argv[1]);
> -       struct selinux_opt f1_opts[] =3D {
> -               { .type =3D SELABEL_OPT_PATH, .value =3D path }
> +       asprintf(&path, "%s/f1.fc", basedir);
> +       struct selinux_opt f1_opts[] =3D { {
> +                       .type =3D SELABEL_OPT_PATH,
> +                       .value =3D path
> +               }
>         };
>
> -       hnd =3D selabel_open(SELABEL_CTX_FILE, /* options=3D */ f1_opts, =
/* nopt=3D */ 1);
> +       struct selabel_handle *hnd =3D
> +               selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opt=
s));
>         free(path);
>
>         if (!hnd) {
> -               perror("file_context:f1_options");
> +               log_errno("Unable to open file backend");
>                 exit(2);
>         }
>
>         char *context =3D NULL;
>         if (selabel_lookup(hnd, &context, "/", S_IFREG)) {
> -               perror("file_contexts:f1_lookup");
> +               log_errno("Unable to lookup \"/\"");
>                 exit(2);
>         }
>
> -       if (strcmp(context, "system_u:object_r:rootfs:s0")) {
> -               perror("file_contexts:f1_strcmp");
> +       const char *expected =3D "system_u:object_r:rootfs:s0";
> +       if (strcmp(context, expected)) {
> +               log_err("Incorrect context returned, expected %s got %s",
> +                       expected, context);
>                 exit(2);
>         }
>
>         free(context);
>
>         selabel_close(hnd);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       if (argc !=3D 2) {
> +               log_err("basedir not provided");
> +               exit(1);
> +       }
> +
> +       test_no_options();
> +       test_null_path();
> +       test_valid_path(argv[1]);
>
>         return 0;
>  }
> diff --git a/tests/file_contexts/test_open_base.c b/tests/file_contexts/t=
est_open_base.c
> index 33b0cac..3e4b4c6 100644
> --- a/tests/file_contexts/test_open_base.c
> +++ b/tests/file_contexts/test_open_base.c
> @@ -22,26 +22,40 @@ void test_default_options(const char *basedir)
>
>         char *path;
>         asprintf(&path, "%s/f3.fc", basedir);
> -       struct selinux_opt f3_opts[] =3D {
> -               { .type =3D SELABEL_OPT_PATH, .value =3D path }
> +       struct selinux_opt f3_opts[] =3D { {
> +                       .type =3D SELABEL_OPT_PATH,
> +                       .value =3D path
> +               }
>         };
>
>         hnd =3D selabel_open(SELABEL_CTX_FILE, f3_opts, ARRAY_SIZE(f3_opt=
s));
>         free(path);
>
>         if (!hnd) {
> -               perror("file_context:f3_default_options");
> +               log_errno("Unable to open file backend");
>                 exit(2);
>         }
>
>         struct test_t tests[] =3D {
>                 { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
> -               { .path =3D "/local", .context =3D "system_u:object_r:tes=
t_local:s0" },
> -               { .path =3D "/homedirs", .context =3D "system_u:object_r:=
test_homedirs:s0" },
> -               { .path =3D "/sub", .context =3D "system_u:object_r:test_=
subbed:s0" },
> -               { .path =3D "/sub_dist", .context =3D "system_u:object_r:=
test_subbed:s0" },
> +               {
> +                       .path =3D "/local",
> +                       .context =3D "system_u:object_r:test_local:s0"
> +               },
> +               {
> +                       .path =3D "/homedirs",
> +                       .context =3D "system_u:object_r:test_homedirs:s0"
> +               },
> +               {
> +                       .path =3D "/sub",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
> +               {
> +                       .path =3D "/sub_dist",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
>         };
> -       assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
>
>         selabel_close(hnd);
>  }
> @@ -62,7 +76,7 @@ void test_base_only_option(const char *basedir)
>         free(path);
>
>         if (!hnd) {
> -               perror("file_context:f3_base_only_options");
> +               log_errno("Unable to open file backend");
>                 exit(2);
>         }
>
> @@ -70,10 +84,16 @@ void test_base_only_option(const char *basedir)
>                 { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
>                 { .path =3D "/local", .context =3D NULL },
>                 { .path =3D "/homedirs", .context =3D NULL },
> -               { .path =3D "/sub", .context =3D "system_u:object_r:test_=
subbed:s0" },
> -               { .path =3D "/sub_dist", .context =3D "system_u:object_r:=
test_subbed:s0" },
> +               {
> +                       .path =3D "/sub",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
> +               {
> +                       .path =3D "/sub_dist",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
>         };
> -       assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
>
>         selabel_close(hnd);
>  }
> @@ -81,7 +101,7 @@ void test_base_only_option(const char *basedir)
>  int main(int argc, char **argv)
>  {
>         if (argc !=3D 2) {
> -               fprintf(stderr, "basedir not provided\n");
> +               log_err("basedir not provided");
>                 exit(1);
>         }
>
> diff --git a/tests/file_contexts/test_validate.c b/tests/file_contexts/te=
st_validate.c
> index 8abefed..4d9e920 100644
> --- a/tests/file_contexts/test_validate.c
> +++ b/tests/file_contexts/test_validate.c
> @@ -1,6 +1,5 @@
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <string.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> @@ -10,47 +9,58 @@
>
>  #include "internal.h"
>
> -int main(int argc, char **argv)
> +void test_validate_unknown_fails(const char *basedir)
>  {
>         char *path;
> -       struct selabel_handle *hnd;
> -
> -       if (argc !=3D 2) {
> -               fprintf(stderr, "basedir not provided\n");
> -               exit(1);
> -       }
> -
> -       asprintf(&path, "%s/f1.fc", argv[1]);
> +       asprintf(&path, "%s/f1.fc", basedir);
>         struct selinux_opt f1_opts[] =3D {
>                 { .type =3D SELABEL_OPT_PATH, .value =3D path },
>                 { .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
>         };
>
>         /* f1 types are not defined in the test policy. */
> -       hnd =3D selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opt=
s));
> +       struct selabel_handle *hnd =3D
> +               selabel_open(SELABEL_CTX_FILE, f1_opts, ARRAY_SIZE(f1_opt=
s));
>         free(path);
>
>         if (hnd) {
> -               fprintf(stderr, "The validation of f1 should have failed.=
\n");
> +               log_err("The validation of f1 should have failed");
> +               selabel_close(hnd);
>                 exit(2);
>         }
> +}
>
> -       asprintf(&path, "%s/f2.fc", argv[1]);
> +void test_validate_known_succeeds(const char *basedir)
> +{
> +       char *path;
> +       asprintf(&path, "%s/f2.fc", basedir);
>         struct selinux_opt f2_opts[] =3D {
>                 { .type =3D SELABEL_OPT_PATH, .value =3D path },
>                 { .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
>         };
>
>         /* f2 types are defined in the test policy. */
> -       hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opt=
s));
> +       struct selabel_handle *hnd =3D
> +               selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opt=
s));
>         free(path);
>
>         if (!hnd) {
> -               perror("Unable to read valid file_contexts");
> +               log_errno("Unable to read valid file_contexts");
>                 exit(2);
>         }
>
>         selabel_close(hnd);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       if (argc !=3D 2) {
> +               log_err("basedir not provided");
> +               exit(1);
> +       }
> +
> +       test_validate_unknown_fails(argv[1]);
> +       test_validate_known_succeeds(argv[1]);
>
>         return 0;
>  }
> --
> 2.55.0.229.g6434b31f56-goog
>
