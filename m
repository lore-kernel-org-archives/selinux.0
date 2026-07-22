Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00B40F74B
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722903; cv=pass; b=hGl3IQbi+LnzSx0bln30/m2q2ysOHz30XDNpTHYnApzq372RnwhpyfkPTYo60Z+MmlSZR5p0G3Hw0gS8a7IKVvwB7sSeD8LUO39XGYEBSIzlGsUmEQRTkXDRj0ltnzhQ6qOcxSI1MJp9GrW6kJ6/SA46pKn43EQmtS3a+LTPBac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722903; c=relaxed/simple;
	bh=Dx5shlEERNcVRBOlKSrJ6HJ+nb5BWqQMFnx3DM1WoDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXqyOoOaFAAYNrwBWd4TihCOOUa9dx3p5w3HR2X76jXhgRy6vQgihdX7BpPGZ2k9/l+aD4P3ssArOsOe5hmBQ/sh42WF921vxIY72bOY1EyXPA/pSFeWJONimrxzfm2wISRHDvrd+JoUYfJAcrNxmWoYSUtIHLktt4SMvkw/BZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h48lLH32; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h48lLH32"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so41148045ad.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 05:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784722901; cv=none;
        d=google.com; s=arc-20260327;
        b=iidVBiqjOAekm7aGDM881TGJsDdpf5ZtY8mSrMp48ankYbJ6Yxwsa8gLGAyvDHVnZf
         rDUpMrpCILrCPBfV0INdAxUljv4RNYr8kzwubKqVRXlPDR/hIEd7G0Ru29xNolGQhbEU
         ytlw9BXMjh1onYPXlSvkTchfy/1t+58/5HtPvIT5gkyFoDZi8AWgleHyISLDpy3VnWEe
         TM7rpQijkdpkDoh6UbV4R7HZJJpGTcdmx4aJ7fSWpdx87McOFnMGs0DYpKXrEEqOfFLc
         DQmIAJOHtNslLif5j+lmj+Yx8tXzOM3I50shD9T5p6oMXFAOIlwCa0X1CKLB+r02PGNA
         mDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHTPEjjnrNzeQ7M8TGBbWXlAv15jkAqJ/ZbKsPX9+zA=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=rRvzD9p62kWOrdAVTosI47nKrW/gtQZ6UQtWrdn956TrVgPeNPeyfRKWr0m3/gygTO
         pBx0FQ49LZkp3dYLSwwqRp+gCufQ5YTX9syMgSYGaPYcHgYmDB0wnHy7wVplcy9gKW57
         N4ma94D7qTPx/bGpJWABSaIMTvdcJQ9/FuMjLjL9ufdLvqHepvO84QDsXhjSErZuUS+g
         VpksDraEcqGPJ/gPPQIjkR3frP0kXPjx+O6IMcFc9e6fIZmkEBGBY0VyCmGKPdnCXWQg
         3GRQzbaf7DOGrHSjBYVpsGPReMHGXACOZDzLxKCy6MTR887wSkCVwM3Kw7mtBaiSnoS0
         sksg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784722901; x=1785327701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHTPEjjnrNzeQ7M8TGBbWXlAv15jkAqJ/ZbKsPX9+zA=;
        b=h48lLH32unwdg4TvAcl+LJVfZQ1ENPWAopEPDLvB3feidwuz4cyk+c5achZF5B/H7H
         wsM8Fl7ZWenHlsYLQitisZCLSKA4mduLQ6reFEFVMINnSYdZJ+VOg/yxpvJPAso8j29a
         UL4ZX374Kgp/cZuFCY67RS6/GVjVUyLefaqtd3kWhirR0Rq2JVx1MWJ72ToegJceKq8p
         dcGpHsrOq5X96K7J2hAkCYwVk+NQrrVwEPcddqBxyT+xWH7Eco5t3Nd+Vt52rSoqFEgG
         WqNHP5f/z9BUR1j2BvAS9l/PjLyU3JwdtuT+g9uDpZ47wPqzyewluk9b0xotu2WZhAfQ
         itWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784722901; x=1785327701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHTPEjjnrNzeQ7M8TGBbWXlAv15jkAqJ/ZbKsPX9+zA=;
        b=FqMl89NThZ4F9oMp4BILXb4HrLAPQIovVsb5pBjucAVSQeF8dMTaqe55Kh5PidHE25
         YBlNWUD8LYHMjA+jwps7ikLpxQcKf/pDGH1S8LFyQkBpFPJIF2V5y9CJR7lrud44XfAM
         vG6DFRXt0W8Czgc5MK3PuZbtRNESZcKCwQN6jZrLCT2co+k5a9Dd0p7hunDdHg4U/LC2
         MAwGesvz32Fw2LycdmyGhTdDmVxdY+QOhuYkV5sfR0UUah9PEq7KiWiGFi8aAXa+4QRq
         i7A/hqwupV13xi+pZaqSef0tcgNxf8S/6stDsggGaM3QCnbOK4OumZmso249Q+qKlR92
         cBMQ==
