Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41237CD48
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708050; cv=pass; b=BUzbueAz+i58aMAtmp3MFrCxrhAXjolIK+hh/2eBlXSGB1N22Fe86YQ+StmUkC79EDspQi6k6mTvcRVUqHjQnB3Nb+Uu/l6SkqTlZeN7nDVqdgQJz2UJnnzVJSKxCLYRt5rTkxCoNG+l17C3IJn97JBHMaL0SHir3TA7RH/2jb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708050; c=relaxed/simple;
	bh=QumxzyWEfgCcU/WRCn2KyVAXTGJJq0zbTZmChHgEVgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er1MVS/RY8P06nATc0qlMitIX8QMgLi5JN4H+G+MrNLTwqhX1KprBT/iVHtvQ2sd+bjOOwGni9XnVGP7mdv7GQkIggta0xOImID5t43NvNtavFR3C8eOcgShrlhAMxFKdr1FBGhdOEEsEhQNUOD4l3rihDQCZVdCLuAlikzt6qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCDRDE+e; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCDRDE+e"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-382a3fe0d28so1335747a91.0
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 11:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783708047; cv=none;
        d=google.com; s=arc-20260327;
        b=Xfc65vDa7/0IEAH1oMu38h69z+mzsHAF6lYsYZH6MuB+1FTvlhu2ItZWePvWkimChA
         ZqfFPBZI0OLijY6p9Sfo/uKxA6Ic0UIgV7Gq2tvy3+WttbNI/42tJJ1l0j6yO+P1LuJL
         qfHRJKtVsJb7c565RHrLukMFvHDTo4zXKGItRFfHA58EVhqecN4hxbRfSS8Jh1NcEwK7
         sQPlox7DOBHuaqkdC4uR/xwQX7jk+kZacHwtDlNgaTf91Jbn5+tJRBnCuxfUwlhWmTOt
         YcYqhbfLBgm8KLLsjn8F4qll6UJ3NaNAtGGWwCNuINtIufa4/aEwCdY4AEqBRAYGdcq2
         wF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CHk2vqM3Y/KC7/NoX0wwFc49f28b0xO8q4wMxMFQ79U=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=P+A+AnnKfl/9ztRGiEHcxLLszNdAtBxSojSGfA0UIrja7s0zUz9AwBs2krp8hmoXRG
         Ep3g21yQhXQ9/rDrc5Fx90X8G3j5a9bNnuLiXmTwmVkR7ivm642saVfZCzF0MhHraez6
         vRStK7Zsxs6kDaQhA7efVFnGgIaDHC+za+rpMjFgAfLGQPX4QzLslCKl/0GQWl60hbB9
         8vmtFVDS10E+TzbxzRn+n1bUi0pSQFgoTJQy2KbABFlAKAs+7RMNQdAmTfkqh028BO9m
         SsLd7Is9kUokgZGoUShINn56mtFFAmHur+dEZxJrxnBrBnsR33lnCtbmaQ0CmSda2HpU
         QkOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783708047; x=1784312847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CHk2vqM3Y/KC7/NoX0wwFc49f28b0xO8q4wMxMFQ79U=;
        b=UCDRDE+em+R5IFjAV0eGjnndWc/8eS+3s3z+PXQdEffTZ0sXRIJEznRDF+/F/RwkB7
         jVcHxg4kLxGzex5V2l7Hw+QssvXbuqXCmcFluydxSQzelTCDtrPULJutLAPZndrtEP/+
         6S934+mOX5OJCm9SMURuLH1LsPvjnuRJoAEsEQiwvP1K55uOy8IaLEEg4floLwUou6sh
         tLFf7Hfk84+mJj73gph3vX7sOQjhDunIDNllAQTiRaMI4fjHUsfLQqREO0NUnOsA0uaJ
         4V0haWusri5VmencupEdIswD/j6txf9EbaubiU9AHqY22sBmPte/ydjsRqSAI1M7Xaml
         7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783708047; x=1784312847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHk2vqM3Y/KC7/NoX0wwFc49f28b0xO8q4wMxMFQ79U=;
        b=oS4DKZPsmvfnvcvtOQDTRW64Q+ech0WCj1qQPqpOm2z5/kobs+w6ECv0wsT+T5/ypH
         BJtujCRcavXXPwICgF2lg8miS2PGvs/e5Gme6aC1rXyIV844NYd5bJAQoJbS5CfIfL16
         8k0zvbW5czrAkzk74pOkzmdNh6/DPILIJR4hIsJiD11AP1Yo9clpWZdD0ZcCgqx5ebDh
         ZseMLSKvyrj0eqzchc5Wzw3/88H2OOnFqfnQEM7WRn3ObacT7do8y6zu+7jiRDHKLxWA
         9iPcq69p8NNKNuDv8BpYdrWYvwUZkxAtEofb+ISYRO7Uu1VBB6N5meiv1BagA5KM9pmF
         zSTQ==
