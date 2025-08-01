Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E21DAC92
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754073969; cv=none; b=P6nfRGhGw3p+xbQFMgWqp9WxPlyg2IAnlAFRgicZ9c+5ZMKcGTtOU9PzdSeioUirk99zL/XlWZR5YyEnLk2w8oVvOcVI1iQlL+unlMrGDqol5N36hVI9CVAhDlJKRGYkvmMaeRMVUq3PY0RinW2Tti2ZQTWet4q4jZ/UNm70bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754073969; c=relaxed/simple;
	bh=ySE7SvNpqP2Kaoi738qJeFVjXXxHxJmJc1LzGEgnq/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz/mMj8QDb6vD72uBObRsX9dkJhy6Xrw9+YuBgf8+rwC3ByE1GIWoHy/RvUk9InILoTiojhaYd717hCIMyq71p38GESJvt/JWkiUXcCqFhP/IlLxRV/rMx/pPfVeHh99D9pdwMyEklabjbFMx4nHahg7TATWFcGUZKfud/kxXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHUCTz82; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHUCTz82"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32117db952aso29737a91.0
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754073966; x=1754678766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f3uZ0aTYpHQFh3GYAlD4P8cMB7Ry6cevwz+YhFLAis=;
        b=GHUCTz82UjfR9DeIs8eOTfUGPAvwPuhXVQg/5gys0e87hxgC1Yjk3rZywmPKIFHQVj
         XkLcNxkCegR3Z3So9empqwmprYHrJPY8hreQjKs/eWaihUu/w/8E9Vzn+iXd6s2aSuUB
         yO09W3nXnCE1YMXqU4N8qqZRzPY/STcX62LFxhGo4XcvQ1+yT94/jHKhYCDgfpJEdqCF
         aHihGIxYQWXmDgtSOq0nPWgmOVIcBYrrqYqajlHl/mxqtTABgiOzgnB1MzPNRB0NFx7L
         hqYz30TNkIivRcAIHnn1cFUcGS0AZBjzYr3bj42mfrQjfDwQ/lHAdn7KTTGBKsGNDC/e
         salg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754073966; x=1754678766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f3uZ0aTYpHQFh3GYAlD4P8cMB7Ry6cevwz+YhFLAis=;
        b=r2rhZhqzqOeo6MdHfAk5Mb6mU4fDrwTRLCR+m4496M4aajs72+rbMEaceLkT9vJQ+v
         HsJA/rQL2jG3s84JMEN9itK0Ax3xq8oCarUuc8e8O3LFcGPOGKT4gIeHUqiwpfnHRrgA
         41Evpot8ao634vc8qUSWHfrsXZS4V3ngp9AUDF2qvLXTBSWi4uXApw90iZleemShpoiw
         OiUfkQCLPl8xCBy8vEQfXthv4hfPKPM1r8oAIBM/jw3ge5mhl3Lc9AwlK7h+MxXJeAAG
         huS4DaJxzc/gn5u1nJ2zP//Tcj523LyPtZ3GcITbdbMa6bBN3XS8ZXEcOKU4SqDmJjhZ
         BqjA==
X-Gm-Message-State: AOJu0YyGTJ2UEyf8+yS3arMc6FFtCeUvoltJAQtUY4ZlDEIEt34cmuGn
	GPRJniC9brjtddqCMGQ5eXtJbrO5eOB7WZDnPxGjF79g/fZf7mPXYp4KvdRWU9mdN5oHoZG73UU
	7Av3+/LGmFyskVDk3jCIsSGTbdI/C6HU9Xw==
X-Gm-Gg: ASbGncv31Ltg3WwUsqmIXwa+gItGywyLTTQjS5ZdHNooezeUfSCHnEwxlf/AKeCIO5P
	6Q+kfoRkJKCZn+X/a4jvn6OvUGK+UeYRbeftpKvIENTT59ULdcXLWnY2I75bGxhA0kyb8BaiTi/
	9wPzMrEXgq012F+C3Vls7/sjIGteVQjVaNGWRvd8FtZxgq11ABSJV2MlDWLAnHl1v3FmmCI6zex
	3fthwU=
X-Google-Smtp-Source: AGHT+IE8U9CFKLP0B1ssI2Jc0IpMzAVNMtv8q+kb0qEMCTYY3J8KHDZrYHHsY7LH0KPVKvSxcA0tlINwcBiUKBxoigM=
X-Received: by 2002:a17:90b:1650:b0:31e:f193:1822 with SMTP id
 98e67ed59e1d1-321162c8f2dmr951881a91.28.1754073966119; Fri, 01 Aug 2025
 11:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801155025.144118-1-danieldurning.work@gmail.com>