X-Gm-Message-State: AOJu0YwFsusRkyWCMIPCEIRs/wK9IxTgMP6zmbWkcQHuQ/gGt8cLx8//
	4ePoHlmYdmQLHsdnFL82MCIQaYQu9lcXJSeiCFILRd5GgtZHdSMUGtjw8waYpdrsw5de+ZPz3LH
	JASlQbamMOOW7Mvae6TnIcZkkOahSiLo9qw==
X-Gm-Gg: AR+sD139VwHFyV8624Pl1ocjQLh5PKQwoNjpyiAWl1dP55kaUuqH5S1ESS8uoQetjeM
	haXe7pzlsv5dYU/mqeSimoiDuVBMt3gzX8HzTIukGPMxw/POskeWty+K8zSC6IqKL2gr97MJaeM
	Qsii/P2ulE5vZW9z9bIibaqLd2zwZVFChctmKCT3VjH/JgXuuS9UovW7J8Qh9xcNjLviy/IaGZ/
	+ZRjq8AIFROesLTgo5siYtr15Tzjk22d6/QAioNv353ZtzGqpS5jnw7pJCJiw==
X-Received: by 2002:a17:903:40c9:b0:2ca:61bc:317c with SMTP id
 d9443c01a7336-2cf348453b6mr272815055ad.13.1784722901013; Wed, 22 Jul 2026
 05:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720134940.2192826-1-akkohli@redhat.com> <20260721212614.2264953-1-akkohli@redhat.com>
In-Reply-To: <20260721212614.2264953-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 Jul 2026 08:21:29 -0400
X-Gm-Features: AUfX_mw86a7vh7GcGmwZaOKzIdt7Kpecye6O8RkI3PlfbNaJ4y-xkJBHTn3F3N0
Message-ID: <CAEjxPJ6i97g7nq-Yx2UJ3wJLYUNfH-w4_dvXF2L=NKXxHn6B-Q@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for semodule_package
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:34=E2=80=AFPM Akhil Kohli <akkohli@redhat.com> wr=
ote:
>
> Add tests/bad-data/run.sh and fixtures for semodule_package bad-data
> protection: input path validation for -m and -f (missing paths, directori=
es,
> broken symlinks, unreadable files, empty arguments) and malformed .mod.fc
> content at packaging time. Wire the driver into semodule-utils make test.
> Semantic validation of bad file contexts is deferred to sefcontext_compil=
e.
>
> Run the harness as a non-root user in GitHub Actions so unreadable -m/-f
> inputs are exercised in CI.
>
> ---
> v2 changes:
> - Fix CI non-root bad-data run: cd to repo root and chmod checkout for ru=
nuser
> - Fail fast if run.sh cannot resolve BASEDIR

You didn't update the subject line to include "v2" (use -v2 to
git-send-email to add it automatically),
which confuses b4 when it fetches the patches and tries to decide
which one(s) to apply. We can
manually fetch and apply but note for future patches please.

