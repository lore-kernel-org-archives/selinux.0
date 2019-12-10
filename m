Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C186CC43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FF020828
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="b67Vgd8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJPac (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:30:32 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:37530 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfLJPab (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 10:30:31 -0500
X-EEMSG-check-017: 37085751|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="37085751"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 15:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575991827; x=1607527827;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=hszbaYJpCQDnLX2Kla/5jEpfwpk8ABR7P4v3bF/d49c=;
  b=b67Vgd8EJx+UJnEs+TF9IPdZ17D4z/sn7eC8MvuRc0DCwO3tZBkWq7ko
   yUFHBMnJSqXYjeZ2u3+5Jt022LhWPHyZugDm5tgHTm7vIaEZIpZIzHyfK
   EKVOtO/fJ0mQYQSyxSaCfR5I/rBZeK04wPDkwCL/PMAfPukPxz9jni7B2
   Pp2Y6lIVpm9C6mkEIBcAzqLyg49Qt7My/k/HixYAj82tSlopR7qxEiAN+
   EoKsmpAE09EcnZXZFhUBSC+gbb6mIGGiuPlpdDGyzYEX5703/JOQfm6Ko
   RifOhyBHjDT4fAsvKPqU4bHdZiOjT/16W4G6qre4FugU42l2sXb+pC9XP
   A==;
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="30942957"
IronPort-PHdr: =?us-ascii?q?9a23=3AfxvNvRaxw207DV8D9nQIYdL/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsuybnLW6fgltlLVR4KTs6sC17ON9fmxAidfvd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu80YjIdtKKs8xQ?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRegAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUSy5Qo2QTfa/qZfIiM+B7jU/yRITh+iXl4e7y/nw6//VWvx+DzTMW50E?=
 =?us-ascii?q?tGojBbntTDqHwBzQHf586aQfVn5EihwyyA1wXL5+FBJkA7iLTUJoY6wr41ip?=
 =?us-ascii?q?oTqUPDHjLqmEnujK+ZaEEk+u+w5uT7eLrmvJ6cN5Jvig3kM6QunMK/AeMjMg?=
 =?us-ascii?q?cQQ2eX4/i81b3/8k35R7VGlPs2nbXCsJ/GP8gbo6+5AwtN3oYi7RawESum3c?=
 =?us-ascii?q?wFkXQII19JYhKKg5XzN13QL/30E+2zj0m0nDdu3f/GP7nhApvXLnjElbfsZa?=
 =?us-ascii?q?195FNHyAco0dBe545bCrEGIP7pXE/xr8bXAgU2Mwyz3ebrEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUWJ5u0zI+mDfpUVtyvlJPc5//HujWU2mV4bfaa3xpsac2u3HuhnI0?=
 =?us-ascii?q?WffXrjnM0BEWEUsQoiVuDllFqCUTtLbXaoQ608/i07CJ6hDYrbXYCinriB3C?=
 =?us-ascii?q?a9Hp1LaWFLEU6MEXj2eIWeQfsMazydItVnkjMaUbitUYgh1QuhtFyy970yFO?=
 =?us-ascii?q?vf+iQCudrD3dlz6vabwQsz/jx9Fciq2FaNRmByk3ggTSM32rxyu0pw1hGI1q?=
 =?us-ascii?q?0ux7RDGNhS4e5Zehk1OISazOFgDd32HAXbcYSnUlGjF+66DCkxQ9R5+NoHZ0?=
 =?us-ascii?q?JwCp32lRzY9za7CL8S0bqQDdo79byKjCu5HNp013uTjPpptFIhWMYacDT816?=
 =?us-ascii?q?M=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3AADvuO9d/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdIEYVSASKoQDiQOGZwEBAQEBAQaBEiWJaZFGCQEBA?=
 =?us-ascii?q?QEBAQEBAS0KAQGEQAKCJzgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCegEFI?=
 =?us-ascii?q?xVRCxgCAiYCAlcGAQwGAgEBgl8/AYJGAwklD61vgTKFT4NBgUIGgQ4ojDJ5g?=
 =?us-ascii?q?QeBEScMA4JdPoIbSQSBQQEBgy6CXgSHNYV3iG9hRnaWLII5gjuEaIUwiRcGG?=
 =?us-ascii?q?4JCjDeLP45KiEWOAIV9IoFYKwgCGAghD4MnUBEUjHIXiGSFXSMDMAEBjHeBU?=
 =?us-ascii?q?18BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Dec 2019 15:30:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAFU9XK013270;
        Tue, 10 Dec 2019 10:30:09 -0500
