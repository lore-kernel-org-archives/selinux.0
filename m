Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5F2BEFEB
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122558; cv=pass; b=LVQNNjl6qT9zncXTO8KK5f79R1kmTpKUldb/XbjQ1b6LiLS8z8WeWt8vGd7FXT9NBOiM5xBJj7Gzgvwe+vSj3SSmDle2yqO2TTQ6oSpG277S/8f8zRI9TT2/rVgk5Fqfh70RvH2csP8xkNebi36zkgx94nQwpYb6pz80iboJ9ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122558; c=relaxed/simple;
	bh=5+SmCIbsAQe7XAH4tScTa54fOhTCESjbiyW3ELHaohI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKi8yUnijyAhnDnRPE8Hb7cnitIzx70wNuVx8vph1kw13086s9wAh4Dj25yYyjrb75f4NSDtgiXZoNGkLrwDOFfiSCAm8/wln/cLMY+lyIlPcJpBy2I9grHtHGZt/DocfYJ3V4jkQy2WB68K+IVsfptvYlhnubfulE5NJfzmjdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsaeZo2k; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsaeZo2k"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso18306141fa.2
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 06:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784122555; cv=none;
        d=google.com; s=arc-20260327;
        b=B+GEE2wJZ7zqOLNJbQnwbF9euiwFOBLJAGjcWhSGxyOXrW0y/XWybqvV38C4OjXxPl
         mRNDO85T3NYwWrTpgrdS52NCffngaRa/0q6BpseXzP1a08COVyhCunYv+vPx4NL8T+T+
         VJzC8lsX4rGDBgztADwYRglZITP603UXPFv5ylu76m+FLE5COd+Jyrz2oJnmZ5SMLzTk
         H9iej+4qNvEibZXh68Y7m4cP5wiowluhSH/1Yp38AjMGcCb00Ta6iCwlVmj/XunwvKsU
         hJ6TEwq6TgdWXwNfHNMiONLnkN+MhpqIbIE+p4fJIiqEfXJnJCzutusaFKoTBj+eRumy
         g8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7e9HB/JIHwqNWSlLStcsszYwSvG9LO/peNcryN0fWp4=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=ntFY9f2xYByAxg68lRGRYTiddU2VaxoLUxbFX7X8OCm9Er5vgNxpMBoz7Ewl6lRQlL
         kZrcwWCIVMzosHW1d9sz3FeOQGwlx4pz64OyoalwyyK6wrYuIwIVfwxXTcH+C0jaFLbG
         uAsSaVWtHk0GzDJdUcyZ/clsNLTf4iIgwP6a+kbPqv7N4bVP471jjT9jWNLjt6fuKZu7
         jv+fCZNCQDkDe6/SXvoo3Tlc1oM7lxw0HGCibIQkducpaTYghKFl50C53kvLkge678Bq
         Fz121D5vO7iDG2pTOP/Gpw4d95OykUjMCc7uv8K8eFYYwE6113uqmdo9lL3NpL/ydjEu
         PEyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122555; x=1784727355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7e9HB/JIHwqNWSlLStcsszYwSvG9LO/peNcryN0fWp4=;
        b=OsaeZo2k1aZpeHIkmrEuuLNtwIyXLpknjpsQSGG8xhxipFERdI/zDoNaTevOZuozcG
         uzRHClq2IBx4+xgFf4nJvzI7GoZYZLCVRPVKXmIUwtshi+ob/KYqvFho/mYJiw/r7RgY
         vzmONZLkuzML1tLP1aVH3WMocvIFVDvXfNv6q48nvSEI6bpsLP+qPdesfem4bX0kmrv0
         Sn0CJOYNM9pQiL6ZD/5br3g6m7d4bJdxY9pukJDhJlQLHsqae6j4lObqr4EE+ZtO8p5y
         c9RhoIc9QXb+wrGsHRgwkwzC9MC89IoS97WALfnrv4mX73ODZf9cpjdAC39DATn40KJN
         L82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122555; x=1784727355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7e9HB/JIHwqNWSlLStcsszYwSvG9LO/peNcryN0fWp4=;
        b=nmaS3HGWGRs5NX9a+/SzjfMiCngMWkKzou2eb51odVFVy6IhMv87RqmxSY0znGkFB/
         UnRSDTPYOES3caM5XBDc7hQVjwNT+cW37uQnMEL7RK5Of/1hoxSKuBd1cZ8iHOFkqxcI
         EqzbHHdZfN51yUN73NBtRaFB4T8nNhVMyUtZOGogg2H+HJVqWitduDIADZH4RKTCDhzK
         5zInmjhcc1G1p1KzWGrGYORB+5CMXFQKUz2VmP/vZoAouuasrL0UYvYsmUjeILdaEkXs
         P+rloWcrzqmu5+XK6bbXhS9Awle7AzMdhbaRWgquY2jqt1+ZTcKWkMkGs/8vFwMP9NaD
         toWg==