X-Gm-Message-State: AOJu0Yz1gL4WVd7XnJnFnopQq0xSvw5pJW8vHxvc6kuOPjawOKq/BFjW
	BidYSO6AX+R8nTSDqtdvpQBhjD5RbMjlXSPhsZZLvCKTpJgmDEInXceJH2Qx96LPAnAekf2PlNT
	UkaIS/IGh2OsO5z5JBBcHwldaM4FCawQ=
X-Gm-Gg: AfdE7cnmZxIKWSnpD2lek9xaBCxGv1ML2mt2pJjjEbQxLgY6BzEZtWbJahs4e4cnHAy
	OXtS2IQLN8bPgmH1tKEW36yfGPwKackesfzmvS+5shYVRlKLBhDinwPl7OrgngTIEuPZ+vvE0UM
	xQnBYld5toOsbqu7aj6wWoCsIp0PpAs+w4cdR5KvCHHr4T8Alg8+RFt80uNMrwmx/QmBTaWoVIA
	xLqAUkVyCQkDJOcEUQ1wU+x1hSw+rH5rivWtwjQfryC9fbn1GbfyoKlCcRd8UkdkAqNynSu
X-Received: by 2002:a17:90b:2c85:b0:381:77cd:38d1 with SMTP id
 98e67ed59e1d1-38dc75d0377mr125493a91.10.1783708046671; Fri, 10 Jul 2026
 11:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710110323.3086408-1-akkohli@redhat.com>
In-Reply-To: <20260710110323.3086408-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Jul 2026 14:27:15 -0400
X-Gm-Features: AVVi8CfA95oy6_b5YtdOS2TFS4bn-nZs_-Bg72FzkCaGTtfMDLbB9MdSgdEUtcg
Message-ID: <CAEjxPJ60wc63kb9XeKAL5u4XFyo5Ydxpg2VooEwN20LXfBiZZQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: add bad data protection tests
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:03=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> wr=
ote:
>
> Add test_checkmodule_negative.sh and .te fixtures for  bad-data protectio=
n (missing/bad-path and corrupted .te inputs).
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>

No need to re-send just for this, but for future reference use -v2,
-v3, etc to signify which version of the patch is the latest and after
the --- before the diffstat, add a little note about
what changed from the prior version. Thanks.

