Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF443D50D
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903755; cv=pass; b=E64orKhdtJexp7tS7q6kUNA+5e+0fT0kQiPtONAoM7Oqbc+80Efs1O8F9T87SqHx2cRj1/e6kD0EDuFR3VvfNR6Cum4OSXSeftWf+8cGfx/Ym+J0x8Alba0k4gHaQlsOUq6xg60ZCDHg8s6mTs+SadxhXQVpkVMUL248AvkqC8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903755; c=relaxed/simple;
	bh=ar3/TE+R00Smqn5VNJCPwrgBJdasDIHshyQG7/ud54k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbBANTIbvFJS4KExc4RDnRVWFZM6R1e+6xIkFe0MdCYAzD+4t0h7/DopG9zC+1nQZLZDV8p/5Ct9n+eBuTtCGEa6EYFUK9BaPXavtIb/wCxR0JYzYH99x5mI4rxx4ctpH9z4mAQBWuTQ1urusce15svTv+g2sqpy8F/E/HXMpSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWMJonOZ; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWMJonOZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2a76536bso5674381cf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903752; cv=none;
        d=google.com; s=arc-20260327;
        b=c35Tfk0CtQmOpQMWmjAt9C0aJUIxMSoYwX0B9io7BFiMSJ+D6PC2kj4rtmJ1WxBWGf
         7pS/yUBgYyqccAKz1RrlQv73cuFbDAuXiRDXpgxPgvYKdC0a9e3UuDxpggSDCIo4ESVF
         BxFzlsHt01vPfVR03J3SYtqqZhTuaCFP2F+RnTrrRv061tsGxQXf0x2IlzY5uGkK1Sbv
         4J7GLIr58gPvI6QJd3dQyaWwJ1B1gdonp8El6qGMRn3ggkJRjgc2c1/4Nmbmf7rezjHI
         23uSZcyZRsdbe9zjD7z+qRYiKLw1LI5a7OuaU+gOx8N+zJuJ5HRdnXAi1X7Gq4OKb64H
         QIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+5yDfwW2CZE5atr4f/uLXe6q9XDDxlahR+RO1kWFI6k=;
        fh=fLF9pLxcv4hKKFgN0sJhPMZd0Elw3Mux3O6VcDqhGB8=;
        b=QoChJerGdb9SR1Fb9CjwB3vFj/O7w7i4i1q696Cpnqui4UfzZcdUXDiaoMbUT+LFVG
         sf0p9W6C3Oye7/sSUE+G/hT2pGukOxhz2OPf/G0hjNbisH75WK9qFoBhnlrJmM/R5Fbl
         0bTFMM9Xk/8pkBb6g1Poy+oWHQ+0ML7GCa+EabFWqgBS2/wegoTJdN2oroktSvbua4Fo
         vpB3vHLrw00t/ONTOwq3AOHt9VVyXYz+Ay0S8x38E/b3G8NTA8zszIM99Au1UIW/yPTJ
         4/buKKiEJw3nf+Ytw1SQzI3FKIBMccOwATVYIq+YvDSyyslOa2c8WUuflFAuGqAC27YQ
         ekmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903752; x=1785508552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5yDfwW2CZE5atr4f/uLXe6q9XDDxlahR+RO1kWFI6k=;
        b=PWMJonOZNxBPKkdyPq1k5kVWn7/rBLdzMz4uPAl08t0YKj4A/d+E0CswjyzCeNoBKx
         OUHOCLtpkJyUMyPTHHfJPCLWqvhIb4N32qEOkw4ZPEK9R4nayLQ5iGdhOg+plfREgjjr
         NgmuTwlysgs5FuYsoXHBkOj4Lvl5e0thn5i2i9Wscidvg+CAQ0GKeqfFOL4JOf+hZrr9
         P2q5FVhYsIuR9GhyZMGOpKj8SXkW+MsoMw5Aqv4113YISNDpeif13zR5TVpW/2AlRDc7
         dsN5YGkn0NhoZYWqay6Gp8k9YrLxghCBc/PvS6vgZmyS1IUnMnL47QdTxMZ52zK8xJRu
         XwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903752; x=1785508552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5yDfwW2CZE5atr4f/uLXe6q9XDDxlahR+RO1kWFI6k=;
        b=W0UcvMNyIt7QgRSv9FSXdu4YD40pgFtsJMWGA90EDXu2PoniWawk9w8ixFWVRWx69e
         DdB1Eg+wB1WoYKhtFh7l0pK4uh9ouEmX9qho16OI5Yjf+2nuR4tU17XZqZm+zpf6S9qH
         ouzOEoa29uod093sG1L2unOme7AJEgX8umy2gZIH94THc1BG7Mq2D3BU6739HfZtVLKc
         tybXhNR9BOP89d/PbTrXkoIn2SjVHf+Ac+ubZTb7WcaQilUY/hjBbqpGPOrvWFxQo3B8
         I1nsYQ8kG+2Sht/qLCFptfayG7fOaaEq04fq3jZYR+eGzyM3H4boLPFvKxQv1kyMAL83
         j3yQ==
