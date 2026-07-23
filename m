Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7E448B9E
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821621; cv=pass; b=BbKp2LPq/tfxwYGJQunOrR4WwMBUCt3ntJKqENpx5bInO3Hd1S/dR8PqipDrdTxV7GBW+KF2ZVcBzC3yTwNwCkIravUxeoyDb236NBpGgbZXWdJr12Rh9z/3Dpx2SYJhF2g7bwYpsu+6eyQ81p5FAYd/ptN7xpq7vsfEv7ywkxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821621; c=relaxed/simple;
	bh=iEw3tGjViuqI+xE+7feWo8CISuQc33i1w2DshzOiZ9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sacUX4RkvhuwNifYcqyYgbVVlxMQQNE0j0C2wfy33jYQcwns33S6nA038SpJEdXQCd8HHmeIFo6qNJ9jy//ofL9hXLBcwtudoNSyMrvPqvDI8WxgBrYl7TVmvvvgR0nSpqxvUA6igrgN4Fb/c/uQqpeVkjmnvgixMAfRr1/LkPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3F81SrO; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3F81SrO"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso557580a12.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 08:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821608; cv=none;
        d=google.com; s=arc-20260327;
        b=Er6AGyVzYt2OziVBW0imF4MdopcRAY/ZI8rFTrjw7rCdBtgM+p7H0//7fKAKx3GFl9
         SiT3AfaXRXeGWDhOssYii4qPI3tYJgSoBIj4hgxOPRXqv8FpoK/VDEXmG7VqYh0E1xFo
         IvX9WjS26w3tDkdNgQ+nC0foEoFNQXdjn5pJLanNGzB35wehP+kfWXjv7c/lqhYBR5bW
         xvFb4o7Mi6J0RpfePUKqtDX7TWAiCV/cBrHuq4/aAy/K1SO0IP5B4Izlc3u0H/puBg2O
         cUZAvAwW+iaSp5EYtH6g4TElciR0fvdJ9zM2o2jHplCcZd+jsT1S7MJ6ObzpTaA+DLZL
         SxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fzc2TGfZhVnDFOuugzqt2fW7st8znOY0n0GiWdpLhGI=;
        fh=fLF9pLxcv4hKKFgN0sJhPMZd0Elw3Mux3O6VcDqhGB8=;
        b=hDGcxKgNv6j0jX8NaWIyaggjOJ2h6qko4GB1Zg6jQexSmVW2TUTtEsx7KzAptW3OZE
         7HMC+Gl73IphUQLsSHhDTE1Kktg/GRX0wmddIPlXBCFZAqYUC43EHZ6rAQ7XPkeSzIrL
         SmH3Rs7CKQRUCauC3oY+Ad8O5eayc4c7yL8gvz9+0LdhDhOBMxlFNl6V0Au1Wk2UXZwk
         tMjX5pfd1s/46TrQWSA/Qi1CtBYjLDlNXjivf3Ln9hRmPzCKwKXtnjM1FZV+69/5R3n8
         XidsKncjjGgfRn3SURq2HM4XeoFmMvx1OkUqsG3ceaumPplAAoF8O2OrMcTU1KVjLxgJ
         wyuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821608; x=1785426408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fzc2TGfZhVnDFOuugzqt2fW7st8znOY0n0GiWdpLhGI=;
        b=S3F81SrOOrgSdLKvgF4M8ghAR7JezInAsDoqNMTPE9NJmwiQ4EAdVnWzUMWXjKF1fX
         HjvBuUVMWhfM27n4EVubMsmZ9LkqbXyNx15dBTbD/NNnnurRqRCV5DjArmFaxgRaBmxq
         Yam3Q1ulq9OYZPxnsIrWMFCHK+ULmJcRi5QQe73Ar444Q9Dzvy9jTUHjUCkVAHZeEn3e
         g3liZvieHmHr/l/J8yWWRdUr2QQCvNgvFQyq5HRf1sq+LZgVd2/JxO9vTBjXiFm69v9e
         JWJNZTuQAgmZ3OcUUsPaTBNDK3mxqjTZHxMLtiSy7yRaip09sW2rNoso1YYb4OaGjx9k
         ItTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821608; x=1785426408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzc2TGfZhVnDFOuugzqt2fW7st8znOY0n0GiWdpLhGI=;
        b=jx5dEYHs11Pm0jDL/S53XkBLxB8opJEYsmI0a2atQVSfznDpJW4NZfdGo91lZSWjba
         YIrRxyENq7tjOkFWHUp1PvSD7m79s1hdHBoDkN0PxGURkB9USGL6k00qQMiCsw3PfFCT
         biU28ALqIIbNJMmghNBSE3MJNSiwdcytvG+7VdzEpYminbEDopbC5X5RJ2pwuRPxVMft
         elIEkugLgcTSLYEDPHdugUE3Ij7sw5pqnihV1hxHs8Re+bqb3UT2YKXCGErudg9CuhpB
         WMHDK6C4+58EZmD6te33lh40vVmSAe4oThSlCQr2ImfUgaWYYiYGy13fVXL0OBF4a/qZ
         voxA==
