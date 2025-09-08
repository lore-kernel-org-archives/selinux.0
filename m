Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46841946AA
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348633; cv=none; b=WWrYRqpHlzoU3cnYzuTt4s2Ft/VDZL+uuSDZYqi3MpRNbSbflSm7sOCxSFGb67st+jZEWsHZuCEL+EoNaoRU1Vfy+StHc52kWraPHUrye+cMSeWHihc6hSTBrQzNr5n/O0rYj4x+YPvf7bgAsyPydNw4ZmK7iOQUYx36PZJknp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348633; c=relaxed/simple;
	bh=FRY7hK/GSlg69u3w8zHEU+szFkPb+3bnRFUjkrJD5e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8jeFKa4pg+WC2gghjn05mEjy0fD0ido1nx3Rwy5C0/IQVctoHinfjQ36Zkr17XXLUuPmib+LLGqMVyEfdys4P1rfcX3RZWJVE6aQaLNQEk2m/bmP91OThI+c17J0WgQ7V9lIEBjVAr6NceCCys6ybtqop5/fxA1B0nkg+rIPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXHfXJWg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXHfXJWg"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32d9086276eso753831a91.0
        for <selinux@vger.kernel.org>; Mon, 08 Sep 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757348631; x=1757953431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmLErVkpZ0Hfb56s2plZdBlW6nqlUNKkSjvYf92TYX8=;
        b=YXHfXJWg+/8d7L1hUkS9ipRxrK6w4HhCAV71l+j0zL1SCkDkGyZEfHvZC8jiRJAU2v
         2Y6sKQQe01M+dXfUAkcLkpGTEeeERZCj+62Ev/yymqHjV37zHHTyIPLmG114ObL33yCx
         22ZL/JVpSYDPEvtdN27itRwqgJdvgEfIzsmKFeuI6ps2UGBtvtkmoWmn66jK85T5W+0X
         fT+PCrGPWYSe2OJgDEopvEY1uqmejkamVmn/RLpcgI88b/V2NXEQRzO5qQ7o00y38PyO
         1d/c48F/2DHIJ4K5yRv5zOnL089v4lK1DIX7FKYCVzLF81t7qoXJWMWEAQgOrVNuiY9w
         wWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348631; x=1757953431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmLErVkpZ0Hfb56s2plZdBlW6nqlUNKkSjvYf92TYX8=;
        b=HcBC8amXwUEC+S0sE40bQO4xQiwzeNoLf+z/VV7SRJRuFM62p3iiG/1XqRRmAcXjul
         SyYu1XCaRFouCrnkkXR8nNpIE8pktgKY56WiS8QvPQZN0fpR9l1DpQwsBgxAXj8BmjvP
         8qGyRbtkieIpQWL+ckWBLxasdydx19U8E3GJKUcP2C5nllPGsBjXSnI6b1ncAooRMAsJ
         N0Wc2V17wGmbRDePPCQTPhnMiSbK5u5c+BBUhH+nutG/7idDnb4vxNyeYFRSoR+/q0qu
         kDOPYo0U4IEgi0w0qxuG+nNEV/KUd3tisO5DfVTau7c6gYualeCBIe0lAvDp/U1NQorQ
         RaSw==
X-Forwarded-Encrypted: i=1; AJvYcCUex30e9V2a0Dw/llL7ApHMt7y1tLSBI+MGnCJFBYqWnrt6gMOs9rtsCm1vgTWjfRXwk826WcmZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwahscjYNGl8pZf6UPxF5r+o5q0IJ5G5fQLwtERUVVAyf5TsCck
	nUlMCvOlN2v1NEsfrFHiYEb4vg+j/PSVLQsA6QsmEu2yKSTdiSJ1YmEFNkvSES7dZN9ligJpdwY
	+pG8oqOP8X7dd9+GS2SXcGnIUmZhPeRpW9A==
