Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ADFC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2820650
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="H2HYSYcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfIPSF0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:05:26 -0400
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:18797 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfIPSFZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 14:05:25 -0400
X-EEMSG-check-017: 28379323|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28379323"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 18:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568656963; x=1600192963;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=e2W1kQj0xh/4DZ7PNZ7b+ZEIWtxd/kAN/gf+phYhkMI=;
  b=H2HYSYcm7Hl7XnS+IAYBs9KuWX0MM/wRfzuyhKQWAATqSRtzMsQ+aGos
   gnWcu9fWBgHFXtmhpQYiEx6amke8LMGpZcmTa/wjVklfqd539bZVuJVZr
   w68/ejxlQyPVGiumiqdC9+AawWFaU6lHt5Op+i8N0aelrCUF788BZGsRm
   2FvRU8bCUs+NvNjONWO7+A3AjfugXQzGdUx3WzPXVDtjFMlG8qpldRf+4
   QBSP+22Wzqs2wELxxK5cjJ7Qh45UwWbuxNuyg+DtI+pYN0djQeFQqNYxr
   rXAttLEBjx8s0ho3ROvioAOy77PnE/V6AW4zPXpQ1vIqNF7Dt0906MP2i
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="27964451"
IronPort-PHdr: =?us-ascii?q?9a23=3AT+Ux6B2e2by3gGNCsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKfnxwZ3uMQTl6Ol3ixeRBMOHsqkC0rGd6vmwESxYuNDd6SpEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQYjId4N6o8xB?=
 =?us-ascii?q?TFrmZVd+lV2GhkIU6fkwvm6sq/4ZJv7T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YodvxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdq5boMy+J2ukDsWWW6fdrW+K1i24grgF8uiWhxtsyhY?=
 =?us-ascii?q?nRhoIa1FbE/jhkzoYwP9K4TEp7bsCkEZBNsCyaLJZ5Qtg5TmF0uCc11r0GuZ?=
 =?us-ascii?q?mhcCgM05Qo3QTTa/OAc4iW+x/uUvuaLzRghH99Zb6yiBm//VKgx+HhTMW4zl?=
 =?us-ascii?q?lHojRfntXRsH0Gygbd5dKdSvRn+0eswTOP1wfO5e5aOU00jq/bK4I5wr43i5?=
 =?us-ascii?q?oTrVzPHi/ol0Xyi6+bblkk9fKy6+Tmf7XmvYWQN5N0iw7iMqQundazAeIkPQ?=
 =?us-ascii?q?gVQ2eX4+G81Lzn/UHhQbVKiOM5krXBvZzHKskWqbS1Dg9I3oo59RqyACmq3M?=
 =?us-ascii?q?4FkXUfKVJKYhOHj4znO1HUJ/D4CO+yg0+xnzdw3P3GIr3gDYnNLnjEirvhe6?=
 =?us-ascii?q?195FRGxAo8ytBf+YpYCqsdL/LrRk/xqNvYAwcjMwy13+nnCM9y1pkDVm2XHq?=
 =?us-ascii?q?CWKKPSvkWJ5uIpPeaMf5QYty3hK/gk4f7ukWE2mUUbfaa3wZsbcmy3HvNjI0?=
 =?us-ascii?q?+Be3rjns8BEXsWvgo5VOHqk0ONUTpSZ3a0QqI96So2CJypDYjdXIChmr+B0z?=
 =?us-ascii?q?mhHp1QeG9GDkqAEXDyd4WLQ/0Mcj6dItd9kjwYUrisU5ch2guztA/+0LdnNv?=
 =?us-ascii?q?Db+jActZ760dh14OrTlQss+jBuE8ud1GSNHClImTYyRjQ21bpz6Wx0y1GOyu?=
 =?us-ascii?q?Asmf1TFdVJ68RCZQczNJjR1MRwF9H0Rg/beNqVDl2hR4PiSSo8StM33s8mfU?=
 =?us-ascii?q?lwAZOhgwrF0i7sBKUa0/STDYEw2rrVwny0IsF60XuA364k3Hc8Rc4aDnGrnq?=
 =?us-ascii?q?5y8UDoAofNl0iI3/Kxeb80wD/G9GDFy3GH+k5fTlgjAu3+QXkDax6O/pzC7U?=
 =?us-ascii?q?TYQurrUO92Pw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CFAgBQzX9d/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qbVIBMiqEIY8JTQEBAQEBAQaBESWJc49AgWcJAQEBAQEBAQEBIxEBAgEBh?=
 =?us-ascii?q?D8Cgm8jNwYOAgwBAQEEAQEBAQEFAwEBbIUuDII6KQGCZwEFIxVRCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYFqAwkUrTiBMoVMgzeBSYEMKAGLdxh4gQeBEAEnDIJfP?=
 =?us-ascii?q?oIagXMRDgEXgwuCWASMXYg2XoEylUeCLIIuhFeNdQYbgjVxhlaPHY4JmxIig?=
 =?us-ascii?q?VgrCAIYCCEPgycJgkUXh1eGZyQDMIEGAQGNGgElgi4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Sep 2019 18:02:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GI2f0D032123;
        Mon, 16 Sep 2019 14:02:41 -0400