X-Gm-Message-State: AOJu0YzMvecm1WOVzxMjq7gFOFou4En5y1/a5fROLls3R1B/mhP6KbVf
	BMhjsHzjcidMZQpsX+xkXo0ke/s9X0Crf7YkJmd9VP2UXj2bYhnLsZT3FVvAWYUpMCjXisXhwG6
	3zpiStjPkWcT0NgXyzDyfR7u1Xbzqmj4=
X-Gm-Gg: AR+sD11J8MNiCZDt9xGATpKAtD/FhM9UqQUOLPLydc7oKr23s9aIaEjP2Z9RiUZ+5JQ
	1EkG08RNl4eFhidimVby4nLSRjjBcxZ31r+yiwih76yS4RSTYmoYiduw5UBuwBRE3fkJ9+fOLjj
	tusaXzPmjNFsCB2mox7LDdBTxF/FSul9XJ1qP6ZJaWB15wfkhNqmKQ/PJLcvWeOInP0oRFGshms
	3tzbl38dYF0UeYQ21qY2q9e8JZNESanSteqsrII8fvo5Lb+++Mj9CTIUDCfgQ==
X-Received: by 2002:a05:6a00:228f:b0:848:700d:c950 with SMTP id
 d2e1a72fcca58-84e2bb22dafmr4446637b3a.37.1784821607918; Thu, 23 Jul 2026
 08:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723130943.2346775-1-akkohli@redhat.com>
In-Reply-To: <20260723130943.2346775-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 11:46:36 -0400
X-Gm-Features: AUfX_mx5c4_rRNC-5OhhWqkNlqyDABxIbPdJ42yiX07mO36kC_k9bwd7VOfMocw
Message-ID: <CAEjxPJ77sv_bX0B9vhKnZKay9xnu-TOvA0LZW3f04avLdTK3uA@mail.gmail.com>
Subject: Re: [PATCH v3] semodule-utils: add bad-data tests for semodule_package
To: Akhil Kohli <akkohli@redhat.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:16=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> wr=
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
> inputs are exercised in CI. Semantic validation of bad file contexts is
> deferred to sefcontext_compile
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>

Looks good to me but would appreciate review by those more familiar
with the GitHub CI.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
>  .github/workflows/run_tests.yml               |  13 +
>  semodule-utils/Makefile                       |   1 +
>  .../fixtures/file_contexts/bad_context.mod.fc |   1 +
>  .../fixtures/file_contexts/bad_fields.mod.fc  |   1 +
>  .../fixtures/file_contexts/good.mod.fc        |   1 +
>  .../tests/bad-data/fixtures/modules/good.te   |   8 +
>  semodule-utils/tests/bad-data/run.sh          | 355 ++++++++++++++++++
>  7 files changed, 380 insertions(+)
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
> index f4aa1a4c..4322ddff 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -82,6 +82,19 @@ jobs:
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
> +          # World-readable checkout; run via relative path (inherited CW=
D). Do not
> +          # cd to $PWD =E2=80=94 bad-data-test cannot traverse /home/run=
ner/work/... .
> +          chmod -R a+rX .
> +          sudo runuser -u bad-data-test -- env PATH=3D"$PATH" LD_LIBRARY=
_PATH=3D"$LD_LIBRARY_PATH" \
> +            ./semodule-utils/tests/bad-data/run.sh
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
> index 00000000..7c9f7c7d
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/run.sh
> @@ -0,0 +1,355 @@
> +#!/bin/sh
> +#
> +# Bad-data tests for semodule_package in the modular policy packaging pi=
peline.
> +# Covers packaging path edge cases (-m/-f) and documents deferred reject=
ion of bad
> +# .mod.fc content (enforced later by sefcontext_compile).
> +# Unreadable -m/-f cases skip when run as root; CI runs this script as n=
on-root.
> +#
> +
> +set -u
> +
> +# Prefer an absolute script dir, but keep a relative dirname when cd fai=
ls.
> +# Non-root CI can inherit the repo as CWD without being able to traverse
> +# /home/runner/work/...; relative paths from that CWD still work.
> +BASEDIR=3D$(dirname -- "$0")
> +ABS_BASEDIR=3D$(CDPATH=3D cd -- "${BASEDIR}" 2>/dev/null && pwd) || ABS_=
BASEDIR=3D
> +if [ -n "${ABS_BASEDIR}" ]; then
> +       BASEDIR=3D"${ABS_BASEDIR}"
> +fi
> +FIXTURES=3D"${BASEDIR}/fixtures"
> +if [ ! -d "${FIXTURES}" ]; then
> +       echo "FAIL: cannot resolve fixtures directory (\$0=3D$0 BASEDIR=
=3D${BASEDIR})" >&2
> +       exit 1
> +fi
> +OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/semodule-package-bad-data.XXXXXX")
> +PASS=3D0
> +FAIL=3D0
> +
> +CHECKMODULE=3D${CHECKMODULE:-checkmodule}
> +# Modular TE for MCS/MLS builds (checkmodule -M -m).
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
