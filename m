Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F7C4CEC9
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 14:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E2D218AF
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HhwvcATI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfIRO62 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:58:28 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:23551 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbfIRO61 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 10:58:27 -0400
X-EEMSG-check-017: 9823014|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="9823014"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 14:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568818705; x=1600354705;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Fk22VjG9dNzMnTWmZ2pAdwtf2zf3BpgmlCEAbQEwyw4=;
  b=HhwvcATImBDL45oieYreqlPvncMCQ5YabRrn9qk2O21MEwm09NnNHMiA
   eYxFhMl3gLWTflDqn3TQPr5KE6iRhwRDDrVlQvWuP8ERMZS3eWfzPQxWH
   4OQAbvDUMXjPVDNh7Sy1DCT+wvxEQ2/aBiCsT7uL9K+iETQEc2375wYzD
   zOZrHDkrmbn03W6uk/lgrkjBgYPJ3NS4jEJwE1DQt+QNGqt6/50aK7M0Q
   NO9gWzYh2XDccnIvG3tGEsHu0yOMpRJBHN9mY4cwchY72Y1/ke7rZwovP
   GMW6aGOXXFU1EDKJPfXcTYG5Atc1tDYDrXObKmmgfxecQxOxqoHC73w4k
   w==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28049595"
IronPort-PHdr: =?us-ascii?q?9a23=3AvpTLWBFCcNGQ3+zkIhLdnp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8+4bnLW6fgltlLVR4KTs6sC17ON9fmwEjNRqdbZ6TZeKcYKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZsJ6or1x?=
 =?us-ascii?q?fEoXREduZSyGh1IV6fgwvw6t2/8ZJ+7Shcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdv4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0Mxa1w+n7CNVyzJkeVn+XDa?=
 =?us-ascii?q?CFKKzSsUWH5uMpI+aSf48Yoy3yK+Qk5/7okX82h0Udfa+30psLcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHyk12NTzpTZ3e0X6Ih6TA2E5ymDYjdSYC3mrCB3z?=
 =?us-ascii?q?m0HodQZm9YDlCAC3Dod5+LW/0UciKdPtdhkiAYVbimU4IhzQuhtBL+y7d8Nu?=
 =?us-ascii?q?rb4DAYtZb62Nhw4O3Tkgsy+iJuA8uB1GGNSjI8omRdfT493KllrQRdw1aF3L?=
 =?us-ascii?q?Mw1+ZZHtxa/f9+WTA6PJ/awvdSAczzXB7MZNGEVBCtRdDwRXkqQ9YwxcIeS1?=
 =?us-ascii?q?hyFs/kjR3Z2SeuRbgPmPjDHJUp9orE1mX1YsN6zGzLkqImigoIWMxKYFa6i7?=
 =?us-ascii?q?Z/+g6bPIvAl0GUhu7+bqgH9DLc/2eEi2yVtQdXVxAmAvaNZmwWekaD9Yex3U?=
 =?us-ascii?q?jFVbL7TO18YwY=3D?=
X-IPAS-Result: =?us-ascii?q?A2B/AACARIJd/wHyM5BmHAEBAQQBAQcEAQGBVQUBAQsBg?=
 =?us-ascii?q?W0qbVMyKoQijw9NAQEBAQEBBoE2iXSPLYF7CQEBAQEBAQEBASMRAQIBAYQ/A?=
 =?us-ascii?q?oMDIzYHDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmcBBSMVUQsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfPwGBagMJFLBdgTKFTIMwgUmBDCgBjAgYeIEHgRABJ4JrPoIag?=
 =?us-ascii?q?XMRJoMLglgEjGWJGIEylU6CLIIuhFeNeQYbgyiVeY4QmwsMJYFYKwgCGAghD?=
 =?us-ascii?q?4MnCUcQFIFaF4dXhmckAzCBBgEBjRoBJYIuAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 14:58:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IEwNQJ016735;
        Wed, 18 Sep 2019 10:58:23 -0400
Subject: Re: [PATCH V4 1/3] selinux-testsuite: Add BPF tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20190917145640.25629-1-richard_c_haines@btinternet.com>
 <20190917145640.25629-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <38ef3983-987f-692b-fe1d-14ed15a7a507@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 10:58:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917145640.25629-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/17/19 10:56 AM, Richard Haines wrote:
