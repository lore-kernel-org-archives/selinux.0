Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F846A605
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649045; cv=pass; b=ciLxOFtW6X4Y1KZp5fFKwM//LgTGoyZ+gNJSoAELaxcIL1J+NwC+GH40V7/iuNKPx6i/O56MfmSv8+OW2rfWD2HsQUUfvvNJUeN65RGAxoCq+1rInLKFmlfDjjCjTYLA8+YgURvs1j1VSfdsB1G7zrvTX1p5nAGBpeyQpCGFwF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649045; c=relaxed/simple;
	bh=OdBISnhLWV/Baz4dU3LnPBzHrLy2ltGgdk9D5yH3V4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trg/oqyaoghGFknQELmZWlGXPtxZluuThRtoXu/rmEZtf6XWgNjgMBuThYO2UGfsaeEM1w1qfygMPW91cXm9gF6tW7bGKkdX79Lq+2oKs9jOjVL/3xnLYMP8YAVhs0hYoKpor/qjLiUF/q26l81S4Tthcfus38t+GVSZJDjsySk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCbtgAe1; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCbtgAe1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc97653887so125624265ad.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 08:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784649042; cv=none;
        d=google.com; s=arc-20260327;
        b=NPfJhAbCAquEJ3bQAXHjWncJHcatc2dvArIMoZ1/Evv0kLnSoAjhfSggxlRDSOmn1l
         CsOr00kicjKPOWNRs1Xcm9sLeSXW5UkcpBPTbyuIIFe/oI1xstdl1TAc0r+xkdJqQsIu
         APotnlnG+n47FHkSc4Fe1gg5ZQHj7t5KL5Fw8ye66trOk7eSQAxu8QnAK5pdEbGhOCdI
         imHTeqWforRnubyJ6C9mozhlMp1upNpqseHByULiowgmxWXQ5yvIJ8QRUzE5FloUzimX
         GTPHjKJYFsG8VLFHdQ2m3bVrA0WEAXYqphgrSqxDNf6NqjfOT+oO2D+OxWGgQMRHIHIm
         YWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qkh/MhfCng7PwTRXpzMD5TXXB10ySJxCIlhaHIBeqOA=;
        fh=hlqJRkFsr5pVVyGqb/lIzaFzh8LQOEVa8C6xrPLLpBw=;
        b=Bk+smuga4LbrdGpPg2oFUVIiMkBJL/EfdyhlUvK3DRlcBcrK7YNRkVmO3ns/T+TkAg
         T0XRevZUdeMd9DY7CLEHZqJyDUX6yyjTfLI90MtMp7C75vviDwwriebr6yRJsTpZDWwo
         Aw2i0HMPuFEB2ou24b6NPNHBkcY8Fbop4sGLIuPMkQPk1lSIj35y+ckbEHUFkpDLSCca
         Pa5stg9enR7cSXBMmKxKMmd0voztZrdejkSyb3iDK5bdK/x1bqiVzqRKp9cKzu5qJK5l
         9+aWMfFueJo78JIRgBBPXyIDJRsukCZETgEq0hNute7qqj451WyP4mqFKvsodhZteSNd
         DBBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649042; x=1785253842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qkh/MhfCng7PwTRXpzMD5TXXB10ySJxCIlhaHIBeqOA=;
        b=JCbtgAe14/U07+Ou83Eo+WLvk3/VogMjoGrWqtB9kgRk0w1GJHzG26Ru4Q+/du4N9X
         Z29yM+O5gQxW2wPuWL7gSQyX8QiL5nYYoeaO659mkcEzBXYmt6PpkNgdDp0d94QIK6ON
         bfFURZrQiZXgjKKoOCJm5HyedtQarhDZtGVKq8toNSHbnJbNUgxAfP9ew7TPAY+Rqd39
         udfL0khdC4xt7B21xaFuOwrFNDEyRQc5+TcqFiqfrqpzUG2R3u0hNT2aZxTyRIKH3xEt
         /W9i/Yt4lkxMD4ppUtwVn/pgYccWvBfKj+b6qCMYpDMrmYn0itSNutPB/y8T115PIwg1
         th1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649042; x=1785253842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qkh/MhfCng7PwTRXpzMD5TXXB10ySJxCIlhaHIBeqOA=;
        b=Nhdyh/Ihx+DZjalsxVtkHKngcR4T8cCg22V73TfZKVg3NqaRy2f+SPYlEnUVk55S+7
         zt4w7RhoDU+a+xmhGmNZHamSmfHfByMI5W6D3dz1af90ry10vjWfcXlS0MncZBG52Vjk
         Im2ez1j2plp3AuQtPIG4YhZ+xScK2Quv9GMkjtwYGTCjDqMzsrpbhGrcNgZelQBBIntX
         aCSFfP3RPPTpzl8x/iqg78RtRaWDZ1y4J/drBzh6qWZzIUm1Z2ZWVnMAO7fSIdcn7Em1
         Io0Tcqz9Vrn1idPmwKOU/M5vEaZ0yJ0pyC4Zz7Pnf+2KScNCCdEmGqUqpI244bv6sQAm
         nhEA==
