Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5648BD39
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333934; cv=pass; b=BHeA7q3FXcWUdP12Uoq+b5zDzkCIIEArUaZ+YB5+k3TnJ/T/PXxXBdvCiRRudYigohvjkR5e62sxE6XhW4pWWf7kWGcBvYGo+BBJouIcUwxKaE8Hp+MAl/ufs4o2JjKZMgLkaL0O7ubQAZIaUq1s9nJcb2bbP0/MynNvkonNgGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333934; c=relaxed/simple;
	bh=aJ6slnH1xcyKYoW2U3VvELUbheoffGYUVgfHpSI22T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdpaluq6HmhHg8DpFTQQGBMPi6o86Q7OgD0uj9/zagnW8U4eUXnpcTsUlBYilwLvCWCeh3Vbq12ZiDrRBvjpfdJWu/BUNNpeT4A9PczfW3KPU4fqYTeFWImUkYa22pVPgXVKZCckPBz+U3fT+V+S6HVBXr1A//2ARhv5cpHJ010=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW19jLX7; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW19jLX7"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ebd88be784so783764a34.2
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 07:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333931; cv=none;
        d=google.com; s=arc-20260327;
        b=mM6WaFPatxGk2rcN0sBPvQM/7935NLoQCnajqovNVr4duf/AwBLtPX5ih70RkA7WBu
         byFVfxVmyDZB8YFIcRbUhXeqpJ0rMoKWOIAfTYmKg8N5i2cj2z4g0ZE9J7oeE5gqjmbw
         zfsZIk2a6tDILrlllrTtCKabs1i5ZD70IpzedftRuODE3NOpidSb8KQmQQoAWSTytI1n
         3V9nuLMhuEj2Xu1LmaE2jG1Ue4+rIGZHIqd9sH/2/pJhvWu73O18BFY9IZg3mU2go/Ob
         ALODBwkvo/mE1me2Ko+kGFM8zh0MHoqWve+cXxv9uT0ReLYFQAnKNuaQ8ihdke8g9hNj
         0JIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1hLE1pKSb0lEt2FOh7Yse0P9P4TYhtPiOMTxxpNOK5s=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=pCCp1Pr3JM44269sw52jW8wu4w0K3e9EnRdjcZ3cQ52y0l0W6dDhspXbr3qU6JKar4
         Nj+5CYIn/K/OCWyAI9yd1SEHdJChto5zEt6VIPLjpwzjQyQotP1+pnBByReVl8uXCgot
         XZ+z4rqOoOtMT6ZAzfyOvD+lA0YrYMcONeyfzDY8mg9ZHTghZf7j+J0+RBEEy9hHoR9u
         +o9qimZ5f9StTdbjeU4BwxZ0wB8SOsTPB++18pDGrbxyEFQ7AViN25CWmvE6Vm7xBNKH
         Dcrihn9EBMlI4OdDuezrk/T6vdIxEdITQj2gcWbLdCSh5h7MWeaeLXpSONEcusWgrFPh
         YPVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785333931; x=1785938731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1hLE1pKSb0lEt2FOh7Yse0P9P4TYhtPiOMTxxpNOK5s=;
        b=RW19jLX7f8FLIU44x5EXB7oPAMruD4P6B/ew7ABVtZ4vsH5BsLa8AzpRAFbc4Vt3pb
         qmXASSGAdNf6SXbn2IA0Vo9g55Hl8m1Vcz5Ys2X/lu9SSiTRZSZBcoO/iNIPeAt6oSuX
         ZFJ89jCGM252nBbDTShrwd5t9jqhEGYyoUtDrBkJJ1UfUE/zhGvNaYOl6CJU5tM2hLRn
         7lEmnCMPsnyMZwjeWhCoaQsa4sPX46+iFxWRlbUzrCfe2awekCyKyujJ8g3KGQQmF5qp
         syJVhkdA3WcDc23G1Fdsmses/yXYTWtwscAMUMWEx3JuCnrc817iSre/pJOcnuFM9x9W
         GHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333931; x=1785938731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1hLE1pKSb0lEt2FOh7Yse0P9P4TYhtPiOMTxxpNOK5s=;
        b=lw2ZJoL3TxLtJ8UGYAqmLWlj5Tgi4O3mhbOrVANENSDpnT07PB67jI7c2MFC5Rdrmu
         Prs8FjEKyn26e4PxwC4VJN6lue9MxoT5BqgnQow7OAg2Lz3NPnQ1a9aaAe5U+FfxhJsi
         kAW2OIi3HlJQPXF8wl6Noxk7N6fGV6p268S+/O5zDoaIhz6kCVqjUo16GTTZN60jd7Oh
         ElCCNVV6tCW+j/p1osNUyo0tkroqA9NWSRydTlenHzwyYjz5x7n7dgIOS5K4CGGz0SKZ
         jtUFcC3TpzcOo94SkkXzzGsf4uC/63Xnmgirb9OhIVWyYAvcWXCV0F3cPkttohyge1+n
         u27g==
