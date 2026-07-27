Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2C41BA9B
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159121; cv=pass; b=ko3quQ+vkgBle7Po+bslXO9Kz2SmaKrX8dk5luF6+pCHZw7SWZ0fbXAmuuc88NBYA+fWlKGMikBnBai0AqR61C9dxaefQhJCXvxoZyXker6MXFeuaQlRjz1tsBbq/xS6ncCQjK+zS17bCGgj7JZ7crS5FSNBr5U20OtdMI6vjWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159121; c=relaxed/simple;
	bh=mOj0/AbYkl7adnep4wOdQRbi+0V1EMc25We4w5ygxi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WahGPWGOJn2zw5J6PICkO+0/3aqx8DFS4VlegcGAykEz93tM1rnFKbTiQdngfrxJlSz6VHTvzDkxwBc4F4wD5S8nqa3DbtGbsmIGvTCJgChFUhju/X7cLbrcpjNOIQKdTXUGoSq4vk7xshzyYVih53BAjWpYoInK4rsknMz6Blk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rw2w5/5R; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rw2w5/5R"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-446f87b6de1so1373433fac.3
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159119; cv=none;
        d=google.com; s=arc-20260327;
        b=JAqO3fu27d3QWQPZ39kxkDCuzeVUFC0P34MguKhSa4tPKguRtZywX85Rzmn1WxSqU9
         PnFF3y0sJIxRoBl56dvN1YcxsdErP3d2IUY/VJNpuNeNL0tQlAw+worucRxKxc8GEyuc
         250ESm8AGKiuUF3zttfsOimcEYDXxDoKk0Yvli2A+qDE/DBNi+ekzRnGKZr0OrZ8BPW4
         RVyydOJuCc+R+KE55OtCWkcdzGKnaQBi9ZXGjrGzvn1yBOoqxLhYM2lprCWK2GphRGd8
         yTGAQV5NayJ2MHYG2qdkrrtzm2SItC86T/ZzLaIxGZzzYGI4yetmrQS91lFt/CZnMq6H
         JDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=En5uIKpXdNw48ndPyxZqRPTpSWO/G7rDzomScRv8Hl8=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=CVNj3yfBkSPhpAL7UBiSJ5glMAXq5gwqmcJ6Lv4/X2R5/7wDDr9tDR010V/STX47Sr
         GALY8Z2vgK4KxI3jVclxhQ+sacJJz3nBK2GkZdTI8Fngbr7FXRVKIzA3CTOyQXN2s5yb
         Fe/HtC8cuetOXgPBBNAyZyLHdJmFNHMoJM2VxcaZbMOXlf0r9lxbZmVkVGUc1jQUnVFj
         w/GNdb8sDe6QSs9DJJf4CMXG4Hjvxdui8hW2L3gGP4/p8zhHR0oS4dPkeUxj+Brop644
         /VPJyfPPTXM+djqKZEKnDbLCl6QO1jVr548rM3dmi/SGCp2WrHQ8lTgiVO13BjBWtRIg
         XCgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159119; x=1785763919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=En5uIKpXdNw48ndPyxZqRPTpSWO/G7rDzomScRv8Hl8=;
        b=rw2w5/5R+gYLW6pgTBEsSl/kAxkoznRZ2cNoMmaqA1vNL/JZv1zuc4me6SVl5eVSjB
         uLQItI4ts1wFItnvPj/O/HtESaMCjby/aa2x5CSIazJoxgDtIXzByPtBx6Ou04pebLcC
         b9XNw2UrdxPYxHOP5x5ZDrP7/OFDJazWWiPGuQmWS5MAMMWqCvQAEjmAvVD4aBAHq0ib
         UmyutS9DihnvBgSXzU1BTos6thVegsZvdoT9cz3G9mGrhOu9CdyWU0Wbu+jfApv94WTx
         rtvAVdTNbbExbCLo/EK5B9Dl4T8ljNQtUFJcWKFPLy8wH6RaTlR07sNWVJCxw5eVLzbt
         ZfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159119; x=1785763919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=En5uIKpXdNw48ndPyxZqRPTpSWO/G7rDzomScRv8Hl8=;
        b=PUt3gFejgis6vb36eVlRNvgUxv+6QElho3cmCtPXIkAmBFAc5x+zDOcZ0NyRkqR9Bu
         A9KNPyH5W665pQBKGswTy31mmOcJ+mH3DuB7QPy0NmhLOHUhVuvOLBOPwyJ/0z4WGVib
         jDl6kO1ZjDSHcoNSe3/Q7bFPbmxH/IQIUFqeT3j6uadchsS1mm2xslJ9UiW6q2IV9C3B
         aQ6MM1NCDpTX7s5D1TauYEvpQDgnDa/Pff09vPFty2IPmd/uoWZjnXsaawGcrRiI1W3Q
         p+kWFYCQUnqB+4lH8aGLRXz+88o2ghlyTUp77ycBK4PB5NvaY6ZVhhxxT18UBUqq2tpV
         Sskg==
