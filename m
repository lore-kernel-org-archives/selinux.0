Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE49C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 18:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B547222B1
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 18:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LwZ0sJHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRSP5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:15:57 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:13013 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRSP4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 13:15:56 -0500
X-EEMSG-check-017: 49510745|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,321,1569283200"; 
   d="scan'208";a="49510745"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Nov 2019 18:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574100952; x=1605636952;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=2gRzs+2f3nFSdG4Pd+fMrgaPtRx7E/wPRxd6yxUUnoE=;
  b=LwZ0sJHMQE57vYXxuIgISp0ge655UjltX7G4FoHSieTmE4r0gYoh4iNM
   XLlzQs1GzmEvqmUJZFMS7CL27LBn3QhqingyN1TyDcTHt4BVsCRX3kLiE
   Dm/iYiIvJC/c6Jldpwlc63qRERFxtRgSZcIQSTryGAcTXfLw/HJhVdv/C
   KN80zjY/KeSAbywPJpgJSyy4x8D8i/WPqVYqrepzUd5DKyc4YY36dmZpO
   LOOz9tmdxJMaQuUV+nYJjOD0M4/JhESFhOzqLEA6RpwjYPlm+03ktWOQD
   a1w29RjBdR8cbSUkDrT58YwhMxQIiT2NBYFZntXc6yAYx8UB49Y3mSE/l
   w==;
X-IronPort-AV: E=Sophos;i="5.68,321,1569283200"; 
   d="scan'208";a="35675182"
IronPort-PHdr: =?us-ascii?q?9a23=3A1L/nRBTLMsvc6ZKgjDsScnUlgNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYhaN2/xhgRfzUJnB7Loc0qyK6vumADBeqsbe+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UbjopvJqkyxx?=
 =?us-ascii?q?bLv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCReoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtig9yr0Do5?=
 =?us-ascii?q?G7fS4KxYwkxxHBcfyHdZaH4hb5WOaWOzd4i3Roc6+8iRaq6UWs1+LxW8au3F?=
 =?us-ascii?q?tKsyZJiMfAu38T2xDJ98SKTOZ28F271jaVzQ/T7/lJIUUzlaXGNZEs2qUwlp?=
 =?us-ascii?q?8PsUTbGS/2hVn2gLeWdko6/uio7PzqYqn8qZ+GNo90lxr+Pr4yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eugz73s4Vf1QLBLjv0yiqXZsZbaKtoHpqOhHgNY3Yku5wy/Aju7yt?=
 =?us-ascii?q?gUg3YKIExfdB6al4TpPkvBIPH8DfexmVSslzJryujdPrL8GZXANWTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzzctF6J5OBbEBJ+zzVlfrtNPEFh85LxC0w+H/BdVn14MRRWKPDb?=
 =?us-ascii?q?WDMKzPqVCH+vogI+mWa48UvjbyNeMl6uX1gn8lmF8de7Wp0oUNaHC+APtmP1?=
 =?us-ascii?q?+VbmbrgtcECW0KpBYxTPT2iF2eVj5ef22yULw45jE6DoKmEIjCS5uzgLyOwi?=
 =?us-ascii?q?i7BIdaZmNYBVCWF3fnaYGEV+0LaCKILc8y2gADAIKgQI8ozx3mlAb7zbd8Zr?=
 =?us-ascii?q?7O+yYYvIjv49NC5+TSkxwp3TZoDsKB3nuLQn0ylWQNEXt+x617oEpg2n+d3q?=
 =?us-ascii?q?Vixf9VD9pe47VOSAhpG4TbyrlBF93qWg/HNuyMQVKiT8TuVSo9Vfot0tQOZA?=
 =?us-ascii?q?B7ANzkgRfdiXn5S4QJnqCGUcRnupnX2GL8coMkkSfL?=
X-IPAS-Result: =?us-ascii?q?A2CIAABs3tJd/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdCxsVAEyKoQqjwhUBoERJYlmkUMJAQEBAQEBAQEBL?=
 =?us-ascii?q?QcBAgEBhEACgiMkOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjFVELG?=
 =?us-ascii?q?AICJgICVwYBDAYCAQGCXz8BgkYDCSUPsSmBMoVOgyeBQgaBDiiMFRh4gQeBE?=
 =?us-ascii?q?ScMgl8+ghtHBIE/AQGDLoJeBIcohXKIYGFGdJYUgjSCN4RjhSaJCQYbgj6MI?=
 =?us-ascii?q?osxjkiIOI1qhXcigVgrCAIYCCEPgydQERSRJheIZIVdIwMwAQGBAwEBiyWBU?=
 =?us-ascii?q?14BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Nov 2019 18:15:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAIIFmcA022856;
        Mon, 18 Nov 2019 13:15:48 -0500
Subject: Re: [PATCH V3] selinux-testsuite: Add kernel module tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191118173602.25506-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e41bd3ab-dc85-193f-1886-7472624ba457@tycho.nsa.gov>
Date:   Mon, 18 Nov 2019 13:15:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118173602.25506-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 12:36 PM, Richard Haines wrote:
> Test kernel module loading permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change:
> Check permission denial module_load versus module_request by using a
> test kernel module for each.
> Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd when
> building modules, therefore added to Makefile and .gitignore.
> V3 Changes:
> As requested in [1] except policy change, coalesced type attributes instead.