> ---
>  checkpolicy/Makefile                          |   3 +-
>  checkpolicy/tests/negative/bad_module_line.te |   5 +
>  checkpolicy/tests/negative/bad_require.te     |   5 +
>  checkpolicy/tests/negative/bad_syntax.te      |   8 +
>  checkpolicy/tests/negative/dup_module.te      |   6 +
>  checkpolicy/tests/negative/good_module.te     |   8 +
>  .../tests/negative/invalid_module_version.te  |   5 +
>  checkpolicy/tests/negative/unknown_class.te   |   7 +
>  checkpolicy/tests/negative/unknown_perm.te    |   8 +
>  checkpolicy/tests/negative/unknown_type.te    |   8 +
>  .../tests/test_checkmodule_negative.sh        | 178 ++++++++++++++++++
>  11 files changed, 240 insertions(+), 1 deletion(-)
>  create mode 100644 checkpolicy/tests/negative/bad_module_line.te
>  create mode 100644 checkpolicy/tests/negative/bad_require.te
>  create mode 100644 checkpolicy/tests/negative/bad_syntax.te
>  create mode 100644 checkpolicy/tests/negative/dup_module.te
>  create mode 100644 checkpolicy/tests/negative/good_module.te
>  create mode 100644 checkpolicy/tests/negative/invalid_module_version.te
>  create mode 100644 checkpolicy/tests/negative/unknown_class.te
>  create mode 100644 checkpolicy/tests/negative/unknown_perm.te
>  create mode 100644 checkpolicy/tests/negative/unknown_type.te
>  create mode 100755 checkpolicy/tests/test_checkmodule_negative.sh
>
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index 0055f495..e59ad63a 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -51,8 +51,9 @@ lex.yy.c: policy_scan.l y.tab.c
>         $(LEX) policy_scan.l
>
>  .PHONY: test
> -test: checkpolicy
> +test: checkpolicy checkmodule
>         ./tests/test_roundtrip.sh
> +       ./tests/test_checkmodule_negative.sh
>
>  # helper target for fuzzing
>  checkobjects: $(CHECKOBJS)
> diff --git a/checkpolicy/tests/negative/bad_module_line.te b/checkpolicy/=
tests/negative/bad_module_line.te
> new file mode 100644
> index 00000000..587df2e1
> --- /dev/null
> +++ b/checkpolicy/tests/negative/bad_module_line.te
> @@ -0,0 +1,5 @@
> +module bad module name 1.0 garbage;
> +
> +require {
> +       type foo_t;
> +}
> diff --git a/checkpolicy/tests/negative/bad_require.te b/checkpolicy/test=
s/negative/bad_require.te
> new file mode 100644
> index 00000000..a45df4f4
> --- /dev/null
> +++ b/checkpolicy/tests/negative/bad_require.te
> @@ -0,0 +1,5 @@
> +module bad_require 1.0;
> +
> +require {
> +       garbage_token foo_t;
> +}
> diff --git a/checkpolicy/tests/negative/bad_syntax.te b/checkpolicy/tests=
/negative/bad_syntax.te
> new file mode 100644
> index 00000000..20605201
> --- /dev/null
> +++ b/checkpolicy/tests/negative/bad_syntax.te
> @@ -0,0 +1,8 @@
> +module bad_syntax 1.0;
> +
> +require {
> +       type foo_t;
> +       class file { read };
> +}
> +
> +allow foo_t foo_t:file {
> diff --git a/checkpolicy/tests/negative/dup_module.te b/checkpolicy/tests=
/negative/dup_module.te
> new file mode 100644
> index 00000000..beefff72
> --- /dev/null
> +++ b/checkpolicy/tests/negative/dup_module.te
> @@ -0,0 +1,6 @@
> +module dup_module 1.0;
> +module dup_module 1.0;
> +
> +require {
> +       type foo_t;
> +}
> diff --git a/checkpolicy/tests/negative/good_module.te b/checkpolicy/test=
s/negative/good_module.te
> new file mode 100644
> index 00000000..b9c9982f
> --- /dev/null
> +++ b/checkpolicy/tests/negative/good_module.te
> @@ -0,0 +1,8 @@
> +module good_module 1.0;
> +
> +require {
> +       type foo_t, bar_t;
> +       class file { read write };
> +}
> +
> +allow foo_t bar_t:file read;
> diff --git a/checkpolicy/tests/negative/invalid_module_version.te b/check=
policy/tests/negative/invalid_module_version.te
> new file mode 100644
> index 00000000..d18b7639
> --- /dev/null
> +++ b/checkpolicy/tests/negative/invalid_module_version.te
> @@ -0,0 +1,5 @@
> +module invalid_module_version;
> +
> +require {
> +       type foo_t;
> +}
> diff --git a/checkpolicy/tests/negative/unknown_class.te b/checkpolicy/te=
sts/negative/unknown_class.te
> new file mode 100644
> index 00000000..825e0413
> --- /dev/null
> +++ b/checkpolicy/tests/negative/unknown_class.te
> @@ -0,0 +1,7 @@
> +module unknown_class 1.0;
> +
> +require {
> +       type foo_t;
> +}
> +
> +allow foo_t self:not_a_class read;
> diff --git a/checkpolicy/tests/negative/unknown_perm.te b/checkpolicy/tes=
ts/negative/unknown_perm.te
> new file mode 100644
> index 00000000..f4efbb54
> --- /dev/null
> +++ b/checkpolicy/tests/negative/unknown_perm.te
> @@ -0,0 +1,8 @@
> +module unknown_perm 1.0;
> +
> +require {
> +       type foo_t, bar_t;
> +       class file { read };
> +}
> +
> +allow foo_t bar_t:file circular_ref;
> diff --git a/checkpolicy/tests/negative/unknown_type.te b/checkpolicy/tes=
ts/negative/unknown_type.te
> new file mode 100644
> index 00000000..62360e04
> --- /dev/null
> +++ b/checkpolicy/tests/negative/unknown_type.te
> @@ -0,0 +1,8 @@
> +module unknown_type 1.0;
> +
> +require {
> +       type foo_t;
> +       class file { read };
> +}
> +
> +allow foo_t undeclared_t:file read;
> diff --git a/checkpolicy/tests/test_checkmodule_negative.sh b/checkpolicy=
/tests/test_checkmodule_negative.sh
> new file mode 100755
> index 00000000..a5f49f3b
> --- /dev/null
> +++ b/checkpolicy/tests/test_checkmodule_negative.sh
> @@ -0,0 +1,178 @@
> +#!/bin/sh
> +#
> +# Negative / bad-data tests for checkmodule on module (.te) inputs.
> +# Matches the modular policy compile path: checkmodule -M -m <input> -o =
<module>.mod
> +#
> +
> +set -eu
> +
> +BASEDIR=3D$(CDPATH=3D cd -- "$(dirname "$0")" && pwd)
> +NEGDIR=3D"${BASEDIR}/negative"
> +CHECKMODULE=3D"${BASEDIR}/../checkmodule"
> +OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/checkmodule-negative.XXXXXX")
> +PASS=3D0
> +FAIL=3D0
> +
> +cleanup() {
> +       rm -rf "${OUTDIR}"
> +}
> +trap cleanup EXIT
> +
> +mod_name_from_fixture() {
> +       basename "$1" .te
> +}
> +
> +expect_pass() {
> +       desc=3D"$1"
> +       fixture=3D"$2"
> +       modname=3D$(mod_name_from_fixture "${fixture}")
> +       outmod=3D"${OUTDIR}/${modname}.mod"
> +       stderr=3D"${OUTDIR}/${modname}.err"
> +
> +       echo "=3D=3D=3D=3D POSITIVE (expect checkmodule success): ${desc}=
"
> +       rm -f "${outmod}"
> +
> +       set +e
> +       "${CHECKMODULE}" -M -m -o "${outmod}" "${NEGDIR}/${fixture}" 2>"$=
{stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -ne 0 ]; then
> +               echo "FAIL: expected success (rc=3D0), got rc=3D${rc}" >&=
2
> +               cat "${stderr}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +       if [ ! -s "${outmod}" ]; then
> +               echo "FAIL: expected non-empty ${outmod}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +
> +       echo "=3D=3D=3D=3D ${desc} success"
> +       PASS=3D$((PASS + 1))
> +       echo ""
> +}
> +
> +expect_fail() {
> +       desc=3D"$1"
> +       pattern=3D"$2"
> +       outname=3D"${3:-fail}"
> +       shift 3
> +
> +       outmod=3D"${OUTDIR}/${outname}.mod"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D NEGATIVE (expect checkmodule error): ${desc}"
> +       rm -f "${outmod}"
> +
> +       set +e
> +       "${CHECKMODULE}" -M -m "$@" -o "${outmod}" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -eq 0 ]; then
> +               echo "FAIL: expected non-zero exit, got rc=3D0" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +       if [ -f "${outmod}" ]; then
> +               echo "FAIL: did not expect output module ${outmod}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +       if ! grep -Eq "${pattern}" "${stderr}"; then
> +               echo "FAIL: stderr did not match /${pattern}/" >&2
> +               cat "${stderr}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +
> +       echo "=3D=3D=3D=3D ${desc}: rejected as expected"
> +       PASS=3D$((PASS + 1))
> +       echo ""
> +}
> +
> +expect_fail_unreadable() {
> +       desc=3D"unreadable .te file"
> +       fixture=3D"${OUTDIR}/unreadable.te"
> +       outmod=3D"${OUTDIR}/unreadable.mod"
> +       stderr=3D"${OUTDIR}/unreadable.err"
> +
> +       echo "=3D=3D=3D=3D NEGATIVE (expect checkmodule error): ${desc}"
> +       if [ "$(id -u)" -eq 0 ]; then
> +               echo "SKIP: root can read mode 000 files; unreadable chec=
k is non-root only"
> +               PASS=3D$((PASS + 1))
> +               echo ""
> +               return 0
> +       fi
> +
> +       rm -f "${outmod}"
> +
> +       set +e
> +       "${CHECKMODULE}" -M -m -o "${outmod}" "${fixture}" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -eq 0 ]; then
> +               echo "FAIL: expected non-zero exit, got rc=3D0" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +       if [ -f "${outmod}" ]; then
> +               echo "FAIL: did not expect output module ${outmod}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +       if ! grep -Eq 'unable to open|Permission denied' "${stderr}"; the=
n
> +               echo "FAIL: stderr did not mention unable to open or Perm=
ission denied" >&2
> +               cat "${stderr}" >&2
> +               FAIL=3D$((FAIL + 1))
> +               return 1
> +       fi
> +
> +       echo "=3D=3D=3D=3D ${desc}: rejected as expected"
> +       PASS=3D$((PASS + 1))
> +       echo ""
> +}
> +
> +# Ephemeral fixtures for path-based cases.
> +ln -sf /nonexistent/path "${OUTDIR}/broken_symlink.te"
> +cat > "${OUTDIR}/unreadable.te" <<'EOF'
> +module unreadable 1.0;
> +
> +require {
> +       type foo_t;
> +}
> +EOF
> +chmod 000 "${OUTDIR}/unreadable.te"
> +
> +# Control fixture: valid module compiles and produces .mod output.
> +expect_pass "good_module.te" "good_module.te"
> +
> +# Corrupted .te sections (PDF #2).
> +expect_fail "bad_syntax.te" "syntax error" "bad_syntax" "${NEGDIR}/bad_s=
yntax.te"
> +expect_fail "unknown_perm.te" "permission circular_ref is not defined" "=
unknown_perm" "${NEGDIR}/unknown_perm.te"
> +expect_fail "unknown_type.te" "unknown type undeclared_t" "unknown_type"=
 "${NEGDIR}/unknown_type.te"