X-Gm-Message-State: AOJu0YzLedv1HwhjEYQL14IMj7Uzkfp7zWwtXLXJ/bXaFBFaujGtik8c
	x9Ecre29lWLf1pKB4O7ipdmq9yQa7HFSCrIRljCciV8yVjmIkZrtdITAVNsJKYS44t6iMp6277P
	1ThHtZqtBGnlH6YKqQlSBu7d4FzOZPeE=
X-Gm-Gg: AR+sD12IXeLeZsr6JyBJhQcRJyrLDIW6bneQ22Wng1oJwt+W/WHzB61H9cbxu/KUzvH
	BPFQoBhKacMWn8RRaueEaNTxFKuJG8BZC+CTgJ212zUIR8Kf3AK7kPRZwL0BUi14HY8z34g/6JX
	1bjavKYDBDsysEUBP2lv5pvpsRfrrUNHzQFhbvNc6arz8VfPmrAqaGRKzS5BcxQ1ftE7/DNkhJR
	yXlfompsc7LBLEvMzQb2x6nlh+/Jv4RKbzNIaZxaDgPHO7PNc5iZRWgCwVp8A==
X-Received: by 2002:a05:6870:140c:b0:44c:a4cf:ccde with SMTP id
 586e51a60fabf-457f27e2fd9mr6261391fac.38.1785159118483; Mon, 27 Jul 2026
 06:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727025214.2534071-1-tweek@google.com> <20260727025214.2534071-2-tweek@google.com>
