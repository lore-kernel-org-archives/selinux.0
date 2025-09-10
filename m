Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495232BF2F
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515616; cv=none; b=psZJc4rmqx3CfN9AHF9d0ngScF8e8GbcPf2Jadj25pCfFlvA26Q+ZPZfFJyjeqlGvL4B9xufQDjgrZL4vB+rAYoOAIxb8G30pf/bQ3+xCFsLF+OQ1zey42wMcb7O6RTWpOxeCXw75D1ArjbJMEdEvgeGN0+ZCD3kNvghWHmjB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515616; c=relaxed/simple;
	bh=+wRIoLdlKK5HJ7wei+CAyTIM1jNVeEV+EWKuRg8soW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQq2vAzxbCVS169DM2fHLA9/vo7IjfFMpZOZdIhOz8iLEk3yA9NCRbUm5j3YZMbFDH89ISo/aqglk/dQGLoFeqcvh9jrVb18g8pmaH0W+TXR07rmUdz9oE0FKsLuHEmqdWfryCWpROCz9ZbdOlFZL7RpCGKegEYiec7sXutQf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMqIiAQu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMqIiAQu"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso5974467a12.2
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757515614; x=1758120414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKr39pm/1FNf+B5PIuySy3xQnyEAWvJDfJHHKrC2Qu0=;
        b=BMqIiAQu7Sv7C199IUwmGDIVv+gUVr0uzMwIYInB30C0zFUYy0Fl2pxJC6uoFzwh5X
         OdKWv528zpPFZmYPxc29ZGz58QGrth2x8IqQloXAt8jKybDQSmG2GFY/VVQoB07NjppY
         ejvzHwE9H7S5IqFk5ejzzUKh9ZxjD2gFXyImwm9QLJGJYBty6o14Vk8zR5lGEgqbtfa3
         ADUL1qpC0+q+/eilyANAyk/6etJNh80Qx9AUNYLnSaWYx3IGXYLVf9ediMrUgSKOMIEO
         7mRoaFjdHp5IaWbhxixNnm04psNVrrTglFwzblK0i+ISvhWyfaNtV3h4+RNEYHiB8tLb
         uQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757515614; x=1758120414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKr39pm/1FNf+B5PIuySy3xQnyEAWvJDfJHHKrC2Qu0=;
        b=AvNrxpHkIhGP3r17TrvMzzcoNHS5Z89csXBsvSN5TxRvMgORZx0tPx8iZ5sY+hBv1L
         J72xjxTabvVY4e39cNinC0CtINsG7fvkajPFym2zf/dJX0Ln6xBjW0PkdI1m5Rjp8Nb+
         zvMtbPQZzs38Dc8Qw4E7QXsojbk+a5HWfnKtho7ElIY9uygC4CggAX5f2QytYO46dCTx
         +Ivb0NWfILVDj3ROEaKn9K8+YffimxO4MXEw/6tEIYOQAiqMrMwHFctDJZB4lsb9TcOP
         lhhnclegGH0r+6GhFc5QBbhB3dM60Bu32snUuxjE65FR9LW+6YlKYE8yQxYfC3QD05vv
         P2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVwiIgRIULg2egVdmlO1ONKy74ydiK3YFtmVo4UZ8jpthhSvcMM2KENSePjSlKM3bdbOCWLmUZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YzENEC7TnJ6ex/L5/xBOdgCgwz6D2VuZ4DF7oTmNYtZfKXV2dbF
	FjOo+J8DomqWctal+bPrD4131a9Nnh9wnqXQ0DcBqd3fIwPxTOOgYPNzIG6gG3GBSPMNQZyvCKy
	CfPbcJBf7mpesz03apnN+KSNxK1r+jiQ=
X-Gm-Gg: ASbGnctdO4nKZOM+x9J3l6row01ayAGbt5UnlYy5VUCxGLWI8k8gUQDWcl8ACcyDZ1/
	+iC272SSIYJmYlG6aKkYKS2YkOOgugCgdCzz/pPszy+yETpuPUP16bSQicRi4AdggyNjV8aofRb
	wUnVMhQKZXAEDAvaD1hrWicNpc8BoCUfE3WgsaG5nQyT9pHpEo5mjOsWWjl7yyfjZiCgJTc/l4K
	cc893A=
