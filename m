Return-Path: <SRS0=8Pnr=ZO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE59CC43215
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DE420708
	for <selinux@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQhM3S0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfKVKk5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727556AbfKVKk4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Nov 2019 05:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574419254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcAIz4fJ1CzFLDUtDDhFcNpB63A3lR8LocEme/g0umA=;
        b=ZQhM3S0RynDW8Oo7HLijae0I8pqMEvv1IM9jpU23/cYKjgsxG949yY8KgXecfzIBvHhhNy
        MlerzSYg59blYkPCCMstJhyEyVp3m1DM7A0sgd5DaCijHJFdmkQQmBofLDzO603JhMvKtm
        epsohO8zeKgvURc2UR7yjH3gWxn+ANI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-rAOFZhOUNfqVOqATheXt2g-1; Fri, 22 Nov 2019 05:40:51 -0500
Received: by mail-oi1-f198.google.com with SMTP id x15so3411011oif.19
        for <selinux@vger.kernel.org>; Fri, 22 Nov 2019 02:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oQugWEGTepRZqn4YC++JP9ghpzWhi41vj+HSDtF5hk=;
        b=ks8cvkTvWbQJEbN8OQyV/765gy+IZDfisrldqWe07UUfpi7qR3l4TjZXP7RzQY6WrD
         Vf9VQCFHrGlwxVKKYj4aCVNvLhw/iytjujtOQ3wNrWux1rAd+8WFXMjJETxpaiWoxPgj
         qtaoFtxOeySzQOzcxPnUHp7zh+YotiOk1c+2UrInQelke5DaFtrhzIQQy6mtIJ812kFt
         vAJ34Dn5PBIYy98GvWUAB8j37JjIsqnLnG+TtmveIrrd5PG5avSunogFnw9n8WaEDY52
         niWQvQ0vIyE6seVHEY7dfZVyKKXV7pkpIu/9Q4wzRX68Fvy6fqxgP6lb1KLTIejh9D6+
         CFGg==
X-Gm-Message-State: APjAAAXT+ympWf4lYm0RPyKH2lKSsHCgnhV20r4mZkMUC/Tkk92paOGe
        z717l5jp2lQ60gn92gDJrTn6gpXPpS9xiTDmV8tzKevxm12w5eso7hLNlvILcjpGdoQprDfaSKS
        J37Tp3koZIqh8oxiUx25MQVs+fSIUh1XogA==
X-Received: by 2002:aca:b10a:: with SMTP id a10mr11826969oif.26.1574419250330;
        Fri, 22 Nov 2019 02:40:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqw37CPXDZxGO9PPl7ACc5ZCSGChL1OpIOKg4dNeHhZdo0cqbTK/cN1ZWlsmKg2kXjzrNV3b+rbqQe2UtWNgC7Q=
X-Received: by 2002:aca:b10a:: with SMTP id a10mr11826937oif.26.1574419249726;
 Fri, 22 Nov 2019 02:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20191119113845.89951-1-richard_c_haines@btinternet.com> <CAFqZXNtdWNSma6Y55bPcRvJinCe=F4YNwuciDAhhdgr95ef0Dg@mail.gmail.com>
In-Reply-To: <CAFqZXNtdWNSma6Y55bPcRvJinCe=F4YNwuciDAhhdgr95ef0Dg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Nov 2019 11:40:46 +0100
Message-ID: <CAFqZXNtZ8TVWP=6Rsp81u5NOHsvgc0Xr2yMtATTv2R-u5YmOhw@mail.gmail.com>
Subject: Re: [PATCH V4] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
X-MC-Unique: rAOFZhOUNfqVOqATheXt2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 20, 2019 at 12:58 PM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> On Tue, Nov 19, 2019 at 12:38 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > Test kernel module loading permissions.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> > ---
> > V2 Change:
> > Check permission denial module_load versus module_request by using a
> > test kernel module for each.
> > Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd =
when
> > building modules, therefore added to Makefile and .gitignore.
> > V3 Changes:
> > As requested in [1] except policy change, coalesced type attributes ins=
tead.
> > V4 Change:
> > Change attributes initmoddoman and finitmoddomain to a single attribute=
 of