X-Gm-Message-State: AOJu0Yy2VUoYXWQJZ6MUDHtSKpSPlhu4y2+V+LdWQyaYrcGjzcTOPy1O
	zG+4gDGXT4kB9/TyJEeiqpu7FspdYn+3ihIS88aG9bEk2w+YF6oHeGXVXMdZi0FZ7EbDWTjAR9+
	c1lsOZcF6537HTTp/2oYCW0lp6HrxXOY=
X-Gm-Gg: AR+sD10kOqV9iuf0i/5lMfwc2IKHGwAh3VBmNgFOFY+g/OU2NTM32szjW0Sxjrm6y99
	ZbbpIVCAL2Q3ILBUt1BvjdoJA28/xmCDZApAbF2fm96uutzNS/Y5vu0NS8L/rD4HEgrmFdMZluG
	Cto5bTyLHPFlInoBl1fzOgE013Rkg68AuWmWKNpt1gZH2OsMJVW0loYVmPkcNKCxPoQxaV4DT7E
	6/nOlraCCh5b3ISmlrvSLCP1jAkucjG40EEEn6adiJdlQqORxUZhzi9JKVhZTB9IfdCSG5HhC71
	OF8aXk1SegB2aFTo6+meUouiG5yYPQM4PEOcdneo8/38
X-Received: by 2002:a05:6820:4d04:b0:6aa:f235:cce5 with SMTP id
 006d021491bc7-6ac96a77e43mr3362517eaf.26.1785333931545; Wed, 29 Jul 2026
 07:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728131007.2588686-1-akkohli@redhat.com>
