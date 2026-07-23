Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FE45D1A3
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823890; cv=pass; b=Vi2QxA7egUDG8xxCAFAJDO0Hjkbbl6B6hwBzdgevXo4bseTjmC1ApWONc9Qkhm0FgobzDZKjZcHHkKrvpu9XrfwqD2pPxUmhGJgbucWMK17QliirloYtexOle0gIUc/z9PXFspHzC8yU/Jv5dGEFUg9sUNfomWKr38gK28Ua1Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823890; c=relaxed/simple;
	bh=U0Avun+QwL83ilds7XZai7nES+cETJOwhVwupLtXnPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7AerGjKSPQhEfONn10sDezRvPG4Yl2oL6ys4J/cCsoiA2cUhLaQ+1reOaqv5IySUkDyKcIE9K0cxzcYTiW8eMXJLi0zAjJqUXyUmcbz9SLIIccaEDVAYNIWHXXJ28oR4/wvvCTPIWT44PEIwjKg95rHQxR69z7r8qvQux+BSH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYxpVb8x; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYxpVb8x"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so647745a12.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 09:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784823881; cv=none;
        d=google.com; s=arc-20260327;
        b=MqSxP0CbGA8zzjyVhMN4Rc09ggzPlT24NLhQ6WtVZs1UT27C9LxUXnjd/TKBXAV3wg
         pLZm6UFnz3k+tVR38d6p36Zc3MOae1wcLWlQSvnalZUsE9EU4wcZ7LDEx77aZ+2z8y4v
         P+qKYAFxD1DzQ9Yg3qS8o32fQQo0B6ekpsDqvHfGzVhHMnp7nOAMZ3ZUqs30eR+kCYVg
         sTLZ5wlfGv2KoSX6tIOQm9M2nhqSgunbqTX9xSXE3KR8uIbkZpRbzzPEhAg0Wz1JXDkD
         MAs51tM1tSNlgGFL7sInughB/8MRqFbdE+HHUfZ2uDBYIQjG/8Pz//z3ZZ0f7tizttBi
         bcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LS62LtrF9VTfwRQ87z/mbU/vcGZMYgnzNqOJmWh2Apw=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=cKO2Zj494q9h0x5y2yLM+0Nz0gUhpvc9063kamAoFHcPz13NKC4VGm1IqZsG+FFj8r
         1VwOsy+zNjzj0Mwd/i54quZUN1PiO0qnBYXTNVKMJbM+eSL8p8Z5mvwrV+a3SJDnxFq8
         qUsAp2DGOJSlfikTyBwKyaRJqJd6dV0ycuxRmVQlQNNq5nwIElhBj5zanEl4gxe6/sWJ
         UUzj5/gck8whw+W1o3QkoikoA6A58x2kVv8q5gVk1AuD2bQZAADXOuDabJFvXWr3hQo8
         ezTLPjnHXmrhrlqdRzgTLF8hXpVDT1tE3uSlUtv/sDGIpzTr9IqGfsm/QgjdAhEhycxG
         K7PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784823881; x=1785428681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LS62LtrF9VTfwRQ87z/mbU/vcGZMYgnzNqOJmWh2Apw=;
        b=RYxpVb8xw7tCV6ZjVYtmPO1Eh0Hl/TngyKfP6NcefZOqMMjEfcJmvCMvV/kE7Hj3L/
         Wmzf70W3pCBu9t327M9WZ/yZRDESTc+84BJdWGSnwpST6LofHUmwysbkFdTi0KQKAm7w
         jG77MZabOP9Cdl5gR/yp4XfEAUc4kiNGtmaykre2uadeOYrkvq2XVoha5I5cWWD8tDZ2
         Hj2S5daNW0b/WJ6VEJfU8jxy2UM/8bSOaujZmRXOb3sH8lauiP3uSK5gvtO1SBqbAQI3
         dWxS1eRwAdy5+0ICB1SBQ+CeuYyyXNTkK0GeqBM78C1GKNVWxh3qF3AaUFqgiZqxUUux
         JiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784823881; x=1785428681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LS62LtrF9VTfwRQ87z/mbU/vcGZMYgnzNqOJmWh2Apw=;
        b=hSb1znyQwt6bdxZDhGWMctM9Ai8x5n4eC8XPVX7XGJlI/u+IAQuCn+wS1RB/ehGSF6
         z6T6D64EqiMSvSAHPRiukSomNdZXY63SulXTrHDMcEKaoKuwoJV7N3mPguloatSca3P4
         0HEyWG3c9vefkIupyuZhRvVKdIbXSnNW3IGxcbbNc8BU8UEeZ+5tpwYMUs/dj4wqeb7g
         AhRY9UQ/hA4zbsDrE21Q9tAh4WZngDvu+FzLneemXwkm0bB82iEfBKAycEiPRhMWntwA
         ToeIkLYYQMgUoBoUXE+mU8Fk3IPpA/RONC7DjoNp0tYvBe8ykTAj+1mHSV+In+ModZXd
         4jWA==