X-Gm-Message-State: AOJu0Yw+xt8mt3GHqjlZ1sQTKXM0Qru039cJ7O+lyPpwdrPIRzt1ihz+
	/l4OaJbCeix0HAWheicn5WNM3cWERTdPKV42izVY83sTPIiOXJEVhVH7mpqAzEZ5iZ7R3mzFzfw
	0f69lAe8F3LAgKsl3ApPoHn//+IYbEI4=
X-Gm-Gg: AR+sD13P5oP0w75HAms1o2HudP9mf9/e8KuaIPfv8k9MK17zd77f6nM3sBMgyhlNJWk
	AML5vAG7oLk1mEqp4Bt8DGAiEalQDTJsf4WTJV5H8vLj7gU+R103UFFrt3NYqUkFCbkkzKlk8m8
	a2hXQce0DJu//VKzlzDRvcMTpKbOqHJA273XjcoHrkX6UDAB7BsY93W4mX8CxCAgfTnvalbXxKI
	2izR6ll8fcG1GIKxOa39rYL8H67jM3RLW9gljwOsVscfLN5C2NRIRxf0Osp8Q==
X-Received: by 2002:a05:622a:1792:b0:51b:fde4:cd57 with SMTP id
 d75a77b69052e-5283de0aefemr73270351cf.31.1784903752054; Fri, 24 Jul 2026
 07:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723130943.2346775-1-akkohli@redhat.com> <CAEjxPJ77sv_bX0B9vhKnZKay9xnu-TOvA0LZW3f04avLdTK3uA@mail.gmail.com>
