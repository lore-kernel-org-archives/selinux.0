Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A21DE2A0
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825683; cv=none; b=eG+/ACzv4cFeo8GKIcMZwEnhVipGORQePSa4cH/MEkphnvp3uMxBn97z+cnDwVeEKGOmZuG1/gccrHSnoeoUDrN28zmZJ1qyO4DTahRVO1+EVGqz6CJODMiol9YLrANrmvnCpT2mVy1ivFdrwdtr/adX6+4ap4N/HGyHGcZZwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825683; c=relaxed/simple;
	bh=xvABH4X0FOg0PCBz7gPm15KaKnb6nrEaFXE+Yq9w6Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWwJiPv+KkOfPMNtqWiA0iNhS8gkYTmYzCWXmKpWs+eEZm63AM+8TbXI1AOQEFWO5c+/0hvAl/bAl9yifBCTiEK5V+uPQqreOZsBPWujSs4CPY/sXZ2Khns/f9J6uJnP018XcQE75nZdoc6U29V4kXtOCrqtvvJw6DW0Y3rn1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZFV6cpw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZFV6cpw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326793a85so4381064a91.1
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756825681; x=1757430481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdfWFq4B0xu7tM8TEx6Q5N0ZwgEUbQVJLbbmsDG8ZpI=;
        b=hZFV6cpwC9EafFTMbe1cqQv2mB7L2sKm4NG5TI513wJpgXLUFgc1eMYDPnAkAR/J6t
         lPkYUJViJmjr6X1XAh81jXif9CTfWh1SMkhBzBZ4zVlhU0xDQWZgO15flHGhILTTT1Tn
         EGdYjOKUWj+/5eGIB0QPWL9eF1nAWJKLyMAqtM3VBvP8dckKrZ1+l6NIhRzs3r+lEriR
         U5IC+ndsKEniVUlFqSE/xTdt1FdAToD1srd73nngO0hzfhpiEEz8ohqBI1PBQg6ZU2LH
         zIcxsSl3MxkNsz8t0EE3XNGMARAEPS7EN/SmgvID01J3Ja/AL/r0koyR6FBxIgZPfn79
         nWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756825681; x=1757430481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdfWFq4B0xu7tM8TEx6Q5N0ZwgEUbQVJLbbmsDG8ZpI=;
        b=IHhuzqDbpbLj+DlMxdS3yjYTk+ybxie124TydfPHmt+oyDAK0rwnA0NCX4CNhHcdiY
         tOg7TINVglP8fXn5zPDxm5xE9ixBLuuFo45ROGwdN1dLChP0TAzpOT6942O083lWJwbX
         dujaq6s8J/7rPdKQCZa5YzSNhfQJ4EQ2pk7IZrkd9sE2Aw+oKd6fr+fZRp7RXO5TandR
         c9DX9XGBcyZm+2enWZlFlU+Xj3jgINU9AgBHvzMDPdKfTA+ir9YTmnpRP8c2EcajGnp5
         Ty14ZNoeXzGP1vtHNaJrlCDtlSicnZtJ/ds2meUk4U1pq5tF43PlvVPxBjCY2qBXwQoo
         RgYA==
X-Forwarded-Encrypted: i=1; AJvYcCWMTMl6LzhiWc5B3DseRGp95U0U0RhybVZlBiLlYb4Bi/+hZGXoCrarw14/6GAE1NJyng0rKMNV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkr5kRrGVrFsXx4SEI8/VkRm2jfgBHag3b5XktxNjyUfJnV4kJ
	1APWz7aJ6dwg3tmIne7YBDRqR1tco3H3ogGVCnIM5xxYUdMIirHdHf5O/09PwGdNqEZvI2QdOxs
	GZEJk6Dikx3Kv7vhLjLwEYAsvXI+TQoM=
X-Gm-Gg: ASbGncsSPRfVB6WFizRUhpJ/u0Le6JuYiapGNwIQfy322wjdQTWitV7Frh8sT0ugg7Z
	+d2zE8r5bjwHNx54FHm6ch9uIEAUhSuSb3v/ian87hTfYBNQzEO00/+SnPxtbJgXE/ST3tQYzUC
	XLw+4cYmwybeMkMdFf/ReEoSj5CqrKU15Ld4C/rCKAZlSqq3G6C1BJM3LSJ2vru31d2gAO/CXCT
	UribJ4=