X-Gm-Message-State: AOJu0YyjZ20eJi/I3Rska+4VobvcJ9pxwitremmVcqfesuouKsbTCAN3
	BZW2EoTi01QDYAfkH1hxdf7QnyQdbA/8vJK1L8momRDufC3iaI3NWR4Wulo8alrRVJjgCtV5jIW
	c5JP7vjkWvf4ifDuzW9yQ2uCqJYQJDE50bA==
X-Gm-Gg: AR+sD104CW1Ul7pCmt0R+A7r85DPFATLxPyMBgxlmtJ6oXNoRV72PulUnIL0LL3r3/J
	MXIBvLzDhK1v2+ygE6QmZdFbMe51DyMircpwlEQq2bw9wdDhThvbOrCPxxP2phzu8zbV6uWyx5A
	yijz2D0wi4ZErw3CeG+h1XYt5uFMStTKL6p4Bkx6MeBuKZPMkO9t1WsYgUa/Rl3tsCFVkLbscys
	yRqLMHD5jgytWxwS1htMdEsIjRz/mo6Bd3l3cdraXqELF9J7vXgp/2d2pKg+O/rhoYaBLq0
X-Received: by 2002:a05:6a21:7a8e:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3c44af6dba5mr4449997637.12.1784823880584; Thu, 23 Jul 2026
 09:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723031316.2720083-1-tweek@google.com> <20260723031316.2720083-2-tweek@google.com>
In-Reply-To: <20260723031316.2720083-2-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 12:24:29 -0400
X-Gm-Features: AUfX_mye7174ha2ly5ZLp2fjnyAkX9qCgP5DGdhmDASUPTpYGylfOb_In78Uuc8
Message-ID: <CAEjxPJ4YWcccS-rFme4LxqBQbZff-ZafkKQzskrpaqVy+2N1cQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 2/2] tests/file_contexts: add tests for
 multiple SELABEL_OPT_PATH
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:13=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
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
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

We need to avoid breaking the testsuite when it is run with older
libselinux before
your patch too. Should just skip the multi-file tests when the system libse=
linux
doesn't support it.

> ---
>  tests/file_contexts/Makefile        |   2 +-
>  tests/file_contexts/test            |   5 +-
>  tests/file_contexts/test_multiple.c | 233 ++++++++++++++++++++++++++++
>  3 files changed, 238 insertions(+), 2 deletions(-)
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
> index 1534925..cd7849b 100755
> --- a/tests/file_contexts/test
> +++ b/tests/file_contexts/test
> @@ -5,7 +5,7 @@
>
>  use Test;
>
> -BEGIN { plan tests =3D> 4; }
> +BEGIN { plan tests =3D> 5; }
>
>  $basedir =3D $0;
>  $basedir =3D~ s|(.*)/[^/]*|$1|;
> @@ -22,4 +22,7 @@ ok( $result, 0 );
>  $result =3D system "$basedir/test_validate $basedir 2>&1";
>  ok( $result, 0 );
>
> +$result =3D system "$basedir/test_multiple $basedir 2>&1";
> +ok( $result, 0 );
> +
>  exit;
> diff --git a/tests/file_contexts/test_multiple.c b/tests/file_contexts/te=
st_multiple.c
> new file mode 100644
> index 0000000..65fb726
> --- /dev/null
> +++ b/tests/file_contexts/test_multiple.c
> @@ -0,0 +1,233 @@
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
> +int main(int argc, char **argv)
> +{
> +       if (argc !=3D 2) {
> +               log_err("basedir not provided");
> +               exit(1);
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