X-Gm-Message-State: AOJu0YyM5twfM7477Vbu5gTy2NjKfjKrwg/wr9BAp0douNkobWeFcET3
	qlWxugdyshIUu1Ze8sZgcxAlYKMQqDYmKbI6HDCO1Jtk0wXRXY9/jlR18eGMfx4Gq/BYpONBTJm
	dGOl+barBBj20naQ0OagrhQCA9EiFEuo=
X-Gm-Gg: AfdE7cm38yfW+oGhee7NzsChoGAMLMi/SPYfMIt+GTDVIMyvGtvo/kTFualQRo8JtIS
	5zxMFW2p6Fe15PRGrwtIVaNqfcHcdz5SSj2JLJaXgWuYcSCU4Tj52GWqbHEJ40nkA9/hPhNaoas
	3+PwSR98PWrGdxcJLo6XZGnsqBP5yqt6HE4qpHETkvGYO5NWL/3WKdfXKWkflAExQ+gV0s8EzyM
	NGu3wIrNmwZdeavIo0bIrUIAlNxs0pLCAJ0p1ynjbXR44XzTD/P5m371Yhxpi7ttxrfuA==
X-Received: by 2002:a2e:a9a3:0:b0:39b:128e:ae68 with SMTP id
 38308e7fff4ca-39ca49e5572mr37306071fa.0.1784122554389; Wed, 15 Jul 2026
 06:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710110323.3086408-1-akkohli@redhat.com> <CAP+JOzTrNuaS7HqayhaRfsPVFfH7CLNjR3W8HG09s2YtRVqM6A@mail.gmail.com>