X-Google-Smtp-Source: AGHT+IE29GC/KJr/hfDgI51QkDvQi8LeLP1CdbeaGD4V6mlwIMX3MC0Uoyzs6w0Gv/QLhVbRAjFVpDDwnfXTj6Ka1Tw=
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id
 98e67ed59e1d1-32815412e9bmr16496804a91.4.1756825639539; Tue, 02 Sep 2025
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055401.618729-1-tweek@google.com>
In-Reply-To: <20250902055401.618729-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Sep 2025 11:07:08 -0400
X-Gm-Features: Ac12FXyQMJ1c8PTIy7pyeafgDea9rAyiZyJ_DBqIDp2enLXr_fArhO4Gf5lp4tY
Message-ID: <CAEjxPJ4UzRUKkWgoO80hpPF6HhkPM_DUq7BV4+Nh6RhRAdpP7g@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for memfd_file class
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:54=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> A new class "memfd_file" is introduced to the kernel in [1]. This class
> is only used when the policy capability "memfd_class" is set. Add tests
> to validate this new class:
>
>   1. Validate that memfd_create() requires the "create" permission.
>   2. Validate that fexecve() on a memfd requires the "execute_no_trans"
>      permission.

Thanks for this patch. Do you have example CIL modules for defining
the memfd_file class and memfd_class policy capability that we can use
to exercise these tests without needing to modify the base policy?
And corresponding sed command for updating
/usr/share/selinux/devel/include/support/obj_perm_sets.spt to define
it for use by the test_memfd.te file?
Is there an actual policy version dependency or is that just
cut-and-pasted from prior examples?
And then lastly, please run ./toosl/check-syntax -f to fix up
formatting issues with the C and perl code before submission.
Thank you!

>
> [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@google=
.com/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  policy/Makefile             |  5 ++++
>  policy/test_memfd.te        | 25 +++++++++++++++++
>  tests/Makefile              |  5 ++++
>  tests/memfd/Makefile        |  5 ++++
>  tests/memfd/memfd.c         | 24 +++++++++++++++++
>  tests/memfd/memfd_fexecve.c | 53 +++++++++++++++++++++++++++++++++++++
>  tests/memfd/nothing.c       |  6 +++++
>  tests/memfd/test            | 39 +++++++++++++++++++++++++++
>  8 files changed, 162 insertions(+)
>  create mode 100644 policy/test_memfd.te
>  create mode 100644 tests/memfd/Makefile
>  create mode 100644 tests/memfd/memfd.c
>  create mode 100644 tests/memfd/memfd_fexecve.c
>  create mode 100644 tests/memfd/nothing.c
>  create mode 100755 tests/memfd/test
>
> diff --git a/policy/Makefile b/policy/Makefile
> index ffd774d..d19f687 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -163,6 +163,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERN=
EL_POLICY) -ge 30 ] && [ -f
>  TARGETS +=3D test_nlmsg.te
>  endif
>
> +# memfd_file test dependencies: policy >=3D 30, memfd_file class, memfd_=
class capability
> +ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] =
&& [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/policy=
_capabilities/memfd_class && echo true),true)
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
> index 7a6aace..e6fa76b 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -158,6 +158,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERN=
EL_POLICY) -ge 30 ] && [ -f
>  SUBDIRS +=3D nlmsg
>  endif
>
> +# memfd_file test dependencies: policy >=3D 30, memfd_file class, memfd_=
class capability
> +ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] =
&& [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/policy=
_capabilities/memfd_class && echo true),true)
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
> index 0000000..a88a0db
> --- /dev/null
> +++ b/tests/memfd/test
> @@ -0,0 +1,39 @@
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
> +$result =3D system "runcon -t test_memfd_with_exec_t -- $basedir/memfd_f=
execve $basedir/nothing 2>&1";
> +ok( $result, 0 );
> +
> +#
> +# Attempt to fexecve() on a memfd_create() fd from the not-allowed domai=
n.
> +#
> +$result =3D system "runcon -t test_memfd_with_noexec_t -- $basedir/memfd=
_fexecve $basedir/nothing 2>&1";
> +ok($result);
> +exit;
> --
> 2.51.0.338.gd7d06c2dae-goog
>
