Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCD33939F
	for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725709; cv=pass; b=Ux2QNkHj4wsEyachib5G9lW+VneGgrAIg3DDPQaOoWeGaym6NUApqYmqeuZpMcW7zEquhwj8522pSDmmWQV2jRTjMaPNEhKNEed/U9jIJKD1IAJU3MPEbv/luSrQzHBjR9jolks5SxMie366uy9HFm0E0VZPmKsaoSrCCvAeGMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725709; c=relaxed/simple;
	bh=br8tmWta8ewvdACzWDL26masqczUuZy+9iJpKRyTm+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fa7Hl9JXd+qF+38jw1tBHQeYE9Yi9jPAyI8Wg/dfZVLsJXETkEnuB9BWCnul53Gzqm5dWWX0aIrVt0uQmwJ13oHumHJP3/AGrisd61Avfnt09iad8Vx1WeQzDTU8HYJyuUHYuQPlklYyV4hFqrTeH8f3FROEGdZurDZUqyTlvpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNzQeN43; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNzQeN43"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso9300763b3a.2
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 06:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784725695; cv=none;
        d=google.com; s=arc-20260327;
        b=VosYGwtqjBcO3odVTU9/DGI9P0guAKgo5kZynU5UdIc5f5pgYov1dcjDSBdXOZ9v6e
         uu5ejAoNaIT7lvjt6pdL3r7XlaLFAWr4yDqoPlWQdyZZPCTQ9SrpzEwzQ6aL+GiELVmv
         GxP8bMJ7B7TzG2O+40suBcs1AtaU9oPIwT2h1kj5smWx2Bm4nEL/7rwCKdhVR2lO8C5J
         CKXgyFDrRU2k9aCT5JH91qozBr/TFb7/RTI0zMz/NxxQs1x2ANkf32Rj3kmL56XhKTca
         G5eiXDfRN3FiMQmB+61vxLIwS9PQEsrht3kXnkxNX4ZxA++A2nRaPPwuUPFULBGOalSa
         tO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sE4vSJQPEZ95gZ667lkCGIgXnED1kxKhmn/lFjohatc=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=PKFgfjzxcUYNzR1C6VwqFOIM/WIQoKx/a+QgJLpm2oUUvl6hmiABvD3sjjsiRaW6/b
         XX36+SGbrsTBAIYLgZXY7mXdl59acByfxRfF3vlhlqEdkYC99lm+CWqO9H8nktMM9eIm
         LWr//eZLpgdkMNcJSSm1mhVKfFq2XHGUfgJLTZRzlShl/3RF+0z5DLD8V4r2asxR5+Q3
         EE3clJG4XWb9IHGIpWGxWFeGc4/9OI9aVsKTd3YHvc+1QaukmNcIoYISzfFYgcLq+uGO
         wxSVwiUa6Z8UVXbIxfBN2Mb79L9r4oNPF10DCO7ZWwDdN9SWCr6nhC3V1pGiw12k/Zh4
         iuCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784725695; x=1785330495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sE4vSJQPEZ95gZ667lkCGIgXnED1kxKhmn/lFjohatc=;
        b=SNzQeN434cjupcVy7AmUCX4YqgyUDnqN3GNiOuNQ/eKwuJ6uPO5vut2Mg1NM1cImcn
         ig6xlPum5rggcyDgxMaFHBywBs0U30LPxB+4B7A7uZIfB75hThDG4jXw7OZkTZOv2iOg
         +kDrj593EjU+Q+KSPrvdjLy2Xk6OuWO8f7Ot/lw4PryojKAjHJnBXpNe6g1JyLc8z9rb
         Wk9Wdlt1JOUkhOR5yMAEgve+Us5+gbduh4ibFqlPWwYvhUumwROrqAKyQ/fTRo7m5Ffn
         doNWpxHOGdeQvQGRqF9+Aw0gkZsc0KqW0nBe/7ThZaFpixDszUCpfbCHsgRNwBfNq6el
         lCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784725695; x=1785330495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sE4vSJQPEZ95gZ667lkCGIgXnED1kxKhmn/lFjohatc=;
        b=ChVr+WcvV1qYLkfZ4GT5+XczCEJlS57oAaWemlaZDMw8UP2QW8rINa0NGnFbLU/U6Q
         d1VaaRL1XU2+ezBtYLqnEAlY/dfNvvt+SA2APiEpEQMqW1KLMDYsISVp+pE+nkEjVnjQ
         F4A2/JIyE+LICdlHMZymFbIef1O6Uje0rW9qoKhkIsCI2IVdE9KGKGsNj0TiyKxnWMrk
         Y0MqZ0Ch9vgOsgcs5Yie49ZcN5V3N0QBAIjLP1Z4ahFazsw9YBgCPESxi6C0k34hVDcf
         jB1HEY+MzA4gor35+cTcdrIPSXtPW2n6hOk2LrmCiHAV61+iUYPOPVkUz5pIeDgBmvqu
         DX8w==
X-Gm-Message-State: AOJu0YzT+1X+zpKJAASBR3yyJEr9MqORrREyx2kiVXaYZtwGK3hlsNv+
	KStetLw+7UGmm4kqGqaQ6WxtLCZQVKf2bUk9G///uK5t2Snm7oS+BZTxJwRbsVrEALCK2UqGvHO
	c085izlcVhcl/zoOtMgoo36kdVvaStSmE5gvM