In-Reply-To: <20260727025214.2534071-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:31:47 -0400
X-Gm-Features: AUfX_myYFtDwNJUVx9EuhFZ4OiFs6TO_rJHH3ANww23uTBCNwZMS9TWzCwFlZ3M
Message-ID: <CAEjxPJ69dbMJsyJYuSsfqt6CUz+YUND4weBteEwxzrJ_R3F-ZQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v3 2/2] tests/file_contexts: add tests for
 multiple SELABEL_OPT_PATH
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 10:52=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> Add unit tests in test_multiple.c to exercise opening the file contexts
> backend with multiple SELABEL_OPT_PATH options under various validation
> and path configuration scenarios.
>
> The following test functions were added:
> - Verifies opening multiple file contexts without validation.
> - Verifies validation failure when contexts contain undefined types.
> - Verifies extra files (.subs, .local, .homedirs) are processed only for
>   the primary path.
> - Verifies multiple files with the same definition, no error is raised.
> - Verifies context lookups when providing three distinct
>   SELABEL_OPT_PATH options.
>
> These tests are skipped if libselinux does not support that feature.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes since v2:
> - Add subcommand "check" to skip test_multiple when not supported by
>   libselinux.
>
>  tests/file_contexts/Makefile        |   2 +-
>  tests/file_contexts/test            |  35 +++-
>  tests/file_contexts/test_multiple.c | 275 ++++++++++++++++++++++++++++
>  3 files changed, 301 insertions(+), 11 deletions(-)
>  create mode 100644 tests/file_contexts/test_multiple.c
>
> diff --git a/tests/file_contexts/Makefile b/tests/file_contexts/Makefile
> index 592a65f..083ef25 100644
> --- a/tests/file_contexts/Makefile
> +++ b/tests/file_contexts/Makefile
> @@ -1,4 +1,4 @@
> -TARGETS=3Dtest_open test_lookup test_open_base test_validate
> +TARGETS=3Dtest_open test_lookup test_open_base test_validate test_multip=
le
>  CFLAGS +=3D -O2 -Werror -Wall
>  LDLIBS +=3D -lselinux
>
> diff --git a/tests/file_contexts/test b/tests/file_contexts/test
> index 1534925..6d97597 100755
> --- a/tests/file_contexts/test
> +++ b/tests/file_contexts/test
> @@ -3,23 +3,38 @@
>  # This test validates the parsing of file_contexts.
>  #
>
> -use Test;
> -
> -BEGIN { plan tests =3D> 4; }
> -
> -$basedir =3D $0;
> -$basedir =3D~ s|(.*)/[^/]*|$1|;
> +use Test::More;
> +
> +BEGIN {
> +    $basedir =3D $0;
> +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +    $test_multiple =3D 0;
> +    $result        =3D system "$basedir/test_multiple $basedir check 2>/=
dev/null";
> +    if ( $result eq 0 ) {
> +        $test_multiple =3D 1;
> +        plan tests =3D> 5;
> +    }
> +    else {
> +        plan tests =3D> 4;
> +    }
> +}
>
>  $result =3D system "$basedir/test_open $basedir 2>&1";
> -ok( $result, 0 );
> +ok( $result eq 0 );
>
>  $result =3D system "$basedir/test_lookup $basedir 2>&1";
> -ok( $result, 0 );
> +ok( $result eq 0 );
>
>  $result =3D system "$basedir/test_open_base $basedir 2>&1";
> -ok( $result, 0 );
> +ok( $result eq 0 );
>
>  $result =3D system "$basedir/test_validate $basedir 2>&1";
> -ok( $result, 0 );
> +ok( $result eq 0 );
> +
> +if ($test_multiple) {
> +    $result =3D system "$basedir/test_multiple $basedir 2>&1";
> +    ok( $result eq 0 );
> +}
>
>  exit;
> diff --git a/tests/file_contexts/test_multiple.c b/tests/file_contexts/te=
st_multiple.c
> new file mode 100644
> index 0000000..88b4cc8
> --- /dev/null
> +++ b/tests/file_contexts/test_multiple.c
> @@ -0,0 +1,275 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include <selinux/label.h>
> +#include <selinux/selinux.h>
> +
> +#include "internal.h"
> +
> +void test_multiple_no_validation(const char *basedir)
> +{
> +       struct selabel_handle *hnd;
> +
> +       /* f1.fc and f2.fc file */
> +       char *f1_path, *f2_path;
> +       asprintf(&f1_path, "%s/f1.fc", basedir);
> +       asprintf(&f2_path, "%s/f2.fc", basedir);
> +       struct selinux_opt opts[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
> +       };
> +
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> +       free(f1_path);
> +       free(f2_path);
> +
> +       if (!hnd) {
> +               log_errno("Unable to open file backend");
> +               exit(2);
> +       }
> +
> +       struct test_t tests[] =3D {
> +               { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
> +               {
> +                       .path =3D "/base",
> +                       .context =3D "system_u:object_r:test_base_t:s0"
> +               },
> +       };
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> +
> +       selabel_close(hnd);
> +}
> +
> +void test_multiple_with_validation(const char *basedir)
> +{
> +       struct selabel_handle *hnd;
> +
> +       /* f1.fc and f2.fc file - f1 has undefined type rootfs in test po=
licy */
> +       char *f1_path, *f2_path;
> +       asprintf(&f1_path, "%s/f1.fc", basedir);
> +       asprintf(&f2_path, "%s/f2.fc", basedir);
> +       struct selinux_opt opts[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> +               { .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
> +       };
> +
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> +       free(f1_path);
> +       free(f2_path);
> +
> +       if (hnd) {
> +               log_err("Validation of f1 and f2 should have failed");
> +               selabel_close(hnd);
> +               exit(2);
> +       }
> +}
> +
> +void test_multiple_with_extras(const char *basedir)
> +{
> +       struct selabel_handle *hnd;
> +       char *f2_path, *f3_path;
> +       asprintf(&f2_path, "%s/f2.fc", basedir);
> +       asprintf(&f3_path, "%s/f3.fc", basedir);
> +
> +       /* 1. f3.fc is the first path: extras (.subs, .local, .homedirs) =
of f3 ARE processed */
> +       struct selinux_opt opts_f3_first[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f3_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
> +       };
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts_f3_first,
> +                          ARRAY_SIZE(opts_f3_first));
> +       if (!hnd) {
> +               log_errno("Unable to open file backend");
> +               exit(2);
> +       }
> +
> +       struct test_t tests_f3_first[] =3D {
> +               { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
> +               {
> +                       .path =3D "/sub",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
> +               {
> +                       .path =3D "/local",
> +                       .context =3D "system_u:object_r:test_local:s0"
> +               },
> +               {
> +                       .path =3D "/homedirs",
> +                       .context =3D "system_u:object_r:test_homedirs:s0"
> +               },
> +               {
> +                       .path =3D "/base",
> +                       .context =3D "system_u:object_r:test_base_t:s0"
> +               },
> +       };
> +       assertContextsMatch(hnd, __func__, tests_f3_first,
> +                           ARRAY_SIZE(tests_f3_first));
> +       selabel_close(hnd);
> +
> +       /* 2. f2.fc is the first path, f3.fc is second: extras from f3 ar=
e NOT processed */
> +       struct selinux_opt opts_f2_first[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f3_path }
> +       };
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts_f2_first,
> +                          ARRAY_SIZE(opts_f2_first));
> +       if (!hnd) {
> +               log_errno("Unable to open file backend");
> +               exit(2);
> +       }
> +
> +       struct test_t tests_f2_first[] =3D {
> +               {
> +                       .path =3D "/base",
> +                       .context =3D "system_u:object_r:test_base_t:s0"
> +               },
> +               { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
> +               {
> +                       .path =3D "/subbed",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
> +               /* /sub, /local, /homedirs should NOT match the f3 extra =
contexts */
> +               { .path =3D "/sub", .context =3D NULL },
> +               { .path =3D "/local", .context =3D NULL },
> +               { .path =3D "/homedirs", .context =3D NULL },
> +       };
> +       assertContextsMatch(hnd, __func__, tests_f2_first,
> +                           ARRAY_SIZE(tests_f2_first));
> +       selabel_close(hnd);
> +
> +       free(f2_path);
> +       free(f3_path);
> +}
> +
> +void test_multiple_three_paths(const char *basedir)
> +{
> +       struct selabel_handle *hnd;
> +       char *f1_path, *f2_path, *f3_path;
> +       asprintf(&f1_path, "%s/f1.fc", basedir);
> +       asprintf(&f2_path, "%s/f2.fc", basedir);
> +       asprintf(&f3_path, "%s/f3.fc", basedir);
> +
> +       struct selinux_opt opts[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f3_path }
> +       };
> +
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> +       free(f1_path);
> +       free(f2_path);
> +       free(f3_path);
> +
> +       if (!hnd) {
> +               log_errno("Unable to open file backend");
> +               exit(2);
> +       }
> +
> +       struct test_t tests[] =3D {
> +               { .path =3D "/", .context =3D "system_u:object_r:rootfs:s=
0" },
> +               {
> +                       .path =3D "/base",
> +                       .context =3D "system_u:object_r:test_base_t:s0"
> +               },
> +               {
> +                       .path =3D "/subbed",
> +                       .context =3D "system_u:object_r:test_subbed:s0"
> +               },
> +       };
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> +       selabel_close(hnd);
> +}
> +
> +void test_multiple_duplicate_validation(const char *basedir)
> +{
> +       struct selabel_handle *hnd;
> +
> +       /* Two copies of f2.fc to provide duplicate specifications */
> +       char *f2_path;
> +       asprintf(&f2_path, "%s/f2.fc", basedir);
> +       struct selinux_opt opts[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> +               { .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
> +       };
> +
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> +       free(f2_path);
> +
> +       if (!hnd) {
> +               log_errno("Unable to open file backend");
> +               exit(2);
> +       }
> +
> +       struct test_t tests[] =3D {
> +               {
> +                       .path =3D "/base",
> +                       .context =3D "system_u:object_r:test_base_t:s0"
> +               },
> +       };
> +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> +
> +       selabel_close(hnd);
> +}
> +
> +/* Check if multiple paths are supported. Returns 0 if they are; 1 other=
wise */
> +static int check_multiple_path_support(const char *basedir)
> +{
> +       struct selabel_handle *hnd;
> +       char *f1_path, *f2_path;
> +       char *context1 =3D NULL, *context2 =3D NULL;
> +       bool supported =3D false;
> +
> +       asprintf(&f1_path, "%s/f1.fc", basedir);
> +       asprintf(&f2_path, "%s/f2.fc", basedir);
> +
> +       struct selinux_opt opts[] =3D {
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
> +       };
> +
> +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> +       free(f1_path);
> +       free(f2_path);
> +
> +       if (!hnd) {
> +               /* On older libselinux releases, the second file_context =
would
> +                * be ignored but selabel_open should not fail. */
> +               log_err("Unable to open file backend");
> +               exit(2);
> +       }
> +
> +       if (selabel_lookup(hnd, &context1, "/", S_IFREG) =3D=3D 0 &&
> +           selabel_lookup(hnd, &context2, "/base", S_IFREG) =3D=3D 0) {
> +               supported =3D true;
> +       }
> +
> +       free(context1);
> +       free(context2);
> +       selabel_close(hnd);
> +       return supported ? 0 : 1;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       if (argc < 2 || argc > 3) {
> +               log_err("usage: %s <basedir> [check]", argv[0]);
> +               exit(1);
> +       }
> +
> +       if (argc =3D=3D 3 && strcmp(argv[2], "check") =3D=3D 0) {
> +               return check_multiple_path_support(argv[1]);
> +       }
> +
> +       test_multiple_no_validation(argv[1]);
> +       test_multiple_with_validation(argv[1]);
> +       test_multiple_duplicate_validation(argv[1]);
> +       test_multiple_with_extras(argv[1]);
> +       test_multiple_three_paths(argv[1]);
> +
> +       return 0;
> +}
> --
> 2.55.0.229.g6434b31f56-goog
>