In-Reply-To: <20250801155025.144118-1-danieldurning.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 14:45:54 -0400
X-Gm-Features: Ac12FXw8s8QRaAf0sMwhbwvlEX0ENd_vgmt1K2YSjB3Okfc24gPdv1HFxBiWiHI
Message-ID: <CAEjxPJ7DBDnZEFvgpe58K4B+4kZdOqUGMHvGC2vKt-4Zget=Hg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: add tests for bpf token
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 11:50=E2=80=AFAM <danieldurning.work@gmail.com> wrot=
e:
>
> From: Daniel Durning <danieldurning.work@gmail.com>
>
> Added two tests using BPF tokens which will test the bpf_token_capable an=
d bpf_token_cmd LSM hooks.
>
> Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>

We will likely need to wrap these new tests with a conditional based
on whether the kernel has the requisite checks merged but we won't
know the proper kernel version against which to check until the kernel
patch is merged. You can look at binder/test for an example of such
kernel version comparisons and conditionals.

I am also unsure of the proper way to handle the BPF API changes for
this case, will defer to others who know more in this area.

Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_bpf.te     |  40 ++++
>  tests/bpf/Makefile     |   1 +
>  tests/bpf/bpf_common.c |  35 ++++
>  tests/bpf/bpf_common.h |   6 +
>  tests/bpf/bpf_test.c   |  42 +++-
>  tests/bpf/bpf_token.c  | 459 +++++++++++++++++++++++++++++++++++++++++
>  tests/bpf/test         |  20 +-
>  7 files changed, 594 insertions(+), 9 deletions(-)
>  create mode 100644 tests/bpf/bpf_token.c
>
> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
> index 5eab0bd..c62d6b0 100644
> --- a/policy/test_bpf.te
> +++ b/policy/test_bpf.te
> @@ -5,6 +5,9 @@
>  attribute bpfdomain;
>
>  ################################### Main ###############################=
####
> +require {
> +    type bpf_t;
> +}
>  type test_bpf_t;
>  testsuite_domain_type(test_bpf_t)
>  typeattribute test_bpf_t bpfdomain;
> @@ -12,6 +15,13 @@ typeattribute test_bpf_t bpfdomain;
>  allow test_bpf_t self:process { setrlimit };
>  allow test_bpf_t self:capability { sys_resource sys_admin };
>  allow test_bpf_t self:bpf { map_create map_read map_write prog_load prog=
_run };
> +allow test_bpf_t self:cap2_userns bpf;
> +files_mounton_rootfs(test_bpf_t)
> +fs_list_bpf_dirs(test_bpf_t)
> +allow test_bpf_t self:cap_userns { setgid setuid sys_admin };
> +allow test_bpf_t self:user_namespace create;
> +allow test_bpf_t bpf_t:filesystem mount;
> +allow test_bpf_t self:cap_userns net_admin;
>
>  ############################## Deny map_create #########################=
####
>  type test_bpf_deny_map_create_t;
> @@ -57,3 +67,33 @@ typeattribute test_bpf_deny_prog_run_t bpfdomain;
>  allow test_bpf_deny_prog_run_t self:process { setrlimit };
>  allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin =
};
>  allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write =
prog_load };
> +
> +############################# Deny token_cap ###########################=
####
> +type test_bpf_deny_token_cap_t;
> +testsuite_domain_type(test_bpf_deny_token_cap_t)
> +typeattribute test_bpf_deny_token_cap_t bpfdomain;
> +
> +allow test_bpf_deny_token_cap_t self:process { setrlimit };
> +allow test_bpf_deny_token_cap_t self:capability { sys_resource sys_admin=
 };
> +allow test_bpf_deny_token_cap_t self:cap2_userns bpf;
> +allow test_bpf_deny_token_cap_t self:bpf { map_create map_read map_write=
 prog_load prog_run };
