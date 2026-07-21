Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC646F4BA
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660573; cv=pass; b=dHD1h8wI6BqroSIAruVBbRJ2sR2OAR6gWjy7Fe4GYYAJ2Xw/FnABNmGUDOgjF3VUAuVdGX2RdCBc7nEJPpSwescj4y0ansF3Au6q0ZokQt+9vZSrMh2t0etGd3Q41ZOTP516w66Kp9gwhbd+MA2oXMHUh6ZbktPEjAE3BeEU6is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660573; c=relaxed/simple;
	bh=gFWPGS9ByYa8ypd0rSnVXZ1fGF+Y/LB0JIpeVIVJs2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA4HNYoQsCCL749d+/XCx0Wb5S06PAktdp2z4zdcR+7UAaQE0LvptL176Xl9Uecta5Y84VELKTHt0iMf/UIkCd417Qdv/KfjJoOn/SjgpzN/CzNr1RPpriNkyK3TRYQ0Al01n442ZaFPmdLS+v+Nlg+uPZybPKivc0OMvgQWgiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cotyzocr; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cotyzocr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so106693715ad.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784660568; cv=none;
        d=google.com; s=arc-20260327;
        b=Qx/KB/XSAr4VEK8PpLFQoslx8buCxRL9hwNpMifhKxqBota8vDuxHcgU6fdZmy49ie
         PlY/XgYXyF3FYtQZQs49bA/O4zYA39gT3jNttsns2iAenbgu9r1PJKOyWR2ZZH4+rmov
         X7NbJUezNI/TDGqO9hwmyafnp8AZpNt5MgVzHp1ODjRfw4Qm9rbJH4hKSA0ECgH9YlCH
         EHyYwCk2QE6mtD65TbmaP1ELpIRFj7datE7yVghHRMDtZTS3VMVdWXchPTx0TakQAaO0
         6qwRuQNjdO8TN+XyaZp4t7OMUBrkpB6HAAYGPuVzr3hxkomcBiOUYNBbGdIJNbNxVEMm
         as9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rzMKDYHB7RNB5vQsEx2mOXKWjSWTKN/fKIlZGntE7tw=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=s38nWTmz61482mGrIdM+Dj5uFAipCu9tWkG33VH9qB4f7wey31vSPpKN5SPS/GxM1k
         mEpir/QZy3MukwuiHLnMvrJl1YTDbftdb+Cq5hhaIEVi3DySKcweTeFxlQDV6/M/7l4l
         nx8A9GZL5Z6Mnc2x6H9wAaVPuyP21fm7HAbxMgVneDb3TWo+YzBjEA1O5By9XzcGZLQI
         swY0cgSzqp/FqRMGlGzakJdhKcddPHNFA3wPvolCuSFR7afqjY6IYeudebgzvvXfD8Gw
         +xEX67fvqmte6cHyrQnOwqoKLfDEsb2vyYaLpffO3YBrze+/I7j5eNj9oaYbk+wPupWU
         LQXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784660568; x=1785265368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rzMKDYHB7RNB5vQsEx2mOXKWjSWTKN/fKIlZGntE7tw=;
        b=CotyzocrlcY3g7o6+Z2QEgZYprCxNqGGaqPuZmjN+yheMT2strvPXh1NtcedPQQNcl
         Inzmglz8mbDQMcjPk7Je0wOAx7T65/3qCeSdELQYD23yWev4+xu5mt0AhNzRmfOwXmf0
         xo4u3Sb8505HiLrZ32CVcC9KlJe5qCdTNk9veSoEcj/rrLOlG2GQ/YDoNNsfzeXY13Kq
         u3mSZefMviN5njfiwqrcYr30sijn+g1v42CuM8l3dxowMoux9+yAuQB+IRHcN5mCaiQs
         ByShxR5jw6tauBtxeyQEWcbbO8EWzme8OjvwNPOM0krCze3IwfIm0cuZ4Tf/VXE4HYMY
         BEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660568; x=1785265368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzMKDYHB7RNB5vQsEx2mOXKWjSWTKN/fKIlZGntE7tw=;
        b=J2PC0hg7/wNWZfLvOBgIrjeDdYziSWgBe+ohJRY2ZdatYZMHsR6RQsvgMg+X6E7waS
         jJFchRTGi3zo/7az3XA/X8IDSiFoxJjT5hAWe+NwK0Jwt23P756Fj4vt1scES/sH3LBV
         hs8VrrD0f23Mrs/2h0RPzazcvGJGEBbSlerPKcYwmHoF6MV6OxMFZQWGpM8cg5wGTrJY
         eBdNhL2R10O7KstW1C+Lam9bPJvUE5+urQjRRR0ejW3+BVWpdNUcWicmKBL41NZ80rFq
         K3/E4DDuzB3Ji/lDkWS3dXIHdHtYrx0inOUiNsRZTgSl8iD8qykhNILq10q6k9PHAyVQ
         otcg==
