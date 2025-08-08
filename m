Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAD1A2872
	for <selinux@vger.kernel.org>; Fri,  8 Aug 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683166; cv=none; b=dw1Z3lacMxE9OdcGeMhTp9Ur7wTnOQZZJ051zkhDSrEy+pbuRu6pww/IcAHCaZRV1RSMxM1CHiJ5VWzWGmPnKM24HU9T0CXJo8ElDAkqPrnWzC1jbVDYfpuvbOHx0AOtWTjma0hcZpWdXizHsg9uVSbhTMGle9BPTU1cLGaosHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683166; c=relaxed/simple;
	bh=w8yy06cPEfW10O17pvCyyAcirGn7b6BN/VkQLj7mMdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEPuZaRnVsFHPLe4YOTSak7E5/VKVJAVKQOz7bMk6JQKG5x9iQ07VpuQhJ0LH1Qbbo/v2ynlTtdUkCBbn1PYZ9jzqI8wHPOafJIYTLBdTdS0QwKcQxOU27oXtt18E8PnjPsgXH3tDF9AK4r67TE1yKT2eyTumZO8wa3uAeLR5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbfODRsq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbfODRsq"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so2524634a91.3
        for <selinux@vger.kernel.org>; Fri, 08 Aug 2025 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754683164; x=1755287964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gstJ9lzNC/2TKQwV9Yw8GwR1eoY2+udFR08hGoS0M6U=;
        b=cbfODRsqul0SV+pjos/rJPpG8aqqZ9hswYSRfJ9h8Kq01HUVAeKP+Rz95wz40Olkh5
         NV9KzSCd+6vjWnPfNJLod4RfFqtI/LUuPnWCwkjaEbBuI/wXz+ewE4Ikob1DFgfBv7MK
         QDWbEOTcULU0AYJssG8Ks4Ocbe9PzCjaOP6bcyBoZqFy/CO38kUR9s5e326c5ZYIdmDR
         lUxlN6+/1eOG2K8alC505ZByESaetJNQzNZFYFrVH1+8vk0MuvmBaOAs7gGgNjA86adV
         wzHGRoeM0cUQb26txwiRu5IDSCw9gH7rLXmfp4zEQYLdXbl/4OYGgmLzi44VjuWtYTAM
         HB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683164; x=1755287964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gstJ9lzNC/2TKQwV9Yw8GwR1eoY2+udFR08hGoS0M6U=;
        b=BM2gzLM7/U44s3TQx5lZw2QXhMbm5hUvkuoy11AVY8LJ7co0I311qKMJDUdi+d0KiX
         3uVgytnNIZB0N4IMEi6k+KX8IwFxmX4kqxBk1hQy1E2DmOkkzbbyEr2ejwZrZevTMRv6
         hGQ0NyiEzmZNmBYy/5x3VgQka34hzFqYQt0wy9CmISOuGEuldosP9S8pVB2LcFHDYh11
         GNqLBEDGYK+Yo8P9rXp17Bze45Z8d7DbftRm2RytsASYZdRt7qfr+1wqFEcIy6igQaY3
         sgT4KD+aeSkbrRQoaWWoGeWaDKnmc7IsGQwQXVouUMM+iEnr3tmusiBYl5sapTKioSEb
         6Xng==
X-Gm-Message-State: AOJu0YwB80qPxLRcBh0NUW4Mq42FdsskrC3uRkCG5O9jDiyoik/NdntN
	RNANJ0aitbu6Mk/pJBVWENB2UQttM05/EezUrw/Y+9oHcPMJr74LdB+u10YMhSr6TAoUs2/cMPX
	nJMIfwg0oQMjd0/qedeY3o8nqSePIrDk=
X-Gm-Gg: ASbGncvtrHWFUBwD+l1UpOxjwje4GZUud30pK0dkGWthS+iTx4I+bD23WqKcK52boP9
	2A78e3Yl2Dkxp/yUnd1U3cLviMIwCRER+QapcSKCNJ+Yh3ukyHEwk0k7irar/SXGi9++nQejgEy
	WFuer4XNBA7f7iDoKqwIygtJu/BbYA8B88UvdOpK9QD4MElQHKyBhQFoOGi3wSm5MTh4aikZnzy
	jkcAHp5I/+Bm4LPdw==