> > kmoduledomain.
> >
> > [1] https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5=
Qo78s+geSsBok8=3DQ@mail.gmail.com/
> >
> >  policy/Makefile                           |   4 +
> >  policy/test_module_load.te                | 108 +++++++++++++++++++
> >  tests/Makefile                            |   4 +
> >  tests/module_load/.gitignore              |  11 ++
> >  tests/module_load/Makefile                |  12 +++
> >  tests/module_load/finit_load.c            |  94 +++++++++++++++++
> >  tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
> >  tests/module_load/setest_module_load.c    |  18 ++++
> >  tests/module_load/setest_module_request.c |  22 ++++
> >  tests/module_load/test                    |  62 +++++++++++
> >  10 files changed, 458 insertions(+)
> >  create mode 100644 policy/test_module_load.te
> >  create mode 100644 tests/module_load/.gitignore
> >  create mode 100644 tests/module_load/Makefile
> >  create mode 100644 tests/module_load/finit_load.c
> >  create mode 100644 tests/module_load/init_load.c
> >  create mode 100644 tests/module_load/setest_module_load.c
> >  create mode 100644 tests/module_load/setest_module_request.c
> >  create mode 100755 tests/module_load/test
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index ad94c43..25dfb69 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -94,6 +94,10 @@ ifeq ($(shell grep -q key_socket $(POLDEV)/include/s=
upport/all_perms.spt && echo
> >  TARGETS +=3D test_key_socket.te
> >  endif
> >
> > +ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.=
spt && echo true),true)
> > +TARGETS+=3Dtest_module_load.te
> > +endif
> > +
> >  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> >  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.t=
e, $(TARGETS))
> >  endif
> > diff --git a/policy/test_module_load.te b/policy/test_module_load.te
> > new file mode 100644
> > index 0000000..5496d86
> > --- /dev/null
> > +++ b/policy/test_module_load.te
> > @@ -0,0 +1,108 @@
> > +############# Test kernel modules ###################
> > +#
> > +attribute kmoduledomain;
> > +
> > +#
> > +############################## Define Macro ##########################=
######
> > +#
> > +# Replace domain_type() macro as it hides some relevant denials in aud=
it.log
> > +#
> > +gen_require(`
> > +       type setrans_var_run_t, syslogd_t;
> > +')
> > +
> > +define(`module_domain_type',`
> > +       allow $1 proc_t:dir { search };
> > +       allow $1 proc_t:lnk_file { read };
> > +       allow $1 self:dir { search };
> > +       allow $1 self:file { open read write };
> > +       dontaudit init_t syslogd_t:fd use;
> > +       dontaudit $1 security_t:filesystem getattr;
> > +       dontaudit $1 self:file getattr;
> > +       dontaudit $1 setrans_var_run_t:dir search;
> > +       dontaudit unconfined_t $1:process { noatsecure rlimitinh siginh=
 };
> > +')
> > +
> > +#
> > +############# Test kernel modules with finitmod_module(2) ############=
#######
> > +#
> > +type test_finitmod_t;
> > +module_domain_type(test_finitmod_t)
> > +unconfined_runs_test(test_finitmod_t)
> > +typeattribute test_finitmod_t testdomain, kmoduledomain;
> > +
> > +allow test_finitmod_t self:capability { sys_module };
> > +allow test_finitmod_t test_file_t:system { module_load };
> > +allow test_finitmod_t kernel_t:system { module_request };
> > +
> > +############### Deny cap sys_module ######################
> > +type test_finitmod_deny_sys_module_t;
> > +module_domain_type(test_finitmod_deny_sys_module_t)
> > +unconfined_runs_test(test_finitmod_deny_sys_module_t)
> > +typeattribute test_finitmod_deny_sys_module_t testdomain, kmoduledomai=
n;
> > +
> > +neverallow test_finitmod_deny_sys_module_t self:capability { sys_modul=
e };
> > +
> > +############### Deny sys module_load ######################
> > +type test_finitmod_deny_module_load_t;
> > +module_domain_type(test_finitmod_deny_module_load_t)
> > +unconfined_runs_test(test_finitmod_deny_module_load_t)
> > +typeattribute test_finitmod_deny_module_load_t testdomain, kmoduledoma=
in;
> > +
> > +allow test_finitmod_deny_module_load_t self:capability { sys_module };
> > +neverallow test_finitmod_deny_module_load_t test_file_t:system { modul=
e_load };
> > +
> > +############### Deny sys module_request ######################
> > +type test_finitmod_deny_module_request_t;
> > +module_domain_type(test_finitmod_deny_module_request_t)
> > +unconfined_runs_test(test_finitmod_deny_module_request_t)
> > +typeattribute test_finitmod_deny_module_request_t testdomain, kmoduled=
omain;
> > +
> > +allow test_finitmod_deny_module_request_t self:capability { sys_module=
 };
> > +allow test_finitmod_deny_module_request_t test_file_t:system { module_=
load };
> > +neverallow test_finitmod_deny_module_request_t kernel_t:system { modul=
e_request };
> > +
> > +#
> > +############# Test kernel modules with initmod_module(2) #############=
######
> > +#
> > +type test_initmod_t;
> > +module_domain_type(test_initmod_t)
> > +unconfined_runs_test(test_initmod_t)
> > +typeattribute test_initmod_t testdomain, kmoduledomain;
> > +
> > +allow test_initmod_t self:capability { sys_module };
> > +allow test_initmod_t self:system { module_load };
> > +allow test_initmod_t kernel_t:system { module_request };
> > +
> > +############### Deny cap sys_module ######################
> > +type test_initmod_deny_sys_module_t;
> > +module_domain_type(test_initmod_deny_sys_module_t)
> > +unconfined_runs_test(test_initmod_deny_sys_module_t)
> > +typeattribute test_initmod_deny_sys_module_t testdomain, kmoduledomain=
;
> > +
> > +neverallow test_initmod_deny_sys_module_t self:capability { sys_module=
 };
> > +
> > +############### Deny sys module_load ######################
> > +type test_initmod_deny_module_load_t;
> > +module_domain_type(test_initmod_deny_module_load_t)
> > +unconfined_runs_test(test_initmod_deny_module_load_t)
> > +typeattribute test_initmod_deny_module_load_t testdomain, kmoduledomai=
n;
> > +
> > +allow test_initmod_deny_module_load_t self:capability { sys_module };
> > +neverallow test_initmod_deny_module_load_t self:system { module_load }=
;
> > +
> > +############### Deny sys module_request ######################
> > +type test_initmod_deny_module_request_t;
> > +module_domain_type(test_initmod_deny_module_request_t)
> > +unconfined_runs_test(test_initmod_deny_module_request_t)
> > +typeattribute test_initmod_deny_module_request_t testdomain, kmoduledo=
main;
> > +
> > +allow test_initmod_deny_module_request_t self:capability { sys_module =
};
> > +allow test_initmod_deny_module_request_t self:system { module_load };
> > +neverallow test_initmod_deny_module_request_t kernel_t:system { module=
_request };
> > +
> > +#
> > +########### Allow these domains to be entered from sysadm domain #####=
#######
> > +#
> > +miscfiles_domain_entry_test_files(kmoduledomain)
> > +userdom_sysadm_entry_spec_domtrans_to(kmoduledomain)
> > diff --git a/tests/Makefile b/tests/Makefile
> > index cca6648..0452887 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -72,6 +72,10 @@ ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV=
)/include/support/all_perms.
> >  SUBDIRS+=3Dnotify
> >  endif
> >
> > +ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.=
spt && echo true),true)

