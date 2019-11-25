Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E72C432C3
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62A920823
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQOghNup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfKYJ2H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:28:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfKYJ2H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 04:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574674084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOCmbltmDldWUZ0lInOJKMFdL4+Gt3Hvq6qYfk7jyeM=;
        b=JQOghNupe1sWuL9btBo8EPBuqWAkd4mkqMlRAg6C9sRS29nuqo5NCIoiNQsnl3t6Nq/okT
        kSHk+yBF4WSUPzqMw9BluSJrJlXSyw6JV2zg9EZFEgo/YVIoSOsQKRrjig0yoNLIRt2QDB
        4I5JOUEf48KIRInjX+bAtU+H0LHWuH0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-aTvnd_0ROfCXTGLR5A_Y6Q-1; Mon, 25 Nov 2019 04:28:02 -0500
Received: by mail-ot1-f71.google.com with SMTP id g17so7781959otg.10
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2019 01:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGH6JnSYTNY5gpTTS6MtWorZp8Nkm+KS6+2l+C0L7lM=;
        b=Eet/jH+qAwIRSNT0EmznIpOLhH6yVKzGm2gbGeZb19On9g27Ufy2fa0nXV6W2TZ2KI
         8lfL7l29wwuS1PAvI6NXC3SqBmEu/BeB6wLaAOYEYEM5kAWIFc0tKObHKmOniuHbhPIn
         tv56Wq0dbRJQzxqGsOdhTEMrUrHnQJVaYXKTXYxB1FnqAKSzq9ZV9+RVl8C4t7Yzue7D
         JdIEp+lrjnIFwpYYMdnpIG2PMUD3fnE9HplUH8+p/zdz08EkjUNqKX8eXBwS7nGGoAgg
         X019i88KxAGSupwhqRS6ATn4VEGEAsPvs2OYdSORvx2xOjAoLP/yD+CaKBf3ff6eyYst
         8FXg==
X-Gm-Message-State: APjAAAVfrMaeHo2SX1c3RM9pK/Y9Kpkpvl3I0aV94plMPhoO6fCDtAcW
        VpzGERinahsXbzMGsyDmgmKhb9zjlRNDVcKy8VldDCusYXeoKuGegUkR7BKFYJoGeszEVrOxwpf
        IFRbyWBU5+aFePUFYfm/ePHk+YckrvCwUOQ==
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr19646363otn.66.1574674081437;
        Mon, 25 Nov 2019 01:28:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuM5scjWtlKNd+Xyb7j8yjA8cGL7YrVz8mkyZ51gPw6Uo3Ni+xZ16ICYBRdfhwUTKtm3TEer/RoYMJs/tp/ck=
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr19646344otn.66.1574674080986;
 Mon, 25 Nov 2019 01:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20191122164719.98943-1-richard_c_haines@btinternet.com>
In-Reply-To: <20191122164719.98943-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Nov 2019 10:28:02 +0100
Message-ID: <CAFqZXNt3DmsEDMNBtJRYLR=w7ZOfsBcF8pCE9k66B9YUZWTQxQ@mail.gmail.com>
Subject: Re: [PATCH V5] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: aTvnd_0ROfCXTGLR5A_Y6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 22, 2019 at 5:47 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Test kernel module loading permissions.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change:
> Check permission denial module_load versus module_request by using a
> test kernel module for each.
> Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd wh=
en
> building modules, therefore added to Makefile and .gitignore.
> V3 Changes:
> As requested in [1] except policy change, coalesced type attributes inste=
ad.
> V4 Change:
> Combine the original initmoddoman and finitmoddomain type
> attribute for both sets of types
> V5 Change:
> Do not run on kernels < 4.7 as module loading not supported.
>
> [1] https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo=
78s+geSsBok8=3DQ@mail.gmail.com/
>
>  policy/Makefile                           |   4 +
>  policy/test_module_load.te                |  72 +++++++++++++
>  tests/Makefile                            |   6 ++
>  tests/module_load/.gitignore              |  11 ++
>  tests/module_load/Makefile                |  12 +++
>  tests/module_load/finit_load.c            |  94 +++++++++++++++++
>  tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
>  tests/module_load/setest_module_load.c    |  18 ++++
>  tests/module_load/setest_module_request.c |  22 ++++
>  tests/module_load/test                    |  62 +++++++++++
>  10 files changed, 424 insertions(+)
>  create mode 100644 policy/test_module_load.te
>  create mode 100644 tests/module_load/.gitignore
>  create mode 100644 tests/module_load/Makefile
>  create mode 100644 tests/module_load/finit_load.c
>  create mode 100644 tests/module_load/init_load.c
>  create mode 100644 tests/module_load/setest_module_load.c
>  create mode 100644 tests/module_load/setest_module_request.c
>  create mode 100755 tests/module_load/test