That isn't what I meant.  I meant you could get rid of one or the other 
of initmoddoman or finitmoddomain altogether and use a single type 
attribute for both sets of types, because you allow exactly the same 
allow rules / refpolicy interfaces to both attributes (just the rules 
for entering via test files and from sysadm).  Anyway, not a big deal 
either way.

> 
> [1] https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com/
> 
>   policy/Makefile                           |   4 +
>   policy/test_module_load.te                | 110 +++++++++++++++++++
>   tests/Makefile                            |   4 +
>   tests/module_load/.gitignore              |  11 ++
>   tests/module_load/Makefile                |  12 +++
>   tests/module_load/finit_load.c            |  94 +++++++++++++++++
>   tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
>   tests/module_load/setest_module_load.c    |  18 ++++
>   tests/module_load/setest_module_request.c |  22 ++++
>   tests/module_load/test                    |  62 +++++++++++
>   10 files changed, 460 insertions(+)
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
> index 0000000..9256ddd
> --- /dev/null
> +++ b/policy/test_module_load.te
> @@ -0,0 +1,110 @@
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
> +attribute finitmoddomain;
> +
> +type test_finitmod_t;
> +module_domain_type(test_finitmod_t)
> +unconfined_runs_test(test_finitmod_t)
> +typeattribute test_finitmod_t testdomain, finitmoddomain;
> +
> +allow test_finitmod_t self:capability { sys_module };
> +allow test_finitmod_t test_file_t:system { module_load };
> +allow test_finitmod_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_finitmod_deny_sys_module_t;
> +module_domain_type(test_finitmod_deny_sys_module_t)
> +unconfined_runs_test(test_finitmod_deny_sys_module_t)
> +typeattribute test_finitmod_deny_sys_module_t testdomain, finitmoddomain;
> +
> +neverallow test_finitmod_deny_sys_module_t self:capability { sys_module };
> +
> +############### Deny sys module_load ######################
> +type test_finitmod_deny_module_load_t;
> +module_domain_type(test_finitmod_deny_module_load_t)
> +unconfined_runs_test(test_finitmod_deny_module_load_t)
> +typeattribute test_finitmod_deny_module_load_t testdomain, finitmoddomain;
> +
> +allow test_finitmod_deny_module_load_t self:capability { sys_module };
> +neverallow test_finitmod_deny_module_load_t test_file_t:system { module_load };
> +
> +############### Deny sys module_request ######################
> +type test_finitmod_deny_module_request_t;
> +module_domain_type(test_finitmod_deny_module_request_t)
> +unconfined_runs_test(test_finitmod_deny_module_request_t)
> +typeattribute test_finitmod_deny_module_request_t testdomain, finitmoddomain;
> +
> +allow test_finitmod_deny_module_request_t self:capability { sys_module };
> +allow test_finitmod_deny_module_request_t test_file_t:system { module_load };
> +neverallow test_finitmod_deny_module_request_t kernel_t:system { module_request };
> +
> +#
> +############# Test kernel modules with initmod_module(2) ###################
> +#
> +attribute initmoddomain;
> +
> +type test_initmod_t;
> +module_domain_type(test_initmod_t)
> +unconfined_runs_test(test_initmod_t)
> +typeattribute test_initmod_t testdomain, initmoddomain;
> +
> +allow test_initmod_t self:capability { sys_module };
> +allow test_initmod_t self:system { module_load };
> +allow test_initmod_t kernel_t:system { module_request };
> +
> +############### Deny cap sys_module ######################
> +type test_initmod_deny_sys_module_t;
> +module_domain_type(test_initmod_deny_sys_module_t)
> +unconfined_runs_test(test_initmod_deny_sys_module_t)
> +typeattribute test_initmod_deny_sys_module_t testdomain, initmoddomain;
> +
> +neverallow test_initmod_deny_sys_module_t self:capability { sys_module };
> +
> +############### Deny sys module_load ######################
> +type test_initmod_deny_module_load_t;
> +module_domain_type(test_initmod_deny_module_load_t)
> +unconfined_runs_test(test_initmod_deny_module_load_t)
> +typeattribute test_initmod_deny_module_load_t testdomain, initmoddomain;
> +
> +allow test_initmod_deny_module_load_t self:capability { sys_module };
> +neverallow test_initmod_deny_module_load_t self:system { module_load };
> +
> +############### Deny sys module_request ######################
> +type test_initmod_deny_module_request_t;
> +module_domain_type(test_initmod_deny_module_request_t)
> +unconfined_runs_test(test_initmod_deny_module_request_t)
> +typeattribute test_initmod_deny_module_request_t testdomain, initmoddomain;
> +
> +allow test_initmod_deny_module_request_t self:capability { sys_module };
> +allow test_initmod_deny_module_request_t self:system { module_load };
> +neverallow test_initmod_deny_module_request_t kernel_t:system { module_request };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(finitmoddomain)
> +userdom_sysadm_entry_spec_domtrans_to(finitmoddomain)
> +miscfiles_domain_entry_test_files(initmoddomain)
> +userdom_sysadm_entry_spec_domtrans_to(initmoddomain)
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

