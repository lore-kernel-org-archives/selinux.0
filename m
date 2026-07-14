Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC301371873
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039009; cv=pass; b=UVlHwT2Nd2pBzgFnlBDSkjHekeYsTjqVpBTMuBEE755TJUT/eeLoHOLgASKOZdxgDmziE7LjucjsI0Ipsn7kZk5eDqW0jHUUDpSY3euPml0Sqwf48GfwSiJ4Gbf44t57ZMWOA8zfKNkUt3a9yuZ2j8j7MVal4jvM54JTY+iA0/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039009; c=relaxed/simple;
	bh=ln5pBuyGak6lhi9Cku0kbu9KKqNh4Zx9TmqqGCgipiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8w6iksC0GnJF5UxbG76fg4BjghQDlzK113k50mCuvgm61PmpqPWkW/iVOYZgGtLM+WRJAWv+XshTtrGP8SRIPtGI8sCbf1ySRihfrpUu42VuffIN44x2x3X5HNA+F9a+aLk5JQbL1RCKZFHecR+eDDy1TawavhuKV3yv1BMXt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duW3IYXb; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duW3IYXb"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c953950dfso32407461fa.1
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 07:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784039006; cv=none;
        d=google.com; s=arc-20260327;
        b=cgut+IPrgqYfPfkLjiYO6zL6bVep92EfDeoDNi1xcjYpHzOg3dPnYLnYAmwJQhVAAy
         g3RjfSvagge4Xe6nRGAJEIe2wyw2GD+0a+eAQat8c2B47SR/ARnUQxk+8moGjoXSx/Qs
         /R9f4Mma5hlq9sg3Q3949tN7TQX57BWp1LZlt7yizEFSUMWFz/H1h6wvjuLtXRGxhqiq
         rSvs6gbPdRehjltmgMUmG8ow+t+FMcuQ7IgY+KGgiIZMhLmNIxhX1DLhIVus43cABAQJ
         WjbK3ABhIClXnPbu9gyJd5HC5U6uAwM+RZnNNzRtuc80N/GGIOOd/gwAU3oCsifp26gY
         S1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fGwrJv5FI4aloDZxh9fy82Jk4FG9Ui0dcw6BsxEcAyw=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=AR5Y9sVyKpPmnpcG9+auilYHt+4IbN/+EIqh1FtYlxLoO3ROK0qqPOm5xOXsIGXXKo
         5xiBUuF6EOboNy9XdS5R1uEyrHQinO7XSxZgn4qTr0yHk5IVYnMuPN8kPvzZClXJfvjg
         Y4kRkTOYmrADijAvNfXUjRYOdbL2CBH8RaHsyJAbXfWGyzveXbviu8pfJ7v1hR7AIM7l
         WNyLNXmiheJ6UAa/sLZc/r6gN3KJedhDIUOHIAm8zWEQHy6iIZvu8nTw76Gr7+MfOoR3
         5Hjc+VVpingWii0d9uQ+eQCCBMqv3tpgm1hQ4IwvJWw2J2jSJmWIBeEbUCW7zgXS8gTh
         uadQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784039006; x=1784643806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGwrJv5FI4aloDZxh9fy82Jk4FG9Ui0dcw6BsxEcAyw=;
        b=duW3IYXbLpqFy5Vplbaw6/IaAsBAIptBMM4BOS1WmpX9tOsZKa77kH2PSgsW3OYk6n
         isWQS9OMLggJcsyOK/4WcugG+YIIhlvCuZ4opmUWmbAwLIoEHBzMUawH8SAHsWWyju8H
         XNoJhb9l47VkND+vHCep+9X9nXFeYQBCoFgJ8ORJPbFgZjf+87ykyGu6zzf0jmK8bhqi
         3A/oMnffwL7rvwQBRk1b8rS4V7q9QckTgklJ5KGXjY6EteXWn5vJ/1yNbuTzYvb8wmHX
         ZzkEXigbcwLq+r3kFa2eb1xLQGtks1R4wjCBdljBZb2LZHoBXhopmYAF3XPI5tOT5rKh
         iM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039006; x=1784643806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGwrJv5FI4aloDZxh9fy82Jk4FG9Ui0dcw6BsxEcAyw=;
        b=LN5qHiSO3NCyNCKe/KU3/3rHjQ7rvvk313sgKCCCEhVoFZKQv95uG9O02dkFq092d8
         9a+xJ5uE5uoDy8VESjVXWZ396TADUA5uwefQ/RBV699yZiem4TwoCRNqAo/jkQV9nlFo
         m/YqOO/DHF9Znx7Df/UwgoY4VTt8IPzn28BqkXFOwKcFyvBSolVoREMcNm8/TIZgANZB
         t1NG3d0dLAMpg8UfpmkyGXFlEIrn6yPlZf3hBe8/NNy41qw10PiK4Ypq2DmPIfO6Fc5t
         nfQbgtqJDJkMl+iZrb2xdjDwnKnpcAHyfyo7YgrjkJ2MOHolQwbUzr37sJlrp+tsbyPc
         XnmQ==
X-Gm-Message-State: AOJu0YyRuT/R8Zs96YpyQpW2wEnYSgUJMbea4A3LqiHTPnTkHnOlcPeA
	hfdTqfFrij0psQK5HEwpwDu+Flk4c/58xep/seIua9iL0uwJP5fpDBSzlRT3eQ5iUk6DpB4YIU4
	SjAedS0w6ZrTF3MrUs+R17/V1Tz0xStU=
X-Gm-Gg: AfdE7cm0i20QxLGGxbRPPPck9IC7ouhSSLmyDJWzVNg+JBGo842DkAORwKRXHOzaqo6
	3L7uP42P5vrO1JfbiHmkX1fLA0chlW9m8kaBj+UbvH4JtgP7HFuLyh930n58j/X0W9eoqBucujN
	jN7ScmWoDRN4caFfu97l32AieAIqaBnZS7daJ3BEkjppo1KbD6JN34ieby5e7aj6wrRdzGap3Ze
	SyBOXJfp4K9HAXUQ+Af0qmX5veAf+/OY+QU+Y5jtTGlgClZ4/VaIw0VMN3AGhMyT17XHkbEwewc
	xkRF
X-Received: by 2002:a2e:a98e:0:b0:39c:6e84:99bf with SMTP id
 38308e7fff4ca-39daa8227b5mr8753501fa.19.1784039005331; Tue, 14 Jul 2026
 07:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710110323.3086408-1-akkohli@redhat.com>
In-Reply-To: <20260710110323.3086408-1-akkohli@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 14 Jul 2026 10:23:14 -0400
X-Gm-Features: AUfX_mwdngOdeq5zarch0KvE_YQOJwcZIHSjoidsbEA31ouz3x54_e2ThueSFmw
Message-ID: <CAP+JOzTrNuaS7HqayhaRfsPVFfH7CLNjR3W8HG09s2YtRVqM6A@mail.gmail.com>
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

Acked-by: James Carter <jwcart2@gmail.com>

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
