Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9439B949
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260906; cv=pass; b=aKSyc+pZjFJ32qHRukolrz+pMl9RI0gt6GS4rXwl5OqsaC8DT5dXKmtJ4yeof9MZ1GrEKA3wVr61xemASdMpYqJy7tiuKDHaPjDtp59/GQwfGO+yt03Chq/RIQnfxwnleaFdOQM+UECOi1bK21nGNweAeV6E7vijmMSh0EadeS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260906; c=relaxed/simple;
	bh=gTzODIDVNd+y5FUZHL/268BtX28Q9z0dd3jYvnlsvvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=notNhJLFqhffMlYKXIAGklupAyobx0ckK9LB8p/f49ErjSv6/tI60ro4CIbT6cis0sX7WAearSz50awYWi3rdQcv8xt4JEBknFTlvETXPxfO0Ahb9Lwi4DVJmoMoXf7J6B5mxt4vTyPvh79sqJ/bT5N6Z5d/3MpA6NbX99+4bFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEGTFFIu; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEGTFFIu"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43cce34c881so5513fac.2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 10:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785260904; cv=none;
        d=google.com; s=arc-20260327;
        b=IMhpvTwxWUpp+Xnu9hhdB1JoLDJnquZSFK/BlXyUEMR30PqL1EO2WY0fdG+nftkqFp
         thigysaCP05VfnPzzfOlOvHHsaNghi5JymEYI2rPXo8cfH0MGO7neOl+CRUEdc+y/uob
         oeLfLp+ZWsIMCq++lBvOYsL3dgivwUOKw6/vU6vno51oaTzUqEJZeaJY298dO3IHkmwP
         SomHHiYuaB1oj9/vU8DAfe90pbOpMUFVi6HOoBeuQJBFlEhfasYfNpJuusHVSue6EiKm
         RsbWLK0Onb3vb0S5lOTGw1J9bUkoQxiVWkaQo2MVIjf1okpz0cEZepp9o34aQHmt6iXL
         OV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJA6Ncr3Ojaxn23+q9SGKF74kdKbqxZixKA/e9Os49g=;
        fh=mMDxYY5wtlIekXoYIfjt6lvMWgTaMUwdwgsYDQ6qy3A=;
        b=szZa4UQI2L3bj/BenwuZrSnoPx8fDu/iFl3Xc+88f6R+7MqW8oBUQLuWDh3i+cKOyn
         zB9PtTkLSYJcNAAlFMRgPe0IY0Yz9mc7Gs3DLkzMGxDe+a4Ulmp4wMyX72+uTqFryd9w
         1BpL5EPn8QkDjSyr5N1V5QknOMbrGXQ0bG52QuwSpAD1bqEGyWYAMMEiX5e/hQs6jMPC
         aouWCZlUflko4orrQMOGiTUnT1bNkRYK46epnt0FKN/cx/fii25D8u7pm633/iJF0OHv
         6aq+L8zYsJ9v0lK3oGAWfUt/tYWNtYPCJkYGFN1LtCgOLCiywGLboLuWaaKDC9Qeq07X
         Qb/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785260904; x=1785865704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJA6Ncr3Ojaxn23+q9SGKF74kdKbqxZixKA/e9Os49g=;
        b=mEGTFFIud7TJL32s/3UOciPueXWvfsLhmyPC54apmwJonwa1ZnfCnmas/BwzS5LloJ
         +IYvIoPZvLlWLEyqdXEtdC2G7BsRhKyl/1q4I18umdqqtHd7n4+4feMCDFqN4B1qyCKb
         Ofb3NMCaVovMmkCdJKGrwwQ/hlvKlbywzUd1IBl126V7+N+EkIYR5koqUFZb9xb0dnn7
         acRJ/zOSRRkTQPBeYkPLYxyAFxlnw0Zj2L6SpxsXO+Vu985XlrHEqKOv5lrd+PpDpd+t
         mcMpw79M8WA1ltn/rImf3FCt6Gh/8N7WHlJcBfABs9cnHtIjVQ/Mbnrq4YuOkzn1lVQd
         0WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785260904; x=1785865704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJA6Ncr3Ojaxn23+q9SGKF74kdKbqxZixKA/e9Os49g=;
        b=VI1AEkJZFRph7z5nDac3zwiu+ntWTCfYfRMLLppb8lxavDVZ96eX6DU3/WD36crC7K
         yZlSwKpgn3uJ1EeiwnZTyg3ZLfHxFR1gSksn7fZJs5kggn0OqzAOe1ItRkCmXiyp84n8
         +42KQoQeyobDzKt/vpayEeOTZtYcy8LFpAOeX1rI74ImTFxEIf7NP1p7d5a91fprI+rV
         gCFPzYTbkdFgMBPFj5knkgh6jJw6Xocc0scJpQ5rGeLZmSdanAyQXPtpD/39ZDypCPXh
         TFRVwPA0GUux7/4q0CK47N7JYrPYgtRnTOee1hSFJGGn0YzcmC74PcH3se3dc8A7grgx
         ww3g==