In-Reply-To: <CAP+JOzTrNuaS7HqayhaRfsPVFfH7CLNjR3W8HG09s2YtRVqM6A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Jul 2026 09:35:42 -0400
X-Gm-Features: AUfX_mxNb8qlosfzDOmKhwzaqj8m2BDnU5_JFlic23mn5zhe9x-k8fLZQu1HH5o
Message-ID: <CAP+JOzRkxLrcDi2NkEPE8vdudaX_PWyy9FBCNwzoHe=rGg7EQQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: add bad data protection tests
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 10:23=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Jul 10, 2026 at 7:03=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> =
wrote:
> >
> > Add test_checkmodule_negative.sh and .te fixtures for  bad-data protect=
ion (missing/bad-path and corrupted .te inputs).
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  checkpolicy/Makefile                          |   3 +-
> >  checkpolicy/tests/negative/bad_module_line.te |   5 +
> >  checkpolicy/tests/negative/bad_require.te     |   5 +
> >  checkpolicy/tests/negative/bad_syntax.te      |   8 +
> >  checkpolicy/tests/negative/dup_module.te      |   6 +
> >  checkpolicy/tests/negative/good_module.te     |   8 +
> >  .../tests/negative/invalid_module_version.te  |   5 +
> >  checkpolicy/tests/negative/unknown_class.te   |   7 +
> >  checkpolicy/tests/negative/unknown_perm.te    |   8 +
> >  checkpolicy/tests/negative/unknown_type.te    |   8 +
> >  .../tests/test_checkmodule_negative.sh        | 178 ++++++++++++++++++
> >  11 files changed, 240 insertions(+), 1 deletion(-)
> >  create mode 100644 checkpolicy/tests/negative/bad_module_line.te
> >  create mode 100644 checkpolicy/tests/negative/bad_require.te
> >  create mode 100644 checkpolicy/tests/negative/bad_syntax.te
> >  create mode 100644 checkpolicy/tests/negative/dup_module.te
> >  create mode 100644 checkpolicy/tests/negative/good_module.te
> >  create mode 100644 checkpolicy/tests/negative/invalid_module_version.t=
e
> >  create mode 100644 checkpolicy/tests/negative/unknown_class.te
> >  create mode 100644 checkpolicy/tests/negative/unknown_perm.te
> >  create mode 100644 checkpolicy/tests/negative/unknown_type.te
> >  create mode 100755 checkpolicy/tests/test_checkmodule_negative.sh
> >
> > diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> > index 0055f495..e59ad63a 100644
> > --- a/checkpolicy/Makefile
> > +++ b/checkpolicy/Makefile
> > @@ -51,8 +51,9 @@ lex.yy.c: policy_scan.l y.tab.c
> >         $(LEX) policy_scan.l
> >
> >  .PHONY: test
> > -test: checkpolicy
> > +test: checkpolicy checkmodule
> >         ./tests/test_roundtrip.sh
> > +       ./tests/test_checkmodule_negative.sh
> >
> >  # helper target for fuzzing
> >  checkobjects: $(CHECKOBJS)
> > diff --git a/checkpolicy/tests/negative/bad_module_line.te b/checkpolic=
y/tests/negative/bad_module_line.te
> > new file mode 100644
> > index 00000000..587df2e1
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_module_line.te
> > @@ -0,0 +1,5 @@
> > +module bad module name 1.0 garbage;
> > +
> > +require {
> > +       type foo_t;
> > +}
> > diff --git a/checkpolicy/tests/negative/bad_require.te b/checkpolicy/te=
sts/negative/bad_require.te
> > new file mode 100644
> > index 00000000..a45df4f4
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_require.te
> > @@ -0,0 +1,5 @@
> > +module bad_require 1.0;
> > +
> > +require {
> > +       garbage_token foo_t;
> > +}
> > diff --git a/checkpolicy/tests/negative/bad_syntax.te b/checkpolicy/tes=
ts/negative/bad_syntax.te
> > new file mode 100644
> > index 00000000..20605201
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/bad_syntax.te
> > @@ -0,0 +1,8 @@
> > +module bad_syntax 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +       class file { read };
> > +}
> > +
> > +allow foo_t foo_t:file {
> > diff --git a/checkpolicy/tests/negative/dup_module.te b/checkpolicy/tes=
ts/negative/dup_module.te
> > new file mode 100644
> > index 00000000..beefff72
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/dup_module.te
> > @@ -0,0 +1,6 @@
> > +module dup_module 1.0;
> > +module dup_module 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +}
> > diff --git a/checkpolicy/tests/negative/good_module.te b/checkpolicy/te=
sts/negative/good_module.te
> > new file mode 100644
> > index 00000000..b9c9982f
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/good_module.te
> > @@ -0,0 +1,8 @@
> > +module good_module 1.0;
> > +
> > +require {
> > +       type foo_t, bar_t;
> > +       class file { read write };
> > +}
> > +
> > +allow foo_t bar_t:file read;
> > diff --git a/checkpolicy/tests/negative/invalid_module_version.te b/che=
ckpolicy/tests/negative/invalid_module_version.te
> > new file mode 100644
> > index 00000000..d18b7639
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/invalid_module_version.te
> > @@ -0,0 +1,5 @@
> > +module invalid_module_version;
> > +
> > +require {
> > +       type foo_t;
> > +}
> > diff --git a/checkpolicy/tests/negative/unknown_class.te b/checkpolicy/=
tests/negative/unknown_class.te
> > new file mode 100644
> > index 00000000..825e0413
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/unknown_class.te
> > @@ -0,0 +1,7 @@
> > +module unknown_class 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +}
> > +
> > +allow foo_t self:not_a_class read;
> > diff --git a/checkpolicy/tests/negative/unknown_perm.te b/checkpolicy/t=
ests/negative/unknown_perm.te
> > new file mode 100644
> > index 00000000..f4efbb54
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/unknown_perm.te
> > @@ -0,0 +1,8 @@
> > +module unknown_perm 1.0;
> > +
> > +require {
> > +       type foo_t, bar_t;
> > +       class file { read };
> > +}
> > +
> > +allow foo_t bar_t:file circular_ref;
> > diff --git a/checkpolicy/tests/negative/unknown_type.te b/checkpolicy/t=
ests/negative/unknown_type.te
> > new file mode 100644
> > index 00000000..62360e04
> > --- /dev/null
> > +++ b/checkpolicy/tests/negative/unknown_type.te
> > @@ -0,0 +1,8 @@
> > +module unknown_type 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +       class file { read };
> > +}
> > +
> > +allow foo_t undeclared_t:file read;
> > diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpoli=
cy/tests/test_checkmodule_negative.sh
> > new file mode 100755
> > index 00000000..a5f49f3b
> > --- /dev/null
> > +++ b/checkpolicy/tests/test_checkmodule_negative.sh
> > @@ -0,0 +1,178 @@
> > +#!/bin/sh
> > +#
> > +# Negative / bad-data tests for checkmodule on module (.te) inputs.
> > +# Matches the modular policy compile path: checkmodule -M -m <input> -=
o <module>.mod
> > +#
> > +
> > +set -eu
> > +
> > +BASEDIR=3D$(CDPATH=3D cd -- "$(dirname "$0")" && pwd)
> > +NEGDIR=3D"${BASEDIR}/negative"
> > +CHECKMODULE=3D"${BASEDIR}/../checkmodule"
> > +OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/checkmodule-negative.XXXXXX")
> > +PASS=3D0
> > +FAIL=3D0
> > +
> > +cleanup() {
> > +       rm -rf "${OUTDIR}"
> > +}
> > +trap cleanup EXIT
> > +
> > +mod_name_from_fixture() {
> > +       basename "$1" .te
> > +}
> > +
> > +expect_pass() {
> > +       desc=3D"$1"
> > +       fixture=3D"$2"
> > +       modname=3D$(mod_name_from_fixture "${fixture}")
> > +       outmod=3D"${OUTDIR}/${modname}.mod"
> > +       stderr=3D"${OUTDIR}/${modname}.err"
> > +
> > +       echo "=3D=3D=3D=3D POSITIVE (expect checkmodule success): ${des=
c}"
> > +       rm -f "${outmod}"
> > +
> > +       set +e
> > +       "${CHECKMODULE}" -M -m -o "${outmod}" "${NEGDIR}/${fixture}" 2>=
"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -ne 0 ]; then
> > +               echo "FAIL: expected success (rc=3D0), got rc=3D${rc}" =
>&2
> > +               cat "${stderr}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +       if [ ! -s "${outmod}" ]; then
> > +               echo "FAIL: expected non-empty ${outmod}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +
> > +       echo "=3D=3D=3D=3D ${desc} success"
> > +       PASS=3D$((PASS + 1))
> > +       echo ""
> > +}
> > +
> > +expect_fail() {
> > +       desc=3D"$1"
> > +       pattern=3D"$2"
> > +       outname=3D"${3:-fail}"
> > +       shift 3
> > +
> > +       outmod=3D"${OUTDIR}/${outname}.mod"
> > +       stderr=3D"${OUTDIR}/${outname}.err"
> > +
> > +       echo "=3D=3D=3D=3D NEGATIVE (expect checkmodule error): ${desc}=
"
> > +       rm -f "${outmod}"
> > +
> > +       set +e
> > +       "${CHECKMODULE}" -M -m "$@" -o "${outmod}" 2>"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -eq 0 ]; then
> > +               echo "FAIL: expected non-zero exit, got rc=3D0" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +       if [ -f "${outmod}" ]; then
> > +               echo "FAIL: did not expect output module ${outmod}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +       if ! grep -Eq "${pattern}" "${stderr}"; then
> > +               echo "FAIL: stderr did not match /${pattern}/" >&2
> > +               cat "${stderr}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +
> > +       echo "=3D=3D=3D=3D ${desc}: rejected as expected"
> > +       PASS=3D$((PASS + 1))
> > +       echo ""
> > +}
> > +
> > +expect_fail_unreadable() {
> > +       desc=3D"unreadable .te file"
> > +       fixture=3D"${OUTDIR}/unreadable.te"
> > +       outmod=3D"${OUTDIR}/unreadable.mod"
> > +       stderr=3D"${OUTDIR}/unreadable.err"
> > +
> > +       echo "=3D=3D=3D=3D NEGATIVE (expect checkmodule error): ${desc}=
"
> > +       if [ "$(id -u)" -eq 0 ]; then
> > +               echo "SKIP: root can read mode 000 files; unreadable ch=
eck is non-root only"
> > +               PASS=3D$((PASS + 1))
> > +               echo ""
> > +               return 0
> > +       fi
> > +
> > +       rm -f "${outmod}"
> > +
> > +       set +e
> > +       "${CHECKMODULE}" -M -m -o "${outmod}" "${fixture}" 2>"${stderr}=
"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -eq 0 ]; then
> > +               echo "FAIL: expected non-zero exit, got rc=3D0" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +       if [ -f "${outmod}" ]; then
> > +               echo "FAIL: did not expect output module ${outmod}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +       if ! grep -Eq 'unable to open|Permission denied' "${stderr}"; t=
hen
> > +               echo "FAIL: stderr did not mention unable to open or Pe=
rmission denied" >&2
> > +               cat "${stderr}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 1
> > +       fi
> > +
> > +       echo "=3D=3D=3D=3D ${desc}: rejected as expected"
> > +       PASS=3D$((PASS + 1))
> > +       echo ""
> > +}
> > +
> > +# Ephemeral fixtures for path-based cases.
> > +ln -sf /nonexistent/path "${OUTDIR}/broken_symlink.te"
> > +cat > "${OUTDIR}/unreadable.te" <<'EOF'
> > +module unreadable 1.0;
> > +
> > +require {
> > +       type foo_t;
> > +}
> > +EOF
> > +chmod 000 "${OUTDIR}/unreadable.te"
> > +
> > +# Control fixture: valid module compiles and produces .mod output.
> > +expect_pass "good_module.te" "good_module.te"
> > +
> > +# Corrupted .te sections (PDF #2).
> > +expect_fail "bad_syntax.te" "syntax error" "bad_syntax" "${NEGDIR}/bad=
_syntax.te"
> > +expect_fail "unknown_perm.te" "permission circular_ref is not defined"=
 "unknown_perm" "${NEGDIR}/unknown_perm.te"