>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> ---
>  .github/workflows/run_tests.yml               |  11 +
>  semodule-utils/Makefile                       |   1 +
>  .../fixtures/file_contexts/bad_context.mod.fc |   1 +
>  .../fixtures/file_contexts/bad_fields.mod.fc  |   1 +
>  .../fixtures/file_contexts/good.mod.fc        |   1 +
>  .../tests/bad-data/fixtures/modules/good.te   |   8 +
>  semodule-utils/tests/bad-data/run.sh          | 347 ++++++++++++++++++
>  7 files changed, 370 insertions(+)
>  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/=
bad_context.mod.fc
>  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/=
bad_fields.mod.fc
>  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/=
good.mod.fc
>  create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/good.t=
e
>  create mode 100755 semodule-utils/tests/bad-data/run.sh
>
> diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_test=
s.yml
> index f4aa1a4c..45778c25 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -82,6 +82,17 @@ jobs:
>          eval make test $EXPLICIT_MAKE_VARS
>          echo "::endgroup::"
>
> +        # semodule_package bad-data: unreadable -m/-f inputs need non-ro=
ot (root reads mode 000).
> +        if [ "${{ matrix.python-ruby-version.other }}" !=3D "sanitizers"=
 ] ; then
> +          echo "::group::semodule-utils bad-data (non-root)"
> +          sudo useradd -m -s /usr/sbin/nologin bad-data-test 2>/dev/null=
 || true
> +          chmod -R a+rX .
> +          sudo runuser -u bad-data-test -- env PATH=3D"$PATH" LD_LIBRARY=
_PATH=3D"$LD_LIBRARY_PATH" \
> +            sh -c 'cd "$1" && exec ./semodule-utils/tests/bad-data/run.s=
h' sh "$PWD"
> +          sudo userdel -r bad-data-test 2>/dev/null || true
> +          echo "::endgroup::"
> +        fi
> +
>          if [ "${{ matrix.python-ruby-version.other }}" !=3D "sanitizers"=
 ] ; then