> This adds basic BPF tests for map and prog functions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>   README.md              |  4 ++-
>   defconfig              |  5 +++
>   policy/Makefile        |  4 +++
>   policy/test_bpf.te     | 78 ++++++++++++++++++++++++++++++++++++++++++
>   tests/Makefile         |  7 ++++
>   tests/bpf/.gitignore   |  2 ++
>   tests/bpf/Makefile     | 10 ++++++
>   tests/bpf/bpf_common.c | 53 ++++++++++++++++++++++++++++
>   tests/bpf/bpf_common.h | 34 ++++++++++++++++++
>   tests/bpf/bpf_test.c   | 77 +++++++++++++++++++++++++++++++++++++++++
>   tests/bpf/test         | 64 ++++++++++++++++++++++++++++++++++
>   11 files changed, 337 insertions(+), 1 deletion(-)
>   create mode 100644 policy/test_bpf.te
>   create mode 100644 tests/bpf/.gitignore
>   create mode 100644 tests/bpf/Makefile
>   create mode 100644 tests/bpf/bpf_common.c
>   create mode 100644 tests/bpf/bpf_common.h
>   create mode 100644 tests/bpf/bpf_test.c
>   create mode 100755 tests/bpf/test
> 
> diff --git a/README.md b/README.md
> index 26784f8..1396c8e 100644
> --- a/README.md
> +++ b/README.md
> @@ -51,6 +51,7 @@ similar dependencies):
>   * iptables _(to load the `iptables SECMARK` rules during `inet_socket` tests)_
>   * lksctp-tools-devel _(to build the SCTP test programs)_
>   * attr _(tools used by the overlayfs tests)_
> +* libbpf-devel _(tools used by the bpf tests)_
>   
>   On a modern Fedora system you can install these dependencies with the
>   following command:
> @@ -65,7 +66,8 @@ following command:
>   		netlabel_tools \
>   		iptables \
>   		lksctp-tools-devel \
> -		attr
> +		attr \
> +		libbpf-devel
>   
>   The testsuite requires a pre-existing base policy configuration of SELinux,
>   using either the old example policy or the reference policy as the baseline.
> diff --git a/defconfig b/defconfig
> index d7f0ea5..cb57f22 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -62,3 +62,8 @@ CONFIG_ANDROID_BINDER_IPC=y
>   # This will configure the Dynamically Allocated Binder Devices added
>   # to 5.0+ kernels:
>   CONFIG_ANDROID_BINDERFS=y
> +
> +# Test BPF + check in selinux_file_receive and selinux_binder_transfer_files.
> +# They are not required for SELinux operation itself.
> +CONFIG_BPF=y
> +CONFIG_BPF_SYSCALL=y
> diff --git a/policy/Makefile b/policy/Makefile
> index 305b572..16a4469 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
>   TARGETS += test_sctp.te
>   endif
>   
> +ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_bpf.te
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
>   endif
> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
> new file mode 100644
> index 0000000..89d240c
> --- /dev/null
> +++ b/policy/test_bpf.te
> @@ -0,0 +1,78 @@
> +#
> +################# BPF selinux-testsuite policy module ######################
> +#
> +
> +attribute bpfdomain;
> +
> +################################### Main ###################################
> +type test_bpf_t;
> +domain_type(test_bpf_t)
> +unconfined_runs_test(test_bpf_t)
> +typeattribute test_bpf_t testdomain;
> +typeattribute test_bpf_t bpfdomain;
> +
> +allow test_bpf_t self:process { setrlimit };
> +#allow test_bpf_t self:capability { sys_resource sys_admin };
> +allow test_bpf_t self:capability { sys_resource };
> +allow test_bpf_t self:bpf { map_create map_read map_write prog_load prog_run };
> +
> +############################## Deny map_create #############################
> +type test_bpf_deny_map_create_t;
> +domain_type(test_bpf_deny_map_create_t)
> +unconfined_runs_test(test_bpf_deny_map_create_t)
> +typeattribute test_bpf_deny_map_create_t testdomain;
> +typeattribute test_bpf_deny_map_create_t bpfdomain;
> +
> +allow test_bpf_deny_map_create_t self:process { setrlimit };
> +allow test_bpf_deny_map_create_t self:capability { sys_resource };
> +allow test_bpf_deny_map_create_t self:bpf { map_read map_write prog_load prog_run };
> +
> +############################## Deny map_read ##############################
> +type test_bpf_deny_map_read_t;
> +domain_type(test_bpf_deny_map_read_t)
> +unconfined_runs_test(test_bpf_deny_map_read_t)
> +typeattribute test_bpf_deny_map_read_t testdomain;
> +typeattribute test_bpf_deny_map_read_t bpfdomain;
> +
> +allow test_bpf_deny_map_read_t self:process { setrlimit };
> +allow test_bpf_deny_map_read_t self:capability { sys_resource };
> +allow test_bpf_deny_map_read_t self:bpf { map_create map_write prog_load prog_run };
> +
> +############################## Deny map_write ##############################
> +type test_bpf_deny_map_write_t;
> +domain_type(test_bpf_deny_map_write_t)
> +unconfined_runs_test(test_bpf_deny_map_write_t)
> +typeattribute test_bpf_deny_map_write_t testdomain;
> +typeattribute test_bpf_deny_map_write_t bpfdomain;
> +
> +allow test_bpf_deny_map_write_t self:process { setrlimit };
> +allow test_bpf_deny_map_write_t self:capability { sys_resource };
> +allow test_bpf_deny_map_write_t self:bpf { map_create map_read prog_load prog_run };
> +
> +############################## Deny prog_load ##############################
> +type test_bpf_deny_prog_load_t;
> +domain_type(test_bpf_deny_prog_load_t)
> +unconfined_runs_test(test_bpf_deny_prog_load_t)
> +typeattribute test_bpf_deny_prog_load_t testdomain;
> +typeattribute test_bpf_deny_prog_load_t bpfdomain;
> +
> +allow test_bpf_deny_prog_load_t self:process { setrlimit };
> +allow test_bpf_deny_prog_load_t self:capability { sys_resource };
> +allow test_bpf_deny_prog_load_t self:bpf { map_create map_read map_write prog_run };
> +
> +############################## Deny prog_run ###############################
> +type test_bpf_deny_prog_run_t;
> +domain_type(test_bpf_deny_prog_run_t)
> +unconfined_runs_test(test_bpf_deny_prog_run_t)
> +typeattribute test_bpf_deny_prog_run_t testdomain;
> +typeattribute test_bpf_deny_prog_run_t bpfdomain;
> +
> +allow test_bpf_deny_prog_run_t self:process { setrlimit };
> +allow test_bpf_deny_prog_run_t self:capability { sys_resource };
> +allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
> +
> +#
> +############ Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(bpfdomain)
> +userdom_sysadm_entry_spec_domtrans_to(bpfdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 63aa325..80187b7 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -42,6 +42,13 @@ ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && test -e
>   SUBDIRS += binder
>   endif
>   
> +ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +ifneq ($(shell ./kvercmp $$(uname -r) 4.4),-1)

The SELinux checks for bpf weren't introduced until Linux v4.15.

> +SUBDIRS += bpf
> +export CFLAGS += -DHAVE_BPF
> +endif
> +endif
> +
>   ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
>   SUBDIRS += infiniband_endport
>   endif
> diff --git a/tests/bpf/.gitignore b/tests/bpf/.gitignore
> new file mode 100644
> index 0000000..1919ff8
> --- /dev/null
> +++ b/tests/bpf/.gitignore
> @@ -0,0 +1,2 @@
> +bpf_test
> +bpf_common
> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> new file mode 100644
> index 0000000..46817a5
> --- /dev/null
> +++ b/tests/bpf/Makefile
> @@ -0,0 +1,10 @@
> +TARGETS = bpf_test
> +DEPS = bpf_common.c bpf_common.h
> +LDLIBS += -lselinux -lbpf
> +
> +all: $(TARGETS)
> +
> +clean:
> +	rm -f $(TARGETS)
> +
> +$(TARGETS): $(DEPS)
> diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
> new file mode 100644
> index 0000000..738c607
> --- /dev/null
> +++ b/tests/bpf/bpf_common.c
> @@ -0,0 +1,53 @@
> +#include "bpf_common.h"
> +
> +int create_bpf_map(void)
> +{
> +	int map_fd, key;
> +	long long value = 0;
> +
> +	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key),
> +				sizeof(value), 256, 0);
> +	if (map_fd < 0) {
> +		fprintf(stderr, "Failed to create BPF map: %s\n",
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	return map_fd;
> +}
> +
> +int create_bpf_prog(void)
> +{
> +	int prog_fd;
> +	size_t insns_cnt;
> +
> +	struct bpf_insn prog[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN(),
> +	};
> +	insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
> +
> +	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
> +				   insns_cnt, "GPL", 0, NULL, 0);
> +
> +	if (prog_fd < 0) {
> +		fprintf(stderr, "Failed to load BPF prog: %s\n",
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	return prog_fd;
> +}
> +
> +void bpf_setrlimit(void)
> +{
> +	int result;
> +	struct rlimit r = { RLIM_INFINITY, RLIM_INFINITY };
> +
> +	result = setrlimit(RLIMIT_MEMLOCK, &r);

Is this required?  Why must it be unlimited especially for such trivial 
map/prog examples?

> +	if (result < 0) {
> +		fprintf(stderr, "Failed to set resource limit: %s\n",
> +			strerror(errno));
> +		exit(-1);
> +	}
> +}
> diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
> new file mode 100644
> index 0000000..44ac28f
> --- /dev/null
> +++ b/tests/bpf/bpf_common.h
> @@ -0,0 +1,34 @@
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <selinux/selinux.h>
> +#include <bpf/bpf.h>
> +#include <linux/bpf.h>
> +#include <sys/resource.h>
> +
> +extern int create_bpf_map(void);
> +extern int create_bpf_prog(void);
> +extern void bpf_setrlimit(void);
> +
> +/* edited eBPF instruction library */
> +/* Short form of mov, dst_reg = imm32 */
> +#define BPF_MOV64_IMM(DST, IMM)				\
> +	((struct bpf_insn) {				\
> +		.code  = BPF_ALU64 | BPF_MOV | BPF_K,	\
> +			 .dst_reg = DST,				\
> +				    .src_reg = 0,				\
> +					       .off   = 0,				\
> +							.imm   = IMM })
> +
> +/* Program exit */
> +#define BPF_EXIT_INSN()				\
> +	((struct bpf_insn) {			\
> +		.code  = BPF_JMP | BPF_EXIT,	\
> +			 .dst_reg = 0,			\
> +				    .src_reg = 0,			\
> +					       .off   = 0,			\
> +							.imm   = 0 })
> +
> diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
> new file mode 100644
> index 0000000..3c6a29c
> --- /dev/null
> +++ b/tests/bpf/bpf_test.c
> @@ -0,0 +1,77 @@
> +#include "bpf_common.h"
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s -m|-p [-v]\n"
> +		"Where:\n\t"
> +		"-m    Create BPF map fd\n\t"
> +		"-p    Create BPF prog fd\n\t"
> +		"-v Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt, result, fd;
> +	bool verbose = false;
> +	char *context;
> +
> +	enum {
> +		MAP_FD = 1,
> +		PROG_FD
> +	} bpf_fd_type;
> +
> +	while ((opt = getopt(argc, argv, "mpv")) != -1) {
> +		switch (opt) {
> +		case 'm':
> +			bpf_fd_type = MAP_FD;
> +			break;
> +		case 'p':
> +			bpf_fd_type = PROG_FD;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	result = getcon(&context);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain SELinux context\n");
> +		exit(-1);
> +	}
> +
> +	if (verbose)
> +		printf("Process context:\n\t%s\n", context);
> +
> +	free(context);
> +
> +	/* If BPF enabled, then need to set limits */
> +	bpf_setrlimit();
> +
> +	switch (bpf_fd_type) {
> +	case MAP_FD:
> +		if (verbose)
> +			printf("Creating BPF map\n");
> +
> +		fd = create_bpf_map();
> +		break;
> +	case PROG_FD:
> +		if (verbose)
> +			printf("Creating BPF prog\n");
> +
> +		fd = create_bpf_prog();
> +		break;
> +	default:
> +		usage(argv[0]);
> +	}
> +
> +	if (fd < 0)
> +		return fd;
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/bpf/test b/tests/bpf/test
> new file mode 100755
> index 0000000..ee00a19
> --- /dev/null
> +++ b/tests/bpf/test
> @@ -0,0 +1,64 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    $test_count = 7;
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
> +    plan tests => $test_count;
> +}
> +
> +#
> +# These tests are run with: kernel.unprivileged_bpf_disabled = FALSE
> +#
> +
> +#
> +################ Core BPF Tests #######################
> +#
> +# BPF map - BPF_MAP_TYPE_ARRAY
> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -m $v";
> +ok( $result eq 0 );
> +
> +# BPF prog - BPF_PROG_TYPE_SOCKET_FILTER
> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
> +ok( $result eq 0 );
> +
> +# Deny map_create permission
> +$result =
> +  system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2>&1";
> +ok($result);
> +
> +# Deny map_read permission
> +$result =
> +  system "runcon -t test_bpf_deny_map_read_t $basedir/bpf_test -m $v 2>&1";
> +ok($result);
> +
> +# Deny map_write permission
> +$result =
> +  system "runcon -t test_bpf_deny_map_write_t $basedir/bpf_test -m $v 2>&1";
> +ok($result);
> +
> +# Deny prog_load permission
> +$result =
> +  system "runcon -t test_bpf_deny_prog_load_t $basedir/bpf_test -p $v 2>&1";
> +ok($result);
> +
> +# Deny prog_run permission
> +$result =
> +  system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
> +ok($result);
> +
> +exit;
> 

