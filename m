Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C192DC432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4342067D
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 09:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH/Rwl/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfKRJKe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:10:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726460AbfKRJKd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 04:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574068231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpLLxozGusakYgsEuCZOKjgstbdLNNdTi5vyKO2W7Gg=;
        b=KH/Rwl/bBQEFDF05SshlwUUH/ExfOPOpW1xU/jupQdpq5jBSfzNlcwqmE0Uek5bjO0GBN/
        crY3OxBXY5DsQlxyT8f9W5aQvbKqaiDJQYP3Qpha2nzHoMY3IjvwB4HU/eXjruxwlA6IgK
        aUTOqnU2bREJdAt0hHmd0YvBfwHz3sE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-kmO6X3VENiOcUAvU7o1WRw-1; Mon, 18 Nov 2019 04:10:30 -0500
Received: by mail-oi1-f199.google.com with SMTP id j23so8403951oii.21
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 01:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dd4vUfVEEdD3OyaIw8zHcuvVIUufjBCVRO86xXv4Q8k=;
        b=Ujwe2FaN2VPLdM9T9FGQkZ/q2zoNMhL59OI7VahUBHf1BnUjUQet4OZlbw/eZu6sLZ
         3598QsI1M3tHTJaobGTd3Dzv7IuVxYXWwGuIwbD95560zQSfSeKWP3j06SaZ5x+6Q+cC
         PbLGk8xFMb4+SCjTw9QwfTiwKM6T/rfo5oGhpqVxw1JPYuCinDT4pFkUgsoU5u2TNphi
         PMhfOa9jHfbWrOHWRHwgphlo1so/oRKExNb/sU6VeKGwWVkQcDkA+VdEyX8Pzg4OUDOm
         /+ayIrHveaIALHtOAE2eC7h2/nkMkRe7ZSgyyyZu3ybSx4SAtO577e14B/gDcpXqLNV4
         GgJw==
X-Gm-Message-State: APjAAAUZVgRlX0WQNcYO0kkitc29NxvKp0NPllZQj1WUoE/XXV3Agb9i
        jWHp1CN1kS5FkFJx9unBLeWvAoIZPRfc17i8mwegcUgx9I4lkj/h5ShQAVhxZOT/Q+VGdL+tNy9
        PEGfNjI7StX7nc7ntNnOjX0IADpaW53z3bw==
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr21623099otn.66.1574068229617;
        Mon, 18 Nov 2019 01:10:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9i+QCcjp0vnTz5Bc5jAM+RHXMLYjx2ZyMNmMUlSzXWT4zviVxNAJv5z0Ym0C+UqmTQhmP5J5cNj7YGz1HZa8=
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr21623068otn.66.1574068229077;
 Mon, 18 Nov 2019 01:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20191115114429.18566-1-richard_c_haines@btinternet.com>
In-Reply-To: <20191115114429.18566-1-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 18 Nov 2019 10:10:20 +0100
Message-ID: <CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com>
Subject: Re: [PATCH V2] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: kmO6X3VENiOcUAvU7o1WRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A couple comments below...