Thank you!

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

>
> diff --git a/policy/Makefile b/policy/Makefile
> index ad94c43..25dfb69 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -94,6 +94,10 @@ ifeq ($(shell grep -q key_socket $(POLDEV)/include/sup=
port/all_perms.spt && echo
>  TARGETS +=3D test_key_socket.te
>  endif
>
> +ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.sp=
t && echo true),true)
> +TARGETS+=3Dtest_module_load.te
> +endif
> +
>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te,=
 $(TARGETS))
>  endif
> diff --git a/policy/test_module_load.te b/policy/test_module_load.te
> new file mode 100644
> index 0000000..ec8be67
> --- /dev/null
> +++ b/policy/test_module_load.te
> @@ -0,0 +1,72 @@
> +############# Test kernel modules ###################
> +#
> +attribute kmoduledomain;
> +
> +#
> +############################## Define Macro ############################=
####
> +#
> +# Replace domain_type() macro as it hides some relevant denials in audit=
.log
> +#
> +gen_require(`
> +       type setrans_var_run_t, syslogd_t;
> +')
> +
> +define(`module_domain_type',`
> +       allow $1 proc_t:dir { search };
> +       allow $1 proc_t:lnk_file { read };
> +       allow $1 self:dir { search };
> +       allow $1 self:file { open read write };
> +       dontaudit init_t syslogd_t:fd use;
> +       dontaudit $1 security_t:filesystem getattr;
> +       dontaudit $1 self:file getattr;
> +       dontaudit $1 setrans_var_run_t:dir search;
> +       dontaudit unconfined_t $1:process { noatsecure rlimitinh siginh }=
;
> +')
> +
> +############# Test finit_module(2) / init_module(2) ####################
> +type test_kmodule_t;
> +module_domain_type(test_kmodule_t)
> +unconfined_runs_test(test_kmodule_t)
> +typeattribute test_kmodule_t testdomain, kmoduledomain;
> +
> +allow test_kmodule_t self:capability { sys_module };
> +# Required for finit_module(2):
> +allow test_kmodule_t test_file_t:system { module_load };
> +# Required for init_module(2):
> +allow test_kmodule_t self:system { module_load };
> +allow test_kmodule_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_kmodule_deny_sys_module_t;
> +module_domain_type(test_kmodule_deny_sys_module_t)
> +unconfined_runs_test(test_kmodule_deny_sys_module_t)
> +typeattribute test_kmodule_deny_sys_module_t testdomain, kmoduledomain;
> +
> +neverallow test_kmodule_deny_sys_module_t self:capability { sys_module }=
;
> +
> +############### Deny sys module_load ######################
> +type test_kmodule_deny_module_load_t;
> +module_domain_type(test_kmodule_deny_module_load_t)
> +unconfined_runs_test(test_kmodule_deny_module_load_t)
> +typeattribute test_kmodule_deny_module_load_t testdomain, kmoduledomain;
> +
> +allow test_kmodule_deny_module_load_t self:capability { sys_module };
> +neverallow test_kmodule_deny_module_load_t test_file_t:system { module_l=
oad };
> +neverallow test_kmodule_deny_module_load_t self:system { module_load };
> +
> +############### Deny sys module_request ######################
> +type test_kmodule_deny_module_request_t;
> +module_domain_type(test_kmodule_deny_module_request_t)
> +unconfined_runs_test(test_kmodule_deny_module_request_t)
> +typeattribute test_kmodule_deny_module_request_t testdomain, kmoduledoma=
in;
> +
> +allow test_kmodule_deny_module_request_t self:capability { sys_module };
> +allow test_kmodule_deny_module_request_t test_file_t:system { module_loa=
d };
> +allow test_kmodule_deny_module_request_t self:system { module_load };
> +neverallow test_kmodule_deny_module_request_t kernel_t:system { module_r=
equest };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain #######=
#####
> +#
> +miscfiles_domain_entry_test_files(kmoduledomain)
> +userdom_sysadm_entry_spec_domtrans_to(kmoduledomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index cca6648..1cdb1ac 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -72,6 +72,12 @@ ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/=
include/support/all_perms.
>  SUBDIRS+=3Dnotify
>  endif
>
> +ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.sp=
t && echo true),true)
> +ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> +SUBDIRS+=3Dmodule_load
> +endif
> +endif
> +
>  ifeq ($(DISTRO),RHEL4)
>      SUBDIRS:=3D$(filter-out bounds dyntrace dyntrans inet_socket mmap nn=
p_nosuid overlay unix_socket, $(SUBDIRS))
>  endif
> diff --git a/tests/module_load/.gitignore b/tests/module_load/.gitignore
> new file mode 100644
> index 0000000..7fa5772
> --- /dev/null
> +++ b/tests/module_load/.gitignore
> @@ -0,0 +1,11 @@
> +finit_load
> +init_load
> +modules.order
> +Module.symvers
> +*.a
> +*.o
> +*.ko
> +*.cmd
> +*.mod
> +*.mod.c
> +.*.cmd
> diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> new file mode 100644
> index 0000000..b6eba25
> --- /dev/null
> +++ b/tests/module_load/Makefile
> @@ -0,0 +1,12 @@
> +obj-m =3D setest_module_load.o setest_module_request.o
> +
> +TARGETS =3D finit_load init_load
> +LDLIBS +=3D -lselinux
> +KDIR =3D /lib/modules/$(shell uname -r)/build
> +
> +all: $(TARGETS)
> +       $(MAKE) -C $(KDIR) M=3D$(PWD)
> +
> +clean:
> +       rm -f $(TARGETS)
> +       rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers modu=
les.order
> diff --git a/tests/module_load/finit_load.c b/tests/module_load/finit_loa=
d.c
> new file mode 100644
> index 0000000..1c05d7b
> --- /dev/null
> +++ b/tests/module_load/finit_load.c
> @@ -0,0 +1,94 @@
> +#define _GNU_SOURCE 1
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <sys/syscall.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progfile_name)
> +{
> +       fprintf(stderr,
> +               "usage:  %s [-v] path name\n"
> +               "Where:\n\t"
> +               "-v    Print information.\n\t"
> +               "path  Kernel module build path.\n\t"
> +               "name  Name of kernel module to load.\n", progfile_name);
> +       exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       char *context, file_name[PATH_MAX];
> +       int opt, result, fd, s_errno;
> +       bool verbose =3D false;
> +
> +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> +               switch (opt) {
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               default:
> +                       print_usage(argv[0]);
> +               }
> +       }
> +
> +       if (optind >=3D argc)
> +               print_usage(argv[0]);
> +
> +       result =3D sprintf(file_name, "%s/%s.ko", argv[optind],
> +                        argv[optind + 1]);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed sprintf\n");
> +               exit(-1);
> +       }
> +
> +       fd =3D open(file_name, O_RDONLY);
> +       if (!fd) {
> +               fprintf(stderr, "Failed to open %s: %s\n",
> +                       file_name, strerror(errno));
> +               exit(-1);
> +       }
> +
> +       if (verbose) {
> +               result =3D getcon(&context);
> +               if (result < 0) {
> +                       fprintf(stderr, "Failed to obtain process context=
\n");
> +                       close(fd);
> +                       exit(-1);
> +               }
> +
> +               printf("Process context:\n\t%s\n", context);
> +               free(context);
> +       }
> +
> +       result =3D syscall(__NR_finit_module, fd, "", 0);
> +       s_errno =3D errno;
> +       close(fd);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to load '%s' module: %s\n",
> +                       file_name, strerror(s_errno));
> +               /* Denying: sys_module=3DEPERM, module_load=3DEACCES */
> +               exit(s_errno);
> +       }
> +
> +       if (verbose)
> +               printf("Loaded kernel module:  %s\n", file_name);
> +
> +       result =3D syscall(__NR_delete_module, argv[optind + 1], 0);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to delete '%s' module: %s\n",
> +                       argv[optind + 1], strerror(errno));
> +               exit(-1);
> +       }
> +
> +       if (verbose)
> +               printf("Deleted kernel module: %s\n", argv[optind + 1]);
> +
> +       return 0;
> +}
> diff --git a/tests/module_load/init_load.c b/tests/module_load/init_load.=
c
> new file mode 100644
> index 0000000..0422c19
> --- /dev/null
> +++ b/tests/module_load/init_load.c
> @@ -0,0 +1,123 @@
> +#define _GNU_SOURCE 1
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <selinux/selinux.h>
> +
> +static void print_usage(char *progfile_name)
> +{
> +       fprintf(stderr,
> +               "usage:  %s [-v] path name\n"
> +               "Where:\n\t"
> +               "-v    Print information.\n\t"
> +               "path  Kernel module build path.\n\t"
> +               "name  Name of kernel module to load.\n", progfile_name);
> +       exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       char *context, file_name[PATH_MAX];
> +       int opt, result, fd, s_errno;
> +       bool verbose =3D false;
> +       void *elf_image;
> +       struct stat st;
> +
> +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> +               switch (opt) {
> +               case 'v':
> +                       verbose =3D true;
> +                       break;
> +               default:
> +                       print_usage(argv[0]);
> +               }
> +       }
> +
> +       if (optind >=3D argc)
> +               print_usage(argv[0]);
> +
> +       result =3D sprintf(file_name, "%s/%s.ko", argv[optind],
> +                        argv[optind + 1]);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed sprintf\n");
> +               exit(-1);
> +       }
> +
> +       fd =3D open(file_name, O_RDONLY);
> +       if (!fd) {
> +               fprintf(stderr, "Failed to open %s: %s\n",
> +                       file_name, strerror(errno));
> +               exit(-1);
> +       }
> +
> +       if (verbose) {
> +               result =3D getcon(&context);
> +               if (result < 0) {
> +                       fprintf(stderr, "Failed to obtain process context=
\n");
> +                       close(fd);
> +                       exit(-1);
> +               }
> +
> +               printf("Process context:\n\t%s\n", context);
> +               free(context);
> +       }
> +
> +       result =3D fstat(fd, &st);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed fstat on %s: %s\n",
> +                       file_name, strerror(errno));
> +               close(fd);
> +               exit(-1);
> +       }
> +
> +       elf_image =3D malloc(st.st_size);
> +       if (!elf_image) {
> +               fprintf(stderr, "Failed malloc on %s: %s\n",
> +                       file_name, strerror(errno));
> +               close(fd);
> +               exit(-1);
> +       }
> +
> +       result =3D read(fd, elf_image, st.st_size);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed read on %s: %s\n",
> +                       file_name, strerror(errno));
> +               close(fd);
> +               free(elf_image);
> +               exit(-1);
> +       }
> +       close(fd);
> +
> +       result =3D syscall(__NR_init_module, elf_image, st.st_size, "");
> +       s_errno =3D errno;
> +       free(elf_image);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to load '%s' module: %s\n",
> +                       file_name, strerror(s_errno));
> +               /* Denying: sys_module=3DEPERM, module_load & request=3DE=
ACCES */
> +               exit(s_errno);
> +       }
> +
> +       if (verbose)
> +               printf("Loaded kernel module:  %s\n", file_name);
> +
> +       result =3D syscall(__NR_delete_module, argv[optind + 1], 0);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to delete '%s' module: %s\n",
> +                       argv[optind + 1], strerror(errno));
> +               exit(-1);
> +       }
> +
> +       if (verbose)
> +               printf("Deleted kernel module: %s\n", argv[optind + 1]);
> +
> +       return 0;
> +}
> diff --git a/tests/module_load/setest_module_load.c b/tests/module_load/s=
etest_module_load.c
> new file mode 100644
> index 0000000..0be7a26
> --- /dev/null
> +++ b/tests/module_load/setest_module_load.c
> @@ -0,0 +1,18 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +
> +static int __init setest_module_load_init(void)
> +{
> +       pr_info("INIT - setest_module_load\n");
> +       return 0;
> +}
> +
> +static void __exit setest_module_load_exit(void)
> +{
> +       pr_info("EXIT - setest_module_load\n");
> +}
> +
> +module_init(setest_module_load_init);
> +module_exit(setest_module_load_exit);
> +MODULE_LICENSE("GPL");
> diff --git a/tests/module_load/setest_module_request.c b/tests/module_loa=
d/setest_module_request.c
> new file mode 100644
> index 0000000..f79d4ef
> --- /dev/null
> +++ b/tests/module_load/setest_module_request.c
> @@ -0,0 +1,22 @@
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +
> +static int __init setest_module_request_init(void)
> +{
> +       int result;
> +
> +       pr_info("INIT - setest_module_request\n");
> +       result =3D request_module_nowait("dummy-module");
> +       pr_info("request_module() returned: %d\n", result);
> +       return result;
> +}
> +
> +static void __exit setest_module_request_exit(void)
> +{
> +       pr_info("EXIT - setest_module_request\n");
> +}
> +
> +module_init(setest_module_request_init);
> +module_exit(setest_module_request_exit);
> +MODULE_LICENSE("GPL");
> diff --git a/tests/module_load/test b/tests/module_load/test
> new file mode 100755
> index 0000000..524b333
> --- /dev/null
> +++ b/tests/module_load/test
> @@ -0,0 +1,62 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir =3D $0;
> +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +    # allow info to be shown during tests
> +    $v =3D $ARGV[0];
> +    if ($v) {
> +        if ( $v ne "-v" ) {
> +            plan skip_all =3D> "Invalid option (use -v)";
> +        }
> +    }
> +    else {
> +        $v =3D " ";
> +    }
> +
> +    plan tests =3D> 8;
> +}
> +
> +print "Test finit_module(2)\n";
> +$result =3D system
> +"runcon -t test_kmodule_t $basedir/finit_load $v $basedir setest_module_=
request";
> +ok( $result eq 0 );
> +
> +# Deny capability { sys_module } - EPERM
> +$result =3D system
> +"runcon -t test_kmodule_deny_sys_module_t $basedir/finit_load $v $basedi=
r setest_module_load 2>&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny system { module_load } - EACCES
> +$result =3D system
> +"runcon -t test_kmodule_deny_module_load_t $basedir/finit_load $v $based=
ir setest_module_load 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny system { module_request } - EACCES
> +$result =3D system
> +"runcon -t test_kmodule_deny_module_request_t $basedir/finit_load $v $ba=
sedir setest_module_request 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +print "Test init_module(2)\n";
> +$result =3D system
> +"runcon -t test_kmodule_t $basedir/init_load $v $basedir setest_module_r=
equest";
> +ok( $result eq 0 );
> +
> +# Deny capability { sys_module } - EPERM
> +$result =3D system
> +"runcon -t test_kmodule_deny_sys_module_t $basedir/init_load $v $basedir=
 setest_module_load 2>&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny system { module_load } - EACCES
> +$result =3D system
> +"runcon -t test_kmodule_deny_module_load_t $basedir/init_load $v $basedi=
r setest_module_load 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny system { module_request } - EACCES
> +$result =3D system
> +"runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $bas=
edir setest_module_request 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +exit;
> --
> 2.23.0
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