Subject: Re: [PATCH V4] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191119113845.89951-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2cbe7212-038d-3409-c3aa-d12b3a3a5961@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 10:30:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119113845.89951-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/19/19 6:38 AM, Richard Haines wrote:
> Test kernel module loading permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

I'll fix the merge conflict.

> ---
> V2 Change:
> Check permission denial module_load versus module_request by using a
> test kernel module for each.
> Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd when
> building modules, therefore added to Makefile and .gitignore.
> V3 Changes:
> As requested in [1] except policy change, coalesced type attributes instead.
> V4 Change:
> Change attributes initmoddoman and finitmoddomain to a single attribute of
> kmoduledomain.
> 
> [1] https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com/
> 
>   policy/Makefile                           |   4 +
>   policy/test_module_load.te                | 108 +++++++++++++++++++
>   tests/Makefile                            |   4 +
>   tests/module_load/.gitignore              |  11 ++
>   tests/module_load/Makefile                |  12 +++
>   tests/module_load/finit_load.c            |  94 +++++++++++++++++
>   tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
>   tests/module_load/setest_module_load.c    |  18 ++++
>   tests/module_load/setest_module_request.c |  22 ++++
>   tests/module_load/test                    |  62 +++++++++++
>   10 files changed, 458 insertions(+)
>   create mode 100644 policy/test_module_load.te
>   create mode 100644 tests/module_load/.gitignore
>   create mode 100644 tests/module_load/Makefile
>   create mode 100644 tests/module_load/finit_load.c
>   create mode 100644 tests/module_load/init_load.c
>   create mode 100644 tests/module_load/setest_module_load.c
>   create mode 100644 tests/module_load/setest_module_request.c
>   create mode 100755 tests/module_load/test
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index ad94c43..25dfb69 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -94,6 +94,10 @@ ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && echo
>   TARGETS += test_key_socket.te
>   endif
>   
> +ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS+=test_module_load.te
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
> diff --git a/policy/test_module_load.te b/policy/test_module_load.te
> new file mode 100644
> index 0000000..5496d86
> --- /dev/null
> +++ b/policy/test_module_load.te
> @@ -0,0 +1,108 @@
> +############# Test kernel modules ###################
> +#
> +attribute kmoduledomain;
> +
> +#
> +############################## Define Macro ################################
> +#
> +# Replace domain_type() macro as it hides some relevant denials in audit.log
> +#
> +gen_require(`
> +	type setrans_var_run_t, syslogd_t;
> +')
> +
> +define(`module_domain_type',`
> +	allow $1 proc_t:dir { search };
> +	allow $1 proc_t:lnk_file { read };
> +	allow $1 self:dir { search };
> +	allow $1 self:file { open read write };
> +	dontaudit init_t syslogd_t:fd use;
> +	dontaudit $1 security_t:filesystem getattr;
> +	dontaudit $1 self:file getattr;
> +	dontaudit $1 setrans_var_run_t:dir search;
> +	dontaudit unconfined_t $1:process { noatsecure rlimitinh siginh };
> +')
> +
> +#
> +############# Test kernel modules with finitmod_module(2) ###################
> +#
> +type test_finitmod_t;
> +module_domain_type(test_finitmod_t)
> +unconfined_runs_test(test_finitmod_t)
> +typeattribute test_finitmod_t testdomain, kmoduledomain;
> +
> +allow test_finitmod_t self:capability { sys_module };
> +allow test_finitmod_t test_file_t:system { module_load };
> +allow test_finitmod_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_finitmod_deny_sys_module_t;
> +module_domain_type(test_finitmod_deny_sys_module_t)
> +unconfined_runs_test(test_finitmod_deny_sys_module_t)
> +typeattribute test_finitmod_deny_sys_module_t testdomain, kmoduledomain;
> +
> +neverallow test_finitmod_deny_sys_module_t self:capability { sys_module };
> +
> +############### Deny sys module_load ######################
> +type test_finitmod_deny_module_load_t;
> +module_domain_type(test_finitmod_deny_module_load_t)
> +unconfined_runs_test(test_finitmod_deny_module_load_t)
> +typeattribute test_finitmod_deny_module_load_t testdomain, kmoduledomain;
> +
> +allow test_finitmod_deny_module_load_t self:capability { sys_module };
> +neverallow test_finitmod_deny_module_load_t test_file_t:system { module_load };
> +
> +############### Deny sys module_request ######################
> +type test_finitmod_deny_module_request_t;
> +module_domain_type(test_finitmod_deny_module_request_t)
> +unconfined_runs_test(test_finitmod_deny_module_request_t)
> +typeattribute test_finitmod_deny_module_request_t testdomain, kmoduledomain;
> +
> +allow test_finitmod_deny_module_request_t self:capability { sys_module };
> +allow test_finitmod_deny_module_request_t test_file_t:system { module_load };
> +neverallow test_finitmod_deny_module_request_t kernel_t:system { module_request };
> +
> +#
> +############# Test kernel modules with initmod_module(2) ###################
> +#
> +type test_initmod_t;
> +module_domain_type(test_initmod_t)
> +unconfined_runs_test(test_initmod_t)
> +typeattribute test_initmod_t testdomain, kmoduledomain;
> +
> +allow test_initmod_t self:capability { sys_module };
> +allow test_initmod_t self:system { module_load };
> +allow test_initmod_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_initmod_deny_sys_module_t;
> +module_domain_type(test_initmod_deny_sys_module_t)
> +unconfined_runs_test(test_initmod_deny_sys_module_t)
> +typeattribute test_initmod_deny_sys_module_t testdomain, kmoduledomain;
> +
> +neverallow test_initmod_deny_sys_module_t self:capability { sys_module };
> +
> +############### Deny sys module_load ######################
> +type test_initmod_deny_module_load_t;
> +module_domain_type(test_initmod_deny_module_load_t)
> +unconfined_runs_test(test_initmod_deny_module_load_t)
> +typeattribute test_initmod_deny_module_load_t testdomain, kmoduledomain;
> +
> +allow test_initmod_deny_module_load_t self:capability { sys_module };
> +neverallow test_initmod_deny_module_load_t self:system { module_load };
> +
> +############### Deny sys module_request ######################
> +type test_initmod_deny_module_request_t;
> +module_domain_type(test_initmod_deny_module_request_t)
> +unconfined_runs_test(test_initmod_deny_module_request_t)
> +typeattribute test_initmod_deny_module_request_t testdomain, kmoduledomain;
> +
> +allow test_initmod_deny_module_request_t self:capability { sys_module };
> +allow test_initmod_deny_module_request_t self:system { module_load };
> +neverallow test_initmod_deny_module_request_t kernel_t:system { module_request };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(kmoduledomain)
> +userdom_sysadm_entry_spec_domtrans_to(kmoduledomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index cca6648..0452887 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -72,6 +72,10 @@ ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.
>   SUBDIRS+=notify
>   endif
>   
> +ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +SUBDIRS+=module_load
> +endif
> +
>   ifeq ($(DISTRO),RHEL4)
>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>   endif
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
> +obj-m = setest_module_load.o setest_module_request.o
> +
> +TARGETS = finit_load init_load
> +LDLIBS += -lselinux
> +KDIR = /lib/modules/$(shell uname -r)/build
> +
> +all: $(TARGETS)
> +	$(MAKE) -C $(KDIR) M=$(PWD)
> +
> +clean:
> +	rm -f $(TARGETS)
> +	rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers modules.order
> diff --git a/tests/module_load/finit_load.c b/tests/module_load/finit_load.c
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
> +	fprintf(stderr,
> +		"usage:  %s [-v] path name\n"
> +		"Where:\n\t"
> +		"-v    Print information.\n\t"
> +		"path  Kernel module build path.\n\t"
> +		"name  Name of kernel module to load.\n", progfile_name);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *context, file_name[PATH_MAX];
> +	int opt, result, fd, s_errno;
> +	bool verbose = false;
> +
> +	while ((opt = getopt(argc, argv, "v")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		print_usage(argv[0]);
> +
> +	result = sprintf(file_name, "%s/%s.ko", argv[optind],
> +			 argv[optind + 1]);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed sprintf\n");
> +		exit(-1);
> +	}
> +
> +	fd = open(file_name, O_RDONLY);
> +	if (!fd) {
> +		fprintf(stderr, "Failed to open %s: %s\n",
> +			file_name, strerror(errno));
> +		exit(-1);
> +	}
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			close(fd);
> +			exit(-1);
> +		}
> +
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	result = syscall(__NR_finit_module, fd, "", 0);
> +	s_errno = errno;
> +	close(fd);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to load '%s' module: %s\n",
> +			file_name, strerror(s_errno));
> +		/* Denying: sys_module=EPERM, module_load=EACCES */
> +		exit(s_errno);
> +	}
> +
> +	if (verbose)
> +		printf("Loaded kernel module:  %s\n", file_name);
> +
> +	result = syscall(__NR_delete_module, argv[optind + 1], 0);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to delete '%s' module: %s\n",
> +			argv[optind + 1], strerror(errno));
> +		exit(-1);
> +	}
> +
> +	if (verbose)
> +		printf("Deleted kernel module: %s\n", argv[optind + 1]);
> +
> +	return 0;
> +}
> diff --git a/tests/module_load/init_load.c b/tests/module_load/init_load.c
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
> +	fprintf(stderr,
> +		"usage:  %s [-v] path name\n"
> +		"Where:\n\t"
> +		"-v    Print information.\n\t"
> +		"path  Kernel module build path.\n\t"
> +		"name  Name of kernel module to load.\n", progfile_name);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *context, file_name[PATH_MAX];
> +	int opt, result, fd, s_errno;
> +	bool verbose = false;
> +	void *elf_image;
> +	struct stat st;
> +
> +	while ((opt = getopt(argc, argv, "v")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		print_usage(argv[0]);
> +
> +	result = sprintf(file_name, "%s/%s.ko", argv[optind],
> +			 argv[optind + 1]);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed sprintf\n");
> +		exit(-1);
> +	}
> +
> +	fd = open(file_name, O_RDONLY);
> +	if (!fd) {
> +		fprintf(stderr, "Failed to open %s: %s\n",
> +			file_name, strerror(errno));
> +		exit(-1);
> +	}
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			close(fd);
> +			exit(-1);
> +		}
> +
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	result = fstat(fd, &st);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed fstat on %s: %s\n",
> +			file_name, strerror(errno));
> +		close(fd);
> +		exit(-1);
> +	}
> +
> +	elf_image = malloc(st.st_size);
> +	if (!elf_image) {
> +		fprintf(stderr, "Failed malloc on %s: %s\n",
> +			file_name, strerror(errno));
> +		close(fd);
> +		exit(-1);
> +	}
> +
> +	result = read(fd, elf_image, st.st_size);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed read on %s: %s\n",
> +			file_name, strerror(errno));
> +		close(fd);
> +		free(elf_image);
> +		exit(-1);
> +	}
> +	close(fd);
> +
> +	result = syscall(__NR_init_module, elf_image, st.st_size, "");
> +	s_errno = errno;
> +	free(elf_image);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to load '%s' module: %s\n",
> +			file_name, strerror(s_errno));
> +		/* Denying: sys_module=EPERM, module_load & request=EACCES */
> +		exit(s_errno);
> +	}
> +
> +	if (verbose)
> +		printf("Loaded kernel module:  %s\n", file_name);
> +
> +	result = syscall(__NR_delete_module, argv[optind + 1], 0);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to delete '%s' module: %s\n",
> +			argv[optind + 1], strerror(errno));
> +		exit(-1);
> +	}
> +
> +	if (verbose)
> +		printf("Deleted kernel module: %s\n", argv[optind + 1]);
> +
> +	return 0;
> +}
> diff --git a/tests/module_load/setest_module_load.c b/tests/module_load/setest_module_load.c
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
> +	pr_info("INIT - setest_module_load\n");
> +	return 0;
> +}
> +
> +static void __exit setest_module_load_exit(void)
> +{
> +	pr_info("EXIT - setest_module_load\n");
> +}
> +
> +module_init(setest_module_load_init);
> +module_exit(setest_module_load_exit);
> +MODULE_LICENSE("GPL");
> diff --git a/tests/module_load/setest_module_request.c b/tests/module_load/setest_module_request.c
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
> +	int result;
> +
> +	pr_info("INIT - setest_module_request\n");
> +	result = request_module_nowait("dummy-module");
> +	pr_info("request_module() returned: %d\n", result);
> +	return result;
> +}
> +
> +static void __exit setest_module_request_exit(void)
> +{
> +	pr_info("EXIT - setest_module_request\n");
> +}
> +
> +module_init(setest_module_request_init);
> +module_exit(setest_module_request_exit);
> +MODULE_LICENSE("GPL");
> diff --git a/tests/module_load/test b/tests/module_load/test
> new file mode 100755
> index 0000000..c3242fc
> --- /dev/null
> +++ b/tests/module_load/test
> @@ -0,0 +1,62 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    # allow info to be shown during tests
> +    $v = $ARGV[0];
> +    if ($v) {
> +        if ( $v ne "-v" ) {
> +            plan skip_all => "Invalid option (use -v)";
> +        }
> +    }
> +    else {
> +        $v = " ";
> +    }
> +
> +    plan tests => 8;
> +}
> +
> +print "Test finit_module(2)\n";
> +$result = system
> +"runcon -t test_finitmod_t $basedir/finit_load $v $basedir setest_module_request";
> +ok( $result eq 0 );
> +
> +# Deny capability { sys_module } - EPERM
> +$result = system
> +"runcon -t test_finitmod_deny_sys_module_t $basedir/finit_load $v $basedir setest_module_load 2>&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny system { module_load } - EACCES
> +$result = system
> +"runcon -t test_finitmod_deny_module_load_t $basedir/finit_load $v $basedir setest_module_load 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny system { module_request } - EACCES
> +$result = system
> +"runcon -t test_finitmod_deny_module_request_t $basedir/finit_load $v $basedir setest_module_request 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +print "Test init_module(2)\n";
> +$result = system
> +"runcon -t test_initmod_t $basedir/init_load $v $basedir setest_module_request";
> +ok( $result eq 0 );
> +
> +# Deny capability { sys_module } - EPERM
> +$result = system
> +"runcon -t test_initmod_deny_sys_module_t $basedir/init_load $v $basedir setest_module_load 2>&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny system { module_load } - EACCES
> +$result = system
> +"runcon -t test_initmod_deny_module_load_t $basedir/init_load $v $basedir setest_module_load 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny system { module_request } - EACCES
> +$result = system
> +"runcon -t test_initmod_deny_module_request_t $basedir/init_load $v $basedir setest_module_request 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +exit;
> 