On Fri, Nov 15, 2019 at 12:44 PM Richard Haines
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
>
>  policy/Makefile                           |   4 +
>  policy/test_module_load.te                | 118 +++++++++++++++++++++
>  tests/Makefile                            |   4 +
>  tests/module_load/.gitignore              |  11 ++
>  tests/module_load/Makefile                |  12 +++
>  tests/module_load/finit_load.c            |  94 +++++++++++++++++
>  tests/module_load/init_load.c             | 121 ++++++++++++++++++++++
>  tests/module_load/setest_module_load.c    |  18 ++++
>  tests/module_load/setest_module_request.c |  22 ++++
>  tests/module_load/test                    |  62 +++++++++++
>  10 files changed, 466 insertions(+)
>  create mode 100644 policy/test_module_load.te
>  create mode 100644 tests/module_load/.gitignore
>  create mode 100644 tests/module_load/Makefile
>  create mode 100644 tests/module_load/finit_load.c
>  create mode 100644 tests/module_load/init_load.c
>  create mode 100644 tests/module_load/setest_module_load.c
>  create mode 100644 tests/module_load/setest_module_request.c
>  create mode 100755 tests/module_load/test
>
> diff --git a/policy/Makefile b/policy/Makefile
> index ff65153..545f3b5 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -90,6 +90,10 @@ ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/=
include/support/all_perms.
>  TARGETS+=3Dtest_notify.te
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
> index 0000000..566ddf7
> --- /dev/null
> +++ b/policy/test_module_load.te
> @@ -0,0 +1,118 @@
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
> +#
> +############# Test kernel modules with finitmod_module(2) ##############=
#####
> +#
> +attribute finitmoddomain;
> +
> +type test_finitmod_t;
> +module_domain_type(test_finitmod_t)
> +unconfined_runs_test(test_finitmod_t)
> +typeattribute test_finitmod_t testdomain;
> +typeattribute test_finitmod_t finitmoddomain;
> +
> +allow test_finitmod_t self:capability { sys_module };
> +allow test_finitmod_t test_file_t:system { module_load };
> +allow test_finitmod_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_finitmod_deny_sys_module_t;
> +module_domain_type(test_finitmod_deny_sys_module_t)
> +unconfined_runs_test(test_finitmod_deny_sys_module_t)
> +typeattribute test_finitmod_deny_sys_module_t testdomain;
> +typeattribute test_finitmod_deny_sys_module_t finitmoddomain;
> +
> +neverallow test_finitmod_deny_sys_module_t self:capability { sys_module =
};
> +
> +############### Deny sys module_load ######################
> +type test_finitmod_deny_module_load_t;
> +module_domain_type(test_finitmod_deny_module_load_t)
> +unconfined_runs_test(test_finitmod_deny_module_load_t)
> +typeattribute test_finitmod_deny_module_load_t testdomain;
> +typeattribute test_finitmod_deny_module_load_t finitmoddomain;
> +
> +allow test_finitmod_deny_module_load_t self:capability { sys_module };
> +neverallow test_finitmod_deny_module_load_t test_file_t:system { module_=
load };
> +
> +############### Deny sys module_request ######################
> +type test_finitmod_deny_module_request_t;
> +module_domain_type(test_finitmod_deny_module_request_t)
> +unconfined_runs_test(test_finitmod_deny_module_request_t)
> +typeattribute test_finitmod_deny_module_request_t testdomain;
> +typeattribute test_finitmod_deny_module_request_t finitmoddomain;
> +
> +allow test_finitmod_deny_module_request_t self:capability { sys_module }=
;
> +allow test_finitmod_deny_module_request_t test_file_t:system { module_lo=
ad };
> +neverallow test_finitmod_deny_module_request_t kernel_t:system { module_=
request };
> +
> +#
> +############# Test kernel modules with initmod_module(2) ###############=
####
> +#
> +attribute initmoddomain;
> +
> +type test_initmod_t;
> +module_domain_type(test_initmod_t)
> +unconfined_runs_test(test_initmod_t)
> +typeattribute test_initmod_t testdomain;
> +typeattribute test_initmod_t initmoddomain;
> +
> +allow test_initmod_t self:capability { sys_module };
> +allow test_initmod_t self:system { module_load };
> +allow test_initmod_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_initmod_deny_sys_module_t;
> +module_domain_type(test_initmod_deny_sys_module_t)
> +unconfined_runs_test(test_initmod_deny_sys_module_t)
> +typeattribute test_initmod_deny_sys_module_t testdomain;
> +typeattribute test_initmod_deny_sys_module_t initmoddomain;
> +
> +neverallow test_initmod_deny_sys_module_t self:capability { sys_module }=
;
> +
> +############### Deny sys module_load ######################
> +type test_initmod_deny_module_load_t;
> +module_domain_type(test_initmod_deny_module_load_t)
> +unconfined_runs_test(test_initmod_deny_module_load_t)
> +typeattribute test_initmod_deny_module_load_t testdomain;
> +typeattribute test_initmod_deny_module_load_t initmoddomain;
> +
> +allow test_initmod_deny_module_load_t self:capability { sys_module };
> +neverallow test_initmod_deny_module_load_t self:system { module_load };
> +
> +############### Deny sys module_request ######################
> +type test_initmod_deny_module_request_t;
> +module_domain_type(test_initmod_deny_module_request_t)
> +unconfined_runs_test(test_initmod_deny_module_request_t)
> +typeattribute test_initmod_deny_module_request_t testdomain;
> +typeattribute test_initmod_deny_module_request_t initmoddomain;
> +
> +allow test_initmod_deny_module_request_t self:capability { sys_module };
> +allow test_initmod_deny_module_request_t self:system { module_load };
> +neverallow test_initmod_deny_module_request_t kernel_t:system { module_r=
equest };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain #######=
#####
> +#
> +miscfiles_domain_entry_test_files(finitmoddomain)
> +userdom_sysadm_entry_spec_domtrans_to(finitmoddomain)
> +miscfiles_domain_entry_test_files(initmoddomain)
> +userdom_sysadm_entry_spec_domtrans_to(initmoddomain)