X-Gm-Gg: AR+sD10RIPbuOHy8l1jxqkl6tl29FL4pikhBdxPRKaxtle4vs5D4DKDH5OW43F42fPs
	yp65u420RDkE3E3Drhw1gqQVftczVQ/G80IdfLNGMVHDbLGI11NLeUZpXfE4JZc2bWL7df7FCMv
	gbPJr/mNLMtyNH5xeFdC5xH6YhIZ2TXOkD0vIxMZ98anqs5Rs98FDw4Fg7glq6HXBc3AX2b01MX
	Sd1a0wZ1HzTIeqOLwb7R7dBYlsC5R1C4L8fSJwJyPB0+Alt7dgsGv4vjwFgYQ==
X-Received: by 2002:a05:6a00:3a04:b0:847:8504:9946 with SMTP id
 d2e1a72fcca58-84c29289498mr22894371b3a.25.1784725695127; Wed, 22 Jul 2026
 06:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720134940.2192826-1-akkohli@redhat.com> <20260721212614.2264953-1-akkohli@redhat.com>
 <CAEjxPJ6i97g7nq-Yx2UJ3wJLYUNfH-w4_dvXF2L=NKXxHn6B-Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ6i97g7nq-Yx2UJ3wJLYUNfH-w4_dvXF2L=NKXxHn6B-Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 22 Jul 2026 09:08:03 -0400
X-Gm-Features: AUfX_mx0aZwArDTEl6VKZ66g6-T1rLdDxoOtDFYBdUYfxZ__vahYZaQ5bwPYJ18
Message-ID: <CAEjxPJ7c9tRmFNxXmRdYSUsOmUna3-z5cBz5a6RGB8V5OM_L_A@mail.gmail.com>
Subject: Re: [PATCH] semodule-utils: add bad-data tests for semodule_package
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 8:21=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 21, 2026 at 5:34=E2=80=AFPM Akhil Kohli <akkohli@redhat.com> =
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
> > inputs are exercised in CI.
> >
> > ---
> > v2 changes:
> > - Fix CI non-root bad-data run: cd to repo root and chmod checkout for =
runuser
> > - Fail fast if run.sh cannot resolve BASEDIR
>
> You didn't update the subject line to include "v2" (use -v2 to
> git-send-email to add it automatically),
> which confuses b4 when it fetches the patches and tries to decide
> which one(s) to apply. We can
> manually fetch and apply but note for future patches please.

Still seems to be failing CI,
https://github.com/stephensmalley/selinux/actions/runs/29922183576/job/8893=
0148596

You can try this yourself by pushing to your fork and checking. The
selinux-testsuite failures
are expected since you can't run those yourself but the rest should pass.

>
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > ---
> >  .github/workflows/run_tests.yml               |  11 +
> >  semodule-utils/Makefile                       |   1 +
> >  .../fixtures/file_contexts/bad_context.mod.fc |   1 +
> >  .../fixtures/file_contexts/bad_fields.mod.fc  |   1 +
> >  .../fixtures/file_contexts/good.mod.fc        |   1 +
> >  .../tests/bad-data/fixtures/modules/good.te   |   8 +
> >  semodule-utils/tests/bad-data/run.sh          | 347 ++++++++++++++++++
> >  7 files changed, 370 insertions(+)
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
> > index f4aa1a4c..45778c25 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -82,6 +82,17 @@ jobs:
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
> > +          chmod -R a+rX .
> > +          sudo runuser -u bad-data-test -- env PATH=3D"$PATH" LD_LIBRA=
RY_PATH=3D"$LD_LIBRARY_PATH" \
> > +            sh -c 'cd "$1" && exec ./semodule-utils/tests/bad-data/run=
.sh' sh "$PWD"
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
> > index 00000000..0265032a
> > --- /dev/null
> > +++ b/semodule-utils/tests/bad-data/run.sh
> > @@ -0,0 +1,347 @@
> > +#!/bin/sh
> > +#
> > +# Bad-data tests for semodule_package in the modular policy packaging =
pipeline.
> > +# Covers packaging path edge cases (-m/-f) and documents deferred reje=
ction of bad
> > +# .mod.fc content (enforced later by sefcontext_compile on the Bucket =
D branch).
> > +# Unreadable -m/-f cases skip when run as root; CI runs this script as=
 non-root.
> > +#
> > +
> > +set -u
> > +
> > +BASEDIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd) || {
> > +       echo "FAIL: cannot resolve script directory (\$0=3D$0)" >&2
> > +       exit 1
> > +}
> > +FIXTURES=3D"${BASEDIR}/fixtures"
> > +OUTDIR=3D$(mktemp -d "${TMPDIR:-/tmp}/semodule-package-bad-data.XXXXXX=
")
> > +PASS=3D0
> > +FAIL=3D0
> > +
> > +CHECKMODULE=3D${CHECKMODULE:-checkmodule}
> > +# Modular TE for MCS/MLS builds (matches RHIVOS checkmodule -M -m).
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
