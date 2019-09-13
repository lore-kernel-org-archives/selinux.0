Return-Path: <SRS0=5Yad=XI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC67AC49ED7
	for <selinux@archiver.kernel.org>; Fri, 13 Sep 2019 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9413E20693
	for <selinux@archiver.kernel.org>; Fri, 13 Sep 2019 17:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ePoXJUhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfIMRJE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:09:04 -0400
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:54539 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfIMRJE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Sep 2019 13:09:04 -0400
X-EEMSG-check-017: 22229318|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="22229318"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Sep 2019 17:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568394541; x=1599930541;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=oPOJB/UZhBRFDtIagtM3lYlYPZC8eUOarxrL6j8qp2U=;
  b=ePoXJUhjlfDmSeOalJddxOwOeqSYXdqt1FZrTLyYL5oPiF0ik5p7Ecru
   +gjY/woJNmSrT9FWoBOWVn1iEV8zyEtXQ10/dU8QTvjrXgv8yNFfB4BWE
   nenGsStb1kV00n+ygsUTbJuUn6xmNRLSRUxQWTAZ1esLPfHrwM+zDGXdw
   MUbGrd+nahIAMVuTXLmjEYp1qRBadiKLd3g68LE5zT7sISLdRMf3TL7H7
   ZddNQ1aXLQ1madssw9VhrOZ+Ueoz4qxGIrz84ZH5E5pELhrok8wV9JPkZ
   Aj8VmiFEbg5B4h90OIqRUBRY7yzshXjR43JJcdcjr4bVbTpig1NDP7Zjn
   g==;
X-IronPort-AV: E=Sophos;i="5.64,501,1559520000"; 
   d="scan'208";a="32829227"
IronPort-PHdr: =?us-ascii?q?9a23=3A/L6f0hLa7uEaWl27K9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvjzrarrMEGX3/hxlliBBdydt6sfzbKJ+Pm4ByRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLo9xx?=
 =?us-ascii?q?nGrndVZ+hbxH5jKVaPkxrh/Mu984Nv/zpKt/4968JMVLjxcrglQ7BfEDkoKX?=
 =?us-ascii?q?0+6tfxtRnEQwuP538cXXsTnxFVHQXL7wz0U4novCfiueVzxCeVPcvtTbApQj?=
 =?us-ascii?q?ui9LtkSAXpiCgcKTE09nzch9Fqg6JapBKhoAF/w5LRbYqIOvdyYr/RcNUHTm?=
 =?us-ascii?q?daQM1fSzJODZ+9b4sXDuoOI+BYr5Xmp1ATqReyHBSgCP/zxjNNgHL507c60+?=
 =?us-ascii?q?A8Gg/Y2gIuEc8FvHDNoNj7MKoeVOa4x7TKwzredfNbwSrz5pbGch4hov+CU7?=
 =?us-ascii?q?x/fsXTxkYzGA3IlUmQpI7/Mj+JyugAvWqW4ux9XuyvkW4nrARxryCyyMcwlI?=
 =?us-ascii?q?bJnoIVxU7C9S5k3Yg1IMe3SEp/YdG6EJpbqiaXN5BrTcM5WGxopCY7xaEGuZ?=
 =?us-ascii?q?68ZiQKzo8nyATFZ/yIdIiI/AvuWeCMKjl7nHJoYK+zihm9/ES6yuDwS9O43E?=
 =?us-ascii?q?hFoyZbiNXAq3YA3AHJ5MedUPty5EKh1C6K1wDU9+5LP1g5lbHeK5492r4wkY?=
 =?us-ascii?q?cTsVjbEi/2hkr2iKiWe104+uey8eTnY6jmpoSGO49oigDxLqQumsulDeQ+Lg?=
 =?us-ascii?q?cORHSU9f651L3i+U31WLRKjvsonanFqJ3WOMsWq6GjDwJVz4ov8QizAji43N?=
 =?us-ascii?q?gCgHULNFdFdwiGj4jtNVHOOvf4DfKnjlS3jThr3OvLPqHhA5rRLnjDl63tfb?=
 =?us-ascii?q?Bm60FG0gYzwtdf54xMBrEbPP3zQlPxtMDfDhIhKQy0wvroCNVn2YMERG2AGr?=
 =?us-ascii?q?OWP7vSsVCS5+IvJfeDZJQOtTnmN/gl5vjujWMnll8He6mmw4cXZGqkEfRhJk?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/TniEacXj5XZnayWb885z4gBYK4AofMWJqtjKaC3C?=
 =?us-ascii?q?ilBJ1WYH5JClSWHXfvbYWEVO8GaDiOLc95jjwESb+hRpc51R60qQ/6z6FqLv?=
 =?us-ascii?q?LO9S0FsZLvzd115+rUlREo6zN4FdiS02aITzI8omRdfT493KllrQRdw1aF3L?=
 =?us-ascii?q?Mw1+ZZHtxa/f9+WTA6PJ/awvdSAczzXB7MZNGEVBCtRdDwRXkqQ9YwxcIeS1?=
 =?us-ascii?q?hyFs/kjR3Z2SeuRbgPmPjDPJUp9ur52H/rKo4p03/b0IE5hkQiB85IMnerwK?=
 =?us-ascii?q?V48l6AKZTOlhCii6uydakalBXI/WOHwHvG6FpUSyZsQK7FWjYZfUKQotPnsB?=
 =?us-ascii?q?CRB4SyAKgqZ1MSgfWJLbFHP5iw1gRL?=