When trying this on RHEL-7, I realized there is a missing kernel
version check here (module_load kernel support was introduced in v4.7
[1]):

ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
...
endif

It is quite a corner case to have a policy that supports module_load
and a kernel that does not, but there is at least one distro that hits
it, so I think it's worth it to add the explicit check.

Stephen/Paul, is it trivial enough to add when merging the patch or
should Richard repost it?

[1] https://github.com/torvalds/linux/commit/61d612ea731e57dc510472fb746b55=
cdc017f371

> > +SUBDIRS+=3Dmodule_load
> > +endif
> > +
> >  ifeq ($(DISTRO),RHEL4)
> >      SUBDIRS:=3D$(filter-out bounds dyntrace dyntrans inet_socket mmap =
nnp_nosuid overlay unix_socket, $(SUBDIRS))
> >  endif
> > diff --git a/tests/module_load/.gitignore b/tests/module_load/.gitignor=
e
> > new file mode 100644
> > index 0000000..7fa5772
> > --- /dev/null
> > +++ b/tests/module_load/.gitignore
> > @@ -0,0 +1,11 @@
> > +finit_load
> > +init_load
> > +modules.order
> > +Module.symvers
> > +*.a
> > +*.o
> > +*.ko
> > +*.cmd
> > +*.mod
> > +*.mod.c
> > +.*.cmd
> > diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
> > new file mode 100644
> > index 0000000..b6eba25
> > --- /dev/null
> > +++ b/tests/module_load/Makefile
> > @@ -0,0 +1,12 @@
> > +obj-m =3D setest_module_load.o setest_module_request.o
> > +
> > +TARGETS =3D finit_load init_load
> > +LDLIBS +=3D -lselinux
> > +KDIR =3D /lib/modules/$(shell uname -r)/build
> > +
> > +all: $(TARGETS)
> > +       $(MAKE) -C $(KDIR) M=3D$(PWD)
> > +
> > +clean:
> > +       rm -f $(TARGETS)
> > +       rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers mo=
dules.order
> > diff --git a/tests/module_load/finit_load.c b/tests/module_load/finit_l=
oad.c
> > new file mode 100644
> > index 0000000..1c05d7b
> > --- /dev/null
> > +++ b/tests/module_load/finit_load.c
> > @@ -0,0 +1,94 @@
> > +#define _GNU_SOURCE 1
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <sys/syscall.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progfile_name)
> > +{
> > +       fprintf(stderr,
> > +               "usage:  %s [-v] path name\n"
> > +               "Where:\n\t"
> > +               "-v    Print information.\n\t"
> > +               "path  Kernel module build path.\n\t"
> > +               "name  Name of kernel module to load.\n", progfile_name=
);
> > +       exit(-1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       char *context, file_name[PATH_MAX];
> > +       int opt, result, fd, s_errno;
> > +       bool verbose =3D false;
> > +
> > +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> > +               switch (opt) {
> > +               case 'v':
> > +                       verbose =3D true;
> > +                       break;
> > +               default:
> > +                       print_usage(argv[0]);
> > +               }
> > +       }
> > +
> > +       if (optind >=3D argc)
> > +               print_usage(argv[0]);
> > +
> > +       result =3D sprintf(file_name, "%s/%s.ko", argv[optind],
> > +                        argv[optind + 1]);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed sprintf\n");
> > +               exit(-1);
> > +       }
> > +
> > +       fd =3D open(file_name, O_RDONLY);
> > +       if (!fd) {
> > +               fprintf(stderr, "Failed to open %s: %s\n",
> > +                       file_name, strerror(errno));
> > +               exit(-1);
> > +       }
> > +
> > +       if (verbose) {
> > +               result =3D getcon(&context);
> > +               if (result < 0) {
> > +                       fprintf(stderr, "Failed to obtain process conte=
xt\n");
> > +                       close(fd);
> > +                       exit(-1);
> > +               }
> > +
> > +               printf("Process context:\n\t%s\n", context);
> > +               free(context);
> > +       }
> > +
> > +       result =3D syscall(__NR_finit_module, fd, "", 0);
> > +       s_errno =3D errno;
> > +       close(fd);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed to load '%s' module: %s\n",
> > +                       file_name, strerror(s_errno));
> > +               /* Denying: sys_module=3DEPERM, module_load=3DEACCES */
> > +               exit(s_errno);
> > +       }
> > +
> > +       if (verbose)
> > +               printf("Loaded kernel module:  %s\n", file_name);
> > +
> > +       result =3D syscall(__NR_delete_module, argv[optind + 1], 0);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed to delete '%s' module: %s\n",
> > +                       argv[optind + 1], strerror(errno));
> > +               exit(-1);
> > +       }
> > +
> > +       if (verbose)
> > +               printf("Deleted kernel module: %s\n", argv[optind + 1])=
;
> > +
> > +       return 0;
> > +}
> > diff --git a/tests/module_load/init_load.c b/tests/module_load/init_loa=
d.c
> > new file mode 100644
> > index 0000000..0422c19
> > --- /dev/null
> > +++ b/tests/module_load/init_load.c
> > @@ -0,0 +1,123 @@
> > +#define _GNU_SOURCE 1
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <sys/stat.h>
> > +#include <sys/syscall.h>
> > +#include <selinux/selinux.h>
> > +
> > +static void print_usage(char *progfile_name)
> > +{
> > +       fprintf(stderr,
> > +               "usage:  %s [-v] path name\n"
> > +               "Where:\n\t"
> > +               "-v    Print information.\n\t"
> > +               "path  Kernel module build path.\n\t"
> > +               "name  Name of kernel module to load.\n", progfile_name=
);
> > +       exit(-1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       char *context, file_name[PATH_MAX];
> > +       int opt, result, fd, s_errno;
> > +       bool verbose =3D false;
> > +       void *elf_image;
> > +       struct stat st;
> > +
> > +       while ((opt =3D getopt(argc, argv, "v")) !=3D -1) {
> > +               switch (opt) {
> > +               case 'v':
> > +                       verbose =3D true;
> > +                       break;
> > +               default:
> > +                       print_usage(argv[0]);
> > +               }
> > +       }
> > +
> > +       if (optind >=3D argc)
> > +               print_usage(argv[0]);
> > +
> > +       result =3D sprintf(file_name, "%s/%s.ko", argv[optind],
> > +                        argv[optind + 1]);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed sprintf\n");
> > +               exit(-1);
> > +       }
> > +
> > +       fd =3D open(file_name, O_RDONLY);
> > +       if (!fd) {
> > +               fprintf(stderr, "Failed to open %s: %s\n",
> > +                       file_name, strerror(errno));
> > +               exit(-1);
> > +       }
> > +
> > +       if (verbose) {
> > +               result =3D getcon(&context);
> > +               if (result < 0) {
> > +                       fprintf(stderr, "Failed to obtain process conte=
xt\n");
> > +                       close(fd);
> > +                       exit(-1);
> > +               }
> > +
> > +               printf("Process context:\n\t%s\n", context);
> > +               free(context);
> > +       }
> > +
> > +       result =3D fstat(fd, &st);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed fstat on %s: %s\n",
> > +                       file_name, strerror(errno));
> > +               close(fd);
> > +               exit(-1);
> > +       }
> > +
> > +       elf_image =3D malloc(st.st_size);
> > +       if (!elf_image) {
> > +               fprintf(stderr, "Failed malloc on %s: %s\n",
> > +                       file_name, strerror(errno));
> > +               close(fd);
> > +               exit(-1);
> > +       }
> > +
> > +       result =3D read(fd, elf_image, st.st_size);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed read on %s: %s\n",
> > +                       file_name, strerror(errno));
> > +               close(fd);
> > +               free(elf_image);
> > +               exit(-1);
> > +       }
> > +       close(fd);
> > +
> > +       result =3D syscall(__NR_init_module, elf_image, st.st_size, "")=
;
> > +       s_errno =3D errno;
> > +       free(elf_image);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed to load '%s' module: %s\n",
> > +                       file_name, strerror(s_errno));
> > +               /* Denying: sys_module=3DEPERM, module_load & request=
=3DEACCES */
> > +               exit(s_errno);
> > +       }
> > +
> > +       if (verbose)
> > +               printf("Loaded kernel module:  %s\n", file_name);
> > +
> > +       result =3D syscall(__NR_delete_module, argv[optind + 1], 0);
> > +       if (result < 0) {
> > +               fprintf(stderr, "Failed to delete '%s' module: %s\n",
> > +                       argv[optind + 1], strerror(errno));
> > +               exit(-1);
> > +       }
> > +
> > +       if (verbose)
> > +               printf("Deleted kernel module: %s\n", argv[optind + 1])=
;
> > +
> > +       return 0;
> > +}
> > diff --git a/tests/module_load/setest_module_load.c b/tests/module_load=
/setest_module_load.c
> > new file mode 100644
> > index 0000000..0be7a26
> > --- /dev/null
> > +++ b/tests/module_load/setest_module_load.c
> > @@ -0,0 +1,18 @@
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +
> > +static int __init setest_module_load_init(void)
> > +{
> > +       pr_info("INIT - setest_module_load\n");
> > +       return 0;
> > +}
> > +
> > +static void __exit setest_module_load_exit(void)
> > +{
> > +       pr_info("EXIT - setest_module_load\n");
> > +}
> > +
> > +module_init(setest_module_load_init);
> > +module_exit(setest_module_load_exit);
> > +MODULE_LICENSE("GPL");
> > diff --git a/tests/module_load/setest_module_request.c b/tests/module_l=
oad/setest_module_request.c
> > new file mode 100644
> > index 0000000..f79d4ef
> > --- /dev/null
> > +++ b/tests/module_load/setest_module_request.c
> > @@ -0,0 +1,22 @@
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +
> > +static int __init setest_module_request_init(void)
> > +{
> > +       int result;
> > +
> > +       pr_info("INIT - setest_module_request\n");
> > +       result =3D request_module_nowait("dummy-module");
> > +       pr_info("request_module() returned: %d\n", result);
> > +       return result;
> > +}
> > +
> > +static void __exit setest_module_request_exit(void)
> > +{
> > +       pr_info("EXIT - setest_module_request\n");
> > +}
> > +
> > +module_init(setest_module_request_init);
> > +module_exit(setest_module_request_exit);
> > +MODULE_LICENSE("GPL");
> > diff --git a/tests/module_load/test b/tests/module_load/test
> > new file mode 100755
> > index 0000000..c3242fc
> > --- /dev/null
> > +++ b/tests/module_load/test
> > @@ -0,0 +1,62 @@
> > +#!/usr/bin/perl
> > +use Test::More;
> > +
> > +BEGIN {
> > +    $basedir =3D $0;
> > +    $basedir =3D~ s|(.*)/[^/]*|$1|;
> > +
> > +    # allow info to be shown during tests
> > +    $v =3D $ARGV[0];
> > +    if ($v) {
> > +        if ( $v ne "-v" ) {
> > +            plan skip_all =3D> "Invalid option (use -v)";
> > +        }
> > +    }
> > +    else {
> > +        $v =3D " ";
> > +    }
> > +
> > +    plan tests =3D> 8;
> > +}
> > +
> > +print "Test finit_module(2)\n";
> > +$result =3D system
> > +"runcon -t test_finitmod_t $basedir/finit_load $v $basedir setest_modu=
le_request";
> > +ok( $result eq 0 );
> > +
> > +# Deny capability { sys_module } - EPERM
> > +$result =3D system
> > +"runcon -t test_finitmod_deny_sys_module_t $basedir/finit_load $v $bas=
edir setest_module_load 2>&1";
> > +ok( $result >> 8 eq 1 );
> > +
> > +# Deny system { module_load } - EACCES
> > +$result =3D system
> > +"runcon -t test_finitmod_deny_module_load_t $basedir/finit_load $v $ba=
sedir setest_module_load 2>&1";
> > +ok( $result >> 8 eq 13 );
> > +
> > +# Deny system { module_request } - EACCES
> > +$result =3D system
> > +"runcon -t test_finitmod_deny_module_request_t $basedir/finit_load $v =
$basedir setest_module_request 2>&1";
> > +ok( $result >> 8 eq 13 );
> > +
> > +print "Test init_module(2)\n";
> > +$result =3D system
> > +"runcon -t test_initmod_t $basedir/init_load $v $basedir setest_module=
_request";
> > +ok( $result eq 0 );
> > +
> > +# Deny capability { sys_module } - EPERM
> > +$result =3D system
> > +"runcon -t test_initmod_deny_sys_module_t $basedir/init_load $v $based=
ir setest_module_load 2>&1";
> > +ok( $result >> 8 eq 1 );
> > +
> > +# Deny system { module_load } - EACCES
> > +$result =3D system
> > +"runcon -t test_initmod_deny_module_load_t $basedir/init_load $v $base=
dir setest_module_load 2>&1";
> > +ok( $result >> 8 eq 13 );
> > +
> > +# Deny system { module_request } - EACCES
> > +$result =3D system
> > +"runcon -t test_initmod_deny_module_request_t $basedir/init_load $v $b=
asedir setest_module_request 2>&1";
> > +ok( $result >> 8 eq 13 );
> > +
> > +exit;
> > --
> > 2.23.0
> >
>
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.



--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