X-Gm-Gg: ASbGncvcJwOH19gGaTIpRs2zi0AUw6vY3w6wia4XNYc54QroXDBF4Gyld1JwBZINdY8
	uC+E07isZ4gwcxYXUgy6vUJziVZislItRmQ7jq+rDzI9ZN1h1EYLhmT/osYOX0Gumgs1Er7sMhL
	mkVn567dxMso43D/qRjlLl4AANRWoUr6U0Axv6QHBpnPByghBa1PzMZEEorf4zOJHLXww8ylu7m
	YV7OHs=
X-Google-Smtp-Source: AGHT+IFoTZ9Sea22HUZ+xz5byBd++Xf2N9cCM718UnbAci5fWjFpsWOm37HoIHUIdU/A9vemBmJBoWBRPdvAQk5DQ1M=
X-Received: by 2002:a17:90a:c2c7:b0:32b:dbf1:31b7 with SMTP id
 98e67ed59e1d1-32d43f03db6mr10023663a91.2.1757348630816; Mon, 08 Sep 2025
 09:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013542.4187488-1-tweek@google.com>
In-Reply-To: <20250908013542.4187488-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Sep 2025 12:23:39 -0400
X-Gm-Features: Ac12FXwXRZHojQfKT9n6VC1V26d9S57qf0o1cW0bGnUpdkbHUqdWeIezVPosrs4
Message-ID: <CAEjxPJ5L2hQdE6M7hkTXwqNJ3a9OQoqB9i5KL5iU00B3saxOrQ@mail.gmail.com>
Subject: Re: [PATCH v2] policy,tests: add tests for memfd_file class
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:35=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> A new class "memfd_file" is introduced to the kernel in [1]. This class
> is only used when the policy capability "memfd_class" is set. Add tests
> to validate this new class:
>
>   1. Validate that memfd_create() requires the "create" permission.
>   2. Validate that fexecve() on a memfd requires the "execute_no_trans"
>      permission.
>
> This can be tested by modifying the policy with:
>
>   semodule -c -E base
>   sed -i \
>     -e 's/\((class user_namespace (create ))\)/\1\n(class memfd_file (exe=
cute_no_trans entrypoint ))\n(classcommon memfd_file file)/' \
>     -e 's/\(anon_inode socket\)/memfd_file \1/' \
>     base.cil
>   echo "(policycap memfd_class)" >>base.cil
>   semodule -X 456 -i base.cil

No need to re-spin just for this, but for future reference, I'd just
do the echo to a separate file (e.g. memfdclass.cil) and append -i
memfdclass.cil to the semodule command line,
and I wouldn't bother specifying a priority (just let it use the
default 400). The reason is that I usually do these via sudo and an
echo with file redirect won't work as is when
appending to the root-owned base.cil file created by the earlier
semodule -c -E base.