X-Gm-Message-State: AOJu0YzRep9k+8KrpbLopWB9acwKNxnYcVvTPetbn5KPBGE9XOBppvSZ
	GWLl0B0ZRjJxy352UGUMo/357adz0hqH+RaC1f/TEDWUZbngOGHfAXbw1Kkx7GTMS2nAYoZnVGA
	YDLGrzlJCq4cVu00kFT9vdWYSQfUZnX8=
X-Gm-Gg: AR+sD12t2AToMEZbTZXjtLHS/FO3tc0dLrN5sOzAv8Dv/BTxulunkSkkwxBKgVtATUM
	9i9NqxAi7segoJ+S3kmfcxQRobNI9QfZjt1dc2uWf1zO5H5d0Zmr0daeM0pu96BNSCzQgzua/Oc
	DUh+OlVlJYuVwTx6mSEhiw9OM7naz2n67TfpE+fjugGjlIhL1iDm4cl28MlIlyaPcu1zzHpwIG1
	wVR+qWnPGEed5kK9Pj+X5eBiI/sfhqoN3spq+E5mZy//Q/7ycsKN+b/UIIvFg==
X-Received: by 2002:a05:687c:40a7:b0:455:d1ed:221b with SMTP id
 586e51a60fabf-4586d115aacmr1916154fac.37.1785260903685; Tue, 28 Jul 2026
 10:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727025214.2534071-1-tweek@google.com> <20260727025214.2534071-2-tweek@google.com>
 <CAEjxPJ69dbMJsyJYuSsfqt6CUz+YUND4weBteEwxzrJ_R3F-ZQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ69dbMJsyJYuSsfqt6CUz+YUND4weBteEwxzrJ_R3F-ZQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 13:48:11 -0400
X-Gm-Features: AUfX_mxkwpY1sK4-cY8Q7LrhYreIKNXVq4ykc32tJdcYPUhDPrv0YIMqs63nElQ
Message-ID: <CAEjxPJ52-2rP4JfvY3VU3QBnqnLwqX-fGepZx9ECCOoNHu_F4w@mail.gmail.com>
Subject: Re: [PATCH testsuite v3 2/2] tests/file_contexts: add tests for
 multiple SELABEL_OPT_PATH
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:31=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Jul 26, 2026 at 10:52=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@go=
ogle.com> wrote:
> >
> > Add unit tests in test_multiple.c to exercise opening the file contexts
> > backend with multiple SELABEL_OPT_PATH options under various validation
> > and path configuration scenarios.
> >
> > The following test functions were added:
> > - Verifies opening multiple file contexts without validation.
> > - Verifies validation failure when contexts contain undefined types.
> > - Verifies extra files (.subs, .local, .homedirs) are processed only fo=
r
> >   the primary path.
> > - Verifies multiple files with the same definition, no error is raised.
> > - Verifies context lookups when providing three distinct
> >   SELABEL_OPT_PATH options.
> >
> > These tests are skipped if libselinux does not support that feature.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