X-Gm-Message-State: AOJu0YwFYjnWo/qW+7zUF83X+8chzM4uel1Q6d8vFErvSHbkMY882Qpy
	ebU+WPy3+RN7xnUqsW9wMXR5QZ82vhKHY3v/SxnnbMIzR62aXc3jn5MGb2NcDjYt8RichhiT201
	/6JGCN9NNFpS3ADYDzOcsQJBWPubKNDs=
X-Gm-Gg: AR+sD115cC2z44see86Nl1F07xX/yoR8A1uqFsh0scus0DLF/MZ+13OLkXAViWjMwaf
	iBo4oXWucqqo1fW2zQVOv3UrbM/tmIG6GPtncYF1GmmbhO+6CRuXHElwLi3bZiwPWChMuQWPYCH
	znwiSehN4m2oBl3ELAvy7tT2+5AKcGw0CDW9Cfzk1+W+BffnuQIjdj9mmg4cbDGTFa4R7/0rQbr
	C5oQUL2EgzlGR/C5hr0e81xxxNoltNXrnFgAGNP/9BWg6mb0s1vNcPBGOJeSw==
X-Received: by 2002:a17:903:458d:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2cf3484bed4mr192246095ad.1.1784649042249; Tue, 21 Jul 2026
 08:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721021157.1314051-1-tweek@google.com>
In-Reply-To: <20260721021157.1314051-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 11:50:30 -0400
X-Gm-Features: AUfX_my49T14xDllZqgCLsDcXw5I6V5vtbDof_tNaZUoBJhH-_q8CTK4dUGdb4k
Message-ID: <CAEjxPJ4RGmQ5PArL-J_29y_z7s+rn4FVq8Fhzh4oEEKU9mXcZg@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/2] tests/file_contexts: refactor existing tests
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:12=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Change the logging format when reporting an error to better capture the
> location and context of the error.
>
> Split tests into functions to better isolate the tested behaviour.
>
> Format tests using clang-format.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

To date, the selinux-testsuite has used tools/check-syntax for
formatting and this doesn't match the clang-format. Not fundamentally
opposed to migrating the testsuite to match the userspace but that's
up to Ondrej/Paul and should likely be done as a separate series on
its own.