In-Reply-To: <20260728131007.2588686-1-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 10:05:19 -0400
X-Gm-Features: AUfX_mxTZwl8rlcRgR2NsHKN5U8n6IyamEYMkoAcE2D9pghvoluzjwSLLMOxMyQ
Message-ID: <CAEjxPJ4aaSPxRHd+i76Kq9cMosJ37d0DdYebjUzBcxCG2-zYew@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for sefcontext_compile
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:21=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> wr=
ote:
>
> Extend the bad-data harness to validate file contexts after packaging:
> wrong field count and NUL bytes are rejected by sefcontext_compile, inval=
id
> contexts are rejected with -p, and unpackage'd .pp file contexts are
> checked the same way.
>
> Adds 7 sefcontext_compile test steps on top of the semodule_package
> harness. Adds bad_mls.mod.fc fixture. Preserve errexit restoration
> (set -e after rc=3D$?) in shared helpers.
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .../fixtures/file_contexts/bad_mls.mod.fc     |   1 +
>  semodule-utils/tests/bad-data/run.sh          | 227 +++++++++++++++++-
>  2 files changed, 223 insertions(+), 5 deletions(-)
>  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_contexts/=
bad_mls.mod.fc
>
> diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls=
.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls.mod.=
fc
> new file mode 100644
> index 00000000..1913faaa
> --- /dev/null
> +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_mls.mod.fc
> @@ -0,0 +1 @@
> +/usr/bin/bad_mls       --      system_u:object_r:test_good_exec_t:s0:c99=
9
> diff --git a/semodule-utils/tests/bad-data/run.sh b/semodule-utils/tests/=
bad-data/run.sh
> index 7c9f7c7d..1c7d8f51 100755
> --- a/semodule-utils/tests/bad-data/run.sh
> +++ b/semodule-utils/tests/bad-data/run.sh
> @@ -1,9 +1,10 @@
>  #!/bin/sh
>  #
> -# Bad-data tests for semodule_package in the modular policy packaging pi=
peline.
> -# Covers packaging path edge cases (-m/-f) and documents deferred reject=
ion of bad
> -# .mod.fc content (enforced later by sefcontext_compile).
> -# Unreadable -m/-f cases skip when run as root; CI runs this script as n=
on-root.
> +# Bad-data tests for semodule_package and sefcontext_compile in the modu=
lar
> +# policy packaging pipeline. Covers packaging path edge cases (-m/-f), d=
ocuments
> +# deferred rejection of bad .mod.fc content at packaging time, and valid=
ates
> +# labeling through sefcontext_compile. Unreadable -m/-f cases skip when =
run as
> +# root; CI runs this script as non-root.
>  #
>
>  set -u
> @@ -29,6 +30,8 @@ CHECKMODULE=3D${CHECKMODULE:-checkmodule}
>  # Modular TE for MCS/MLS builds (checkmodule -M -m).
>  CHECKMODULE_MOD_FLAGS=3D${CHECKMODULE_MOD_FLAGS:--M -m}
>  SEMODULE_PACKAGE=3D${SEMODULE_PACKAGE:-semodule_package}
> +SEMODULE_UNPACKAGE=3D${SEMODULE_UNPACKAGE:-semodule_unpackage}
> +SEFCONTEXT_COMPILE=3D${SEFCONTEXT_COMPILE:-sefcontext_compile}
>
>  GOOD_TE=3D"${FIXTURES}/modules/good.te"
>  GOOD_MOD=3D"${OUTDIR}/test_good.mod"
> @@ -250,6 +253,161 @@ expect_package_fail_unreadable_fc() {
>         pass "${desc} (rejected as expected, rc=3D${rc})"
>  }
>
> +find_policy_file() {
> +       if [ -n "${POLICY_FILE:-}" ] && [ -f "${POLICY_FILE}" ]; then
> +               echo "${POLICY_FILE}"
> +               return 0
> +       fi
> +
> +       # Prefer the active policy store (SELINUXTYPE); fall back to targ=
eted, then any
> +       # installed policy.* (POLICY_FILE overrides all of this).
> +       selinuxtype=3Dtargeted
> +       if [ -r /etc/selinux/config ]; then
> +               selinuxtype=3D$(grep -E '^[[:space:]]*SELINUXTYPE=3D' /et=
c/selinux/config 2>/dev/null \
> +                       | tail -1 | cut -d=3D -f2- | tr -d ' "')
> +               [ -n "${selinuxtype}" ] || selinuxtype=3Dtargeted
> +       fi
> +
> +       # shellcheck disable=3DSC2086
> +       set -- /etc/selinux/"${selinuxtype}"/policy/policy.*
> +       if [ -f "$1" ]; then
> +               echo "$1"
> +               return 0
> +       fi
> +
> +       for policy in /etc/selinux/*/policy/policy.*; do
> +               [ -f "${policy}" ] || continue
> +               echo "${policy}"
> +               return 0
> +       done
> +
> +       return 1
> +}
> +
> +expect_sefcontext_pass() {
> +       desc=3D"$1"
> +       outname=3D"$2"
> +       fc=3D"$3"
> +       policy=3D"${4:-}"
> +
> +       outbin=3D"${OUTDIR}/${outname}.bin"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D POSITIVE (expect sefcontext_compile success): =
${desc}"
> +       rm -f "${outbin}"
> +
> +       set +e
> +       if [ -n "${policy}" ]; then
> +               "${SEFCONTEXT_COMPILE}" -p "${policy}" -o "${outbin}" "${=
fc}" \
> +                       2>"${stderr}"
> +       else
> +               "${SEFCONTEXT_COMPILE}" -o "${outbin}" "${fc}" 2>"${stder=
r}"
> +       fi
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -ne 0 ]; then
> +               cat "${stderr}" >&2
> +               die "${desc}: expected exit 0, got rc=3D${rc}"
> +               return 0
> +       fi
> +       if [ ! -s "${outbin}" ]; then
> +               die "${desc}: expected non-empty ${outbin}"
> +               return 0
> +       fi
> +
> +       pass "${desc} (sefcontext_compile succeeded)"
> +}
> +
> +expect_sefcontext_fail() {
> +       desc=3D"$1"
> +       pattern=3D"$2"
> +       outname=3D"$3"
> +       fc=3D"$4"
> +       policy=3D"${5:-}"
> +
> +       outbin=3D"${OUTDIR}/${outname}.bin"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D NEGATIVE (expect sefcontext_compile failure): =
${desc}"
> +       rm -f "${outbin}"
> +
> +       set +e
> +       if [ -n "${policy}" ]; then
> +               "${SEFCONTEXT_COMPILE}" -p "${policy}" -o "${outbin}" "${=
fc}" \
> +                       2>"${stderr}"
> +       else
> +               "${SEFCONTEXT_COMPILE}" -o "${outbin}" "${fc}" 2>"${stder=
r}"
> +       fi
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -eq 0 ]; then
> +               die "${desc}: expected non-zero exit, got rc=3D0"
> +               return 0
> +       fi
> +       if [ -f "${outbin}" ] && [ -s "${outbin}" ]; then
> +               die "${desc}: did not expect successful ${outbin}"
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
> +expect_sefcontext_fail_or_skip_no_policy() {
> +       desc=3D"$1"
> +       pattern=3D"$2"
> +       outname=3D"$3"
> +       fc=3D"$4"
> +
> +       policy=3D$(find_policy_file) || policy=3D
> +       if [ -z "${policy}" ]; then
> +               echo "=3D=3D=3D=3D SKIP (no binary policy for -p validati=
on): ${desc}"
> +               echo "Set POLICY_FILE=3D to enable this check."
> +               PASS=3D$((PASS + 1))
> +               echo ""
> +               return 0
> +       fi
> +
> +       expect_sefcontext_fail "${desc}" "${pattern}" "${outname}" "${fc}=
" \
> +               "${policy}"
> +}
> +
> +expect_sefcontext_pass_deferred() {
> +       desc=3D"$1"
> +       outname=3D"$2"
> +       fc=3D"$3"
> +
> +       outbin=3D"${OUTDIR}/${outname}.bin"
> +       stderr=3D"${OUTDIR}/${outname}.err"
> +
> +       echo "=3D=3D=3D=3D DOCUMENT (sefcontext_compile accepts input; co=
mplements packaging deferral): ${desc}"
> +       rm -f "${outbin}"
> +
> +       set +e
> +       "${SEFCONTEXT_COMPILE}" -o "${outbin}" "${fc}" 2>"${stderr}"
> +       rc=3D$?
> +       set -e
> +
> +       if [ "${rc}" -ne 0 ]; then
> +               cat "${stderr}" >&2
> +               die "${desc}: expected exit 0 at compile stage, got rc=3D=
${rc}"
> +               return 0
> +       fi
> +       if [ ! -s "${outbin}" ]; then
> +               die "${desc}: expected non-empty ${outbin} at compile sta=
ge"
> +               return 0
> +       fi
> +
> +       pass "${desc} (sefcontext_compile exit 0; complements packaging d=
eferral)"
> +}
> +
>  build_good_mod
>
>  # Ephemeral path fixtures for packaging path tests.
> @@ -258,7 +416,7 @@ ln -sf /nonexistent/test_good.mod.fc "${OUTDIR}/broke=
n_symlink.mod.fc"
>  printf '' > "${OUTDIR}/empty.mod.fc"
>
>  # NUL byte inside path column (packaging accepts; sefcontext_compile rej=
ects).
> -printf '/bin/foo\x00bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' \
> +printf '/bin/foo\000bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' \
>         > "${OUTDIR}/nul_bytes.mod.fc"
>
>  GOOD_FC=3D"${FIXTURES}/file_contexts/good.mod.fc"
> @@ -347,6 +505,65 @@ expect_package_pass_deferred \
>         empty_fc \
>         -m "${GOOD_MOD}" -f "${OUTDIR}/empty.mod.fc"
>
> +# --- sefcontext_compile / unpackage validation ---
> +expect_sefcontext_pass \
> +       "control good .mod.fc through sefcontext_compile" \
> +       good_fc \
> +       "${GOOD_FC}"
> +
> +expect_sefcontext_fail \
> +       "wrong field count in .mod.fc (after packaging)" \
> +       "missing fields|process_file failed" \
> +       sefcontext_bad_fields \
> +       "${FIXTURES}/file_contexts/bad_fields.mod.fc"
> +
> +expect_sefcontext_fail \
> +       "NUL byte in .mod.fc path field (after packaging)" \
> +       "missing fields|process_file failed" \
> +       sefcontext_nul_bytes \
> +       "${OUTDIR}/nul_bytes.mod.fc"
> +
> +expect_sefcontext_fail_or_skip_no_policy \
> +       "invalid SELinux context requires policy validation (-p)" \
> +       "invalid context|malformed context|process_file failed" \
> +       sefcontext_bad_context \
> +       "${FIXTURES}/file_contexts/bad_context.mod.fc"
> +
> +expect_sefcontext_pass_deferred \
> +       "empty .mod.fc file through sefcontext_compile" \
> +       sefcontext_empty_fc \
> +       "${OUTDIR}/empty.mod.fc"
> +
> +expect_sefcontext_fail_or_skip_no_policy \
> +       "invalid MLS context requires policy validation (-p)" \
> +       "invalid context|malformed context|process_file failed" \
> +       sefcontext_bad_mls \
> +       "${FIXTURES}/file_contexts/bad_mls.mod.fc"
> +
> +BAD_PP=3D"${OUTDIR}/bad_context.pp"
> +EXTRACTED_MOD=3D"${OUTDIR}/extracted.mod"
> +EXTRACTED_FC=3D"${OUTDIR}/extracted.fc"
> +
> +echo "=3D=3D=3D=3D Setup: extract file contexts from packaged module wit=
h invalid context"
> +rm -f "${EXTRACTED_MOD}" "${EXTRACTED_FC}"
> +set +e
> +"${SEMODULE_UNPACKAGE}" "${BAD_PP}" "${EXTRACTED_MOD}" "${EXTRACTED_FC}"=
 \
> +       2>"${OUTDIR}/unpackage.err"
> +rc=3D$?
> +set -e
> +if [ "${rc}" -ne 0 ] || [ ! -s "${EXTRACTED_FC}" ]; then
> +       die "unpackage setup: could not extract .fc from ${BAD_PP}"
> +       cat "${OUTDIR}/unpackage.err" >&2
> +else
> +       echo "=3D=3D=3D=3D unpackage setup succeeded"
> +       echo ""
> +       expect_sefcontext_fail_or_skip_no_policy \
> +               "invalid context from unpackage'd .pp file contexts" \
> +               "invalid context|malformed context|process_file failed" \
> +               unpackaged_bad_context \
> +               "${EXTRACTED_FC}"
> +fi
> +
>  echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
>  echo "Results: ${PASS} passed, ${FAIL} failed"
>  if [ "${FAIL}" -ne 0 ]; then
> --
> 2.55.0
>
>