> > +expect_fail "unknown_type.te" "unknown type undeclared_t" "unknown_typ=
e" "${NEGDIR}/unknown_type.te"
> > +expect_fail "unknown_class.te" "unknown class not_a_class" "unknown_cl=
ass" "${NEGDIR}/unknown_class.te"
> > +expect_fail "bad_module_line.te" "syntax error" "bad_module_line" "${N=
EGDIR}/bad_module_line.te"
> > +expect_fail "bad_require.te" "syntax error" "bad_require" "${NEGDIR}/b=
ad_require.te"
> > +expect_fail "invalid_module_version.te" "syntax error" "invalid_module=
_version" "${NEGDIR}/invalid_module_version.te"
> > +expect_fail "dup_module.te" "syntax error" "dup_module" "${NEGDIR}/dup=
_module.te"
> > +
> > +# Missing / bad-path .te inputs (PDF #1).
> > +expect_fail "missing .te path" "unable to open" "missing_path" "${OUTD=
IR}/does_not_exist.te"
> > +expect_fail "directory instead of .te file" "input in flex scanner fai=
led" "directory_input" "${NEGDIR}"
> > +expect_fail "broken symlink to .te" "unable to open" "broken_symlink" =
"${OUTDIR}/broken_symlink.te"
> > +expect_fail_unreadable
> > +expect_fail "empty .te path argument" "unable to open" "empty_path" ""
> > +
> > +# CLI edge cases.
> > +expect_fail "checkmodule with no input file" "unable to open policy.co=
nf" "no_input"
> > +expect_fail "checkmodule -o name mismatch" "Module name good_module is=
 different" "name_mismatch" \
> > +       -o "${OUTDIR}/wrong_name.mod" "${NEGDIR}/good_module.te"
> > +
> > +echo "checkmodule negative tests: ${PASS} passed, ${FAIL} failed"
> > +if [ "${FAIL}" -ne 0 ]; then
> > +       exit 1
> > +fi
> > --
> > 2.55.0
> >
> >