X-Gm-Message-State: AOJu0YzzLZ3+9AUOpAJjk2KfFP4fcsC10fGC64iBu4bAEKE3JoxpxWoL
	eNiW23jXdwgpT7PWgP8DggMjoqXKnRpmbzRy8Gb+zscrFGd6cREO6yD11uXisQcCQ+yj6X68HwL
	R81W8vlWAUWdYm0TcK+R81eehghytKQAqdsj3
X-Gm-Gg: AR+sD12Vu2F69cDAuMNuXlC7WBvYZDFuniigU3ejNSPfjJ8nQdP3L+TlcNt6lrVRbFn
	N3Cz5XwQM+rMvo4zGjtseZedB6FXWn38ZhlS9vgcZwhLt0nSKG4EcA7RikFRE0W0itsVwaTzv3C
	PfJ6gkdfWSebD6Pqo/8/r3Uvn8E2favQEVMAR9ZHqkbYL1qUYoOcJP8YUXvYPlnuomrH8FBJukv
	eIs/o+ukwOdyUr1i1Xv6JXB2xwA2si3wKmfQe7TAdPJgvrU60f+8a5KPoxe2Q==
X-Received: by 2002:a17:903:41d0:b0:2ce:6d4a:5b8a with SMTP id
 d9443c01a7336-2cf34a4c2b5mr201789265ad.38.1784660568061; Tue, 21 Jul 2026
 12:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720134940.2192826-1-akkohli@redhat.com>
In-Reply-To: <20260720134940.2192826-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 15:02:36 -0400
X-Gm-Features: AUfX_mx0kC9mWOLruaFGceLWdPI_OdIaEpTO8xaClhPL3uMstj4-EVLY3PNNFXE
Message-ID: <CAEjxPJ5e9bRmf_DAxEcwDc_h1wN1KVL2-VXESuHO=sUWE1MDsQ@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for semodule_package
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 10:01=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> w=
rote:
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

This seemingly breaks the CI,
https://github.com/stephensmalley/selinux/actions/runs/29755661204/job/8839=
7213138

> ---
>  .github/workflows/run_tests.yml               |  10 +
>  semodule-utils/Makefile                       |   1 +
>  .../fixtures/file_contexts/bad_context.mod.fc |   1 +
>  .../fixtures/file_contexts/bad_fields.mod.fc  |   1 +
>  .../fixtures/file_contexts/good.mod.fc        |   1 +
>  .../tests/bad-data/fixtures/modules/good.te   |   8 +
>  semodule-utils/tests/bad-data/run.sh          | 344 ++++++++++++++++++
>  7 files changed, 366 insertions(+)
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
> index f4aa1a4c..11b95a9c 100644
> --- a/.github/workflows/run_tests.yml
> +++ b/.github/workflows/run_tests.yml
> @@ -82,6 +82,16 @@ jobs:
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
> index 00000000..0456bb4f
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/run.sh
> @@ -0,0 +1,344 @@
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
> +BASEDIR=3D$(CDPATH=3D cd -- "$(dirname "$0")" && pwd)
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