> ---
>  tests/file_contexts/internal.c       | 16 ++---
>  tests/file_contexts/internal.h       | 20 +++++-
>  tests/file_contexts/test_lookup.c    | 49 ++++++++-------
>  tests/file_contexts/test_open.c      | 92 ++++++++++++++++------------
>  tests/file_contexts/test_open_base.c | 33 +++++-----
>  tests/file_contexts/test_validate.c  | 37 ++++++-----
>  6 files changed, 148 insertions(+), 99 deletions(-)
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
> index 9a54d1d..49bb18b 100644
> --- a/tests/file_contexts/test_lookup.c
> +++ b/tests/file_contexts/test_lookup.c
> @@ -9,38 +9,45 @@
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
> -       };
> -
> -       hnd =3D selabel_open(SELABEL_CTX_FILE, f2_opts, ARRAY_SIZE(f2_opt=
s));
> +       asprintf(&path, "%s/f2.fc", basedir);
> +       struct selinux_opt f2_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
> +                                          .value =3D path } };
>
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
> +               { .path =3D "/base",
> +                 .context =3D "system_u:object_r:test_base_t:s0" },
> +               { .path =3D "/base/unkown",
> +                 .context =3D "system_u:object_r:test_base_wildcard_t:s0=
" },
> +               { .path =3D "/base/sub",
> +                 .context =3D "system_u:object_r:test_base_sub_t:s0" },
> +               { .path =3D "/base/file.list",
> +                 .context =3D "system_u:object_r:test_file_list_t:s0" },
> +               { .path =3D "/base/file_list",
> +                 .context =3D "system_u:object_r:test_base_wildcard_t:s0=
" },
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
> index eae5691..6bf046d 100644
> --- a/tests/file_contexts/test_open.c
> +++ b/tests/file_contexts/test_open.c
> @@ -1,6 +1,5 @@
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <string.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> @@ -8,75 +7,90 @@
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
> +               SELABEL_CTX_FILE, /* options=3D */ NULL, /* nopt=3D */ 0)=
;
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
> -
> -               if (!hnd) {
> -                       perror("file_context:no_options");
> -                       exit(2);
> -               }
> -               selabel_close(hnd);
> +void test_null_path(void)
> +{
> +       struct stat default_stat;
> +       if (stat(selinux_file_context_path(), &default_stat))
> +               return;
>
> -               /* Default options */
> -               struct selinux_opt null_opts[] =3D {
> -                       { .type =3D SELABEL_OPT_PATH, .value =3D NULL }
> -               };
> +       /* Default options */
> +       struct selinux_opt null_opts[] =3D { { .type =3D SELABEL_OPT_PATH=
,
> +                                            .value =3D NULL } };
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
> -       };
> +       asprintf(&path, "%s/f1.fc", basedir);
> +       struct selinux_opt f1_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
> +                                          .value =3D path } };
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
> index 33b0cac..620b0a5 100644
> --- a/tests/file_contexts/test_open_base.c
> +++ b/tests/file_contexts/test_open_base.c
> @@ -22,26 +22,29 @@ void test_default_options(const char *basedir)
>
>         char *path;
>         asprintf(&path, "%s/f3.fc", basedir);
> -       struct selinux_opt f3_opts[] =3D {
> -               { .type =3D SELABEL_OPT_PATH, .value =3D path }
> -       };
> +       struct selinux_opt f3_opts[] =3D { { .type =3D SELABEL_OPT_PATH,
> +                                          .value =3D path } };
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
> +               { .path =3D "/local",
> +                 .context =3D "system_u:object_r:test_local:s0" },
> +               { .path =3D "/homedirs",
> +                 .context =3D "system_u:object_r:test_homedirs:s0" },
> +               { .path =3D "/sub",
> +                 .context =3D "system_u:object_r:test_subbed:s0" },
> +               { .path =3D "/sub_dist",
> +                 .context =3D "system_u:object_r:test_subbed:s0" },
>         };
> -       assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
>
>         selabel_close(hnd);
>  }
> @@ -62,7 +65,7 @@ void test_base_only_option(const char *basedir)
>         free(path);
>
>         if (!hnd) {
> -               perror("file_context:f3_base_only_options");
> +               log_errno("Unable to open file backend");
>                 exit(2);
>         }
>
> @@ -70,10 +73,12 @@ void test_base_only_option(const char *basedir)
>                 { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
>                 { .path =3D "/local", .context =3D NULL },
>                 { .path =3D "/homedirs", .context =3D NULL },
> -               { .path =3D "/sub", .context =3D "system_u:object_r:test_=
subbed:s0" },
> -               { .path =3D "/sub_dist", .context =3D "system_u:object_r:=
test_subbed:s0" },
> +               { .path =3D "/sub",
> +                 .context =3D "system_u:object_r:test_subbed:s0" },
> +               { .path =3D "/sub_dist",
> +                 .context =3D "system_u:object_r:test_subbed:s0" },
>         };
> -       assertContextsMatch(hnd, tests, ARRAY_SIZE(tests));
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
>
>         selabel_close(hnd);
>  }
> @@ -81,7 +86,7 @@ void test_base_only_option(const char *basedir)
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
> index 8abefed..aa71c22 100644
> --- a/tests/file_contexts/test_validate.c
> +++ b/tests/file_contexts/test_validate.c
> @@ -1,6 +1,5 @@
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <string.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> @@ -10,47 +9,55 @@
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
>
>         return 0;
>  }
> --
> 2.55.0.229.g6434b31f56-goog
>