> +expect_fail "unknown_class.te" "unknown class not_a_class" "unknown_clas=
s" "${NEGDIR}/unknown_class.te"
> +expect_fail "bad_module_line.te" "syntax error" "bad_module_line" "${NEG=
DIR}/bad_module_line.te"
> +expect_fail "bad_require.te" "syntax error" "bad_require" "${NEGDIR}/bad=
_require.te"
> +expect_fail "invalid_module_version.te" "syntax error" "invalid_module_v=
ersion" "${NEGDIR}/invalid_module_version.te"
> +expect_fail "dup_module.te" "syntax error" "dup_module" "${NEGDIR}/dup_m=
odule.te"
> +
> +# Missing / bad-path .te inputs (PDF #1).
> +expect_fail "missing .te path" "unable to open" "missing_path" "${OUTDIR=
}/does_not_exist.te"
> +expect_fail "directory instead of .te file" "input in flex scanner faile=
d" "directory_input" "${NEGDIR}"
> +expect_fail "broken symlink to .te" "unable to open" "broken_symlink" "$=
{OUTDIR}/broken_symlink.te"
> +expect_fail_unreadable
> +expect_fail "empty .te path argument" "unable to open" "empty_path" ""
> +
> +# CLI edge cases.
> +expect_fail "checkmodule with no input file" "unable to open policy.conf=
" "no_input"
> +expect_fail "checkmodule -o name mismatch" "Module name good_module is d=
ifferent" "name_mismatch" \
> +       -o "${OUTDIR}/wrong_name.mod" "${NEGDIR}/good_module.te"
> +
> +echo "checkmodule negative tests: ${PASS} passed, ${FAIL} failed"
> +if [ "${FAIL}" -ne 0 ]; then
> +       exit 1
> +fi
> --
> 2.55.0
>
>