It seems that the finitmoddomain and initmoddomain type sets are
exactly the same except for names - can they be merged into just one
set of types? The AVC denials should be still easily distinguishable
by the comm=3D field if that's the intended purpose of the separation.

[...]

> diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> new file mode 100644
> index 0000000..c561685
> --- /dev/null
> +++ b/tests/module_load/Makefile
> @@ -0,0 +1,12 @@
> +obj-m =3D setest_module_load.o setest_module_request.o
> +
> +TARGETS =3D finit_load init_load
> +LDLIBS +=3D -lselinux
> +KDIR =3D /usr/src/kernels/$(shell uname -r)

I think you should rather use /lib/modules/$(shell uname -r)/build
here, which seems to be more portable (it works at least on Fedora and
Ubuntu, while /usr/src/kernels/... doesn't work at least on Ubuntu).

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
> index 0000000..029c698
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
> +       int opt, result, fd;
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
> +       result =3D getcon(&context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain process context\n");
> +               close(fd);
> +               exit(-1);
> +       }
> +
> +       if (verbose)
> +               printf("Process context:\n\t%s\n", context);
> +
> +       free(context);

Why not wrap also the getcon() & free() calls under the 'if (verbose)
{ ... }'? The context is not used in the non-verbose case.

> +
> +       result =3D syscall(__NR_finit_module, fd, "", 0);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to load '%s' module: %s\n",
> +                       file_name, strerror(errno));
> +               close(fd);
> +               /* Denying: sys_module=3DEPERM, module_load=3DEACCES */
> +               exit(errno);
> +       }
> +       close(fd);
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
> index 0000000..5f9997b
> --- /dev/null
> +++ b/tests/module_load/init_load.c
> @@ -0,0 +1,121 @@
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
> +       int opt, result, fd;
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
> +       result =3D getcon(&context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain process context\n");
> +               close(fd);
> +               exit(-1);
> +       }
> +
> +       if (verbose)
> +               printf("Process context:\n\t%s\n", context);
> +
> +       free(context);

Ditto here.

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

You should free 'elf_image' here.

> +               exit(-1);
> +       }
> +       close(fd);
> +
> +       result =3D syscall(__NR_init_module, elf_image, st.st_size, "");
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to load '%s' module: %s\n",
> +                       file_name, strerror(errno));

...and here as well. (In this case you can just move the
'free(elf_image);' below to before the syscall return value check.)1

> +               /* Denying: sys_module=3DEPERM, module_load & request=3DE=
ACCES */
> +               exit(errno);
> +       }
> +       free(elf_image);
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

[...]

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