X-Google-Smtp-Source: AGHT+IH16zpiU95DJaM6wFKw6n+sbDu1FQuAks84hQE41aM4Gmg2toWfizMwHg+OJsBwLnEVKdRuDlzyo3Y6k2SKouw=
X-Received: by 2002:a17:902:e881:b0:24e:2ede:f9c3 with SMTP id
 d9443c01a7336-2516ec6f1cfmr221728575ad.25.1757515613739; Wed, 10 Sep 2025
 07:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013542.4187488-1-tweek@google.com> <CAEjxPJ5L2hQdE6M7hkTXwqNJ3a9OQoqB9i5KL5iU00B3saxOrQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5L2hQdE6M7hkTXwqNJ3a9OQoqB9i5KL5iU00B3saxOrQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:46:41 -0400
X-Gm-Features: Ac12FXyEh1kiO5hM4nwC9KgHsH8ucE49bD6vEYAgWH1vuV88LKtvokDGLkLOX7E
Message-ID: <CAEjxPJ42z9o4O-Yof3wJ9wdtguXRzBeVTW-fR81vm6UkPtpF2A@mail.gmail.com>
Subject: Re: [PATCH v2] policy,tests: add tests for memfd_file class
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Morris <jmorris@namei.org>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, Sep 7, 2025 at 9:35=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > A new class "memfd_file" is introduced to the kernel in [1]. This class
> > is only used when the policy capability "memfd_class" is set. Add tests
> > to validate this new class:
> >
> >   1. Validate that memfd_create() requires the "create" permission.
> >   2. Validate that fexecve() on a memfd requires the "execute_no_trans"
> >      permission.
> >
> > This can be tested by modifying the policy with:
> >
> >   semodule -c -E base
> >   sed -i \
> >     -e 's/\((class user_namespace (create ))\)/\1\n(class memfd_file (e=
xecute_no_trans entrypoint ))\n(classcommon memfd_file file)/' \
> >     -e 's/\(anon_inode socket\)/memfd_file \1/' \
> >     base.cil
> >   echo "(policycap memfd_class)" >>base.cil
> >   semodule -X 456 -i base.cil
>
> No need to re-spin just for this, but for future reference, I'd just
> do the echo to a separate file (e.g. memfdclass.cil) and append -i
> memfdclass.cil to the semodule command line,
> and I wouldn't bother specifying a priority (just let it use the
> default 400). The reason is that I usually do these via sudo and an
> echo with file redirect won't work as is when
> appending to the root-owned base.cil file created by the earlier
> semodule -c -E base.
>
> >   rm -f base.cil
> >
> >   sed -i.orig \
> >     -e 's/\(define(`all_file_perms'\'',\)\(.*\)$/\1\2\ndefine(`all_memf=
d_file_perms'\'',\2/' \
> >     -e 's/\(class file all_file_perms;\)/\1\nclass memfd_file all_memfd=
_file_perms;/' \
> >     /usr/share/selinux/devel/include/support/all_perms.spt
>
> Likewise, no need to re-spin just for this, but I'd then say to run
> "semodule -r base memfdclass" and
> restore the all_perms.spt.org file to all_perms.spt.
>
> >
> > [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@goog=
le.com/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied.

>
> > ---
> > Changelog since v1:
> > - Add commands to test the policy to the commit message.
> > - Only check for class and capability to include the new tests.
> > - Ran check-syntax.
> >
> >  policy/Makefile             |  5 ++++
> >  policy/test_memfd.te        | 25 +++++++++++++++++
> >  tests/Makefile              |  5 ++++
> >  tests/memfd/Makefile        |  5 ++++
> >  tests/memfd/memfd.c         | 24 +++++++++++++++++
> >  tests/memfd/memfd_fexecve.c | 53 +++++++++++++++++++++++++++++++++++++
> >  tests/memfd/nothing.c       |  6 +++++
> >  tests/memfd/test            | 41 ++++++++++++++++++++++++++++
> >  8 files changed, 164 insertions(+)
> >  create mode 100644 policy/test_memfd.te
> >  create mode 100644 tests/memfd/Makefile
> >  create mode 100644 tests/memfd/memfd.c
> >  create mode 100644 tests/memfd/memfd_fexecve.c
> >  create mode 100644 tests/memfd/nothing.c
> >  create mode 100755 tests/memfd/test
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index ffd774d..520f891 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -163,6 +163,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KE=
RNEL_POLICY) -ge 30 ] && [ -f
> >  TARGETS +=3D test_nlmsg.te
> >  endif
> >
> > +# memfd_file test dependencies: memfd_file class, memfd_class capabili=
ty
> > +ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(S=
ELINUXFS)/policy_capabilities/memfd_class && echo true),true)
> > +TARGETS +=3D test_memfd.te
> > +endif
> > +
> >  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> >  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.t=
e, $(TARGETS))
> >  endif
> > diff --git a/policy/test_memfd.te b/policy/test_memfd.te
> > new file mode 100644
> > index 0000000..5ca1348
> > --- /dev/null
> > +++ b/policy/test_memfd.te
> > @@ -0,0 +1,25 @@
> > +########################################
> > +#
> > +# Policy for testing memfd_file.
> > +
> > +attribute memfdtestdomain;
> > +
> > +type test_memfd_t;
> > +typeattribute test_memfd_t memfdtestdomain;
> > +testsuite_domain_type(test_memfd_t);
> > +allow test_memfd_t self:memfd_file { create mmap_rw_file_perms };
> > +
> > +type test_memfd_nocreate_t;
> > +typeattribute test_memfd_nocreate_t memfdtestdomain;
> > +testsuite_domain_type(test_memfd_nocreate_t);
> > +allow test_memfd_nocreate_t self:memfd_file mmap_rw_file_perms;
> > +
> > +type test_memfd_with_exec_t;
> > +typeattribute test_memfd_with_exec_t memfdtestdomain;
> > +testsuite_domain_type(test_memfd_with_exec_t);
> > +allow test_memfd_with_exec_t self:memfd_file { create mmap_rw_file_per=
ms execute execute_no_trans };
> > +
> > +type test_memfd_with_noexec_t;
> > +typeattribute test_memfd_with_noexec_t memfdtestdomain;
> > +testsuite_domain_type(test_memfd_with_noexec_t);
> > +allow test_memfd_with_noexec_t self:memfd_file { create mmap_rw_file_p=
erms execute };
> > diff --git a/tests/Makefile b/tests/Makefile
> > index 7a6aace..903ab11 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -158,6 +158,11 @@ ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KE=
RNEL_POLICY) -ge 30 ] && [ -f
> >  SUBDIRS +=3D nlmsg
> >  endif
> >
> > +# memfd_file test dependencies: memfd_file class, memfd_class capabili=
ty
> > +ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(S=
ELINUXFS)/policy_capabilities/memfd_class && echo true),true)
> > +SUBDIRS +=3D memfd
> > +endif
> > +
> >  ifeq ($(DISTRO),RHEL4)
> >      SUBDIRS:=3D$(filter-out bounds dyntrace dyntrans inet_socket mmap =
nnp_nosuid overlay unix_socket, $(SUBDIRS))
> >  endif
> > diff --git a/tests/memfd/Makefile b/tests/memfd/Makefile
> > new file mode 100644
> > index 0000000..471900f
> > --- /dev/null
> > +++ b/tests/memfd/Makefile
> > @@ -0,0 +1,5 @@
> > +TARGETS=3Dmemfd nothing memfd_fexecve
> > +
> > +all: $(TARGETS)
> > +clean:
> > +       rm -f $(TARGETS)
> > diff --git a/tests/memfd/memfd.c b/tests/memfd/memfd.c
> > new file mode 100644
> > index 0000000..0d6f838
> > --- /dev/null
> > +++ b/tests/memfd/memfd.c
> > @@ -0,0 +1,24 @@
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <sys/mman.h>
> > +#include <unistd.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       int fd;
> > +       char *name =3D "mymemfd";
> > +
> > +       fd =3D memfd_create(name, 0);
> > +       if (fd < 0) {
> > +               perror("memfd_create");
> > +               exit(-1);
> > +       }
> > +
> > +       close(fd);
> > +       exit(0);
> > +}
> > diff --git a/tests/memfd/memfd_fexecve.c b/tests/memfd/memfd_fexecve.c
> > new file mode 100644
> > index 0000000..977081e
> > --- /dev/null
> > +++ b/tests/memfd/memfd_fexecve.c
> > @@ -0,0 +1,53 @@
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <unistd.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       int memfd_fd, exec_fd;
> > +       int len, written, rc;
> > +       char *name =3D "mymemfd";
> > +
> > +       if (argc !=3D 2) {
> > +               printf("Usage: %s <fexec_binary>\n", argv[0]);
> > +               exit(-1);
> > +       }
> > +
> > +       memfd_fd =3D memfd_create(name, 0);
> > +       if (memfd_fd < 0) {
> > +               perror("memfd_create");
> > +               exit(-1);
> > +       }
> > +
> > +       exec_fd =3D open(argv[1], O_RDONLY);
> > +       if (exec_fd < 0) {
> > +               perror("open");
> > +               exit(-1);
> > +       }
> > +
> > +       char buf[8192];
> > +       while ((len =3D read(exec_fd, buf, sizeof(buf))) > 0) {
> > +               written =3D write(memfd_fd, buf, len);
> > +               if (len !=3D written) {
> > +                       perror("read/write");
> > +                       exit(-1);
> > +               }
> > +       }
> > +       close(exec_fd);
> > +
> > +       char *empty_env[] =3D {NULL};
> > +       char *nothing_argv[] =3D {argv[1], NULL};
> > +
> > +       rc =3D fexecve(memfd_fd, nothing_argv, empty_env);
> > +
> > +       perror("fexecve");
> > +       exit(rc);
> > +}
> > diff --git a/tests/memfd/nothing.c b/tests/memfd/nothing.c
> > new file mode 100644
> > index 0000000..fc53d37
> > --- /dev/null
> > +++ b/tests/memfd/nothing.c
> > @@ -0,0 +1,6 @@
> > +#include <stdlib.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       return 0;
> > +}
> > diff --git a/tests/memfd/test b/tests/memfd/test
> > new file mode 100755
> > index 0000000..1b1e75f
> > --- /dev/null
> > +++ b/tests/memfd/test
> > @@ -0,0 +1,41 @@
> > +#!/usr/bin/perl
> > +#
> > +# This test exercises the memfd_class support
> > +#
> > +
> > +use Test;
> > +
> > +BEGIN {
> > +    $test_count =3D 4;
> > +    plan tests =3D> $test_count;
> > +}
> > +
> > +$basedir =3D $0;
> > +$basedir =3D~ s|(.*)/[^/]*|$1|;
> > +
> > +#
> > +# Attempt to call memfd_create() from the allowed domain.
> > +#
> > +$result =3D system "runcon -t test_memfd_t -- $basedir/memfd 2>&1";
> > +ok( $result, 0 );
> > +
> > +#
> > +# Attempt to call memfd_create() from the not-allowed domain.
> > +#
> > +$result =3D system "runcon -t test_memfd_nocreate_t -- $basedir/memfd =
2>&1";
> > +ok($result);
> > +
> > +#
> > +# Attempt to fexecve() on a memfd_create() fd from the allowed domain.
> > +#
> > +$result =3D system
> > +"runcon -t test_memfd_with_exec_t -- $basedir/memfd_fexecve $basedir/n=
othing 2>&1";
> > +ok( $result, 0 );
> > +
> > +#
> > +# Attempt to fexecve() on a memfd_create() fd from the not-allowed dom=
ain.
> > +#
> > +$result =3D system
> > +"runcon -t test_memfd_with_noexec_t -- $basedir/memfd_fexecve $basedir=
/nothing 2>&1";
> > +ok($result);
> > +exit;
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