> +files_mounton_rootfs(test_bpf_deny_token_cap_t)
> +fs_list_bpf_dirs(test_bpf_deny_token_cap_t)
> +allow test_bpf_deny_token_cap_t self:cap_userns { setgid setuid sys_admi=
n };
> +allow test_bpf_deny_token_cap_t self:user_namespace create;
> +allow test_bpf_deny_token_cap_t bpf_t:filesystem mount;
> +
> +############################# Deny token_cmd ###########################=
####
> +type test_bpf_deny_token_cmd_t;
> +testsuite_domain_type(test_bpf_deny_token_cmd_t)
> +typeattribute test_bpf_deny_token_cmd_t bpfdomain;
> +
> +allow test_bpf_deny_token_cmd_t self:process { setrlimit };
> +allow test_bpf_deny_token_cmd_t self:capability { sys_resource sys_admin=
 };
> +allow test_bpf_deny_token_cmd_t self:cap2_userns bpf;
> +allow test_bpf_deny_token_cmd_t self:bpf { map_read map_write prog_load =
prog_run };
> +files_mounton_rootfs(test_bpf_deny_token_cmd_t)
> +fs_list_bpf_dirs(test_bpf_deny_token_cmd_t)
> +allow test_bpf_deny_token_cmd_t self:cap_userns { setgid setuid sys_admi=
n };
> +allow test_bpf_deny_token_cmd_t self:user_namespace create;
> +allow test_bpf_deny_token_cmd_t bpf_t:filesystem mount;
> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> index 1ae8ce9..610a420 100644
> --- a/tests/bpf/Makefile
> +++ b/tests/bpf/Makefile
> @@ -4,6 +4,7 @@ LDLIBS +=3D -lselinux -lbpf
>
>  # export so that BPF_ENABLED entries get built correctly on local build
>  export CFLAGS +=3D -DHAVE_BPF
> +export CFLAGS +=3D -D_GNU_SOURCE
>
>  BPF_ENABLED =3D ../fdreceive ../binder
>
> diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
> index 2d97299..97c4d2d 100644
> --- a/tests/bpf/bpf_common.c
> +++ b/tests/bpf/bpf_common.c
> @@ -1,4 +1,6 @@
> +#include <sched.h>
>  #include "bpf_common.h"
> +#include "bpf_token.c"
>
>  /*
>   * v0.7 deprecates some functions in favor of a new API (introduced in v=
0.6).
> @@ -58,6 +60,39 @@ int create_bpf_prog(void)
>         return prog_fd;
>  }
>
> +/*
> + * BPF tokens did not exist in the old API - just return 0 if on an olde=
r version.
> + */
> +int test_bpf_token_capable(void)
> +{
> +#ifdef USE_NEW_API
> +       struct bpffs_opts opts =3D {
> +               .cmds_str =3D "map_create",
> +               .maps_str =3D "xskmap",
> +       };
> +
> +       return create_bpf_token(&opts, map_test_bpf_token_capable);
> +
> +#else
> +       return 0;
> +#endif
> +}
> +
> +int test_bpf_token_cmd(void)
> +{
> +#ifdef USE_NEW_API
> +       struct bpffs_opts opts =3D {
> +               .cmds_str =3D "map_create",
> +               .maps_str =3D "stack",
> +       };
> +
> +       return create_bpf_token(&opts, map_test_bpf_token_cmd);
> +
> +#else
> +       return 0;
> +#endif
> +}
> +
>  /*
>   * The default RLIMIT_MEMLOCK is normally 64K, however BPF map/prog requ=
ires
>   * more than this (the actual threshold varying across arches) so set it=
 to
> diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
> index 44ac28f..ed34ab6 100644
> --- a/tests/bpf/bpf_common.h
> +++ b/tests/bpf/bpf_common.h
> @@ -8,9 +8,15 @@
>  #include <bpf/bpf.h>
>  #include <linux/bpf.h>
>  #include <sys/resource.h>
> +#include <sys/syscall.h>
> +#include <linux/unistd.h>
> +#include <sys/mount.h>
> +#include <fcntl.h>
>
>  extern int create_bpf_map(void);
>  extern int create_bpf_prog(void);
> +extern int test_bpf_token_capable(void);
> +extern int test_bpf_token_cmd(void);
>  extern void bpf_setrlimit(void);
>
>  /* edited eBPF instruction library */
> diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
> index 3c6a29c..ea7c02b 100644
> --- a/tests/bpf/bpf_test.c
> +++ b/tests/bpf/bpf_test.c
> @@ -7,22 +7,27 @@ static void usage(char *progname)
>                 "Where:\n\t"
>                 "-m    Create BPF map fd\n\t"
>                 "-p    Create BPF prog fd\n\t"
> +               "-c    Test BPF token capable\n\t"
> +               "-d    Test BPF token cmd\n\t"
>                 "-v Print information.\n", progname);
>         exit(-1);
>  }
>
>  int main(int argc, char *argv[])
>  {
> -       int opt, result, fd;
> +       int opt, result, ret;
> +       bool isFd =3D true;
>         bool verbose =3D false;
>         char *context;
>
>         enum {
>                 MAP_FD =3D 1,
> -               PROG_FD
> +               PROG_FD,
> +               TOKEN_CAP,
> +               TOKEN_CMD
>         } bpf_fd_type;
>
> -       while ((opt =3D getopt(argc, argv, "mpv")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "mpvcd")) !=3D -1) {
>                 switch (opt) {
>                 case 'm':
>                         bpf_fd_type =3D MAP_FD;
> @@ -30,6 +35,12 @@ int main(int argc, char *argv[])
>                 case 'p':
>                         bpf_fd_type =3D PROG_FD;
>                         break;
> +               case 'c':
> +                       bpf_fd_type =3D TOKEN_CAP;
> +                       break;
> +               case 'd':
> +                       bpf_fd_type =3D TOKEN_CMD;
> +                       break;
>                 case 'v':
>                         verbose =3D true;
>                         break;
> @@ -57,21 +68,36 @@ int main(int argc, char *argv[])
>                 if (verbose)
>                         printf("Creating BPF map\n");
>
> -               fd =3D create_bpf_map();
> +               ret =3D create_bpf_map();
>                 break;
>         case PROG_FD:
>                 if (verbose)
>                         printf("Creating BPF prog\n");
>
> -               fd =3D create_bpf_prog();
> +               ret =3D create_bpf_prog();
> +               break;
> +       case TOKEN_CAP:
> +               isFd =3D false;
> +               if (verbose)
> +                       printf("Creating token and testing bpf_token_capa=
ble\n");
> +
> +               ret =3D test_bpf_token_capable();
> +               break;
> +       case TOKEN_CMD:
> +               isFd =3D false;
> +               if (verbose)
> +                       printf("Creating token and testing bpf_token_cmd\=
n");
> +
> +               ret =3D test_bpf_token_cmd();
>                 break;
>         default:
>                 usage(argv[0]);
>         }
>
> -       if (fd < 0)
> -               return fd;
> +       if (ret < 0)
> +               return ret;
> +       else if (isFd)
> +               close(ret);
>
> -       close(fd);
>         return 0;
>  }
> diff --git a/tests/bpf/bpf_token.c b/tests/bpf/bpf_token.c
> new file mode 100644
> index 0000000..8e33383
> --- /dev/null
> +++ b/tests/bpf/bpf_token.c
> @@ -0,0 +1,459 @@
> +// Code derived from: linux/source/tools/testing/selftests/bpf/prog_test=
s/token.c
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "bpf_common.h"
> +#include <sys/socket.h>
> +#include <signal.h>
> +#include <sys/wait.h>
> +
> +struct bpffs_opts {
> +       __u64 cmds;
> +       __u64 maps;
> +       __u64 progs;
> +       __u64 attachs;
> +       const char *cmds_str;
> +       const char *maps_str;
> +       const char *progs_str;
> +       const char *attachs_str;
> +};
> +
> +static inline int sys_fsopen(const char *fsname, unsigned flags)
> +{
> +       return syscall(__NR_fsopen, fsname, flags);
> +}
> +
> +static inline int sys_fsconfig(int fs_fd, unsigned cmd, const char *key,
> +                              const void *val, int aux)
> +{
> +       return syscall(__NR_fsconfig, fs_fd, cmd, key, val, aux);
> +}
> +
> +static inline int sys_fsmount(int fs_fd, unsigned flags, unsigned ms_fla=
gs)
> +{
> +       return syscall(__NR_fsmount, fs_fd, flags, ms_flags);
> +}
> +
> +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> +{
> +       ssize_t ret;
> +
> +       do {
> +               ret =3D write(fd, buf, count);
> +       } while (ret < 0 && errno =3D=3D EINTR);
> +
> +       return ret;
> +}
> +
> +static int write_file(const char *path, const void *buf, size_t count)
> +{
> +       int fd;
> +       ssize_t ret;
> +
> +       fd =3D open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
> +       if (fd < 0)
> +               return -1;
> +
> +       ret =3D write_nointr(fd, buf, count);
> +       close(fd);
> +       if (ret < 0 || (size_t)ret !=3D count)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int wait_for_pid(pid_t pid)
> +{
> +       int status, ret;
> +
> +again:
> +       ret =3D waitpid(pid, &status, 0);
> +       if (ret =3D=3D -1) {
> +               if (errno =3D=3D EINTR)
> +                       goto again;
> +
> +               return -1;
> +       }
> +
> +       if (!WIFEXITED(status))
> +               return -1;
> +
> +       return WEXITSTATUS(status);
> +}
> +
> +static int sendfd(int sockfd, int fd)
> +{
> +       struct msghdr msg =3D {};
> +       struct cmsghdr *cmsg;
> +       int fds[1] =3D { fd }, err;
> +       char iobuf[1];
> +       struct iovec io =3D {
> +               .iov_base =3D iobuf,
> +               .iov_len =3D sizeof(iobuf),
> +       };
> +       union {
> +               char buf[CMSG_SPACE(sizeof(fds))];
> +               struct cmsghdr align;
> +       } u;
> +
> +       msg.msg_iov =3D &io;
> +       msg.msg_iovlen =3D 1;
> +       msg.msg_control =3D u.buf;
> +       msg.msg_controllen =3D sizeof(u.buf);
> +       cmsg =3D CMSG_FIRSTHDR(&msg);
> +       cmsg->cmsg_level =3D SOL_SOCKET;
> +       cmsg->cmsg_type =3D SCM_RIGHTS;
> +       cmsg->cmsg_len =3D CMSG_LEN(sizeof(fds));
> +       memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
> +
> +       err =3D sendmsg(sockfd, &msg, 0);
> +       if (err < 0) {
> +               err =3D -errno;
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int recvfd(int sockfd, int *fd)
> +{
> +       struct msghdr msg =3D {};
> +       struct cmsghdr *cmsg;
> +       int fds[1], err;
> +       char iobuf[1];
> +       struct iovec io =3D {
> +               .iov_base =3D iobuf,
> +               .iov_len =3D sizeof(iobuf),
> +       };
> +       union {
> +               char buf[CMSG_SPACE(sizeof(fds))];
> +               struct cmsghdr align;
> +       } u;
> +
> +       msg.msg_iov =3D &io;
> +       msg.msg_iovlen =3D 1;
> +       msg.msg_control =3D u.buf;
> +       msg.msg_controllen =3D sizeof(u.buf);
> +
> +       err =3D recvmsg(sockfd, &msg, 0);
> +       if (err < 0) {
> +               err =3D -errno;
> +               return err;
> +       }
> +
> +       cmsg =3D CMSG_FIRSTHDR(&msg);
> +
> +       memcpy(fds, CMSG_DATA(cmsg), sizeof(fds));
> +       *fd =3D fds[0];
> +
> +       return 0;
> +}
> +
> +static int create_and_enter_userns(void)
> +{
> +       uid_t uid;
> +       gid_t gid;
> +       char map[100];
> +
> +       uid =3D getuid();
> +       gid =3D getgid();
> +
> +       if (unshare(CLONE_NEWUSER))
> +               return -1;
> +
> +       if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1=
) &&
> +           errno !=3D ENOENT)
> +               return -1;
> +
> +       snprintf(map, sizeof(map), "0 %d 1", uid);
> +       if (write_file("/proc/self/uid_map", map, strlen(map)))
> +               return -1;
> +
> +
> +       snprintf(map, sizeof(map), "0 %d 1", gid);
> +       if (write_file("/proc/self/gid_map", map, strlen(map)))
> +               return -1;
> +
> +       if (setgid(0))
> +               return -1;
> +
> +       if (setuid(0))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +int set_delegate_mask(int fs_fd, const char *key, __u64 mask,
> +                     const char *mask_str)
> +{
> +       char buf[32];
> +       int err;
> +
> +       if (!mask_str) {
> +               if (mask =3D=3D ~0ULL) {
> +                       mask_str =3D "any";
> +               } else {
> +                       snprintf(buf, sizeof(buf), "0x%llx", (unsigned lo=
ng long)mask);
> +                       mask_str =3D buf;
> +               }
> +       }
> +
> +       err =3D sys_fsconfig(fs_fd, FSCONFIG_SET_STRING, key,
> +                          mask_str, 0);
> +       if (err < 0)
> +               err =3D -errno;
> +       return err;
> +}
> +
> +int create_bpffs_fd(void)
> +{
> +       int fs_fd;
> +
> +       fs_fd =3D sys_fsopen("bpf", 0);
> +
> +       return fs_fd;
> +}
> +
> +int materialize_bpffs_fd(int fs_fd, struct bpffs_opts *opts)
> +{
> +       int mnt_fd, err;
> +
> +       /* set up token delegation mount options */
> +       err =3D set_delegate_mask(fs_fd, "delegate_cmds", opts->cmds, opt=
s->cmds_str);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to set delegate dms: %s\n",
> +                       strerror(errno));
> +               return -errno;
> +       }
> +       err =3D set_delegate_mask(fs_fd, "delegate_maps", opts->maps, opt=
s->maps_str);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to set delegate maps: %s\n",
> +                       strerror(errno));
> +               return -errno;
> +       }
> +       err =3D set_delegate_mask(fs_fd, "delegate_progs", opts->progs, o=
pts->progs_str);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to set delegate progs: %s\n",
> +                       strerror(errno));
> +               return -errno;
> +       }
> +       err =3D set_delegate_mask(fs_fd, "delegate_attachs", opts->attach=
s,
> +                               opts->attachs_str);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to set delegate attachs: %s\n",
> +                       strerror(errno));
> +               return -errno;
> +       }
> +
> +       err =3D sys_fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed fsconfig: %s\n",
> +                       strerror(errno));
> +               return -errno;
> +       }
> +
> +       mnt_fd =3D sys_fsmount(fs_fd, 0, 0);
> +       if (mnt_fd < 0) {
> +               fprintf(stderr, "Failed fsmount: %s\n",
> +                       strerror(errno));
> +               return -errno;
> +       }
> +
> +       return mnt_fd;
> +}
> +
> +typedef int (*child_callback_fn)(int token_fd);
> +
> +static int token_child(int sock_fd, struct bpffs_opts *opts,
> +                      child_callback_fn callback)
> +{
> +       int fs_fd, mnt_fd, bpffs_fd, token_fd, err;
> +
> +       err =3D create_and_enter_userns();
> +       if (err < 0) {
> +               fprintf(stderr, "Failed enter_userns: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       err =3D unshare(CLONE_NEWNS);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed unshare: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       err =3D mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed mount: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       fs_fd =3D create_bpffs_fd();
> +       if (fs_fd < 0) {
> +               fprintf(stderr, "Failed create bpffs_fd: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       err =3D sendfd(sock_fd, fs_fd);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to send to parent over socket: %s=
\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       err =3D recvfd(sock_fd, &mnt_fd);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to receive from parent over socke=
t: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       bpffs_fd =3D openat(mnt_fd, ".", 0, O_RDWR);
> +       if (bpffs_fd < 0) {
> +               fprintf(stderr, "Failed openat: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       token_fd =3D bpf_token_create(bpffs_fd, NULL);
> +       if (token_fd < 0) {
> +               fprintf(stderr, "Failed bpf_token_create: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       err =3D callback(token_fd);
> +
> +cleanup:
> +       close(sock_fd);
> +       close(mnt_fd);
> +       close(fs_fd);
> +       close(bpffs_fd);
> +       close(token_fd);
> +       if (err < 0)
> +               exit(err);
> +       exit(0);
> +}
> +
> +static int token_parent(int child_pid, struct bpffs_opts *bpffs_opts,
> +                       int sock_fd)
> +{
> +       int fs_fd =3D -1, mnt_fd =3D -1, err;
> +
> +       err =3D recvfd(sock_fd, &fs_fd);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to receive from child: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       mnt_fd =3D materialize_bpffs_fd(fs_fd, bpffs_opts);
> +       if (mnt_fd < 0) {
> +               fprintf(stderr, "Failed materialize bpffs_fd: %s\n",
> +                       strerror(errno));
> +               err =3D mnt_fd;
> +               goto cleanup;
> +       }
> +       close(fs_fd);
> +
> +       /* pass BPF FS context object to parent */
> +       err =3D sendfd(sock_fd, mnt_fd);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to send to child: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +cleanup:
> +       close(sock_fd);
> +       close(fs_fd);
> +       close(mnt_fd);
> +       return err;
> +}
> +
> +int map_test_bpf_token_capable(int token_fd)
> +{
> +       int map_fd;
> +
> +       LIBBPF_OPTS(bpf_map_create_opts, optslib);
> +       optslib.map_flags =3D BPF_F_TOKEN_FD;
> +       optslib.token_fd =3D token_fd;
> +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_XSKMAP, NULL,
> +                               4, 4, 16, &optslib);
> +
> +       if (map_fd < 0) {
> +               fprintf(stderr, "Failed to create BPF map: %s\n",
> +                       strerror(errno));
> +       }
> +
> +       return map_fd;
> +}
> +
> +int map_test_bpf_token_cmd(int token_fd)
> +{
> +       int map_fd;
> +
> +       LIBBPF_OPTS(bpf_map_create_opts, optslib);
> +       optslib.map_flags =3D BPF_F_TOKEN_FD;
> +       optslib.token_fd =3D token_fd;
> +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_STACK, NULL,
> +                               0, 8, 1, &optslib);
> +
> +       if (map_fd < 0) {
> +               fprintf(stderr, "Failed to create BPF map: %s\n",
> +                       strerror(errno));
> +       }
> +
> +       return map_fd;
> +}
> +
> +int create_bpf_token(struct bpffs_opts *opts, child_callback_fn child_ca=
llback)
> +{
> +       int err, child_pid =3D 0;
> +       int sock_fds[2] =3D { -1, -1 };
> +
> +       err =3D socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds);
> +       if (err < 0) {
> +               fprintf(stderr, "Failed to create sockets: %s\n",
> +                       strerror(errno));
> +               goto cleanup;
> +       }
> +
> +       child_pid =3D fork();
> +       if (child_pid < 0) {
> +               fprintf(stderr, "Failed fork: %s\n",
> +                       strerror(errno));
> +               err =3D child_pid;
> +               goto cleanup;
> +       }
> +
> +       if (child_pid =3D=3D 0) {
> +               close(sock_fds[0]);
> +               err =3D token_child(sock_fds[1], opts, child_callback);
> +               if (err < 0) {
> +                       fprintf(stderr, "Child failed: %s\n",
> +                               strerror(errno));
> +               }
> +       } else {
> +               close(sock_fds[1]);
> +               err =3D token_parent(child_pid, opts, sock_fds[0]);
> +               if (err < 0) {
> +                       fprintf(stderr, "Parent failed: %s\n",
> +                               strerror(errno));
> +                       goto cleanup;
> +               }
> +               err =3D -(wait_for_pid(child_pid));
> +       }
> +
> +cleanup:
> +       close(sock_fds[0]);
> +       close(sock_fds[1]);
> +
> +       if (child_pid > 0)
> +               (void)kill(child_pid, SIGKILL);
> +
> +       return err;
> +}
> diff --git a/tests/bpf/test b/tests/bpf/test
> index a3fd856..5220700 100755
> --- a/tests/bpf/test
> +++ b/tests/bpf/test
> @@ -7,7 +7,7 @@ BEGIN {
>      $fdr_basedir    =3D "$basedir/../fdreceive";
>      $binder_basedir =3D "$basedir/../binder";
>
> -    $test_bpf_count       =3D 7;
> +    $test_bpf_count       =3D 11;
>      $test_fdreceive_count =3D 4;
>
>      $test_count =3D $test_bpf_count + $test_fdreceive_count;
> @@ -67,6 +67,14 @@ ok( $result eq 0 );
>  $result =3D system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
>  ok( $result eq 0 );
>
> +# BPF map with token - checks bpf_token_capable
> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -c $v";
> +ok( $result eq 0 );
> +
> +# BPF map with token - checks bpf_token_cmd
> +$result =3D system "runcon -t test_bpf_t $basedir/bpf_test -d $v";
> +ok( $result eq 0 );
> +
>  # Deny map_create permission
>  $result =3D
>    system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2=
>&1";
> @@ -92,6 +100,16 @@ $result =3D
>    system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&=
1";
>  ok($result);
>
> +# Deny token_cap permission
> +$result =3D
> +  system "runcon -t test_bpf_deny_token_cap_t $basedir/bpf_test -c $v 2>=
&1";
> +ok($result);
> +
> +# Deny token_cmd permission
> +$result =3D
> +  system "runcon -t test_bpf_deny_token_cmd_t $basedir/bpf_test -d $v 2>=
&1";
> +ok($result);
> +
>  #
>  ################ BPF Tests for fdreceive #######################
>  #
> --
> 2.50.1
>