Subject: Re: [PATCH V3 1/2] selinux-testsuite: Add BPF tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20190814092142.3894-1-richard_c_haines@btinternet.com>
 <00949930-14ab-7b58-9be9-23658eed6baf@tycho.nsa.gov>
 <19b043bc4d5efbf2f1994958c0a74709a34e3ad0.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <15534c4e-4607-ac5e-3ac5-ec5b54b92bd3@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 14:02:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <19b043bc4d5efbf2f1994958c0a74709a34e3ad0.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 1:54 PM, Richard Haines wrote:
> On Fri, 2019-09-13 at 13:39 -0400, Stephen Smalley wrote:
>> On 8/14/19 5:21 AM, Richard Haines wrote:
>>> This adds basic BPF tests for map and prog functions.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>> ---
>>> V2 Change - Split BPF code into bpf_common.c for others to use.
>>> V3 Changes - Correct style, Fix typos
>>>
>>>    README.md              |  4 +-
>>>    defconfig              |  5 +++
>>>    policy/Makefile        |  4 ++
>>>    policy/test_bpf.te     | 77 +++++++++++++++++++++++++++++++++
>>>    tests/Makefile         |  4 ++
>>>    tests/bpf/.gitignore   |  2 +
>>>    tests/bpf/Makefile     | 12 ++++++
>>>    tests/bpf/bpf_common.c | 97
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>    tests/bpf/bpf_test.c   | 82 +++++++++++++++++++++++++++++++++++
>>>    tests/bpf/test         | 58 +++++++++++++++++++++++++
>>>    10 files changed, 344 insertions(+), 1 deletion(-)
>>>    create mode 100644 policy/test_bpf.te
>>>    create mode 100644 tests/bpf/.gitignore
>>>    create mode 100644 tests/bpf/Makefile
>>>    create mode 100644 tests/bpf/bpf_common.c
>>>    create mode 100644 tests/bpf/bpf_test.c
>>>    create mode 100755 tests/bpf/test
>>>
>>> diff --git a/README.md b/README.md
>>> index 26784f8..1396c8e 100644
>>> --- a/README.md
>>> +++ b/README.md
>>> @@ -51,6 +51,7 @@ similar dependencies):
>>>    * iptables _(to load the `iptables SECMARK` rules during
>>> `inet_socket` tests)_
>>>    * lksctp-tools-devel _(to build the SCTP test programs)_
>>>    * attr _(tools used by the overlayfs tests)_
>>> +* libbpf-devel _(tools used by the bpf tests)_
>>>    
>>>    On a modern Fedora system you can install these dependencies with
>>> the
>>>    following command:
>>> @@ -65,7 +66,8 @@ following command:
>>>    		netlabel_tools \
>>>    		iptables \
>>>    		lksctp-tools-devel \
>>> -		attr
>>> +		attr \
>>> +		libbpf-devel
>>
>> Since we stipulate it as a dependency here, we shouldn't make the
>> test
>> conditional on the presence of the header.  Otherwise, the test may
>> silently be skipped due to an oversight even on kernels/policies
>> that
>> support it.
> 
> Fixed
> 
>>
>>>    
>>>    The testsuite requires a pre-existing base policy configuration
>>> of SELinux,
>>>    using either the old example policy or the reference policy as
>>> the baseline.
>>> diff --git a/defconfig b/defconfig
>>> index d7f0ea5..96f6443 100644
>>> --- a/defconfig
>>> +++ b/defconfig
>>> @@ -62,3 +62,8 @@ CONFIG_ANDROID_BINDER_IPC=y
>>>    # This will configure the Dynamically Allocated Binder Devices
>>> added
>>>    # to 5.0+ kernels:
>>>    CONFIG_ANDROID_BINDERFS=y
>>> +
>>> +# Test BPF + check in selinux_file_receive and
>>> selinux_binder_transfer_files.
>>> +# They are not required for SELinux operation itself.
>>> +CONFIG_BP=y
>>
>> Typo in the config option name
> 
> Fixed
>>
>>> +CONFIG_BPF_SYSCALL=y
>>> diff --git a/policy/Makefile b/policy/Makefile
>>> index 305b572..16a4469 100644
>>> --- a/policy/Makefile
>>> +++ b/policy/Makefile
>>> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q
>>> corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
>>>    TARGETS += test_sctp.te
>>>    endif
>>>    
>>> +ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt
>>> && echo true),true)
>>> +TARGETS += test_bpf.te
>>> +endif
>>> +
>>>    ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>>    TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te,
>>> $(TARGETS))
>>>    endif
>>> diff --git a/policy/test_bpf.te b/policy/test_bpf.te
>>> new file mode 100644
>>> index 0000000..38b7729
>>> --- /dev/null
>>> +++ b/policy/test_bpf.te
>>> @@ -0,0 +1,77 @@
>>> +#
>>> +################# BPF selinux-testsuite policy module
>>> ######################
>>> +#
>>> +
>>> +attribute bpfdomain;
>>> +
>>> +################################### Main
>>> ###################################
>>> +type test_bpf_t;
>>> +domain_type(test_bpf_t)
>>> +unconfined_runs_test(test_bpf_t)
>>> +typeattribute test_bpf_t testdomain;
>>> +typeattribute test_bpf_t bpfdomain;
>>> +
>>> +allow test_bpf_t self:process { setrlimit };
>>> +allow test_bpf_t self:capability { sys_resource sys_admin };
>>
>> The point (or at least part of it) of introducing the bpf access
>> controls was to provide a middle ground between requiring
>> CAP_SYS_ADMIN
>> and allowing all processes to create/use these objects.  To truly
>> test
>> that, you may need to set the sysctl to allow unprivileged use and
>> further there are still cases that require CAP_SYS_ADMIN even then,
>> so
>> the exact program/map matters.
> 
> I have removed the sys_admin perm as the Fedora default is:
> sysctl kernel.unprivileged_bpf_disabled
> kernel.unprivileged_bpf_disabled = 0
> 
> I've also found a map & prog type that requires sys_admin:
> BPF_MAP_TYPE_LPM_TRIE and BPF_PROG_TYPE_UNSPEC
> These tested ok.
> 
> Is it worth setting kernel.unprivileged_bpf_disabled = 1 and testing as
> it can only be reset by a reboot of the system, if so I'll add a
> message after tests.