>
> > ---
> > Changes since v2:
> > - Add subcommand "check" to skip test_multiple when not supported by
> >   libselinux.
> >
> >  tests/file_contexts/Makefile        |   2 +-
> >  tests/file_contexts/test            |  35 +++-
> >  tests/file_contexts/test_multiple.c | 275 ++++++++++++++++++++++++++++
> >  3 files changed, 301 insertions(+), 11 deletions(-)
> >  create mode 100644 tests/file_contexts/test_multiple.c
> >
> > diff --git a/tests/file_contexts/Makefile b/tests/file_contexts/Makefil=
e
> > index 592a65f..083ef25 100644
> > --- a/tests/file_contexts/Makefile
> > +++ b/tests/file_contexts/Makefile
> > @@ -1,4 +1,4 @@
> > -TARGETS=3Dtest_open test_lookup test_open_base test_validate
> > +TARGETS=3Dtest_open test_lookup test_open_base test_validate test_mult=
iple
> >  CFLAGS +=3D -O2 -Werror -Wall
> >  LDLIBS +=3D -lselinux
> >
> > diff --git a/tests/file_contexts/test b/tests/file_contexts/test
> > index 1534925..6d97597 100755
> > --- a/tests/file_contexts/test
> > +++ b/tests/file_contexts/test
> > @@ -3,23 +3,38 @@
> >  # This test validates the parsing of file_contexts.
> >  #
> >
> > -use Test;
> > -
> > -BEGIN { plan tests =3D> 4; }
> > -
> > -$basedir =3D $0;
> > -$basedir =3D~ s|(.*)/[^/]*|$1|;
> > +use Test::More;
> > +
> > +BEGIN {
> > +    $basedir =3D $0;
> > +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> > +
> > +    $test_multiple =3D 0;
> > +    $result        =3D system "$basedir/test_multiple $basedir check 2=
>/dev/null";
> > +    if ( $result eq 0 ) {
> > +        $test_multiple =3D 1;
> > +        plan tests =3D> 5;
> > +    }
> > +    else {
> > +        plan tests =3D> 4;
> > +    }
> > +}
> >
> >  $result =3D system "$basedir/test_open $basedir 2>&1";
> > -ok( $result, 0 );
> > +ok( $result eq 0 );
> >
> >  $result =3D system "$basedir/test_lookup $basedir 2>&1";
> > -ok( $result, 0 );
> > +ok( $result eq 0 );
> >
> >  $result =3D system "$basedir/test_open_base $basedir 2>&1";
> > -ok( $result, 0 );
> > +ok( $result eq 0 );
> >
> >  $result =3D system "$basedir/test_validate $basedir 2>&1";
> > -ok( $result, 0 );
> > +ok( $result eq 0 );
> > +
> > +if ($test_multiple) {
> > +    $result =3D system "$basedir/test_multiple $basedir 2>&1";
> > +    ok( $result eq 0 );
> > +}
> >
> >  exit;
> > diff --git a/tests/file_contexts/test_multiple.c b/tests/file_contexts/=
test_multiple.c
> > new file mode 100644
> > index 0000000..88b4cc8
> > --- /dev/null
> > +++ b/tests/file_contexts/test_multiple.c
> > @@ -0,0 +1,275 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +
> > +#include <selinux/label.h>
> > +#include <selinux/selinux.h>
> > +
> > +#include "internal.h"
> > +
> > +void test_multiple_no_validation(const char *basedir)
> > +{
> > +       struct selabel_handle *hnd;
> > +
> > +       /* f1.fc and f2.fc file */
> > +       char *f1_path, *f2_path;
> > +       asprintf(&f1_path, "%s/f1.fc", basedir);
> > +       asprintf(&f2_path, "%s/f2.fc", basedir);
> > +       struct selinux_opt opts[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
> > +       };
> > +
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> > +       free(f1_path);
> > +       free(f2_path);
> > +
> > +       if (!hnd) {
> > +               log_errno("Unable to open file backend");
> > +               exit(2);
> > +       }
> > +
> > +       struct test_t tests[] =3D {
> > +               { .path =3D "/", .context =3D "system_u:object_r:rootfs=
:s0" },
> > +               {
> > +                       .path =3D "/base",
> > +                       .context =3D "system_u:object_r:test_base_t:s0"
> > +               },
> > +       };
> > +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> > +
> > +       selabel_close(hnd);
> > +}
> > +
> > +void test_multiple_with_validation(const char *basedir)
> > +{
> > +       struct selabel_handle *hnd;
> > +
> > +       /* f1.fc and f2.fc file - f1 has undefined type rootfs in test =
policy */
> > +       char *f1_path, *f2_path;
> > +       asprintf(&f1_path, "%s/f1.fc", basedir);
> > +       asprintf(&f2_path, "%s/f2.fc", basedir);
> > +       struct selinux_opt opts[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> > +               { .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
> > +       };
> > +
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> > +       free(f1_path);
> > +       free(f2_path);
> > +
> > +       if (hnd) {
> > +               log_err("Validation of f1 and f2 should have failed");
> > +               selabel_close(hnd);
> > +               exit(2);
> > +       }
> > +}
> > +
> > +void test_multiple_with_extras(const char *basedir)
> > +{
> > +       struct selabel_handle *hnd;
> > +       char *f2_path, *f3_path;
> > +       asprintf(&f2_path, "%s/f2.fc", basedir);
> > +       asprintf(&f3_path, "%s/f3.fc", basedir);
> > +
> > +       /* 1. f3.fc is the first path: extras (.subs, .local, .homedirs=
) of f3 ARE processed */
> > +       struct selinux_opt opts_f3_first[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f3_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
> > +       };
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts_f3_first,
> > +                          ARRAY_SIZE(opts_f3_first));
> > +       if (!hnd) {
> > +               log_errno("Unable to open file backend");
> > +               exit(2);
> > +       }
> > +
> > +       struct test_t tests_f3_first[] =3D {
> > +               { .path =3D "/", .context =3D "system_u:object_r:rootfs=
:s0" },
> > +               {
> > +                       .path =3D "/sub",
> > +                       .context =3D "system_u:object_r:test_subbed:s0"
> > +               },
> > +               {
> > +                       .path =3D "/local",
> > +                       .context =3D "system_u:object_r:test_local:s0"
> > +               },
> > +               {
> > +                       .path =3D "/homedirs",
> > +                       .context =3D "system_u:object_r:test_homedirs:s=
0"
> > +               },
> > +               {
> > +                       .path =3D "/base",
> > +                       .context =3D "system_u:object_r:test_base_t:s0"
> > +               },
> > +       };
> > +       assertContextsMatch(hnd, __func__, tests_f3_first,
> > +                           ARRAY_SIZE(tests_f3_first));
> > +       selabel_close(hnd);
> > +
> > +       /* 2. f2.fc is the first path, f3.fc is second: extras from f3 =
are NOT processed */
> > +       struct selinux_opt opts_f2_first[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f3_path }
> > +       };
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts_f2_first,
> > +                          ARRAY_SIZE(opts_f2_first));
> > +       if (!hnd) {
> > +               log_errno("Unable to open file backend");
> > +               exit(2);
> > +       }
> > +
> > +       struct test_t tests_f2_first[] =3D {
> > +               {
> > +                       .path =3D "/base",
> > +                       .context =3D "system_u:object_r:test_base_t:s0"
> > +               },
> > +               { .path =3D "/", .context =3D "system_u:object_r:rootfs=
:s0" },
> > +               {
> > +                       .path =3D "/subbed",
> > +                       .context =3D "system_u:object_r:test_subbed:s0"
> > +               },
> > +               /* /sub, /local, /homedirs should NOT match the f3 extr=
a contexts */
> > +               { .path =3D "/sub", .context =3D NULL },
> > +               { .path =3D "/local", .context =3D NULL },
> > +               { .path =3D "/homedirs", .context =3D NULL },
> > +       };
> > +       assertContextsMatch(hnd, __func__, tests_f2_first,
> > +                           ARRAY_SIZE(tests_f2_first));
> > +       selabel_close(hnd);
> > +
> > +       free(f2_path);
> > +       free(f3_path);
> > +}
> > +
> > +void test_multiple_three_paths(const char *basedir)
> > +{
> > +       struct selabel_handle *hnd;
> > +       char *f1_path, *f2_path, *f3_path;
> > +       asprintf(&f1_path, "%s/f1.fc", basedir);
> > +       asprintf(&f2_path, "%s/f2.fc", basedir);
> > +       asprintf(&f3_path, "%s/f3.fc", basedir);
> > +
> > +       struct selinux_opt opts[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f3_path }
> > +       };
> > +
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> > +       free(f1_path);
> > +       free(f2_path);
> > +       free(f3_path);
> > +
> > +       if (!hnd) {
> > +               log_errno("Unable to open file backend");
> > +               exit(2);
> > +       }
> > +
> > +       struct test_t tests[] =3D {
> > +               { .path =3D "/", .context =3D "system_u:object_r:rootfs=
:s0" },
> > +               {
> > +                       .path =3D "/base",
> > +                       .context =3D "system_u:object_r:test_base_t:s0"
> > +               },
> > +               {
> > +                       .path =3D "/subbed",
> > +                       .context =3D "system_u:object_r:test_subbed:s0"
> > +               },
> > +       };
> > +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> > +       selabel_close(hnd);
> > +}
> > +
> > +void test_multiple_duplicate_validation(const char *basedir)
> > +{
> > +       struct selabel_handle *hnd;
> > +
> > +       /* Two copies of f2.fc to provide duplicate specifications */
> > +       char *f2_path;
> > +       asprintf(&f2_path, "%s/f2.fc", basedir);
> > +       struct selinux_opt opts[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path },
> > +               { .type =3D SELABEL_OPT_VALIDATE, .value =3D "1" }
> > +       };
> > +
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> > +       free(f2_path);
> > +
> > +       if (!hnd) {
> > +               log_errno("Unable to open file backend");
> > +               exit(2);
> > +       }
> > +
> > +       struct test_t tests[] =3D {
> > +               {
> > +                       .path =3D "/base",
> > +                       .context =3D "system_u:object_r:test_base_t:s0"
> > +               },
> > +       };
> > +       assertContextsMatch(hnd, __func__, tests, ARRAY_SIZE(tests));
> > +
> > +       selabel_close(hnd);
> > +}
> > +
> > +/* Check if multiple paths are supported. Returns 0 if they are; 1 oth=
erwise */
> > +static int check_multiple_path_support(const char *basedir)
> > +{
> > +       struct selabel_handle *hnd;
> > +       char *f1_path, *f2_path;
> > +       char *context1 =3D NULL, *context2 =3D NULL;
> > +       bool supported =3D false;
> > +
> > +       asprintf(&f1_path, "%s/f1.fc", basedir);
> > +       asprintf(&f2_path, "%s/f2.fc", basedir);
> > +
> > +       struct selinux_opt opts[] =3D {
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f1_path },
> > +               { .type =3D SELABEL_OPT_PATH, .value =3D f2_path }
> > +       };
> > +
> > +       hnd =3D selabel_open(SELABEL_CTX_FILE, opts, ARRAY_SIZE(opts));
> > +       free(f1_path);
> > +       free(f2_path);
> > +
> > +       if (!hnd) {
> > +               /* On older libselinux releases, the second file_contex=
t would
> > +                * be ignored but selabel_open should not fail. */
> > +               log_err("Unable to open file backend");
> > +               exit(2);
> > +       }
> > +
> > +       if (selabel_lookup(hnd, &context1, "/", S_IFREG) =3D=3D 0 &&
> > +           selabel_lookup(hnd, &context2, "/base", S_IFREG) =3D=3D 0) =
{
> > +               supported =3D true;
> > +       }
> > +
> > +       free(context1);
> > +       free(context2);
> > +       selabel_close(hnd);
> > +       return supported ? 0 : 1;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +       if (argc < 2 || argc > 3) {
> > +               log_err("usage: %s <basedir> [check]", argv[0]);
> > +               exit(1);
> > +       }
> > +
> > +       if (argc =3D=3D 3 && strcmp(argv[2], "check") =3D=3D 0) {
> > +               return check_multiple_path_support(argv[1]);
> > +       }
> > +
> > +       test_multiple_no_validation(argv[1]);
> > +       test_multiple_with_validation(argv[1]);
> > +       test_multiple_duplicate_validation(argv[1]);
> > +       test_multiple_with_extras(argv[1]);
> > +       test_multiple_three_paths(argv[1]);
> > +
> > +       return 0;
> > +}
> > --
> > 2.55.0.229.g6434b31f56-goog
> >
