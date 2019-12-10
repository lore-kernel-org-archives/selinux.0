Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A12C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C83F20836
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZnegxBvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLJPcW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:32:22 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:32609 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfLJPcV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 10:32:21 -0500
X-EEMSG-check-017: 34369988|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="34369988"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 15:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575991924; x=1607527924;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=dooKLjyf3gnWCp2Fs7y2XXAn4dv6BhoP+CSP/gTuZls=;
  b=ZnegxBvkzYEOI7V0C8mN9m9Qo+5yJPSueznFwKKxhXdebRKi+Yxpja6j
   O2Rnp3cwQxNdyOXPnnsoaEJAfK6/U7ls6VeMMT6+BKc27SX4Pn14VZjiR
   VL9dsN+qmZl5omwzP8LuG4TbwJ5l2LRoKdOeGyeBNnywHbpS9GWCsE7Fj
   vt2HP/3ebK0OZ5ZYraiC2xf3Rj3oxxLhSChSVPMAKf1gxf5LOLryqSEJE
   3zTOmXLRfVY40xBm1cFlUuA58Tlheg5/ObXMs1b1LoXzjFCEj9oLsEWdL
   2ycx81cAzgfz+qKwCy5Fv87RWXifHFEzRuvyVaY9NqE86zCKNoFbLeiLP
   A==;
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="30943094"
IronPort-PHdr: =?us-ascii?q?9a23=3Aki56VhLpWEbTzbaYENmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLfTxwZ3uMQTl6Ol3ixeRBMOHsqkC0ruN+P+8EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7qQvcusYUjIZtN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5Dxq0UKoBe7AwSnGeHhxSJShnLuwKM00/?=
 =?us-ascii?q?ovEQ/F0gIuEd0Bv3bbo8n6OqoJTeC4z7PFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TM0lQ2Ftoik6y7sGtI?=
 =?us-ascii?q?a4fCcU0pQnwQDQa/idf4iP+BLjW+CcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5V1igH4PKQunde/DvokPQ?=
 =?us-ascii?q?QUQ2ia+fiz1L3k/UHjRrVFkuY2nbXDvJDfJMQbora1Aw5T0ok99xayFyqq3d?=
 =?us-ascii?q?sXkHUdLF9JZQiLg5bmNl3QOvz0EO+zg1G2nzdqw/DGMKfhApLILnXbi7fuYK?=
 =?us-ascii?q?195lVAyAsz0d9f55VUBqsHIPLoQED9rtPYDhgnMwCs2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZKqLSvkOI5u01OemDeZcatyrlJPgl/fHujHk5lkEGfaSyxpQXdHG4HvJ6I0?=
 =?us-ascii?q?qHe3rshMkOEXsQsgUiS+zqjUWIUSRPaHaqQ6I8+jY7BZq9DYjdQoCtgbqB3D?=
 =?us-ascii?q?q0H5BNeGBGBU6DEW3ye4WHRfgMciSSLdFlkjAeUrihUYAhhlmSs1rAyrFnJ/?=
 =?us-ascii?q?DYsg0RtJTuz5Ah/ezYlRgo+Qt/OMSU0meAVEl+gmIOWzIs2q1j50d6zwHHmb?=
 =?us-ascii?q?N1h/1eCMx7+fxESEE5OITawug8DMr9CSzbedLcc0qrWtWrB3kKS9s1x9IfKx?=
 =?us-ascii?q?JmF86KkgHI3y3sBaQc0bOMGspnoernw3HtKpMlmD793647ggxjG5EeOA=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2A3AAAFuu9d/wHyM5BlGQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QEBAQEBAQEBAQEBgX6BdIEYVSASKoQDiQOGZgEBAQEBAQaBEiWJaZFGCQEBA?=
 =?us-ascii?q?QEBAQEBAS0KAQGEQAKCJzgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCegEFI?=
 =?us-ascii?q?w8BBVEJAhgCAiYCAlcGAQwGAgEBgl8/AYJGAwklD5Fsm3SBMokRgUIGgQ4oj?=
 =?us-ascii?q?DJ5gQeBEScMA4JdPoIbSQSBQQEBgy6CXgSHNYV3iG+BJ3aWLII5gjuEaIUwi?=
 =?us-ascii?q?RcGG4JCjDeLP45KiEWOAIV9IoFYKwgCGAghD4MnUBEUjHIXiGSFXSMDMAEBj?=
 =?us-ascii?q?HeBU18BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Dec 2019 15:31:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAFVTMA013301;
        Tue, 10 Dec 2019 10:31:29 -0500