I don't think so; we are primarily interested in testing the new SELinux 
BPF controls, not sys_admin, here.

> 
>>
>>> +allow test_bpf_t self:bpf { map_create map_read map_write
>>> prog_load prog_run };
>>> +
>>> +############################## Deny map_create
>>> #############################
>>> +type test_bpf_deny_map_create_t;
>>> +domain_type(test_bpf_deny_map_create_t)
>>> +unconfined_runs_test(test_bpf_deny_map_create_t)
>>> +typeattribute test_bpf_deny_map_create_t testdomain;
>>> +typeattribute test_bpf_deny_map_create_t bpfdomain;
>>> +
>>> +allow test_bpf_deny_map_create_t self:process { setrlimit };
>>> +allow test_bpf_deny_map_create_t self:capability { sys_resource
>>> sys_admin };
>>> +allow test_bpf_deny_map_create_t self:bpf { map_read map_write
>>> prog_load prog_run };
>>> +
>>> +############################## Deny map_read
>>> ##############################
>>> +type test_bpf_deny_map_read_t;
>>> +domain_type(test_bpf_deny_map_read_t)
>>> +unconfined_runs_test(test_bpf_deny_map_read_t)
>>> +typeattribute test_bpf_deny_map_read_t testdomain;
>>> +typeattribute test_bpf_deny_map_read_t bpfdomain;
>>> +
>>> +allow test_bpf_deny_map_read_t self:process { setrlimit };
>>> +allow test_bpf_deny_map_read_t self:capability { sys_resource
>>> sys_admin };
>>> +allow test_bpf_deny_map_read_t self:bpf { map_create map_write
>>> prog_load prog_run };
>>> +
>>> +############################## Deny map_write
>>> ##############################
>>> +type test_bpf_deny_map_write_t;
>>> +domain_type(test_bpf_deny_map_write_t)
>>> +unconfined_runs_test(test_bpf_deny_map_write_t)
>>> +typeattribute test_bpf_deny_map_write_t testdomain;
>>> +typeattribute test_bpf_deny_map_write_t bpfdomain;
>>> +
>>> +allow test_bpf_deny_map_write_t self:process { setrlimit };
>>> +allow test_bpf_deny_map_write_t self:capability { sys_resource
>>> sys_admin };
>>> +allow test_bpf_deny_map_write_t self:bpf { map_create map_read
>>> prog_load prog_run };
>>> +
>>> +############################## Deny prog_load
>>> ##############################
>>> +type test_bpf_deny_prog_load_t;
>>> +domain_type(test_bpf_deny_prog_load_t)
>>> +unconfined_runs_test(test_bpf_deny_prog_load_t)
>>> +typeattribute test_bpf_deny_prog_load_t testdomain;
>>> +typeattribute test_bpf_deny_prog_load_t bpfdomain;
>>> +
>>> +allow test_bpf_deny_prog_load_t self:process { setrlimit };
>>> +allow test_bpf_deny_prog_load_t self:capability { sys_resource
>>> sys_admin };
>>> +allow test_bpf_deny_prog_load_t self:bpf { map_create map_read
>>> map_write prog_run };
>>> +
>>> +############################## Deny prog_run
>>> ###############################
>>> +type test_bpf_deny_prog_run_t;
>>> +domain_type(test_bpf_deny_prog_run_t)
>>> +unconfined_runs_test(test_bpf_deny_prog_run_t)
>>> +typeattribute test_bpf_deny_prog_run_t testdomain;
>>> +typeattribute test_bpf_deny_prog_run_t bpfdomain;
>>> +
>>> +allow test_bpf_deny_prog_run_t self:process { setrlimit };
>>> +allow test_bpf_deny_prog_run_t self:capability { sys_resource
>>> sys_admin };
>>> +allow test_bpf_deny_prog_run_t self:bpf { map_create map_read
>>> map_write prog_load };
>>> +
>>> +#
>>> +############ Allow these domains to be entered from sysadm domain
>>> ############
>>> +#
>>> +miscfiles_domain_entry_test_files(bpfdomain)
>>> +userdom_sysadm_entry_spec_domtrans_to(bpfdomain)
>>> diff --git a/tests/Makefile b/tests/Makefile
>>> index 63aa325..2717452 100644
>>> --- a/tests/Makefile
>>> +++ b/tests/Makefile
>>> @@ -42,6 +42,10 @@ ifeq ($(shell grep -q binder
>>> $(POLDEV)/include/support/all_perms.spt && test -e
>>>    SUBDIRS += binder
>>>    endif
>>>    
>>> +ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt
>>> && test -e $(INCLUDEDIR)/bpf/bpf.h && echo true),true)
>>> +SUBDIRS += bpf
>>> +endif
>>
>> Don't make it conditional on the header since that is stated build
>> dependency.  Do make it or the test itself conditional on kernel
>> version
>> so that it doesn't break on kernels that predate the bpf access
>> controls.
> 
> I've set this for kernel 4.4 as that supports kernel.unprivileged_bpf_disabled
> 
>>
>>> +
>>>    ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST="
>>> infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
>>>    SUBDIRS += infiniband_endport
>>>    endif
>>> diff --git a/tests/bpf/.gitignore b/tests/bpf/.gitignore
>>> new file mode 100644
>>> index 0000000..1919ff8
>>> --- /dev/null
>>> +++ b/tests/bpf/.gitignore
>>> @@ -0,0 +1,2 @@
>>> +bpf_test
>>> +bpf_common
>>> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
>>> new file mode 100644
>>> index 0000000..78ae9db
>>> --- /dev/null
>>> +++ b/tests/bpf/Makefile
>>> @@ -0,0 +1,12 @@
>>> +TARGETS = bpf_test
>>> +DEPS = bpf_common.c
>>> +
>>> +LDLIBS += -lselinux -lbpf
>>> +CFLAGS += -DHAVE_BPF
>>> +
>>> +all: $(TARGETS)
>>> +
>>> +clean:
>>> +	rm -f $(TARGETS)
>>> +
>>> +$(TARGETS): $(DEPS)
>>> diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
>>> new file mode 100644
>>> index 0000000..3ac47be
>>> --- /dev/null
>>> +++ b/tests/bpf/bpf_common.c
>>> @@ -0,0 +1,97 @@
>>> +#include <stdio.h>
>>> +#include <string.h>
>>> +#include <stdlib.h>
>>> +#include <errno.h>
>>> +
>>> +#if HAVE_BPF /* Start HAVE_BPF */
>>
>> Not sure what the point of this #if is given that you define it
>> unconditionally in the Makefile and you made the package that
>> provides
>> the header a build dependency.
> 
> 
> I've reworked the tests to remove this in bpf_common.c
> 
>>
>>> +#include <bpf/bpf.h>
>>> +#include <linux/bpf.h>
>>> +#include <sys/resource.h>
>>> +
>>> +/* edited eBPF instruction library */
>>> +/* Short form of mov, dst_reg = imm32 */
>>> +#define BPF_MOV64_IMM(DST, IMM)				\
>>> +	((struct bpf_insn) {				\
>>> +		.code  = BPF_ALU64 | BPF_MOV | BPF_K,	\
>>> +			 .dst_reg = DST,				\
>>> +				    .src_reg = 0,				
>>> \
>>> +					       .off   = 0,			
>>> 	\
>>> +							.imm   = IMM })
>>> +
>>> +/* Program exit */
>>> +#define BPF_EXIT_INSN()				\
>>> +	((struct bpf_insn) {			\
>>> +		.code  = BPF_JMP | BPF_EXIT,	\
>>> +			 .dst_reg = 0,			\
>>> +				    .src_reg = 0,			\
>>> +					       .off   = 0,			
>>> \
>>> +							.imm   = 0 })
>>
>> That's ugly but I guess Paul wants it that way.
>>
>>> +
>>> +int create_bpf_map(void)
>>> +{
>>> +	int map_fd, key;
>>> +	long long value = 0;
>>> +
>>> +	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key),
>>> +				sizeof(value), 256, 0);
>>> +	if (map_fd < 0) {
>>> +		fprintf(stderr, "Failed to create BPF map: %s\n",
>>> +			strerror(errno));
>>> +		return -1;
>>> +	}
>>> +
>>> +	return map_fd;
>>> +}
>>> +
>>> +int create_bpf_prog(void)
>>> +{
>>> +	int prog_fd;
>>> +	size_t insns_cnt;
>>> +
>>> +	struct bpf_insn prog[] = {
>>> +		BPF_MOV64_IMM(BPF_REG_0, 1),
>>> +		BPF_EXIT_INSN(),
>>> +	};
>>> +	insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
>>> +
>>> +	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
>>> +				   insns_cnt, "GPL", 0, NULL, 0);
>>> +	if (prog_fd < 0) {
>>> +		fprintf(stderr, "Failed to load BPF prog: %s\n",
>>> +			strerror(errno));
>>> +		return -1;
>>> +	}
>>> +
>>> +	return prog_fd;
>>> +}
>>> +
>>> +void bpf_setrlimit(void)
>>> +{
>>> +	int result;
>>> +	struct rlimit r = { RLIM_INFINITY, RLIM_INFINITY };
>>> +
>>> +	result = setrlimit(RLIMIT_MEMLOCK, &r);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to set resource limit: %s\n",
>>> +			strerror(errno));
>>> +		exit(-1);
>>> +	}
>>> +}
>>> +
>>> +#else
>>> +int create_bpf_map(void)
>>> +{
>>> +	fprintf(stderr, "BPF map not supported\n");
>>> +	return -1;
>>> +}
>>> +
>>> +int create_bpf_prog(void)
>>> +{
>>> +	fprintf(stderr, "BPF prog not supported\n");
>>> +	return -1;
>>> +}
>>> +
>>> +void bpf_setrlimit(void)
>>> +{
>>> +}
>>> +#endif /* End HAVE_BPF */
>>> diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
>>> new file mode 100644
>>> index 0000000..b866651
>>> --- /dev/null
>>> +++ b/tests/bpf/bpf_test.c
>>> @@ -0,0 +1,82 @@
>>> +#include <stdio.h>
>>> +#include <unistd.h>
>>> +#include <string.h>
>>> +#include <stdlib.h>
>>> +#include <errno.h>
>>> +#include <stdbool.h>
>>> +#include <selinux/selinux.h>
>>> +
>>> +int create_bpf_map(void);
>>> +int create_bpf_prog(void);
>>> +void bpf_setrlimit(void);
>>> +
>>> +static void usage(char *progname)
>>> +{
>>> +	fprintf(stderr,
>>> +		"usage:  %s [-m|-p] [-v]\n"
>>> +		"Where:\n\t"
>>> +		"-m    Create BPF map fd\n\t"
>>> +		"-p    Create BPF prog fd\n\t"
>>> +		"-v Print information.\n", progname);
>>> +	exit(-1);
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	int opt, result, fd, bpf_fd_type = 0;
>>> +	bool verbose = false;
>>> +	char *context;
>>> +
>>> +	while ((opt = getopt(argc, argv, "mpv")) != -1) {
>>> +		switch (opt) {
>>> +		case 'm':
>>> +			bpf_fd_type = 1;
>>> +			break;
>>> +		case 'p':
>>> +			bpf_fd_type = 2;
>>
>> No magic constants please, use a #define or enum with symbolic names.
> Fixed
>>
>>> +			break;
>>> +		case 'v':
>>> +			verbose = true;
>>> +			break;
>>> +		default:
>>> +			usage(argv[0]);
>>> +		}
>>> +	}
>>> +
>>> +	result = getcon(&context);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain SELinux context\n");
>>> +		exit(-1);
>>> +	}
>>> +
>>> +	if (verbose)
>>> +		printf("Process context:\n\t%s\n", context);
>>> +
>>> +	free(context);
>>> +
>>> +	/* If BPF enabled, then need to set limits */
>>> +	bpf_setrlimit();
>>> +
>>> +	switch (bpf_fd_type) {
>>> +	case 1:
>>> +		if (verbose)
>>> +			printf("Creating BPF map\n");
>>> +
>>> +		fd = create_bpf_map();
>>> +		break;
>>> +	case 2:
>>> +		if (verbose)
>>> +			printf("Creating BPF prog\n");
>>> +
>>> +		fd = create_bpf_prog();
>>> +		break;
>>> +	default:
>>> +		usage(argv[0]);
>>> +	}
>>> +
>>> +	if (fd < 0)
>>> +		return bpf_fd_type;
>>> +
>>> +	close(fd);
>>> +	return 0;
>>> +}
>>> diff --git a/tests/bpf/test b/tests/bpf/test
>>> new file mode 100755
>>> index 0000000..1d41d72
>>> --- /dev/null
>>> +++ b/tests/bpf/test
>>> @@ -0,0 +1,58 @@
>>> +#!/usr/bin/perl
>>> +use Test::More;
>>> +
>>> +BEGIN {
>>> +    $basedir = $0;
>>> +    $basedir =~ s|(.*)/[^/]*|$1|;
>>> +
>>> +    # allow info to be shown during tests
>>> +    $v = $ARGV[0];
>>> +    if ($v) {
>>> +        if ( $v ne "-v" ) {
>>> +            plan skip_all => "Invalid option (use -v)";
>>> +        }
>>> +    }
>>> +    else {
>>> +        $v = " ";
>>> +    }
>>> +
>>> +    plan tests => 7;
>>> +}
>>> +
>>> +#
>>> +################ Core BPF Tests #######################
>>> +#
>>> +# BPF map
>>> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -m $v";
>>> +ok( $result eq 0 );
>>> +
>>> +# BPF prog
>>> +$result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
>>> +ok( $result eq 0 );
>>> +
>>> +# Deny map_create permission
>>> +$result =
>>> +  system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test
>>> -m $v 2>&1";
>>> +ok( $result >> 8 eq 1 );
>>> +
>>> +# Deny map_read permission
>>> +$result =
>>> +  system "runcon -t test_bpf_deny_map_read_t $basedir/bpf_test -m
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 1 );
>>> +
>>> +# Deny map_write permission
>>> +$result =
>>> +  system "runcon -t test_bpf_deny_map_write_t $basedir/bpf_test -m
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 1 );
>>> +
>>> +# Deny prog_load permission
>>> +$result =
>>> +  system "runcon -t test_bpf_deny_prog_load_t $basedir/bpf_test -p
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 2 );
>>> +
>>> +# Deny prog_run permission
>>> +$result =
>>> +  system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 2 );
>>> +
>>> +exit;
>>
>> Tests 8 and 9 failed for me,
>> bpf/test .................... 1/11 BPF map not supported
>> sendmsg: Bad file descriptor
>>
>> #   Failed test at bpf/test line 78.
>> BPF prog not supported
>> connect: Connection refused
>>
>> #   Failed test at bpf/test line 82.
>> BPF prog not supported
>> connect: Connection refused
>> BPF map not supported
>> connect: Connection refused
>> # Looks like you failed 2 tests of 11.
>> bpf/test .................... Dubious, test returned 2 (wstat 512,
>> 0x200)
>> Failed 2/11 subtests
> 
> Hopefully this is fixed.
> 
> Note when I send the updated patches I'll include the Binder BPF
> support as Patch 3.
>>
>>
> 
> 
> 