>   rm -f base.cil
>
>   sed -i.orig \
>     -e 's/\(define(`all_file_perms'\'',\)\(.*\)$/\1\2\ndefine(`all_memfd_=
file_perms'\'',\2/' \
>     -e 's/\(class file all_file_perms;\)/\1\nclass memfd_file all_memfd_f=
ile_perms;/' \
>     /usr/share/selinux/devel/include/support/all_perms.spt

Likewise, no need to re-spin just for this, but I'd then say to run
"semodule -r base memfdclass" and
restore the all_perms.spt.org file to all_perms.spt.

>
> [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@google=
.com/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changelog since v1:
> - Add commands to test the policy to the commit message.
> - Only check for class and capability to include the new tests.
> - Ran check-syntax.
>
>  policy/Makefile             |  5 ++++
>  policy/test_memfd.te        | 25 +++++++++++++++++
>  tests/Makefile              |  5 ++++
>  tests/memfd/Makefile        |  5 ++++
>  tests/memfd/memfd.c         | 24 +++++++++++++++++
>  tests/memfd/memfd_fexecve.c | 53 +++++++++++++++++++++++++++++++++++++
>  tests/memfd/nothing.c       |  6 +++++
>  tests/memfd/test            | 41 ++++++++++++++++++++++++++++
>  8 files changed, 164 insertions(+)
>  create mode 100644 policy/test_memfd.te
>  create mode 100644 tests/memfd/Makefile
>  create mode 100644 tests/memfd/memfd.c
>  create mode 100644 tests/memfd/memfd_fexecve.c
>  create mode 100644 tests/memfd/nothing.c
>  create mode 100755 tests/memfd/test
>
> diff --git a/policy/Makefile b/policy/Makefile
> index ffd774d..520f891 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -163,6 +163,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERN=
EL_POLICY) -ge 30 ] && [ -f
>  TARGETS +=3D test_nlmsg.te
>  endif
>
> +# memfd_file test dependencies: memfd_file class, memfd_class capability
> +ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SEL=
INUXFS)/policy_capabilities/memfd_class && echo true),true)
> +TARGETS +=3D test_memfd.te
> +endif
> +
>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te,=
 $(TARGETS))
>  endif
> diff --git a/policy/test_memfd.te b/policy/test_memfd.te
> new file mode 100644
> index 0000000..5ca1348
> --- /dev/null
> +++ b/policy/test_memfd.te
> @@ -0,0 +1,25 @@
> +########################################
> +#
> +# Policy for testing memfd_file.
> +
> +attribute memfdtestdomain;
> +
> +type test_memfd_t;
> +typeattribute test_memfd_t memfdtestdomain;
> +testsuite_domain_type(test_memfd_t);
> +allow test_memfd_t self:memfd_file { create mmap_rw_file_perms };
> +
> +type test_memfd_nocreate_t;
> +typeattribute test_memfd_nocreate_t memfdtestdomain;
> +testsuite_domain_type(test_memfd_nocreate_t);
> +allow test_memfd_nocreate_t self:memfd_file mmap_rw_file_perms;
> +
> +type test_memfd_with_exec_t;
> +typeattribute test_memfd_with_exec_t memfdtestdomain;
> +testsuite_domain_type(test_memfd_with_exec_t);
> +allow test_memfd_with_exec_t self:memfd_file { create mmap_rw_file_perms=
 execute execute_no_trans };
> +
> +type test_memfd_with_noexec_t;
> +typeattribute test_memfd_with_noexec_t memfdtestdomain;
> +testsuite_domain_type(test_memfd_with_noexec_t);
> +allow test_memfd_with_noexec_t self:memfd_file { create mmap_rw_file_per=
ms execute };
> diff --git a/tests/Makefile b/tests/Makefile
> index 7a6aace..903ab11 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -158,6 +158,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERN=
EL_POLICY) -ge 30 ] && [ -f
>  SUBDIRS +=3D nlmsg
>  endif
>
> +# memfd_file test dependencies: memfd_file class, memfd_class capability
> +ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SEL=
INUXFS)/policy_capabilities/memfd_class && echo true),true)
> +SUBDIRS +=3D memfd
> +endif
> +
>  ifeq ($(DISTRO),RHEL4)
>      SUBDIRS:=3D$(filter-out bounds dyntrace dyntrans inet_socket mmap nn=
p_nosuid overlay unix_socket, $(SUBDIRS))
>  endif
> diff --git a/tests/memfd/Makefile b/tests/memfd/Makefile
> new file mode 100644
> index 0000000..471900f
> --- /dev/null
> +++ b/tests/memfd/Makefile
> @@ -0,0 +1,5 @@
> +TARGETS=3Dmemfd nothing memfd_fexecve
> +
> +all: $(TARGETS)
> +clean:
> +       rm -f $(TARGETS)
> diff --git a/tests/memfd/memfd.c b/tests/memfd/memfd.c
> new file mode 100644
> index 0000000..0d6f838
> --- /dev/null
> +++ b/tests/memfd/memfd.c
> @@ -0,0 +1,24 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       int fd;
> +       char *name =3D "mymemfd";
> +
> +       fd =3D memfd_create(name, 0);
> +       if (fd < 0) {
> +               perror("memfd_create");
> +               exit(-1);
> +       }
> +
> +       close(fd);
> +       exit(0);
> +}
> diff --git a/tests/memfd/memfd_fexecve.c b/tests/memfd/memfd_fexecve.c
> new file mode 100644
> index 0000000..977081e
> --- /dev/null
> +++ b/tests/memfd/memfd_fexecve.c
> @@ -0,0 +1,53 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       int memfd_fd, exec_fd;
> +       int len, written, rc;
> +       char *name =3D "mymemfd";
> +
> +       if (argc !=3D 2) {
> +               printf("Usage: %s <fexec_binary>\n", argv[0]);
> +               exit(-1);
> +       }
> +
> +       memfd_fd =3D memfd_create(name, 0);
> +       if (memfd_fd < 0) {
> +               perror("memfd_create");
> +               exit(-1);
> +       }
> +
> +       exec_fd =3D open(argv[1], O_RDONLY);
> +       if (exec_fd < 0) {
> +               perror("open");
> +               exit(-1);
> +       }
> +
> +       char buf[8192];
> +       while ((len =3D read(exec_fd, buf, sizeof(buf))) > 0) {
> +               written =3D write(memfd_fd, buf, len);
> +               if (len !=3D written) {
> +                       perror("read/write");
> +                       exit(-1);
> +               }
> +       }
> +       close(exec_fd);
> +
> +       char *empty_env[] =3D {NULL};
> +       char *nothing_argv[] =3D {argv[1], NULL};
> +
> +       rc =3D fexecve(memfd_fd, nothing_argv, empty_env);
> +
> +       perror("fexecve");
> +       exit(rc);
> +}
> diff --git a/tests/memfd/nothing.c b/tests/memfd/nothing.c
> new file mode 100644
> index 0000000..fc53d37
> --- /dev/null
> +++ b/tests/memfd/nothing.c
> @@ -0,0 +1,6 @@
> +#include <stdlib.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       return 0;
> +}
> diff --git a/tests/memfd/test b/tests/memfd/test
> new file mode 100755
> index 0000000..1b1e75f
> --- /dev/null
> +++ b/tests/memfd/test
> @@ -0,0 +1,41 @@
> +#!/usr/bin/perl
> +#
> +# This test exercises the memfd_class support
> +#
> +
> +use Test;
> +
> +BEGIN {
> +    $test_count =3D 4;
> +    plan tests =3D> $test_count;
> +}
> +
> +$basedir =3D $0;
> +$basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +#
> +# Attempt to call memfd_create() from the allowed domain.
> +#
> +$result =3D system "runcon -t test_memfd_t -- $basedir/memfd 2>&1";
> +ok( $result, 0 );
> +
> +#
> +# Attempt to call memfd_create() from the not-allowed domain.
> +#
> +$result =3D system "runcon -t test_memfd_nocreate_t -- $basedir/memfd 2>=
&1";
> +ok($result);
> +
> +#
> +# Attempt to fexecve() on a memfd_create() fd from the allowed domain.
> +#
> +$result =3D system
> +"runcon -t test_memfd_with_exec_t -- $basedir/memfd_fexecve $basedir/not=
hing 2>&1";
> +ok( $result, 0 );
> +
> +#
> +# Attempt to fexecve() on a memfd_create() fd from the not-allowed domai=
n.
> +#
> +$result =3D system
> +"runcon -t test_memfd_with_noexec_t -- $basedir/memfd_fexecve $basedir/n=
othing 2>&1";
> +ok($result);
> +exit;
> --
> 2.51.0.384.g4c02a37b29-goog
>