Subject: Re: [PATCH V4] selinux-testsuite: Add kernel module tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191119113845.89951-1-richard_c_haines@btinternet.com>
 <2cbe7212-038d-3409-c3aa-d12b3a3a5961@tycho.nsa.gov>
Message-ID: <99f1f582-3873-280e-b9e0-977596a99f3f@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 10:31:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2cbe7212-038d-3409-c3aa-d12b3a3a5961@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/19 10:30 AM, Stephen Smalley wrote:
> On 11/19/19 6:38 AM, Richard Haines wrote:
>> Test kernel module loading permissions.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> I'll fix the merge conflict.

Sorry, replied to the wrong one - meant to reply to the perf tests.  You 
can ignore this one.

> 
>> ---
>> V2 Change:
>> Check permission denial module_load versus module_request by using a
>> test kernel module for each.
>> Note: Rawhide (with secnext kernel) adds built-in.a and built-in.a.cmd 
>> when
>> building modules, therefore added to Makefile and .gitignore.
>> V3 Changes:
>> As requested in [1] except policy change, coalesced type attributes 
>> instead.
>> V4 Change:
>> Change attributes initmoddoman and finitmoddomain to a single 
>> attribute of
>> kmoduledomain.
>>
>> [1] 
>> https://lore.kernel.org/selinux/CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com/ 
>>
>>
>>   policy/Makefile                           |   4 +
>>   policy/test_module_load.te                | 108 +++++++++++++++++++
>>   tests/Makefile                            |   4 +
>>   tests/module_load/.gitignore              |  11 ++
>>   tests/module_load/Makefile                |  12 +++
>>   tests/module_load/finit_load.c            |  94 +++++++++++++++++
>>   tests/module_load/init_load.c             | 123 ++++++++++++++++++++++
>>   tests/module_load/setest_module_load.c    |  18 ++++
>>   tests/module_load/setest_module_request.c |  22 ++++
>>   tests/module_load/test                    |  62 +++++++++++
>>   10 files changed, 458 insertions(+)
>>   create mode 100644 policy/test_module_load.te
>>   create mode 100644 tests/module_load/.gitignore
>>   create mode 100644 tests/module_load/Makefile
>>   create mode 100644 tests/module_load/finit_load.c
>>   create mode 100644 tests/module_load/init_load.c
>>   create mode 100644 tests/module_load/setest_module_load.c
>>   create mode 100644 tests/module_load/setest_module_request.c
>>   create mode 100755 tests/module_load/test
>>
>> diff --git a/policy/Makefile b/policy/Makefile
>> index ad94c43..25dfb69 100644
>> --- a/policy/Makefile
>> +++ b/policy/Makefile
>> @@ -94,6 +94,10 @@ ifeq ($(shell grep -q key_socket 
>> $(POLDEV)/include/support/all_perms.spt && echo
>>   TARGETS += test_key_socket.te
>>   endif
>> +ifeq ($(shell grep -q module_load 
>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>> +TARGETS+=test_module_load.te
>> +endif
>> +
>>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te 
>> test_ibpkey.te, $(TARGETS))
>>   endif
>> diff --git a/policy/test_module_load.te b/policy/test_module_load.te
>> new file mode 100644
>> index 0000000..5496d86
>> --- /dev/null
>> +++ b/policy/test_module_load.te
>> @@ -0,0 +1,108 @@
>> +############# Test kernel modules ###################
>> +#
>> +attribute kmoduledomain;
>> +
>> +#
>> +############################## Define Macro 
>> ################################
>> +#
>> +# Replace domain_type() macro as it hides some relevant denials in 
>> audit.log
>> +#
>> +gen_require(`
>> +    type setrans_var_run_t, syslogd_t;
>> +')
>> +
>> +define(`module_domain_type',`
>> +    allow $1 proc_t:dir { search };
>> +    allow $1 proc_t:lnk_file { read };
>> +    allow $1 self:dir { search };
>> +    allow $1 self:file { open read write };
>> +    dontaudit init_t syslogd_t:fd use;
>> +    dontaudit $1 security_t:filesystem getattr;
>> +    dontaudit $1 self:file getattr;
>> +    dontaudit $1 setrans_var_run_t:dir search;
>> +    dontaudit unconfined_t $1:process { noatsecure rlimitinh siginh };
>> +')
>> +
>> +#
>> +############# Test kernel modules with finitmod_module(2) 
>> ###################
>> +#
>> +type test_finitmod_t;
>> +module_domain_type(test_finitmod_t)
>> +unconfined_runs_test(test_finitmod_t)
>> +typeattribute test_finitmod_t testdomain, kmoduledomain;
>> +
>> +allow test_finitmod_t self:capability { sys_module };
>> +allow test_finitmod_t test_file_t:system { module_load };
>> +allow test_finitmod_t kernel_t:system { module_request };
>> +
>> +############### Deny cap sys_module ######################
>> +type test_finitmod_deny_sys_module_t;
>> +module_domain_type(test_finitmod_deny_sys_module_t)
>> +unconfined_runs_test(test_finitmod_deny_sys_module_t)
>> +typeattribute test_finitmod_deny_sys_module_t testdomain, kmoduledomain;
>> +
>> +neverallow test_finitmod_deny_sys_module_t self:capability { 
>> sys_module };
>> +
>> +############### Deny sys module_load ######################
>> +type test_finitmod_deny_module_load_t;
>> +module_domain_type(test_finitmod_deny_module_load_t)
>> +unconfined_runs_test(test_finitmod_deny_module_load_t)
>> +typeattribute test_finitmod_deny_module_load_t testdomain, 
>> kmoduledomain;
>> +
>> +allow test_finitmod_deny_module_load_t self:capability { sys_module };
>> +neverallow test_finitmod_deny_module_load_t test_file_t:system { 
>> module_load };
>> +
>> +############### Deny sys module_request ######################
>> +type test_finitmod_deny_module_request_t;
>> +module_domain_type(test_finitmod_deny_module_request_t)
>> +unconfined_runs_test(test_finitmod_deny_module_request_t)
>> +typeattribute test_finitmod_deny_module_request_t testdomain, 
>> kmoduledomain;
>> +
>> +allow test_finitmod_deny_module_request_t self:capability { 
>> sys_module };
>> +allow test_finitmod_deny_module_request_t test_file_t:system { 
>> module_load };
>> +neverallow test_finitmod_deny_module_request_t kernel_t:system { 
>> module_request };
>> +
>> +#
>> +############# Test kernel modules with initmod_module(2) 
>> ###################
>> +#
>> +type test_initmod_t;
>> +module_domain_type(test_initmod_t)
>> +unconfined_runs_test(test_initmod_t)
>> +typeattribute test_initmod_t testdomain, kmoduledomain;
>> +
>> +allow test_initmod_t self:capability { sys_module };
>> +allow test_initmod_t self:system { module_load };
>> +allow test_initmod_t kernel_t:system { module_request };
>> +
>> +############### Deny cap sys_module ######################
>> +type test_initmod_deny_sys_module_t;
>> +module_domain_type(test_initmod_deny_sys_module_t)
>> +unconfined_runs_test(test_initmod_deny_sys_module_t)
>> +typeattribute test_initmod_deny_sys_module_t testdomain, kmoduledomain;
>> +
>> +neverallow test_initmod_deny_sys_module_t self:capability { 
>> sys_module };
>> +
>> +############### Deny sys module_load ######################
>> +type test_initmod_deny_module_load_t;
>> +module_domain_type(test_initmod_deny_module_load_t)
>> +unconfined_runs_test(test_initmod_deny_module_load_t)
>> +typeattribute test_initmod_deny_module_load_t testdomain, kmoduledomain;
>> +
>> +allow test_initmod_deny_module_load_t self:capability { sys_module };
>> +neverallow test_initmod_deny_module_load_t self:system { module_load };
>> +
>> +############### Deny sys module_request ######################
>> +type test_initmod_deny_module_request_t;
>> +module_domain_type(test_initmod_deny_module_request_t)
>> +unconfined_runs_test(test_initmod_deny_module_request_t)
>> +typeattribute test_initmod_deny_module_request_t testdomain, 
>> kmoduledomain;
>> +
>> +allow test_initmod_deny_module_request_t self:capability { sys_module };
>> +allow test_initmod_deny_module_request_t self:system { module_load };
>> +neverallow test_initmod_deny_module_request_t kernel_t:system { 
>> module_request };
>> +
>> +#
>> +########### Allow these domains to be entered from sysadm domain 
>> ############
>> +#
>> +miscfiles_domain_entry_test_files(kmoduledomain)
>> +userdom_sysadm_entry_spec_domtrans_to(kmoduledomain)
>> diff --git a/tests/Makefile b/tests/Makefile
>> index cca6648..0452887 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -72,6 +72,10 @@ ifeq ($(shell grep -q all_file_perms.*watch 
>> $(POLDEV)/include/support/all_perms.
>>   SUBDIRS+=notify
>>   endif
>> +ifeq ($(shell grep -q module_load 
>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>> +SUBDIRS+=module_load
>> +endif
>> +
>>   ifeq ($(DISTRO),RHEL4)
>>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap 
>> nnp_nosuid overlay unix_socket, $(SUBDIRS))
>>   endif
>> diff --git a/tests/module_load/.gitignore b/tests/module_load/.gitignore
>> new file mode 100644
>> index 0000000..7fa5772
>> --- /dev/null
>> +++ b/tests/module_load/.gitignore
>> @@ -0,0 +1,11 @@
>> +finit_load
>> +init_load
>> +modules.order
>> +Module.symvers
>> +*.a
>> +*.o
>> +*.ko
>> +*.cmd
>> +*.mod
>> +*.mod.c
>> +.*.cmd
>> diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
>> new file mode 100644
>> index 0000000..b6eba25
>> --- /dev/null
>> +++ b/tests/module_load/Makefile
>> @@ -0,0 +1,12 @@
>> +obj-m = setest_module_load.o setest_module_request.o
>> +
>> +TARGETS = finit_load init_load
>> +LDLIBS += -lselinux
>> +KDIR = /lib/modules/$(shell uname -r)/build
>> +
>> +all: $(TARGETS)
>> +    $(MAKE) -C $(KDIR) M=$(PWD)
>> +
>> +clean:
>> +    rm -f $(TARGETS)
>> +    rm -f *.a *.o *.ko *.cmd *.mod *.mod.c .*.cmd Module.symvers 
>> modules.order
>> diff --git a/tests/module_load/finit_load.c 
>> b/tests/module_load/finit_load.c
>> new file mode 100644
>> index 0000000..1c05d7b
>> --- /dev/null
>> +++ b/tests/module_load/finit_load.c
>> @@ -0,0 +1,94 @@
>> +#define _GNU_SOURCE 1
>> +
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <stdbool.h>
>> +#include <fcntl.h>
>> +#include <limits.h>
>> +#include <sys/syscall.h>
>> +#include <selinux/selinux.h>
>> +
>> +static void print_usage(char *progfile_name)
>> +{
>> +    fprintf(stderr,
>> +        "usage:  %s [-v] path name\n"
>> +        "Where:\n\t"
>> +        "-v    Print information.\n\t"
>> +        "path  Kernel module build path.\n\t"
>> +        "name  Name of kernel module to load.\n", progfile_name);
>> +    exit(-1);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    char *context, file_name[PATH_MAX];
>> +    int opt, result, fd, s_errno;
>> +    bool verbose = false;
>> +
>> +    while ((opt = getopt(argc, argv, "v")) != -1) {
>> +        switch (opt) {
>> +        case 'v':
>> +            verbose = true;
>> +            break;
>> +        default:
>> +            print_usage(argv[0]);
>> +        }
>> +    }
>> +
>> +    if (optind >= argc)
>> +        print_usage(argv[0]);
>> +
>> +    result = sprintf(file_name, "%s/%s.ko", argv[optind],
>> +             argv[optind + 1]);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed sprintf\n");
>> +        exit(-1);
>> +    }
>> +
>> +    fd = open(file_name, O_RDONLY);
>> +    if (!fd) {
>> +        fprintf(stderr, "Failed to open %s: %s\n",
>> +            file_name, strerror(errno));
>> +        exit(-1);
>> +    }
>> +
>> +    if (verbose) {
>> +        result = getcon(&context);
>> +        if (result < 0) {
>> +            fprintf(stderr, "Failed to obtain process context\n");
>> +            close(fd);
>> +            exit(-1);
>> +        }
>> +
>> +        printf("Process context:\n\t%s\n", context);
>> +        free(context);
>> +    }
>> +
>> +    result = syscall(__NR_finit_module, fd, "", 0);
>> +    s_errno = errno;
>> +    close(fd);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed to load '%s' module: %s\n",
>> +            file_name, strerror(s_errno));
>> +        /* Denying: sys_module=EPERM, module_load=EACCES */
>> +        exit(s_errno);
>> +    }
>> +
>> +    if (verbose)
>> +        printf("Loaded kernel module:  %s\n", file_name);
>> +
>> +    result = syscall(__NR_delete_module, argv[optind + 1], 0);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed to delete '%s' module: %s\n",
>> +            argv[optind + 1], strerror(errno));
>> +        exit(-1);
>> +    }
>> +
>> +    if (verbose)
>> +        printf("Deleted kernel module: %s\n", argv[optind + 1]);
>> +
>> +    return 0;
>> +}
>> diff --git a/tests/module_load/init_load.c 
>> b/tests/module_load/init_load.c
>> new file mode 100644
>> index 0000000..0422c19
>> --- /dev/null
>> +++ b/tests/module_load/init_load.c
>> @@ -0,0 +1,123 @@
>> +#define _GNU_SOURCE 1
>> +
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <stdbool.h>
>> +#include <fcntl.h>
>> +#include <limits.h>
>> +#include <sys/stat.h>
>> +#include <sys/syscall.h>
>> +#include <selinux/selinux.h>
>> +
>> +static void print_usage(char *progfile_name)
>> +{
>> +    fprintf(stderr,
>> +        "usage:  %s [-v] path name\n"
>> +        "Where:\n\t"
>> +        "-v    Print information.\n\t"
>> +        "path  Kernel module build path.\n\t"
>> +        "name  Name of kernel module to load.\n", progfile_name);
>> +    exit(-1);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    char *context, file_name[PATH_MAX];
>> +    int opt, result, fd, s_errno;
>> +    bool verbose = false;
>> +    void *elf_image;
>> +    struct stat st;
>> +
>> +    while ((opt = getopt(argc, argv, "v")) != -1) {
>> +        switch (opt) {
>> +        case 'v':
>> +            verbose = true;
>> +            break;
>> +        default:
>> +            print_usage(argv[0]);
>> +        }
>> +    }
>> +
>> +    if (optind >= argc)
>> +        print_usage(argv[0]);
>> +
>> +    result = sprintf(file_name, "%s/%s.ko", argv[optind],
>> +             argv[optind + 1]);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed sprintf\n");
>> +        exit(-1);
>> +    }
>> +
>> +    fd = open(file_name, O_RDONLY);
>> +    if (!fd) {
>> +        fprintf(stderr, "Failed to open %s: %s\n",
>> +            file_name, strerror(errno));
>> +        exit(-1);
>> +    }
>> +
>> +    if (verbose) {
>> +        result = getcon(&context);
>> +        if (result < 0) {
>> +            fprintf(stderr, "Failed to obtain process context\n");
>> +            close(fd);
>> +            exit(-1);
>> +        }
>> +
>> +        printf("Process context:\n\t%s\n", context);
>> +        free(context);
>> +    }
>> +
>> +    result = fstat(fd, &st);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed fstat on %s: %s\n",
>> +            file_name, strerror(errno));
>> +        close(fd);
>> +        exit(-1);
>> +    }
>> +
>> +    elf_image = malloc(st.st_size);
>> +    if (!elf_image) {
>> +        fprintf(stderr, "Failed malloc on %s: %s\n",
>> +            file_name, strerror(errno));
>> +        close(fd);
>> +        exit(-1);
>> +    }
>> +
>> +    result = read(fd, elf_image, st.st_size);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed read on %s: %s\n",
>> +            file_name, strerror(errno));
>> +        close(fd);
>> +        free(elf_image);
>> +        exit(-1);
>> +    }
>> +    close(fd);
>> +
>> +    result = syscall(__NR_init_module, elf_image, st.st_size, "");
>> +    s_errno = errno;
>> +    free(elf_image);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed to load '%s' module: %s\n",
>> +            file_name, strerror(s_errno));
>> +        /* Denying: sys_module=EPERM, module_load & request=EACCES */
>> +        exit(s_errno);
>> +    }
>> +
>> +    if (verbose)
>> +        printf("Loaded kernel module:  %s\n", file_name);
>> +
>> +    result = syscall(__NR_delete_module, argv[optind + 1], 0);
>> +    if (result < 0) {
>> +        fprintf(stderr, "Failed to delete '%s' module: %s\n",
>> +            argv[optind + 1], strerror(errno));
>> +        exit(-1);
>> +    }
>> +
>> +    if (verbose)
>> +        printf("Deleted kernel module: %s\n", argv[optind + 1]);
>> +
>> +    return 0;
>> +}
>> diff --git a/tests/module_load/setest_module_load.c 
>> b/tests/module_load/setest_module_load.c
>> new file mode 100644
>> index 0000000..0be7a26
>> --- /dev/null
>> +++ b/tests/module_load/setest_module_load.c
>> @@ -0,0 +1,18 @@
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +
>> +static int __init setest_module_load_init(void)
>> +{
>> +    pr_info("INIT - setest_module_load\n");
>> +    return 0;
>> +}
>> +
>> +static void __exit setest_module_load_exit(void)
>> +{
>> +    pr_info("EXIT - setest_module_load\n");
>> +}
>> +
>> +module_init(setest_module_load_init);
>> +module_exit(setest_module_load_exit);
>> +MODULE_LICENSE("GPL");
>> diff --git a/tests/module_load/setest_module_request.c 
>> b/tests/module_load/setest_module_request.c
>> new file mode 100644
>> index 0000000..f79d4ef
>> --- /dev/null
>> +++ b/tests/module_load/setest_module_request.c
>> @@ -0,0 +1,22 @@
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +
>> +static int __init setest_module_request_init(void)
>> +{
>> +    int result;
>> +
>> +    pr_info("INIT - setest_module_request\n");
>> +    result = request_module_nowait("dummy-module");
>> +    pr_info("request_module() returned: %d\n", result);
>> +    return result;
>> +}
>> +
>> +static void __exit setest_module_request_exit(void)
>> +{
>> +    pr_info("EXIT - setest_module_request\n");
>> +}
>> +
>> +module_init(setest_module_request_init);
>> +module_exit(setest_module_request_exit);
>> +MODULE_LICENSE("GPL");
>> diff --git a/tests/module_load/test b/tests/module_load/test
>> new file mode 100755
>> index 0000000..c3242fc
>> --- /dev/null
>> +++ b/tests/module_load/test
>> @@ -0,0 +1,62 @@
>> +#!/usr/bin/perl
>> +use Test::More;
>> +
>> +BEGIN {
>> +    $basedir = $0;
>> +    $basedir =~ s|(.*)/[^/]*|$1|;
>> +
>> +    # allow info to be shown during tests
>> +    $v = $ARGV[0];
>> +    if ($v) {
>> +        if ( $v ne "-v" ) {
>> +            plan skip_all => "Invalid option (use -v)";
>> +        }
>> +    }
>> +    else {
>> +        $v = " ";
>> +    }
>> +
>> +    plan tests => 8;
>> +}
>> +
>> +print "Test finit_module(2)\n";
>> +$result = system
>> +"runcon -t test_finitmod_t $basedir/finit_load $v $basedir 
>> setest_module_request";
>> +ok( $result eq 0 );
>> +
>> +# Deny capability { sys_module } - EPERM
>> +$result = system
>> +"runcon -t test_finitmod_deny_sys_module_t $basedir/finit_load $v 
>> $basedir setest_module_load 2>&1";
>> +ok( $result >> 8 eq 1 );
>> +
>> +# Deny system { module_load } - EACCES
>> +$result = system
>> +"runcon -t test_finitmod_deny_module_load_t $basedir/finit_load $v 
>> $basedir setest_module_load 2>&1";
>> +ok( $result >> 8 eq 13 );
>> +
>> +# Deny system { module_request } - EACCES
>> +$result = system
>> +"runcon -t test_finitmod_deny_module_request_t $basedir/finit_load $v 
>> $basedir setest_module_request 2>&1";
>> +ok( $result >> 8 eq 13 );
>> +
>> +print "Test init_module(2)\n";
>> +$result = system
>> +"runcon -t test_initmod_t $basedir/init_load $v $basedir 
>> setest_module_request";
>> +ok( $result eq 0 );
>> +
>> +# Deny capability { sys_module } - EPERM
>> +$result = system
>> +"runcon -t test_initmod_deny_sys_module_t $basedir/init_load $v 
>> $basedir setest_module_load 2>&1";
>> +ok( $result >> 8 eq 1 );
>> +
>> +# Deny system { module_load } - EACCES
>> +$result = system
>> +"runcon -t test_initmod_deny_module_load_t $basedir/init_load $v 
>> $basedir setest_module_load 2>&1";
>> +ok( $result >> 8 eq 13 );
>> +
>> +# Deny system { module_request } - EACCES
>> +$result = system
>> +"runcon -t test_initmod_deny_module_request_t $basedir/init_load $v 
>> $basedir setest_module_request 2>&1";
>> +ok( $result >> 8 eq 13 );
>> +
>> +exit;
>>
> 