>              # Test Python and Ruby wrappers
>              echo "::group::Test Python and Ruby wrappers"
> diff --git a/semodule-utils/Makefile b/semodule-utils/Makefile
> index 81c97af0..4a902146 100644
> --- a/semodule-utils/Makefile
> +++ b/semodule-utils/Makefile
> @@ -6,3 +6,4 @@ all install relabel clean:
>         done
>
>  test:
> +       ./tests/bad-data/run.sh
> diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_con=
text.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_cont=
ext.mod.fc
> new file mode 100644
> index 00000000..06aec43e
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_context.mo=
d.fc
> @@ -0,0 +1 @@
> +/usr/bin/bad   not_a_valid_selinux_context
> diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fie=
lds.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_field=
s.mod.fc
> new file mode 100644
> index 00000000..13821d61
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fields.mod=
.fc
> @@ -0,0 +1 @@
> +only_one_field_on_this_line
> diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mo=
d.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
> new file mode 100644
> index 00000000..12b26cae
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
> @@ -0,0 +1 @@
> +/usr/bin/test_good     --      system_u:object_r:test_good_exec_t:s0
> diff --git a/semodule-utils/tests/bad-data/fixtures/modules/good.te b/sem=
odule-utils/tests/bad-data/fixtures/modules/good.te
> new file mode 100644
> index 00000000..a079aed6
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/fixtures/modules/good.te
> @@ -0,0 +1,8 @@
> +module test_good 1.0;
> +
> +require {
> +       type test_good_t;
> +       class file { read };
> +}
> +
> +allow test_good_t self:file read;
> diff --git a/semodule-utils/tests/bad-data/run.sh b/semodule-utils/tests/=
bad-data/run.sh
> new file mode 100755
> index 00000000..0265032a
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/run.sh
> @@ -0,0 +1,347 @@
> +#!/bin/sh
> +#
> +# Bad-data tests for semodule_package in the modular policy packaging pi=
peline.
> +# Covers packaging path edge cases (-m/-f) and documents deferred reject=
ion of bad
> +# .mod.fc content (enforced later by sefcontext_compile on the Bucket D =
branch).
> +# Unreadable -m/-f cases skip when run as root; CI runs this script as n=
on-root.
> +#
> +
> +set -u
> +
> +BASEDIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd) || {
> +       echo "FAIL: cannot resolve script directory (\$0=3D$0)" >&2
> +       exit 1
> +}
> +FIXTURES=3D"${BASEDIR}/fixtures"
> +OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/semodule-package-bad-data.XXXXXX")
> +PASS=3D0
> +FAIL=3D0
> +
> +CHECKMODULE=3D${CHECKMODULE:-checkmodule}
> +# Modular TE for MCS/MLS builds (matches RHIVOS checkmodule -M -m).
> +CHECKMODULE_MOD_FLAGS=3D${CHECKMODULE_MOD_FLAGS:--M -m}
> +SEMODULE_PACKAGE=3D${SEMODULE_PACKAGE:-semodule_package}
> +
> +GOOD_TE=3D"${FIXTURES}/modules/good.te"
> +GOOD_MOD=3D"${OUTDIR}/test_good.mod"
> +
> +cleanup() {
> +       rm -rf "${OUTDIR}"
> +}
> +trap cleanup EXIT
> +
> +die() {
> +       echo "FAIL: $*" >&2
> +       FAIL=3D$((FAIL + 1))
> +}
> +
> +pass() {
> +       echo "=3D=3D=3D=3D $*"
> +       PASS=3D$((PASS + 1))
> +       echo ""
> +}
> +
> +build_good_mod() {
> +       echo "=3D=3D=3D=3D Setup: build control module ${GOOD_MOD} from g=
ood.te"
> +       rm -f "${GOOD_MOD}"
> +
> +       set +e
> +       # shellcheck disable=3DSC2086
> +       "${CHECKMODULE}" ${CHECKMODULE_MOD_FLAGS} -o "${GOOD_MOD}" "${GOO=
D_TE}" \
> +               2>"${OUTDIR}/build_good.err"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -ne 0 ]; then
> +               echo "FAIL: could not build control module from ${GOOD_TE=
}" >&2
> +               cat "${OUTDIR}/build_good.err" >&2
> +               exit 1
> +       fi
> +       if [ ! -s "${GOOD_MOD}" ]; then
> +               echo "FAIL: ${GOOD_MOD} is empty" >&2
> +               exit 1
> +       fi
> +       echo ""
> +}
> +
> +expect_package_pass() {
> +       desc=3D"$1"
> +       outname=3D"$2"
> +       shift 2
> +
> +       outpp=3D"${OUTDIR}/${outname}.pp"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D POSITIVE (expect semodule_package success): ${=
desc}"
> +       rm -f "${outpp}"
> +
> +       set +e
> +       "${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -ne 0 ]; then
> +               echo "stderr:" >&2
> +               cat "${stderr}" >&2
> +               die "${desc}: expected exit 0, got rc=3D${rc}"
> +               return 0
> +       fi
> +       if [ ! -s "${outpp}" ]; then
> +               die "${desc}: expected non-empty ${outpp}"
> +               return 0
> +       fi
> +
> +       pass "${desc} (exit 0, .pp created)"
> +}
> +
> +expect_package_pass_deferred() {
> +       desc=3D"$1"
> +       outname=3D"$2"
> +       shift 2
> +
> +       outpp=3D"${OUTDIR}/${outname}.pp"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D DOCUMENT (semodule_package accepts input; vali=
date in sefcontext_compile): ${desc}"
> +       rm -f "${outpp}"
> +
> +       set +e
> +       "${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -ne 0 ]; then
> +               echo "stderr:" >&2
> +               cat "${stderr}" >&2
> +               die "${desc}: expected exit 0 at packaging stage, got rc=
=3D${rc}"
> +               return 0
> +       fi
> +       if [ ! -s "${outpp}" ]; then
> +               die "${desc}: expected non-empty ${outpp} at packaging st=
age"
> +               return 0
> +       fi
> +
> +       pass "${desc} (packaging exit 0; labeling validation deferred to =
sefcontext_compile)"
> +}
> +
> +expect_package_fail() {
> +       desc=3D"$1"
> +       pattern=3D"$2"
> +       outname=3D"$3"
> +       shift 3
> +
> +       outpp=3D"${OUTDIR}/${outname}.pp"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D NEGATIVE (expect semodule_package failure): ${=
desc}"
> +       rm -f "${outpp}"
> +
> +       set +e
> +       "${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -eq 0 ]; then
> +               die "${desc}: expected non-zero exit, got rc=3D0"
> +               return 0
> +       fi
> +       if [ -f "${outpp}" ]; then
> +               die "${desc}: did not expect output ${outpp}"
> +               return 0
> +       fi
> +       if ! grep -Eq "${pattern}" "${stderr}"; then
> +               echo "FAIL: stderr did not match /${pattern}/" >&2
> +               cat "${stderr}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 0
> +       fi
> +
> +       pass "${desc} (rejected as expected, rc=3D${rc})"
> +}
> +
> +expect_package_fail_unreadable() {
> +       desc=3D"unreadable -m file"
> +       mod=3D"${OUTDIR}/unreadable.mod"
> +       outpp=3D"${OUTDIR}/unreadable.pp"
> +       stderr=3D"${OUTDIR}/unreadable.err"
> +
> +       echo "=3D=3D=3D=3D NEGATIVE (expect semodule_package failure): ${=
desc}"
> +       if [ "$(id -u)" -eq 0 ]; then
> +               echo "SKIP: root can read mode 000 files; unreadable chec=
k is non-root only"
> +               PASS=3D$((PASS + 1))
> +               echo ""
> +               return 0
> +       fi
> +
> +       rm -f "${outpp}"
> +       cp "${GOOD_MOD}" "${mod}"
> +       chmod 000 "${mod}"
> +
> +       set +e
> +       "${SEMODULE_PACKAGE}" -o "${outpp}" -m "${mod}" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -eq 0 ]; then
> +               die "${desc}: expected non-zero exit, got rc=3D0"
> +               return 0
> +       fi
> +       if [ -f "${outpp}" ]; then
> +               die "${desc}: did not expect output ${outpp}"
> +               return 0
> +       fi
> +       if ! grep -Eq 'Permission denied|Could not open|Failed to open' "=
${stderr}"; then
> +               echo "FAIL: stderr did not mention permission or open fai=
lure" >&2
> +               cat "${stderr}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 0
> +       fi
> +
> +       pass "${desc} (rejected as expected, rc=3D${rc})"
> +}
> +
> +expect_package_fail_unreadable_fc() {
> +       desc=3D"unreadable -f file"
> +       fc=3D"${OUTDIR}/unreadable.mod.fc"
> +       outpp=3D"${OUTDIR}/unreadable_fc.pp"
> +       stderr=3D"${OUTDIR}/unreadable_fc.err"
> +
> +       echo "=3D=3D=3D=3D NEGATIVE (expect semodule_package failure): ${=
desc}"
> +       if [ "$(id -u)" -eq 0 ]; then
> +               echo "SKIP: root can read mode 000 files; unreadable chec=
k is non-root only"
> +               PASS=3D$((PASS + 1))
> +               echo ""
> +               return 0
> +       fi
> +
> +       rm -f "${outpp}"
> +       cp "${GOOD_FC}" "${fc}"
> +       chmod 000 "${fc}"
> +
> +       set +e
> +       "${SEMODULE_PACKAGE}" -o "${outpp}" -m "${GOOD_MOD}" -f "${fc}" \
> +               2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -eq 0 ]; then
> +               die "${desc}: expected non-zero exit, got rc=3D0"
> +               return 0
> +       fi
> +       if [ -f "${outpp}" ]; then
> +               die "${desc}: did not expect output ${outpp}"
> +               return 0
> +       fi
> +       if ! grep -Eq 'Permission denied|Could not open|Failed to open' "=
${stderr}"; then
> +               echo "FAIL: stderr did not mention permission or open fai=
lure" >&2
> +               cat "${stderr}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 0
> +       fi
> +
> +       pass "${desc} (rejected as expected, rc=3D${rc})"
> +}
> +
> +build_good_mod
> +
> +# Ephemeral path fixtures for packaging path tests.
> +ln -sf /nonexistent/test_good.mod "${OUTDIR}/broken_symlink.mod"
> +ln -sf /nonexistent/test_good.mod.fc "${OUTDIR}/broken_symlink.mod.fc"
> +printf '' > "${OUTDIR}/empty.mod.fc"
> +
> +# NUL byte inside path column (packaging accepts; sefcontext_compile rej=
ects).
> +printf '/bin/foo\x00bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' \
> +       > "${OUTDIR}/nul_bytes.mod.fc"
> +
> +GOOD_FC=3D"${FIXTURES}/file_contexts/good.mod.fc"
> +
> +# --- semodule_package input paths ---
> +expect_package_pass \
> +       "control good .mod without file contexts" \
> +       good_mod \
> +       -m "${GOOD_MOD}"
> +
> +expect_package_pass \
> +       "control good .mod with good .mod.fc" \
> +       good_mod_fc \
> +       -m "${GOOD_MOD}" -f "${GOOD_FC}"
> +
> +expect_package_fail \
> +       "missing -m path" \
> +       "Could not open|Failed to open" \
> +       missing_mod \
> +       -m "${OUTDIR}/does_not_exist.mod"
> +
> +expect_package_fail \
> +       "missing -f path" \
> +       "Failed to open|Could not open" \
> +       missing_fc \
> +       -m "${GOOD_MOD}" -f "${OUTDIR}/does_not_exist.mod.fc"
> +
> +expect_package_fail \
> +       "directory instead of -m file" \
> +       "Error while reading policy module|Could not open" \
> +       directory_mod \
> +       -m "${BASEDIR}"
> +
> +expect_package_fail \
> +       "broken symlink for -m" \
> +       "Could not open|Failed to open|No such file" \
> +       symlink_mod \
> +       -m "${OUTDIR}/broken_symlink.mod"
> +
> +expect_package_fail_unreadable
> +
> +expect_package_fail \
> +       "empty -m path argument" \
> +       "Could not open|Failed to open" \
> +       empty_mod \
> +       -m ""
> +
> +expect_package_fail \
> +       "directory instead of -f file" \
> +       "Permission denied|Failed to mmap|Failed to open|Could not open" =
\
> +       directory_fc \
> +       -m "${GOOD_MOD}" -f "${BASEDIR}"
> +
> +expect_package_fail \
> +       "broken symlink for -f" \
> +       "Could not open|Failed to open|No such file" \
> +       symlink_fc \
> +       -m "${GOOD_MOD}" -f "${OUTDIR}/broken_symlink.mod.fc"
> +
> +expect_package_fail_unreadable_fc
> +
> +expect_package_fail \
> +       "empty -f path argument" \
> +       "Could not open|Failed to open" \
> +       empty_fc_arg \
> +       -m "${GOOD_MOD}" -f ""
> +
> +# --- bad .mod.fc at packaging time ---
> +expect_package_pass_deferred \
> +       "invalid SELinux context in .mod.fc" \
> +       bad_context \
> +       -m "${GOOD_MOD}" -f "${FIXTURES}/file_contexts/bad_context.mod.fc=
"
> +
> +expect_package_pass_deferred \
> +       "wrong field count in .mod.fc" \
> +       bad_fields \
> +       -m "${GOOD_MOD}" -f "${FIXTURES}/file_contexts/bad_fields.mod.fc"
> +
> +expect_package_pass_deferred \
> +       "NUL byte in .mod.fc path field" \
> +       nul_bytes \
> +       -m "${GOOD_MOD}" -f "${OUTDIR}/nul_bytes.mod.fc"
> +
> +expect_package_pass_deferred \
> +       "empty .mod.fc file" \
> +       empty_fc \
> +       -m "${GOOD_MOD}" -f "${OUTDIR}/empty.mod.fc"
> +
> +echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> +echo "Results: ${PASS} passed, ${FAIL} failed"
> +if [ "${FAIL}" -ne 0 ]; then
> +       exit 1
> +fi
> +exit 0
> --
> 2.55.0
>
>