X-Google-Smtp-Source: AGHT+IFOJBRIn+3opa3cQmtDDI63oHnL3zM4e+2eAHLbYx3bi5xWhwbztHhCgOINCmE2gL5+3yCgnC9/s9/QyhO9kFw=
X-Received: by 2002:a17:90b:582e:b0:31f:22f:a23e with SMTP id
 98e67ed59e1d1-32183c4608cmr6033038a91.27.1754683163545; Fri, 08 Aug 2025
 12:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808184711.291-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250808184711.291-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Aug 2025 15:59:12 -0400
X-Gm-Features: Ac12FXw9aHkTu5uMp7rw8G0H9WNDFbaabdwGf9vaNsaOD-v4WsahIq2j4Urbnmw
Message-ID: <CAEjxPJ6SBAy8yi8XhASR5pVFnYfvJhFujzGfBQuS9o2TziOSFw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>, danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:47=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.co=
m> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.micr=
osoft.com/
>
> Four new tests are added to cover both positive and negative scenarios,
> ensuring that the SELinux policy enforcement on BPF token usage behaves
> as expected.
>   - Successful map_create and prog_load when SELinux permissions are
>     granted.
>   - Enforcement of SELinux policy restrictions when access is denied.
>
> These tests are located under the tests/bpf directory and can be run
> using the standard SELinux testsuite workflow.

(added Daniel to cc since he also posted a testsuite patch and thus
should be included)

As I mentioned on the other thread, you should include instructions in
your commit message for how to temporarily define the requisite policy
capability and new permissions to run these tests; an example is
linked from the SELinux kernel wiki Getting Started page and my other
email.
That alone isn't worth re-submitting this patch but see below for more.

>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
>  policy/test_bpf.te     | 48 ++++++++++++++++++++++++++++++++++
>  tests/bpf/Makefile     |  5 ++--
>  tests/bpf/bpf_common.h | 10 +++++++
>  tests/bpf/bpf_test.c   | 59 ++++++++++++++++++++++++++++++------------
>  tests/bpf/test         | 21 ++++++++++++++-
>  5 files changed, 124 insertions(+), 19 deletions(-)
>
> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
> index 5eab0bd..ef226a8 100644
> --- a/policy/test_bpf.te
> +++ b/policy/test_bpf.te
> @@ -57,3 +57,51 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
>  allow test_bpf_deny_prog_run_t self:process { setrlimit };
>  allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin =
};
>  allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write =
prog_load };
> +
> +################### Allow map_create_as and prog_load_as ###############=
####
> +fs_list_bpf_dirs(test_bpf_t);

Technically we shouldn't put semicolons at the end of a macro call; it
will turn into an empty statement in the macro-expanded policy.
Semicolons are only for actual policy language statements. You might
just have copied this from elsewhere but it would be better to avoid
it.

> +allow kernel_t test_bpf_t:bpf map_create;
> +allow test_bpf_t bpf_t:dir { ioctl open read search };
> +allow test_bpf_t bpf_t:filesystem mount;
> +allow test_bpf_t root_t:dir mounton;
> +allow test_bpf_t self:bpf { map_create_as prog_load_as };
> +allow test_bpf_t self:cap2_userns { bpf perfmon };
> +allow test_bpf_t self:cap_userns { net_admin setgid setuid sys_admin };
> +allow test_bpf_t self:user_namespace create;
> +allow test_bpf_t unlabeled_t:dir search;

Here and below, the fact that you are allowing kernel_t (i.e. the
domain/type of kernel threads and the first process prior to switching
to init_t) permissions suggests a bug/defect in your kernel patch,
because that just shouldn't be required for a userspace program to
create a BPF map.
Similarly allowing permission to unlabeled_t:dir suggests a bug/defect
in your kernel patch or your test policy, because unlabeled_t is a
type for files that do not have a SELinux label/context assigned to
them. This can occur for example if there are no SELinux policy rules
for labeling a given filesystem type in the base policy, but in that
case you should add a genfscon or similar policy statement either as
part of your test policy or note the need to add such a rule in the
commit message. Daniel's testsuite patch didn't appear to require
either a kernel_t or unlabeled_t allow rule.

> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> index 1ae8ce9..cacefbe 100644
> --- a/tests/bpf/Makefile
> +++ b/tests/bpf/Makefile
> @@ -1,5 +1,5 @@
>  TARGETS =3D bpf_test
> -DEPS =3D bpf_common.c bpf_common.h
> +SRCS =3D bpf_test.c bpf_common.c token_test.c
>  LDLIBS +=3D -lselinux -lbpf
>
>  # export so that BPF_ENABLED entries get built correctly on local build
> @@ -14,4 +14,5 @@ clean:
>         rm -f $(TARGETS) test_sock flag *_flag
>         @set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
>
> -$(TARGETS): $(DEPS)
> +$(TARGETS): $(SRCS)
> +       $(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
> \ No newline at end of file

Please fix the terminating newline issue here.
Also, make doesn't work after this patch is applied:
make: *** No rule to make target 'token_test.c', needed by 'bpf_test'.  Sto=
p.

> diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
> index 44ac28f..adba522 100644
> --- a/tests/bpf/bpf_common.h
> +++ b/tests/bpf/bpf_common.h
> @@ -12,6 +12,8 @@
>  extern int create_bpf_map(void);
>  extern int create_bpf_prog(void);
>  extern void bpf_setrlimit(void);
> +extern int test_bpf_map_create(void);
> +extern int test_bpf_prog_load(void);
>
>  /* edited eBPF instruction library */
>  /* Short form of mov, dst_reg =3D imm32 */
> @@ -32,3 +34,11 @@ extern void bpf_setrlimit(void);
>                                                .off   =3D 0,             =
         \
>                                                         .imm   =3D 0 })
>
> +/* Raw code statement block */
> +#define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)                 \
> +       ((struct bpf_insn) {                                    \
> +               .code  =3D CODE,                                  \
> +                       .dst_reg =3D DST,                                =
 \
> +                               .src_reg =3D SRC,                        =
         \
> +                                       .off   =3D OFF,                  =
                 \
> +                                               .imm   =3D IMM })

I don't see any usage of this macro nor definition of these functions
in your patch?
Did you forget to "git add" a file?

> diff --git a/tests/bpf/test b/tests/bpf/test
> index a3fd856..aefc70c 100755
> --- a/tests/bpf/test
> +++ b/tests/bpf/test
> @@ -9,8 +9,10 @@ BEGIN {
>
>      $test_bpf_count       =3D 7;
>      $test_fdreceive_count =3D 4;
> +    $test_bpf_token_count =3D 4;
>
> -    $test_count =3D $test_bpf_count + $test_fdreceive_count;
> +    $test_count =3D $test_bpf_count + $test_fdreceive_count +
> +                  $test_bpf_token_count;
>
>      # allow info to be shown during tests
>      $v =3D $ARGV[0];
> @@ -67,6 +69,13 @@ ok( $result eq 0 );
>  $result =3D system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
>  ok( $result eq 0 );
>
> +# BPF token - BPF_MAP_CREATE_AS, BPF_PROG_LOAD_AS
> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
> +ok ( $result eq 0 );
> +
> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -l $v";
> +ok ( $result eq 0 );
> +
>  # Deny map_create permission
>  $result =3D
>    system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2=
>&1";
> @@ -92,6 +101,16 @@ $result =3D
>    system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&=
1";
>  ok($result);
>
> +# BPF token - deny BPF_MAP_CREATE_AS
> +$result =3D
> +  system "runcon -t test_bpf_deny_map_create_as_t $basedir/bpf_test -c $=
v 2>&1";
> +ok($result);
> +
> +# BPF token - deny BPF_PROG_LOAD_AS
> +$result =3D
> +  system "runcon -t test_bpf_deny_prog_load_as_t $basedir/bpf_test -l $v=
 2>&1";
> +ok($result);
> +
>  #
>  ################ BPF Tests for fdreceive #######################
>  #

At least on my system, perl tidy complained about some lines in this
file; be sure to re-run it and amend.