In-Reply-To: <CAEjxPJ77sv_bX0B9vhKnZKay9xnu-TOvA0LZW3f04avLdTK3uA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:35:40 -0400
X-Gm-Features: AUfX_mycNeLkg-n9KaaKsl8r24YmmHZVwTwvPgS6ieCf4D-wPTZ3kM_xqqlX6J0
Message-ID: <CAEjxPJ4KJBc+tbUFEQmXhDZ6oKE2EfY+0KieeJV95S6C+SoaEA@mail.gmail.com>
Subject: Re: [PATCH v3] semodule-utils: add bad-data tests for semodule_package
To: Akhil Kohli <akkohli@redhat.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 9:16=E2=80=AFAM Akhil Kohli <akkohli@redhat.com> =
wrote:
> >
> > Add tests/bad-data/run.sh and fixtures for semodule_package bad-data
> > protection: input path validation for -m and -f (missing paths, directo=
ries,
> > broken symlinks, unreadable files, empty arguments) and malformed .mod.=
fc
> > content at packaging time. Wire the driver into semodule-utils make tes=
t.
> > Semantic validation of bad file contexts is deferred to sefcontext_comp=
ile.
> >
> > Run the harness as a non-root user in GitHub Actions so unreadable -m/-=
f
> > inputs are exercised in CI. Semantic validation of bad file contexts is
> > deferred to sefcontext_compile
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
>
> Looks good to me but would appreciate review by those more familiar
> with the GitHub CI.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
>
> > ---
> >  .github/workflows/run_tests.yml               |  13 +
> >  semodule-utils/Makefile                       |   1 +
> >  .../fixtures/file_contexts/bad_context.mod.fc |   1 +
> >  .../fixtures/file_contexts/bad_fields.mod.fc  |   1 +
> >  .../fixtures/file_contexts/good.mod.fc        |   1 +
> >  .../tests/bad-data/fixtures/modules/good.te   |   8 +
> >  semodule-utils/tests/bad-data/run.sh          | 355 ++++++++++++++++++
> >  7 files changed, 380 insertions(+)
> >  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_context=
s/bad_context.mod.fc
> >  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_context=
s/bad_fields.mod.fc
> >  create mode 100644 semodule-utils/tests/bad-data/fixtures/file_context=
s/good.mod.fc
> >  create mode 100644 semodule-utils/tests/bad-data/fixtures/modules/good=
.te
> >  create mode 100755 semodule-utils/tests/bad-data/run.sh
> >
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_te=
sts.yml
> > index f4aa1a4c..4322ddff 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -82,6 +82,19 @@ jobs:
> >          eval make test $EXPLICIT_MAKE_VARS
> >          echo "::endgroup::"
> >
> > +        # semodule_package bad-data: unreadable -m/-f inputs need non-=
root (root reads mode 000).
> > +        if [ "${{ matrix.python-ruby-version.other }}" !=3D "sanitizer=
s" ] ; then
> > +          echo "::group::semodule-utils bad-data (non-root)"
> > +          sudo useradd -m -s /usr/sbin/nologin bad-data-test 2>/dev/nu=
ll || true
> > +          # World-readable checkout; run via relative path (inherited =
CWD). Do not
> > +          # cd to $PWD =E2=80=94 bad-data-test cannot traverse /home/r=
unner/work/... .
> > +          chmod -R a+rX .
> > +          sudo runuser -u bad-data-test -- env PATH=3D"$PATH" LD_LIBRA=
RY_PATH=3D"$LD_LIBRARY_PATH" \
> > +            ./semodule-utils/tests/bad-data/run.sh
> > +          sudo userdel -r bad-data-test 2>/dev/null || true
> > +          echo "::endgroup::"
> > +        fi
> > +
> >          if [ "${{ matrix.python-ruby-version.other }}" !=3D "sanitizer=
s" ] ; then
> >              # Test Python and Ruby wrappers
> >              echo "::group::Test Python and Ruby wrappers"
> > diff --git a/semodule-utils/Makefile b/semodule-utils/Makefile
> > index 81c97af0..4a902146 100644
> > --- a/semodule-utils/Makefile
> > +++ b/semodule-utils/Makefile
> > @@ -6,3 +6,4 @@ all install relabel clean:
> >         done
> >
> >  test:
> > +       ./tests/bad-data/run.sh
> > diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_c=
ontext.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_co=
ntext.mod.fc
> > new file mode 100644
> > index 00000000..06aec43e
> > --- /dev/null
> > +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_context.=
mod.fc
> > @@ -0,0 +1 @@
> > +/usr/bin/bad   not_a_valid_selinux_context
> > diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_f=
ields.mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fie=
lds.mod.fc
> > new file mode 100644
> > index 00000000..13821d61
> > --- /dev/null
> > +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/bad_fields.m=
od.fc
> > @@ -0,0 +1 @@
> > +only_one_field_on_this_line
> > diff --git a/semodule-utils/tests/bad-data/fixtures/file_contexts/good.=
mod.fc b/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
> > new file mode 100644
> > index 00000000..12b26cae
> > --- /dev/null
> > +++ b/semodule-utils/tests/bad-data/fixtures/file_contexts/good.mod.fc
> > @@ -0,0 +1 @@
> > +/usr/bin/test_good     --      system_u:object_r:test_good_exec_t:s0
> > diff --git a/semodule-utils/tests/bad-data/fixtures/modules/good.te b/s=
emodule-utils/tests/bad-data/fixtures/modules/good.te
> > new file mode 100644
> > index 00000000..a079aed6
> > --- /dev/null
> > +++ b/semodule-utils/tests/bad-data/fixtures/modules/good.te
> > @@ -0,0 +1,8 @@
> > +module test_good 1.0;
> > +
> > +require {
> > +       type test_good_t;
> > +       class file { read };
> > +}
> > +
> > +allow test_good_t self:file read;
> > diff --git a/semodule-utils/tests/bad-data/run.sh b/semodule-utils/test=
s/bad-data/run.sh
> > new file mode 100755
> > index 00000000..7c9f7c7d
> > --- /dev/null
> > +++ b/semodule-utils/tests/bad-data/run.sh
> > @@ -0,0 +1,355 @@
> > +#!/bin/sh
> > +#
> > +# Bad-data tests for semodule_package in the modular policy packaging =
pipeline.
> > +# Covers packaging path edge cases (-m/-f) and documents deferred reje=
ction of bad
> > +# .mod.fc content (enforced later by sefcontext_compile).
> > +# Unreadable -m/-f cases skip when run as root; CI runs this script as=
 non-root.
> > +#
> > +
> > +set -u
> > +
> > +# Prefer an absolute script dir, but keep a relative dirname when cd f=
ails.
> > +# Non-root CI can inherit the repo as CWD without being able to traver=
se
> > +# /home/runner/work/...; relative paths from that CWD still work.
> > +BASEDIR=3D$(dirname -- "$0")
> > +ABS_BASEDIR=3D$(CDPATH=3D cd -- "${BASEDIR}" 2>/dev/null && pwd) || AB=
S_BASEDIR=3D
> > +if [ -n "${ABS_BASEDIR}" ]; then
> > +       BASEDIR=3D"${ABS_BASEDIR}"
> > +fi
> > +FIXTURES=3D"${BASEDIR}/fixtures"
> > +if [ ! -d "${FIXTURES}" ]; then
> > +       echo "FAIL: cannot resolve fixtures directory (\$0=3D$0 BASEDIR=
=3D${BASEDIR})" >&2
> > +       exit 1
> > +fi
> > +OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/semodule-package-bad-data.XXXXXX=
")
> > +PASS=3D0
> > +FAIL=3D0
> > +
> > +CHECKMODULE=3D${CHECKMODULE:-checkmodule}
> > +# Modular TE for MCS/MLS builds (checkmodule -M -m).
> > +CHECKMODULE_MOD_FLAGS=3D${CHECKMODULE_MOD_FLAGS:--M -m}
> > +SEMODULE_PACKAGE=3D${SEMODULE_PACKAGE:-semodule_package}
> > +
> > +GOOD_TE=3D"${FIXTURES}/modules/good.te"
> > +GOOD_MOD=3D"${OUTDIR}/test_good.mod"
> > +
> > +cleanup() {
> > +       rm -rf "${OUTDIR}"
> > +}
> > +trap cleanup EXIT
> > +
> > +die() {
> > +       echo "FAIL: $*" >&2
> > +       FAIL=3D$((FAIL + 1))
> > +}
> > +
> > +pass() {
> > +       echo "=3D=3D=3D=3D $*"
> > +       PASS=3D$((PASS + 1))
> > +       echo ""
> > +}
> > +
> > +build_good_mod() {
> > +       echo "=3D=3D=3D=3D Setup: build control module ${GOOD_MOD} from=
 good.te"
> > +       rm -f "${GOOD_MOD}"
> > +
> > +       set +e
> > +       # shellcheck disable=3DSC2086
> > +       "${CHECKMODULE}" ${CHECKMODULE_MOD_FLAGS} -o "${GOOD_MOD}" "${G=
OOD_TE}" \
> > +               2>"${OUTDIR}/build_good.err"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -ne 0 ]; then
> > +               echo "FAIL: could not build control module from ${GOOD_=
TE}" >&2
> > +               cat "${OUTDIR}/build_good.err" >&2
> > +               exit 1
> > +       fi
> > +       if [ ! -s "${GOOD_MOD}" ]; then
> > +               echo "FAIL: ${GOOD_MOD} is empty" >&2
> > +               exit 1
> > +       fi
> > +       echo ""
> > +}
> > +
> > +expect_package_pass() {
> > +       desc=3D"$1"
> > +       outname=3D"$2"
> > +       shift 2
> > +
> > +       outpp=3D"${OUTDIR}/${outname}.pp"
> > +       stderr=3D"${OUTDIR}/${outname}.err"
> > +
> > +       echo "=3D=3D=3D=3D POSITIVE (expect semodule_package success): =
${desc}"
> > +       rm -f "${outpp}"
> > +
> > +       set +e
> > +       "${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -ne 0 ]; then
> > +               echo "stderr:" >&2
> > +               cat "${stderr}" >&2
> > +               die "${desc}: expected exit 0, got rc=3D${rc}"
> > +               return 0
> > +       fi
> > +       if [ ! -s "${outpp}" ]; then
> > +               die "${desc}: expected non-empty ${outpp}"
> > +               return 0
> > +       fi
> > +
> > +       pass "${desc} (exit 0, .pp created)"
> > +}
> > +
> > +expect_package_pass_deferred() {
> > +       desc=3D"$1"
> > +       outname=3D"$2"
> > +       shift 2
> > +
> > +       outpp=3D"${OUTDIR}/${outname}.pp"
> > +       stderr=3D"${OUTDIR}/${outname}.err"
> > +
> > +       echo "=3D=3D=3D=3D DOCUMENT (semodule_package accepts input; va=
lidate in sefcontext_compile): ${desc}"
> > +       rm -f "${outpp}"
> > +
> > +       set +e
> > +       "${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -ne 0 ]; then
> > +               echo "stderr:" >&2
> > +               cat "${stderr}" >&2
> > +               die "${desc}: expected exit 0 at packaging stage, got r=
c=3D${rc}"
> > +               return 0
> > +       fi
> > +       if [ ! -s "${outpp}" ]; then
> > +               die "${desc}: expected non-empty ${outpp} at packaging =
stage"
> > +               return 0
> > +       fi
> > +
> > +       pass "${desc} (packaging exit 0; labeling validation deferred t=
o sefcontext_compile)"
> > +}
> > +
> > +expect_package_fail() {
> > +       desc=3D"$1"
> > +       pattern=3D"$2"
> > +       outname=3D"$3"
> > +       shift 3
> > +
> > +       outpp=3D"${OUTDIR}/${outname}.pp"
> > +       stderr=3D"${OUTDIR}/${outname}.err"
> > +
> > +       echo "=3D=3D=3D=3D NEGATIVE (expect semodule_package failure): =
${desc}"
> > +       rm -f "${outpp}"
> > +
> > +       set +e
> > +       "${SEMODULE_PACKAGE}" -o "${outpp}" "$@" 2>"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -eq 0 ]; then
> > +               die "${desc}: expected non-zero exit, got rc=3D0"
> > +               return 0
> > +       fi
> > +       if [ -f "${outpp}" ]; then
> > +               die "${desc}: did not expect output ${outpp}"
> > +               return 0
> > +       fi
> > +       if ! grep -Eq "${pattern}" "${stderr}"; then
> > +               echo "FAIL: stderr did not match /${pattern}/" >&2
> > +               cat "${stderr}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 0
> > +       fi
> > +
> > +       pass "${desc} (rejected as expected, rc=3D${rc})"
> > +}
> > +
> > +expect_package_fail_unreadable() {
> > +       desc=3D"unreadable -m file"
> > +       mod=3D"${OUTDIR}/unreadable.mod"
> > +       outpp=3D"${OUTDIR}/unreadable.pp"
> > +       stderr=3D"${OUTDIR}/unreadable.err"
> > +
> > +       echo "=3D=3D=3D=3D NEGATIVE (expect semodule_package failure): =
${desc}"
> > +       if [ "$(id -u)" -eq 0 ]; then
> > +               echo "SKIP: root can read mode 000 files; unreadable ch=
eck is non-root only"
> > +               PASS=3D$((PASS + 1))
> > +               echo ""
> > +               return 0
> > +       fi
> > +
> > +       rm -f "${outpp}"
> > +       cp "${GOOD_MOD}" "${mod}"
> > +       chmod 000 "${mod}"
> > +
> > +       set +e
> > +       "${SEMODULE_PACKAGE}" -o "${outpp}" -m "${mod}" 2>"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -eq 0 ]; then
> > +               die "${desc}: expected non-zero exit, got rc=3D0"
> > +               return 0
> > +       fi
> > +       if [ -f "${outpp}" ]; then
> > +               die "${desc}: did not expect output ${outpp}"
> > +               return 0
> > +       fi
> > +       if ! grep -Eq 'Permission denied|Could not open|Failed to open'=
 "${stderr}"; then
> > +               echo "FAIL: stderr did not mention permission or open f=
ailure" >&2
> > +               cat "${stderr}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 0
> > +       fi
> > +
> > +       pass "${desc} (rejected as expected, rc=3D${rc})"
> > +}
> > +
> > +expect_package_fail_unreadable_fc() {
> > +       desc=3D"unreadable -f file"
> > +       fc=3D"${OUTDIR}/unreadable.mod.fc"
> > +       outpp=3D"${OUTDIR}/unreadable_fc.pp"
> > +       stderr=3D"${OUTDIR}/unreadable_fc.err"
> > +
> > +       echo "=3D=3D=3D=3D NEGATIVE (expect semodule_package failure): =
${desc}"
> > +       if [ "$(id -u)" -eq 0 ]; then
> > +               echo "SKIP: root can read mode 000 files; unreadable ch=
eck is non-root only"
> > +               PASS=3D$((PASS + 1))
> > +               echo ""
> > +               return 0
> > +       fi
> > +
> > +       rm -f "${outpp}"
> > +       cp "${GOOD_FC}" "${fc}"
> > +       chmod 000 "${fc}"
> > +
> > +       set +e
> > +       "${SEMODULE_PACKAGE}" -o "${outpp}" -m "${GOOD_MOD}" -f "${fc}"=
 \
> > +               2>"${stderr}"
> > +       rc=3D$?
> > +       set -e
> > +
> > +       if [ "${rc}" -eq 0 ]; then
> > +               die "${desc}: expected non-zero exit, got rc=3D0"
> > +               return 0
> > +       fi
> > +       if [ -f "${outpp}" ]; then
> > +               die "${desc}: did not expect output ${outpp}"
> > +               return 0
> > +       fi
> > +       if ! grep -Eq 'Permission denied|Could not open|Failed to open'=
 "${stderr}"; then
> > +               echo "FAIL: stderr did not mention permission or open f=
ailure" >&2
> > +               cat "${stderr}" >&2
> > +               FAIL=3D$((FAIL + 1))
> > +               return 0
> > +       fi
> > +
> > +       pass "${desc} (rejected as expected, rc=3D${rc})"
> > +}
> > +
> > +build_good_mod
> > +
> > +# Ephemeral path fixtures for packaging path tests.
> > +ln -sf /nonexistent/test_good.mod "${OUTDIR}/broken_symlink.mod"
> > +ln -sf /nonexistent/test_good.mod.fc "${OUTDIR}/broken_symlink.mod.fc"
> > +printf '' > "${OUTDIR}/empty.mod.fc"
> > +
> > +# NUL byte inside path column (packaging accepts; sefcontext_compile r=
ejects).
> > +printf '/bin/foo\x00bar\t--\tsystem_u:object_r:test_good_exec_t:s0\n' =
\
> > +       > "${OUTDIR}/nul_bytes.mod.fc"
> > +
> > +GOOD_FC=3D"${FIXTURES}/file_contexts/good.mod.fc"
> > +
> > +# --- semodule_package input paths ---
> > +expect_package_pass \
> > +       "control good .mod without file contexts" \
> > +       good_mod \
> > +       -m "${GOOD_MOD}"
> > +
> > +expect_package_pass \
> > +       "control good .mod with good .mod.fc" \
> > +       good_mod_fc \
> > +       -m "${GOOD_MOD}" -f "${GOOD_FC}"
> > +
> > +expect_package_fail \
> > +       "missing -m path" \
> > +       "Could not open|Failed to open" \
> > +       missing_mod \
> > +       -m "${OUTDIR}/does_not_exist.mod"
> > +
> > +expect_package_fail \
> > +       "missing -f path" \
> > +       "Failed to open|Could not open" \
> > +       missing_fc \
> > +       -m "${GOOD_MOD}" -f "${OUTDIR}/does_not_exist.mod.fc"
> > +
> > +expect_package_fail \
> > +       "directory instead of -m file" \
> > +       "Error while reading policy module|Could not open" \
> > +       directory_mod \
> > +       -m "${BASEDIR}"
> > +
> > +expect_package_fail \
> > +       "broken symlink for -m" \
> > +       "Could not open|Failed to open|No such file" \
> > +       symlink_mod \
> > +       -m "${OUTDIR}/broken_symlink.mod"
> > +
> > +expect_package_fail_unreadable
> > +
> > +expect_package_fail \
> > +       "empty -m path argument" \
> > +       "Could not open|Failed to open" \
> > +       empty_mod \
> > +       -m ""
> > +
> > +expect_package_fail \
> > +       "directory instead of -f file" \
> > +       "Permission denied|Failed to mmap|Failed to open|Could not open=
" \
> > +       directory_fc \
> > +       -m "${GOOD_MOD}" -f "${BASEDIR}"
> > +
> > +expect_package_fail \
> > +       "broken symlink for -f" \
> > +       "Could not open|Failed to open|No such file" \
> > +       symlink_fc \
> > +       -m "${GOOD_MOD}" -f "${OUTDIR}/broken_symlink.mod.fc"
> > +
> > +expect_package_fail_unreadable_fc
> > +
> > +expect_package_fail \
> > +       "empty -f path argument" \
> > +       "Could not open|Failed to open" \
> > +       empty_fc_arg \
> > +       -m "${GOOD_MOD}" -f ""
> > +
> > +# --- bad .mod.fc at packaging time ---
> > +expect_package_pass_deferred \
> > +       "invalid SELinux context in .mod.fc" \
> > +       bad_context \
> > +       -m "${GOOD_MOD}" -f "${FIXTURES}/file_contexts/bad_context.mod.=
fc"
> > +
> > +expect_package_pass_deferred \
> > +       "wrong field count in .mod.fc" \
> > +       bad_fields \
> > +       -m "${GOOD_MOD}" -f "${FIXTURES}/file_contexts/bad_fields.mod.f=
c"
> > +
> > +expect_package_pass_deferred \
> > +       "NUL byte in .mod.fc path field" \
> > +       nul_bytes \
> > +       -m "${GOOD_MOD}" -f "${OUTDIR}/nul_bytes.mod.fc"
> > +
> > +expect_package_pass_deferred \
> > +       "empty .mod.fc file" \
> > +       empty_fc \
> > +       -m "${GOOD_MOD}" -f "${OUTDIR}/empty.mod.fc"
> > +
> > +echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> > +echo "Results: ${PASS} passed, ${FAIL} failed"
> > +if [ "${FAIL}" -ne 0 ]; then
> > +       exit 1
> > +fi
> > +exit 0
> > --
> > 2.55.0
> >
> >