X-IPAS-Result: =?us-ascii?q?A2BKAABezHtd/wHyM5BdCRwBAQEEAQEHBAEBgVMHAQELA?=
 =?us-ascii?q?YFtKm1SATIqhCGIHIZqTQEBAQEBAQaBESV+iHWPKxSBZwkBAQEBAQEBAQEjE?=
 =?us-ascii?q?QECAQGEPwKCYCM0CQ4CDAEBAQQBAQEBAQYDAQFshS4MgjopAYJmAQEBAQIBG?=
 =?us-ascii?q?gkEEVELGAICJgICVwYBDAYCAQGCXz8BgWoDCQUPqx9/M4VLgzaBSYEMKAGLd?=
 =?us-ascii?q?xh4gQeBEAEnDIIqNT6BDoEMgXMNEhiDC4JYBIxSBokHgTGVN4IrgiyEVY1wB?=
 =?us-ascii?q?huCNHCKcYp1jBmBZppoOIFYKwgCGAghD4MnCYJFF4dXhmckAzCBBgEBjEyCV?=
 =?us-ascii?q?AEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Sep 2019 17:09:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8DH90uP008141;
        Fri, 13 Sep 2019 13:09:00 -0400
Subject: Re: [RFC V3 PATCH] selinux-testsuite: Add test for restorecon
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <20190603095609.21429-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9b525cf9-9132-ff68-9d6a-da78c45b8cac@tycho.nsa.gov>
Date:   Fri, 13 Sep 2019 13:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190603095609.21429-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/3/19 5:56 AM, Richard Haines wrote:
> This will test the updated libselinux selinux_restorecon(3) using a
> simple test version of "restorecon", or if the test is run locally,
> a '-p' option can be used to supply the path of a full version of
> restorecon(8) (see note in restorecon/test).
> 
> As the SELinux testsuite is primarily a set of regression tests for the
> SELinux kernel, this change also adds support to include the testing of
> core userspace services such as library functions or utilities. To
> install and run these type of tests, the following must be run first:
> 
> 	# export TEST_USERSPACE=y

Sorry for the long delay in responding. I would prefer userspace tests 
to remain part of the selinux userspace repository, invoked upon make 
test there.  A test policy if required should be possible via a separate 
standalone cil or te/fc policy module that doesn't depend on the 
testsuite policy.

> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Allow option to run other restorecon binaries.
> Only run if userspace tests enabled.
> Add tests for "Ignore the stem..." patch
> V3 Changes:
> Add tests for No CAP_SYS_ADMIN permission and SKIP_DIGEST
> 
>   README.md                                  |   7 +
>   policy/Makefile                            |   8 +
>   policy/test_restorecon.te                  |  74 ++++++++
>   tests/Makefile                             |   7 +
>   tests/file/test                            |   2 +-
>   tests/restorecon/.gitignore                |   5 +
>   tests/restorecon/Makefile                  |   7 +
>   tests/restorecon/check_fs.c                |  69 ++++++++
>   tests/restorecon/get_all_digests.c         | 176 +++++++++++++++++++
>   tests/restorecon/restorecon.c              |  80 +++++++++
>   tests/restorecon/restorecon_xattr.c        | 116 +++++++++++++
>   tests/restorecon/selinux_restorecon_skip.c |  66 ++++++++
>   tests/restorecon/test                      | 188 +++++++++++++++++++++
>   13 files changed, 804 insertions(+), 1 deletion(-)
>   create mode 100644 policy/test_restorecon.te
>   create mode 100644 tests/restorecon/.gitignore
>   create mode 100644 tests/restorecon/Makefile
>   create mode 100644 tests/restorecon/check_fs.c
>   create mode 100644 tests/restorecon/get_all_digests.c
>   create mode 100644 tests/restorecon/restorecon.c
>   create mode 100644 tests/restorecon/restorecon_xattr.c
>   create mode 100644 tests/restorecon/selinux_restorecon_skip.c
>   create mode 100755 tests/restorecon/test
> 
> diff --git a/README.md b/README.md
> index 26784f8..329a495 100644
> --- a/README.md
> +++ b/README.md
> @@ -114,6 +114,13 @@ the tests:
>   
>   ## Running the Tests
>   
> +The SELinux testsuite is primarily a set of regression tests for the SELinux
> +kernel, however it is possible to include the testing of core userspace
> +services such as library functions or utilities. To install any relevant
> +tests, the following must be run first:
> +
> +	# export TEST_USERSPACE=y
> +
>   Create a shell with the `unconfined_r` or `sysadm_r` role and the Linux
>   superuser identity, e.g.:
>   
> diff --git a/policy/Makefile b/policy/Makefile
> index 305b572..9c7d173 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -3,6 +3,7 @@ POLDEV ?= /usr/share/selinux/devel
>   SEMODULE = /usr/sbin/semodule
>   CHECKPOLICY = /usr/bin/checkpolicy
>   CHECKMODULE = /usr/bin/checkmodule
> +INCLUDEDIR ?= /usr/include
>   
>   DISTRO=$(shell ../tests/os_detect)
>   RHEL_VERS=$(shell echo $(DISTRO) | sed 's/RHEL//')
> @@ -79,6 +80,13 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO), xRHEL6))
>   TARGETS:=$(filter-out test_ibpkey.te, $(TARGETS))
>   endif
>   
> +# Add any userspace test policy
> +ifeq ($(TEST_USERSPACE),y)
> +    ifeq ($(shell grep -q selabel_get_digests_all_partial_matches $(INCLUDEDIR)/selinux/label.h && echo true),true)
> +        TARGETS += test_restorecon.te
> +    endif
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5))
>   	BUILD_TARGET := build_rhel
>   	LOAD_TARGET := load_rhel
> diff --git a/policy/test_restorecon.te b/policy/test_restorecon.te
> new file mode 100644
> index 0000000..57699bb
> --- /dev/null
> +++ b/policy/test_restorecon.te
> @@ -0,0 +1,74 @@
> +#################################
> +#
> +# Policy for testing restorecon
> +#
> +
> +require {
> +	attribute file_type;
> +	type setfiles_exec_t;
> +}
> +
> +attribute restorecon_domain;
> +
> +type test_restorecon_file_t;
> +files_type(test_restorecon_file_t)
> +type in_dir_t;
> +files_type(in_dir_t)
> +type out_dir_t;
> +files_type(out_dir_t)
> +type in_file_t;
> +files_type(in_file_t)
> +type out_file_t;
> +files_type(out_file_t)
> +
> +# Domain for restorecon.
> +type test_restorecon_t;
> +files_type(test_restorecon_t)
> +
> +domain_type(test_restorecon_t)
> +unconfined_runs_test(test_restorecon_t)
> +typeattribute test_restorecon_t testdomain;
> +typeattribute test_restorecon_t restorecon_domain;
> +
> +allow test_restorecon_t self:capability sys_admin;
> +allow test_restorecon_t test_file_t:file relabelfrom;
> +allow test_restorecon_t file_type:dir { relabel_dir_perms manage_dir_perms };
> +allow test_restorecon_t file_type:file { rw_file_perms execute relabelto relabelfrom };
> +allow_map(test_restorecon_t, file_type, file)
> +corecmd_bin_entry_type(test_restorecon_t)
> +
> +# Allow these for statfs(2) if /tmp = TMPFS_MAGIC test
> +allow test_restorecon_t tmpfs_t:filesystem getattr;
> +allow test_restorecon_t user_tmp_t:sock_file getattr;
> +# and this to add the root test directory
> +allow test_restorecon_t fs_t:filesystem getattr;
> +
> +# Allow restorecon(8) to be used instead of the test program
> +allow test_restorecon_t setfiles_exec_t:file entrypoint;
> +
> +######### No CAP_SYS_ADMIN permission ################
> +
> +type test_no_admin_restorecon_t;
> +files_type(test_no_admin_restorecon_t)
> +
> +domain_type(test_no_admin_restorecon_t)
> +unconfined_runs_test(test_no_admin_restorecon_t)
> +typeattribute test_no_admin_restorecon_t testdomain;
> +typeattribute test_no_admin_restorecon_t restorecon_domain;
> +
> +allow test_no_admin_restorecon_t test_file_t:file relabelfrom;
> +allow test_no_admin_restorecon_t file_type:dir { relabel_dir_perms manage_dir_perms };
> +allow test_no_admin_restorecon_t file_type:file { rw_file_perms execute relabelto relabelfrom };
> +allow_map(test_no_admin_restorecon_t, file_type, file)
> +corecmd_bin_entry_type(test_no_admin_restorecon_t)
> +
> +# and this to add the root test directory
> +allow test_no_admin_restorecon_t fs_t:filesystem getattr;
> +
> +# Allow restorecon(8) to be used instead of the test program
> +allow test_no_admin_restorecon_t setfiles_exec_t:file entrypoint;
> +
> +######################################################
> +# Allow all of these domains to be entered from sysadm domain
> +miscfiles_domain_entry_test_files(restorecon_domain)
> +userdom_sysadm_entry_spec_domtrans_to(restorecon_domain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 63aa325..37ed6af 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -50,6 +50,13 @@ ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
>   SUBDIRS += infiniband_pkey
>   endif
>   
> +# Keep userspace tests last
> +ifeq ($(TEST_USERSPACE),y)
> +    ifeq ($(shell grep -q selabel_get_digests_all_partial_matches $(INCLUDEDIR)/selinux/label.h && echo true),true)
> +        SUBDIRS += restorecon
> +    endif
> +endif
> +
>   ifeq ($(DISTRO),RHEL4)
>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>   endif
> diff --git a/tests/file/test b/tests/file/test
> index 32dd2bd..cb86f41 100755
> --- a/tests/file/test
> +++ b/tests/file/test
> @@ -50,7 +50,7 @@ system "chcon -t fileop_exec_t $basedir/wait_io 2>&1 > /dev/null";
>   # Get the SID of the good file.
>   #
>   $output = `ls -Z $basedir/temp_file`;
> -@arr = split( ' ', $output );
> +@arr    = split( ' ', $output );
>   if ( index( $arr[0], ":" ) != -1 ) {
>       $good_file_sid = $arr[0];
>   }
> diff --git a/tests/restorecon/.gitignore b/tests/restorecon/.gitignore
> new file mode 100644
> index 0000000..98a33e8
> --- /dev/null
> +++ b/tests/restorecon/.gitignore
> @@ -0,0 +1,5 @@
> +restorecon
> +selinux_restorecon_skip
> +restorecon_xattr
> +get_all_digests
> +check_fs
> diff --git a/tests/restorecon/Makefile b/tests/restorecon/Makefile
> new file mode 100644
> index 0000000..477f8d1
> --- /dev/null
> +++ b/tests/restorecon/Makefile
> @@ -0,0 +1,7 @@
> +TARGETS = restorecon selinux_restorecon_skip restorecon_xattr get_all_digests check_fs
> +LDLIBS += -lselinux
> +
> +all: $(TARGETS)
> +
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/restorecon/check_fs.c b/tests/restorecon/check_fs.c
> new file mode 100644
> index 0000000..f18910f
> --- /dev/null
> +++ b/tests/restorecon/check_fs.c
> @@ -0,0 +1,69 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/statfs.h>
> +#include <linux/magic.h>
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] <path>\n"
> +		"Where:\n\t"
> +		"-v  Display filesystem f_type magic number.\n\t"
> +		"path  Path to check fs type.\n\n"
> +		"Returns 1=RAMFS_MAGIC, 2=TMPFS_MAGIC, 3=SYSFS_MAGIC\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, rc;
> +	bool verbose = false;
> +	struct statfs sfsb;
> +
> +	while ((opt = getopt(argc, argv, "v")) > 0) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc) {
> +		fprintf(stderr, "No pathname specified\n");
> +		return -1;
> +	}
> +
> +	rc = statfs(argv[optind], &sfsb);
> +	if (rc < 0) {
> +		fprintf(stderr, "Get filesystem statistics ERROR: %s\n",
> +			strerror(errno));
> +		return rc;
> +	}
> +
> +	switch (sfsb.f_type) {
> +	case RAMFS_MAGIC:
> +		if (verbose)
> +			printf("RAMFS_MAGIC\n");
> +		return 1;
> +	case TMPFS_MAGIC:
> +		if (verbose)
> +			printf("TMPFS_MAGIC\n");
> +		return 2;
> +	case SYSFS_MAGIC:
> +		if (verbose)
> +			printf("SYSFS_MAGIC\n");
> +		return 3;
> +	default:
> +		if (verbose)
> +			printf("sfsb.f_type: 0x%lx\n", sfsb.f_type);
> +		return 0;
> +	}
> +
> +	return rc;
> +}
> diff --git a/tests/restorecon/get_all_digests.c b/tests/restorecon/get_all_digests.c
> new file mode 100644
> index 0000000..59f0ed8
> --- /dev/null
> +++ b/tests/restorecon/get_all_digests.c
> @@ -0,0 +1,176 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <fts.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +
> +#define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-vr] <path>\n\n"
> +		"Where:\n\t"
> +		"-v  Display information.\n\t"
> +		"-r  Recursively descend directories.\n\t"
> +		"path  Path to check current SHA1 digest against file_contexts entries.\n\n"
> +		"This will check the directory selinux.sehash SHA1 digest for "
> +		"<path> against\na newly generated digest based on the "
> +		"file_context entries for that node\n(using the regx, mode "
> +		"and path entries).\n", progname);
> +	exit(1);
> +}
> +
> +static int get_digests(struct selabel_handle *hnd, bool verbose, char *path)
> +{
> +	int rc = 0;
> +	size_t i, digest_len = 0;
> +	bool status;
> +	uint8_t *xattr_digest = NULL;
> +	uint8_t *calculated_digest = NULL;
> +	char *sha1_buf = NULL;
> +
> +	status = selabel_get_digests_all_partial_matches(hnd, path,
> +							 &calculated_digest,
> +							 &xattr_digest,
> +							 &digest_len);
> +
> +	sha1_buf = calloc(1, digest_len * 2 + 1);
> +	if (!sha1_buf) {
> +		fprintf(stderr, "Could not calloc buffer ERROR: %s\n",
> +			strerror(errno));
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	/* rc = 0 NO MATCH, rc = 1 MATCH, rc = 2 NO calculated_digest
> +	 * rc = 4 NO xattr_digest, rc = 6 NO digests
> +	 */
> +	if (status) { /* They match */
> +		if (verbose) {
> +			printf("xattr and file_contexts SHA1 digests match for: %s\n",
> +			       path);
> +
> +			if (calculated_digest) {
> +				for (i = 0; i < digest_len; i++)
> +					sprintf((&sha1_buf[i * 2]), "%02x",
> +						calculated_digest[i]);
> +				printf("SHA1 digest: %s\n", sha1_buf);
> +			}
> +		}
> +
> +		rc = 1;
> +		goto out;
> +	} else {
> +		if (!calculated_digest) {
> +			rc = 2;
> +			if (verbose) {
> +				printf("No SHA1 digest available for: %s\n", path);
> +				printf("as file_context entry is \"<<none>>\"\n");
> +			}
> +		}
> +
> +		if (calculated_digest && verbose) {
> +			printf("The file_context entries for: %s\n", path);
> +
> +			for (i = 0; i < digest_len; i++)
> +				sprintf((&sha1_buf[i * 2]), "%02x", calculated_digest[i]);
> +			printf("generated SHA1 digest: %s\n", sha1_buf);
> +		}
> +		if (!xattr_digest) {
> +			rc = rc | 4;
> +			if (verbose)
> +				printf("however there is no selinux.sehash xattr entry.\n");
> +			else
> +				goto out;
> +
> +		} else if (verbose) {
> +			printf("however it does NOT match the current entry of:\n");
> +			for (i = 0; i < digest_len; i++)
> +				sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
> +			printf("%s\n", sha1_buf);
> +		}
> +	}
> +
> +	free(sha1_buf);
> +out:
> +	free(xattr_digest);
> +	free(calculated_digest);
> +	return rc;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, fts_flags, status;
> +	bool verbose = false, recurse = false;
> +	FTS *fts;
> +	FTSENT *ftsent;
> +	char *paths[2] = { NULL, NULL };
> +	struct selabel_handle *hnd;
> +
> +	if (argc < 2)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "vr")) > 0) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		case 'r':
> +			recurse = true;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc) {
> +		fprintf(stderr, "No pathname specified\n");
> +		exit(-1);
> +	}
> +	paths[0] = argv[optind];
> +
> +	hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
> +	if (!hnd) {
> +		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle.\n");
> +		return -1;
> +	}
> +
> +	fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
> +	fts = fts_open(paths, fts_flags, NULL);
> +	if (!fts) {
> +		printf("fts error on %s: %s\n",
> +		       paths[0], strerror(errno));
> +		return -1;
> +	}
> +
> +	while ((ftsent = fts_read(fts)) != NULL) {
> +		switch (ftsent->fts_info) {
> +		case FTS_D:
> +			/* If recurse = TRUE, then 'status' will reflect the
> +			 * last path match with 0 = NO MATCH, 1 = MATCH,
> +			 * 2 = NO calculated_digest, 4 = NO xattr_digest and
> +			 * 6 = NO digests.
> +			 */
> +			status = get_digests(hnd, verbose, ftsent->fts_path);
> +			if (status < 0)
> +				goto out;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (!recurse)
> +			break;
> +	}
> +
> +out:
> +	(void) fts_close(fts);
> +	(void) selabel_close(hnd);
> +	return status;
> +}
> diff --git a/tests/restorecon/restorecon.c b/tests/restorecon/restorecon.c
> new file mode 100644
> index 0000000..9daa19a
> --- /dev/null
> +++ b/tests/restorecon/restorecon.c
> @@ -0,0 +1,80 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +#include <selinux/restorecon.h>
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-IDrv] <path>\n\n"
> +		"Where:\n\t"
> +		"-I  Set SELINUX_RESTORECON_IGNORE_DIGEST\n\t"
> +		"-D  Enable digests\n\t"
> +		"-r  Recursively descend directories.\n\t"
> +		"-v  Display information.\n\t"
> +		"path  Path of file or directory to check.\n\n"
> +		"The parameters must follow those of restorecon(8)\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, rc, flags = 0;
> +	bool request_digest = false;
> +	struct selabel_handle *hnd = NULL;
> +
> +	if (argc < 2)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "IDrv")) > 0) {
> +		switch (opt) {
> +		case 'I':
> +			flags |= SELINUX_RESTORECON_IGNORE_DIGEST;
> +			request_digest = true;
> +			break;
> +		case 'D':
> +			request_digest = true;
> +			break;
> +		case 'r':
> +			flags |= SELINUX_RESTORECON_RECURSE;
> +			break;
> +		case 'v':
> +			flags |= SELINUX_RESTORECON_VERBOSE;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc) {
> +		fprintf(stderr, "No pathname specified\n");
> +		return -1;
> +	}
> +
> +	struct selinux_opt fc_opts[] = {
> +		{ SELABEL_OPT_DIGEST, (request_digest ? (char *)1 : NULL) }
> +	};
> +
> +	hnd = selabel_open(SELABEL_CTX_FILE, fc_opts, 1);
> +	if (!hnd) {
> +		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle.\n");
> +		return -1;
> +	}
> +
> +	/* Use own handle */
> +	selinux_restorecon_set_sehandle(hnd);
> +
> +	rc = selinux_restorecon(argv[optind], flags);
> +	if (rc < 0)
> +		fprintf(stderr, "selinux_restorecon ERROR: %s\n",
> +			strerror(errno));
> +
> +	selabel_close(hnd);
> +	return rc;
> +}
> +
> diff --git a/tests/restorecon/restorecon_xattr.c b/tests/restorecon/restorecon_xattr.c
> new file mode 100644
> index 0000000..12e89b3
> --- /dev/null
> +++ b/tests/restorecon/restorecon_xattr.c
> @@ -0,0 +1,116 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +#include <selinux/restorecon.h>
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"\nusage: %s [-vrdD] <path>\n"
> +		"\nWhere:\n\t"
> +		"-n  Do not append \"Match\" or \"No Match\" to displayed digests.\n\t"
> +		"-r  Recursively descend directories.\n\t"
> +		"-m  Do not read /proc/mounts for entries to be excluded.\n\t"
> +		"-d  Delete non-matching digest entries.\n\t"
> +		"-D  Delete all digest entries.\n\t"
> +		"path  Path to search for xattr \"security.sehash\" entries.\n\n",
> +		progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, rc;
> +	unsigned int xattr_flags = 0, delete_digest = 0, recurse = 0;
> +	unsigned int delete_all_digests = 0;
> +	struct dir_xattr *current, *next, **xattr_list = NULL;
> +	bool verbose = false;
> +
> +	if (argc < 2)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "vrdD")) > 0) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		case 'r':
> +			recurse = SELINUX_RESTORECON_XATTR_RECURSE;
> +			break;
> +		case 'd':
> +			delete_digest =
> +				SELINUX_RESTORECON_XATTR_DELETE_NONMATCH_DIGESTS;
> +			break;
> +		case 'D':
> +			delete_all_digests =
> +				SELINUX_RESTORECON_XATTR_DELETE_ALL_DIGESTS;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc) {
> +		fprintf(stderr, "No pathname specified\n");
> +		exit(-1);
> +	}
> +
> +	xattr_flags = delete_digest | delete_all_digests | recurse;
> +
> +	if (selinux_restorecon_xattr(argv[optind], xattr_flags, &xattr_list)) {
> +		fprintf(stderr, "Error selinux_restorecon_xattr: %s\n",
> +			strerror(errno));
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	if (xattr_list && verbose) {
> +		current = *xattr_list;
> +		while (current) {
> +			next = current->next;
> +			printf("%s ", current->directory);
> +
> +			switch (current->result) {
> +			case MATCH:
> +				printf("Digest: %s Match\n", current->digest);
> +				break;
> +			case NOMATCH:
> +				printf("Digest: %s No Match\n", current->digest);
> +				break;
> +			case DELETED_MATCH:
> +				printf("Deleted Digest: %s Match\n", current->digest);
> +				break;
> +			case DELETED_NOMATCH:
> +				printf("Deleted Digest: %s No Match\n",
> +				       current->digest);
> +				break;
> +			case ERROR:
> +				printf("Digest: %s Error removing xattr\n",
> +				       current->digest);
> +				break;
> +			}
> +			current = next;
> +		}
> +		/* Free memory */
> +		current = *xattr_list;
> +		while (current) {
> +			next = current->next;
> +			free(current->directory);
> +			free(current->digest);
> +			free(current);
> +			current = next;
> +		}
> +	} else if (verbose) {
> +		printf("No digests available\n");
> +	}
> +
> +	rc = 0;
> +out:
> +	return rc;
> +}
> diff --git a/tests/restorecon/selinux_restorecon_skip.c b/tests/restorecon/selinux_restorecon_skip.c
> new file mode 100644
> index 0000000..a09b658
> --- /dev/null
> +++ b/tests/restorecon/selinux_restorecon_skip.c
> @@ -0,0 +1,66 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +#include <selinux/restorecon.h>
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-SIrv] <path>\n\n"
> +		"Where:\n\t"
> +		"-S  set SELINUX_RESTORECON_SKIP_DIGEST\n\t"
> +		"-I  Set SELINUX_RESTORECON_IGNORE_DIGEST\n\t"
> +		"-r  Recursively descend directories.\n\t"
> +		"-v  Display information.\n\t"
> +		"path  Path of file or directory to check.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, rc, flags = 0;
> +
> +	if (argc < 2)
> +		usage(argv[0]);
> +
> +	while ((opt = getopt(argc, argv, "SIrv")) > 0) {
> +		switch (opt) {
> +		case 'I':
> +			flags |= SELINUX_RESTORECON_IGNORE_DIGEST;
> +			break;
> +		case 'S':
> +			flags |= SELINUX_RESTORECON_SKIP_DIGEST;
> +			break;
> +		case 'r':
> +			flags |= SELINUX_RESTORECON_RECURSE;
> +			break;
> +		case 'v':
> +			flags |= SELINUX_RESTORECON_VERBOSE;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc) {
> +		fprintf(stderr, "No pathname specified\n");
> +		return -1;
> +	}
> +
> +	/*
> +	 * selinux_restorecon() calls selabel_open(3) and by default enables
> +	 * digests.
> +	 */
> +	rc = selinux_restorecon(argv[optind], flags);
> +	if (rc < 0)
> +		fprintf(stderr, "selinux_restorecon ERROR: %s\n",
> +			strerror(errno));
> +
> +	return rc;
> +}
> +
> diff --git a/tests/restorecon/test b/tests/restorecon/test
> new file mode 100755
> index 0000000..a21765e
> --- /dev/null
> +++ b/tests/restorecon/test
> @@ -0,0 +1,188 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +# Options: -v = Verbose, -p <path_to_restorecon>
> +# NOTE: If using the -p option to use a different version of restorecon,
> +# ensure they are labeled correctly before use. This can be achieved by:
> +#    chcon -h -t bin_t .../sbin/restorecon
> +#    chcon -h -t setfiles_exec_t .../sbin/setfiles
> +# The test_restorecon.te policy has rules to support this labeling.
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    $v      = " ";
> +    $bindir = $basedir;
> +    $i      = 0;
> +    foreach $arg (@ARGV) {
> +        if ( $arg eq "-v" ) {
> +            $v = $arg;
> +        }
> +        elsif ( $arg eq "-p" ) {
> +            $bindir = $ARGV[ $i + 1 ];
> +            if ( not -e "$bindir/restorecon" ) {
> +                plan skip_all => "$bindir/restorecon not found";
> +            }
> +        }
> +        $i++;
> +    }
> +
> +    # check if /tmp is really type tmpfs (TMPFS_MAGIC).
> +    $test_tmpfs = 0;
> +    $result     = system("$basedir/check_fs $v /tmp 2>/dev/null");
> +    if ( $result >> 8 eq 2 ) {
> +        $test_tmpfs = 1;
> +        plan tests => 12;
> +    }
> +    else {
> +        plan tests => 11;
> +    }
> +}
> +
> +print "Using \"restorecon\" from $bindir\n";
> +
> +# Make sure test directory removed then generate new. Using a root dir to test
> +# libselinux: Ignore the stem when looking up all matches in file context
> +print "Generating test directories\n";
> +system("rm -rf /restore_test");
> +system("mkdir -p /restore_test/in_dir");
> +system("mkdir -p /restore_test/out_dir");
> +
> +# Using semanage is much quicker than using semodule to build fc entries.
> +print "semanage adding file context entries\n";
> +system("semanage fcontext -a -t test_file_t -f d /restore_test");
> +system("semanage fcontext -a -t in_dir_t -f d /restore_test/in_dir");
> +system("semanage fcontext -a -t out_dir_t -f d /restore_test/out_dir");
> +
> +print "Add files to the directories\n";
> +system("touch /restore_test/out_dir/out_file1");
> +system("touch /restore_test/in_dir/in_file1");
> +
> +print "Test no CAP_SYS_ADMIN (setxattr failed)\n";
> +system(
> +    "runcon -t test_restorecon_t $basedir/restorecon_xattr -rD $v /restore_test"
> +);
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +if ( $result >> 8 eq 4 ) {
> +    print "Run selinux_restorecon with digests enabled and no CAP_SYS_ADMIN\n";
> +    system(
> +"runcon -t test_no_admin_restorecon_t $bindir/restorecon -rD $v /restore_test 2>&1"
> +    );
> +    print "Check there are no xattr digest entries\n";
> +    $result = system(
> +"runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test"
> +    );
> +    ok( $result >> 8 eq 4 );
> +}
> +else {
> +    print "Failed no CAP_SYS_ADMIN test\n";
> +    ok(0);
> +}
> +
> +print "Run restorecon to add digest entries, then check they match\n";
> +system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /restore_test");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result >> 8 eq 1 );
> +
> +print "Add new file context entries, then check digests do not match\n";
> +system("semanage fcontext -a -t in_file_t -f f \"/restore_test/in_dir(/.*)?\"");
> +system(
> +    "semanage fcontext -a -t out_file_t -f f \"/restore_test/out_dir(/.*)?\"");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result eq 0 );
> +
> +print "Now fix with restorecon and check digests match\n";
> +system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /restore_test");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result >> 8 eq 1 );
> +
> +print "Remove sehash entry on /restore_test/out_dir then check if removed\n";
> +system(
> +"runcon -t test_restorecon_t setfattr -x security.sehash /restore_test/out_dir"
> +);
> +$result = system(
> +"runcon -t test_restorecon_t $basedir/get_all_digests $v /restore_test/out_dir"
> +);
> +ok( $result >> 8 eq 4 );
> +
> +print
> +  "Run restorecon with SELINUX_RESTORECON_IGNORE_DIGEST = TRUE. This will\n";
> +print "rewrite the missing digest, then check they match\n";
> +system("runcon -t test_restorecon_t $bindir/restorecon -Ir $v /restore_test");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result >> 8 eq 1 );
> +
> +print "Remove some file context entries, then check digests do not match\n";
> +system("semanage fcontext -d -t in_dir_t -f d /restore_test/in_dir");
> +system("semanage fcontext -d -t out_dir_t -f d /restore_test/out_dir");
> +system("semanage fcontext -d -t in_file_t -f f \"/restore_test/in_dir(/.*)?\"");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result eq 0 );
> +
> +print "Run restorecon with digests disabled, then check digests still do\n";
> +print "not match as they were not updated\n";
> +system("runcon -t test_restorecon_t $bindir/restorecon -r $v /restore_test");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result eq 0 );
> +
> +print "Run restorecon with digests enabled, then check they match\n";
> +system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /restore_test");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +ok( $result >> 8 eq 1 );
> +
> +print "Test SELINUX_RESTORECON_SKIP_DIGEST\n";
> +system(
> +    "runcon -t test_restorecon_t $basedir/restorecon_xattr -rD $v /restore_test"
> +);
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
> +if ( $result >> 8 eq 4 ) {
> +    print
> +"Run selinux_restorecon with digests enabled and SELINUX_RESTORECON_SKIP_DIGEST = TRUE\n";
> +    system(
> +"runcon -t test_restorecon_t $basedir/selinux_restorecon_skip -rS $v /restore_test"
> +    );
> +
> +    $result = system(
> +"runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test"
> +    );
> +    ok( $result >> 8 eq 4 );
> +}
> +else {
> +    print "Failed SELINUX_RESTORECON_SKIP_DIGEST test\n";
> +    ok(0);
> +}
> +
> +system(
> +    "semanage fcontext -d -t in_file_t -f f \"/restore_test/out_dir(/.*)?\"");
> +system("semanage fcontext -d -t test_file_t -f d /restore_test");
> +system("rm -rf /restore_test");
> +
> +print
> +  "Run restorecon on /sys with digests enabled, then check digests are not\n";
> +print "written as /sys is SYSFS_MAGIC.\n";
> +system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /sys/fs/selinux");
> +$result = system(
> +    "runcon -t test_restorecon_t $basedir/get_all_digests $v /sys/fs/selinux");
> +ok( $result >> 8 eq 4 );
> +
> +if ($test_tmpfs) {
> +    print
> +"Run restorecon on /tmp with digests enabled, then check digests are not\n";
> +    print "written as /tmp is TMPFS_MAGIC\n";
> +    system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /tmp");
> +    $result =
> +      system("runcon -t test_restorecon_t $basedir/get_all_digests $v /tmp");
> +    ok( $result >> 8 eq 4 );
> +}
> +
> +exit;
> 

