Return-Path: <SRS0=6R7b=XU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FAC432C2
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 18:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFBB21655
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 18:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oE+A/KSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437714AbfIYS1I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:27:08 -0400
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:29173 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407334AbfIYS1I (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Sep 2019 14:27:08 -0400
X-EEMSG-check-017: 17185012|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,549,1559520000"; 
   d="scan'208";a="17185012"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Sep 2019 18:26:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569436017; x=1600972017;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=S/dQtlBOOnlIMVRFR1pIG9rJAJQXwFu3C389oeVILmM=;
  b=oE+A/KSFKTjoWeT1kREJLr8P59jNv5GLuq2gDiDkL2zh1a97QDuknYol
   bdGWlPlX+nrT/RrAnUzdcg6M54dEqm2QvHnfnH9Du1Ku7KsFwhd26MGPI
   6nfn4JsuqnUb9FxeN66F35vhi9NtsB3K/Jj+LhxPqfgLMrlyaWvw8zeLA
   qESx6HwvGIq5cb4AOJMiVoKjJsRhHCKgHHb8gTTz/L6c6i5FLY07GCB2C
   pylaXBR9BtNhjAdFHFuvMG8aOhR8/2rPwyD+Ek/gj+cIWRnwAuQYjlaGE
   MqwLGhsRq9XI0Omw1Y3ArFvCKNY0FLpDRGBjOyGgayAUfqMYSLyaJz4nn
   A==;
X-IronPort-AV: E=Sophos;i="5.64,549,1559520000"; 
   d="scan'208";a="33355594"
IronPort-PHdr: =?us-ascii?q?9a23=3A3KqH1hIqCpnxT71vLtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKPjxwZ3uMQTl6Ol3ixeRBMOHsqkC0LCd6vq9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oIhi6swrdutQIjYZiN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK4Ihw7Eslp?=
 =?us-ascii?q?oTtl7PHinql0XtkKCabEAk+ums6+j/Y7XmoIGTN5Nshw3jPakjldazDOQlPg?=
 =?us-ascii?q?QUQWSW9vqw2Kf+8UHhRbVFlPw2kq3XsJDAIsQbo7a0AxRI3YY48Bu/Ezen38?=
 =?us-ascii?q?gYnXkANl5FfgmHgJLzN1HBJ/D4E++zg06wnzdz2/DGIrrhD43XLnjCjLjhfa?=
 =?us-ascii?q?xy61RBxwUr0d9Q/5JUBasAIPL1REDxr8fVAQQlMwy1xebnFMty1pkYWW2RHq?=
 =?us-ascii?q?+VKr/dsViN5ug3OemDeJcVuCrhK/gi//PulmE2mVscfamvwJsWZ2u1HuppI0?=
 =?us-ascii?q?qHe3rgmNQBHnkQvgo4UuPqjEeOUTlJZ3a9DOoA4WQBCYmmBJ3PDqCkgbqMx2?=
 =?us-ascii?q?/vBJxdZmlcBmeHJnfhdoOJQN8GdCOUPsJ7lDEYE7OmTtllnQqjsA781qpPMO?=
 =?us-ascii?q?XZ4GsbuIjl2dwz4Pfcxj8o8jkhNNiQy2GASSlPm2oMQzInlPRkrVdV1kaI0a?=
 =?us-ascii?q?8+hedRU9NU+aUaAU8BKZfAwrkiWJjJUQXbc4LMEQ33Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AHAAC0sItd/wHyM5BlGgEBAQEBAgEBAQEMAgEBAQGBU?=
 =?us-ascii?q?wUBAQEBCwGBcyptgQUqhCKIHIZ0TQEBAQEBAQaBESV+iHeFRIlpFIFnCQEBA?=
 =?us-ascii?q?QEBAQEBASMRAQIBAYQ/AoMqIzQJDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBg?=
 =?us-ascii?q?mYBAQEBAgEaAQgVOgwLCxgCAhEVAgJXBgEMBgIBAYJfPwGBagMJBQ+vUnOBM?=
 =?us-ascii?q?oVMgz2BSIEMKAGMCxh4gQeBEScMgio1PoIagWUONz+CTIJYBIxcCwqJE4Eyl?=
 =?us-ascii?q?VqCLIIuhFeNfwYbgjZyiwGLAo4bmw84gVgrCAIYCCEPgycJRxAUgVoXh1eGZ?=
 =?us-ascii?q?yQDMIEGAQGLICiCLAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 25 Sep 2019 18:26:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8PIQs0X016560;
        Wed, 25 Sep 2019 14:26:54 -0400
Subject: Re: [PATCH V2] selinux-testsuite: Add keys tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20190925165910.32589-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4097651b-105c-a121-7933-94fa7b288f63@tycho.nsa.gov>
Date:   Wed, 25 Sep 2019 14:26:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925165910.32589-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/25/19 12:59 PM, Richard Haines wrote:
> Test all permissions associated with the key class.
> 
> Note that kernel 5.3 commit keys: Fix request_key() lack of Link perm
> check on found key ("504b69eb3c95180bc59f1ae9096ad4b10bbbf254")
> added an additional check for link perm on request_key(). The tests
> will support earlier kernels.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Added test permission checks between a keyring created by another process
> Split out key_socket tests
> Tested on latest Fedora 30 + Rawhide
> 
>   README.md                    |   4 +-
>   defconfig                    |   7 +
>   policy/Makefile              |   4 +
>   policy/test_keys.te          | 269 +++++++++++++++++++++++++++++++++++
>   setenforce                   |   0

This seems to have been unintentionally added.

>   tests/Makefile               |   4 +
>   tests/keys/.gitignore        |   4 +
>   tests/keys/Makefile          |   7 +
>   tests/keys/keyctl.c          | 235 ++++++++++++++++++++++++++++++
>   tests/keys/keyctl_relabel.c  |  93 ++++++++++++
>   tests/keys/keyring_service.c | 183 ++++++++++++++++++++++++
>   tests/keys/keys_common.h     |  16 +++
>   tests/keys/request_keys.c    | 227 +++++++++++++++++++++++++++++
>   tests/keys/test              | 126 ++++++++++++++++
>   14 files changed, 1178 insertions(+), 1 deletion(-)
>   create mode 100644 policy/test_keys.te
>   create mode 100644 setenforce
>   create mode 100644 tests/keys/.gitignore
>   create mode 100644 tests/keys/Makefile
>   create mode 100644 tests/keys/keyctl.c
>   create mode 100644 tests/keys/keyctl_relabel.c
>   create mode 100644 tests/keys/keyring_service.c
>   create mode 100644 tests/keys/keys_common.h
>   create mode 100644 tests/keys/request_keys.c
>   create mode 100755 tests/keys/test

I still see failures with stock F30:

keys/test ................... Failed KEYCTL_SESSION_TO_PARENT: Operation 
not permitted
keys/test ................... 1/17
#   Failed test at keys/test line 38.

#   Failed test at keys/test line 89.
# Looks like you failed 2 tests of 17.
keys/test ................... Dubious, test returned 2 (wstat 512, 0x200)
Failed 2/17 subtests

Test Summary Report
-------------------
keys/test                 (Wstat: 512 Tests: 17 Failed: 2)
   Failed tests:  1, 11
   Non-zero exit status: 2

The first test fails even if I switch to permissive before running it.
Looking at the kernel code, keyctl_session_to_parent() returns -EPERM 
for any of the following cases:
1) parent is init or a kernel thread
2) parent is multi-threaded
3) parent has different uid/gid
4) parent keyring has different uid

This is running the testsuite from su or sudo from a non-root account 
mapped to unconfined_u (i.e. default). For the first test, you aren't 
creating a parent/child relationship so you can't strictly guarantee 
that these conditions are met by the parent.

For the 11th test, the test passes if I execute it in permissive mode so 
it is a SELinux denial.  I see these denials that appear to be related:

type=AVC msg=audit(09/25/2019 14:21:51.893:5717) : avc:  denied  { view 
} for  pid=11069 comm=request_keys 
scontext=unconfined_u:unconfined_r:test_request_keys_t:s0-s0:c0.c1023 
tcontext=system_u:system_r:init_t:s0 tclass=key permissive=1

type=AVC msg=audit(09/25/2019 14:21:51.893:5716) : avc:  denied  { link 
} for  pid=11069 comm=request_keys 
scontext=unconfined_u:unconfined_r:test_request_keys_t:s0-s0:c0.c1023 
tcontext=system_u:system_r:init_t:s0 tclass=key permissive=1

It appears that the parent keyring was created by init?

> 
> diff --git a/README.md b/README.md
> index 1396c8e..e845df8 100644
> --- a/README.md
> +++ b/README.md
> @@ -52,6 +52,7 @@ similar dependencies):
>   * lksctp-tools-devel _(to build the SCTP test programs)_
>   * attr _(tools used by the overlayfs tests)_
>   * libbpf-devel _(tools used by the bpf tests)_
> +* keyutils-libs-devel _(tools used by the keys tests)_
>   
>   On a modern Fedora system you can install these dependencies with the
>   following command:
> @@ -67,7 +68,8 @@ following command:
>   		iptables \
>   		lksctp-tools-devel \
>   		attr \
> -		libbpf-devel
> +		libbpf-devel \
> +		keyutils-libs-devel
>   
>   The testsuite requires a pre-existing base policy configuration of SELinux,
>   using either the old example policy or the reference policy as the baseline.
> diff --git a/defconfig b/defconfig
> index cb57f22..b13075d 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -67,3 +67,10 @@ CONFIG_ANDROID_BINDERFS=y
>   # They are not required for SELinux operation itself.
>   CONFIG_BPF=y
>   CONFIG_BPF_SYSCALL=y
> +
> +# Keys implementation.
> +# These are enabled to test the key controls in tests/keys; they are
> +# not required for SELinux operation itself.
> +CONFIG_KEYS=y
> +CONFIG_KEYS_COMPAT=y
> +CONFIG_KEY_DH_OPERATIONS=y
> diff --git a/policy/Makefile b/policy/Makefile
> index a5942b3..5c2c438 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -82,6 +82,10 @@ ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),
>   TARGETS += test_bpf.te test_fdreceive_bpf.te test_binder_bpf.te
>   endif
>   
> +ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_keys.te
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
> diff --git a/policy/test_keys.te b/policy/test_keys.te
> new file mode 100644
> index 0000000..c184409
> --- /dev/null
> +++ b/policy/test_keys.te
> @@ -0,0 +1,269 @@
> +#
> +################# KEY selinux-testsuite policy module ######################
> +#
> +attribute keydomain;
> +
> +#
> +############################## Define Macro ################################
> +#
> +# Do not use domain_type() macro as it has allow 'key { link search }'
> +# in base module so 'allow domain self:key ~{ link search };' will not work
> +# here. Add these instead to allow key perms to be controlled by this module.
> +#
> +gen_require(`
> +	type setrans_var_run_t, syslogd_t;
> +')
> +
> +define(`key_domain_type',`
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
> +####################### Main key class tests #####################
> +#
> +type test_key_t;
> +key_domain_type(test_key_t)
> +unconfined_runs_test(test_key_t)
> +typeattribute test_key_t testdomain;
> +typeattribute test_key_t keydomain;
> +
> +allow test_key_t self:process { setkeycreate };
> +allow test_key_t self:key { create write search read view link setattr };
> +
> +# Set new context on a keyring:
> +type test_newcon_key_t;
> +key_domain_type(test_newcon_key_t)
> +unconfined_runs_test(test_newcon_key_t)
> +typeattribute test_newcon_key_t testdomain;
> +typeattribute test_newcon_key_t keydomain;
> +
> +allow test_key_t test_newcon_key_t:key { create write search view };
> +
> +################# Deny process { setkeycreate } #######################
> +type test_no_setkeycreate_t;
> +key_domain_type(test_no_setkeycreate_t)
> +unconfined_runs_test(test_no_setkeycreate_t)
> +typeattribute test_no_setkeycreate_t testdomain;
> +typeattribute test_no_setkeycreate_t keydomain;
> +
> +###################### Deny key { create } ###########################
> +type test_key_no_create_t;
> +key_domain_type(test_key_no_create_t)
> +unconfined_runs_test(test_key_no_create_t)
> +typeattribute test_key_no_create_t testdomain;
> +typeattribute test_key_no_create_t keydomain;
> +
> +allow test_key_no_create_t self:process { setkeycreate };
> +allow test_key_no_create_t self:key { write search read view link setattr };
> +
> +###################### Deny key { write } ###########################
> +type test_key_no_write_t;
> +key_domain_type(test_key_no_write_t)
> +unconfined_runs_test(test_key_no_write_t)
> +typeattribute test_key_no_write_t testdomain;
> +typeattribute test_key_no_write_t keydomain;
> +
> +allow test_key_no_write_t self:process { setkeycreate };
> +allow test_key_no_write_t self:key { create search read view link setattr };
> +
> +###################### Deny key { search } ###########################
> +type test_key_no_search_t;
> +key_domain_type(test_key_no_search_t)
> +unconfined_runs_test(test_key_no_search_t)
> +typeattribute test_key_no_search_t testdomain;
> +typeattribute test_key_no_search_t keydomain;
> +
> +allow test_key_no_search_t self:process { setkeycreate };
> +allow test_key_no_search_t self:key { create write read view link setattr };
> +dontaudit test_key_no_search_t test_key_t:key search;
> +
> +###################### Deny key { view } ###########################
> +type test_key_no_view_t;
> +key_domain_type(test_key_no_view_t)
> +unconfined_runs_test(test_key_no_view_t)
> +typeattribute test_key_no_view_t testdomain;
> +typeattribute test_key_no_view_t keydomain;
> +
> +allow test_key_no_view_t self:process { setkeycreate };
> +allow test_key_no_view_t self:key { create write search read link setattr };
> +dontaudit test_key_no_view_t test_key_t:key search;
> +
> +###################### Deny key { read } ###########################
> +type test_key_no_read_t;
> +key_domain_type(test_key_no_read_t)
> +unconfined_runs_test(test_key_no_read_t)
> +typeattribute test_key_no_read_t testdomain;
> +typeattribute test_key_no_read_t keydomain;
> +
> +allow test_key_no_read_t self:process { setkeycreate };
> +allow test_key_no_read_t self:key { create write search view link setattr };
> +
> +###################### Deny key { link } ###########################
> +type test_key_no_link_t;
> +key_domain_type(test_key_no_link_t)
> +unconfined_runs_test(test_key_no_link_t)
> +typeattribute test_key_no_link_t testdomain;
> +typeattribute test_key_no_link_t keydomain;
> +
> +allow test_key_no_link_t self:process { setkeycreate };
> +allow test_key_no_link_t self:key { create write search read view setattr };
> +
> +###################### Deny key { setattr } ###########################
> +type test_key_no_setattr_t;
> +key_domain_type(test_key_no_setattr_t)
> +unconfined_runs_test(test_key_no_setattr_t)
> +typeattribute test_key_no_setattr_t testdomain;
> +typeattribute test_key_no_setattr_t keydomain;
> +
> +allow test_key_no_setattr_t self:process { setkeycreate };
> +allow test_key_no_setattr_t self:key { create write search read view link };
> +dontaudit test_key_no_setattr_t test_key_t:key search;
> +
> +#
> +############## keyring_service / request_keys process tests ###############
> +#
> +# Check between a process and a keyring created by another process in a
> +# different security context.
> +#
> +type test_keyring_service_t;
> +key_domain_type(test_keyring_service_t)
> +unconfined_runs_test(test_keyring_service_t)
> +typeattribute test_keyring_service_t testdomain;
> +typeattribute test_keyring_service_t keydomain;
> +
> +allow test_keyring_service_t self:process { setkeycreate };
> +allow test_keyring_service_t self:key { create write search read view link setattr };
> +allow test_keyring_service_t init_t:key { write search };
> +allow test_keyring_service_t test_key_t:key { create write search };
> +
> +allow test_keyring_service_t test_file_t:file execute_no_trans;
> +allow test_keyring_service_t self : process { dyntransition };
> +allow test_keyring_service_t test_request_keys_t:process dyntransition;
> +allow test_keyring_service_t test_request_keys_no_search_t:process dyntransition;
> +allow test_keyring_service_t test_request_keys_no_read_t:process dyntransition;
> +allow test_keyring_service_t test_request_keys_no_write_t:process dyntransition;
> +allow test_keyring_service_t test_request_keys_no_view_t:process dyntransition;
> +allow test_keyring_service_t test_request_keys_no_setattr_t:process dyntransition;
> +allow test_keyring_service_t test_request_keys_no_link_t:process dyntransition;
> +
> +################################# request_keys ############################
> +type test_request_keys_t;
> +key_domain_type(test_request_keys_t)
> +unconfined_runs_test(test_request_keys_t)
> +typeattribute test_request_keys_t testdomain;
> +typeattribute test_request_keys_t keydomain;
> +
> +allow test_request_keys_t self:key { create write search read view link setattr };
> +allow test_request_keys_t init_t:key { search };
> +allow test_request_keys_t test_keyring_service_t:key { search read write view link setattr };
> +allow test_request_keys_t test_key_t:key { search view link };
> +
> +################### request_keys deny { search } ############################
> +type test_request_keys_no_search_t;
> +key_domain_type(test_request_keys_no_search_t)
> +unconfined_runs_test(test_request_keys_no_search_t)
> +typeattribute test_request_keys_no_search_t testdomain;
> +typeattribute test_request_keys_no_search_t keydomain;
> +
> +allow test_request_keys_no_search_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_search_t init_t:key { search };
> +allow test_request_keys_no_search_t test_keyring_service_t:key { write view setattr };
> +allow test_request_keys_no_search_t test_key_t:key search;
> +
> +################### request_keys deny { read } ############################
> +type test_request_keys_no_read_t;
> +key_domain_type(test_request_keys_no_read_t)
> +unconfined_runs_test(test_request_keys_no_read_t)
> +typeattribute test_request_keys_no_read_t testdomain;
> +typeattribute test_request_keys_no_read_t keydomain;
> +
> +allow test_request_keys_no_read_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_read_t init_t:key { search };
> +allow test_request_keys_no_read_t test_keyring_service_t:key { write search view setattr link }; # link for 5.3
> +allow test_request_keys_no_read_t test_key_t:key search;
> +
> +################### request_keys deny { write } ############################
> +type test_request_keys_no_write_t;
> +key_domain_type(test_request_keys_no_write_t)
> +unconfined_runs_test(test_request_keys_no_write_t)
> +typeattribute test_request_keys_no_write_t testdomain;
> +typeattribute test_request_keys_no_write_t keydomain;
> +
> +allow test_request_keys_no_write_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_write_t init_t:key { search };
> +allow test_request_keys_no_write_t test_keyring_service_t:key { search view setattr };
> +allow test_request_keys_no_write_t test_key_t:key search;
> +
> +################### request_keys deny { view } ############################
> +type test_request_keys_no_view_t;
> +key_domain_type(test_request_keys_no_view_t)
> +unconfined_runs_test(test_request_keys_no_view_t)
> +typeattribute test_request_keys_no_view_t testdomain;
> +typeattribute test_request_keys_no_view_t keydomain;
> +
> +allow test_request_keys_no_view_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_view_t init_t:key { search };
> +allow test_request_keys_no_view_t test_keyring_service_t:key { search write setattr link }; # link for 5.3
> +allow test_request_keys_no_view_t test_key_t:key search;
> +
> +################### request_keys deny { setattr } ############################
> +type test_request_keys_no_setattr_t;
> +key_domain_type(test_request_keys_no_setattr_t)
> +unconfined_runs_test(test_request_keys_no_setattr_t)
> +typeattribute test_request_keys_no_setattr_t testdomain;
> +typeattribute test_request_keys_no_setattr_t keydomain;
> +
> +allow test_request_keys_no_setattr_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_setattr_t init_t:key { search };
> +allow test_request_keys_no_setattr_t test_keyring_service_t:key { search read write link view };
> +allow test_request_keys_no_setattr_t test_key_t:key search;
> +
> +################### request_keys deny { link } ############################
> +type test_request_keys_no_link_t;
> +key_domain_type(test_request_keys_no_link_t)
> +unconfined_runs_test(test_request_keys_no_link_t)
> +typeattribute test_request_keys_no_link_t testdomain;
> +typeattribute test_request_keys_no_link_t keydomain;
> +
> +allow test_request_keys_no_link_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_link_t init_t:key { search };
> +allow test_request_keys_no_link_t test_keyring_service_t:key { read write search view setattr };
> +allow test_request_keys_no_link_t test_key_t:key search;
> +
> +#
> +########################## Test Watch Queue ##############################
> +#
> +type test_watch_t;
> +key_domain_type(test_watch_t)
> +unconfined_runs_test(test_watch_t)
> +typeattribute test_watch_t testdomain;
> +typeattribute test_watch_t keydomain;
> +
> +allow test_watch_t device_t:chr_file { ioctl open read write };
> +allow test_watch_t self:key { create write search read view link setattr };
> +allow_map(test_watch_t, device_t, chr_file)
> +
> +################# Deny Watch Queue key { view } ##########################
> +type test_watch_no_view_t;
> +key_domain_type(test_watch_no_view_t)
> +unconfined_runs_test(test_watch_no_view_t)
> +typeattribute test_watch_no_view_t testdomain;
> +typeattribute test_watch_no_view_t keydomain;
> +
> +allow test_watch_no_view_t device_t:chr_file { ioctl open read write };
> +allow test_watch_no_view_t self:key { create write search read link setattr };
> +allow_map(test_watch_no_view_t, device_t, chr_file)
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(keydomain)
> +userdom_sysadm_entry_spec_domtrans_to(keydomain)
> diff --git a/setenforce b/setenforce
> new file mode 100644
> index 0000000..e69de29
> diff --git a/tests/Makefile b/tests/Makefile
> index e5bdfff..42f7f40 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -48,6 +48,10 @@ export CFLAGS += -DHAVE_BPF
>   endif
>   endif
>   
> +ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +SUBDIRS += keys
> +endif
> +
>   ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
>   SUBDIRS += infiniband_endport
>   endif
> diff --git a/tests/keys/.gitignore b/tests/keys/.gitignore
> new file mode 100644
> index 0000000..670a61e
> --- /dev/null
> +++ b/tests/keys/.gitignore
> @@ -0,0 +1,4 @@
> +keyctl
> +keyctl_relabel
> +keyring_service
> +request_key
> diff --git a/tests/keys/Makefile b/tests/keys/Makefile
> new file mode 100644
> index 0000000..d3793db
> --- /dev/null
> +++ b/tests/keys/Makefile
> @@ -0,0 +1,7 @@
> +TARGETS = keyctl keyctl_relabel keyring_service request_keys
> +LDLIBS += -lselinux -lkeyutils
> +
> +all: $(TARGETS)
> +
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
> new file mode 100644
> index 0000000..d482a8f
> --- /dev/null
> +++ b/tests/keys/keyctl.c
> @@ -0,0 +1,235 @@
> +#include "keys_common.h"
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v]\n"
> +		"Where:\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt, result;
> +	char *context, *keycreate_con;
> +	char r_con[256];
> +	bool verbose = false;
> +	key_serial_t retrieved, search, link, compute, newring,
> +		     private, prime, base, test_key;
> +	struct keyctl_dh_params params;
> +
> +	while ((opt = getopt(argc, argv, "v")) != -1) {
> +		switch (opt) {
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
> +		fprintf(stderr, "Failed to obtain process context\n");
> +		exit(1);
> +	}
> +	if (verbose)
> +		printf("Process context: %s\n", context);
> +
> +	result = getkeycreatecon(&keycreate_con);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain keycreate context\n");
> +		exit(2);
> +	}
> +	if (verbose)
> +		printf("Current keycreate context: %s\n", keycreate_con);
> +	free(keycreate_con);
> +
> +	/* Set context requires process { setkeycreate } and key { create } */
> +	result = setkeycreatecon(context);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("Set keycreate context: %s\n", context);
> +	free(context);
> +
> +	result = getkeycreatecon(&keycreate_con);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain keycreate context\n");
> +		exit(4);
> +	}
> +	if (verbose)
> +		printf("New keycreate context: %s\n", keycreate_con);
> +	free(keycreate_con);
> +
> +	/*
> +	 * Add three keys as these will be required by the
> +	 * keyctl(KEYCTL_DH_COMPUTE, ..) function.
> +	 * These require key { create write } permissions.
> +	 */
> +	private = add_key("user", "private", payload, strlen(payload),
> +			  KEY_SPEC_PROCESS_KEYRING);
> +	if (private < 0) {
> +		fprintf(stderr, "Failed add_key(private): %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +
> +	prime = add_key("user", "prime", payload, strlen(payload),
> +			KEY_SPEC_PROCESS_KEYRING);
> +	if (prime < 0) {
> +		fprintf(stderr, "Failed add_key(prime): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +
> +	base = add_key("user", "base", payload, strlen(payload),
> +		       KEY_SPEC_PROCESS_KEYRING);
> +	if (base < 0) {
> +		fprintf(stderr, "Failed add_key(base): %s\n",
> +			strerror(errno));
> +		exit(7);
> +	}
> +
> +	if (verbose) {
> +		printf("Private key ID: 0x%x\n", private);
> +		printf("Prime key ID:   0x%x\n", prime);
> +		printf("Base key ID:    0x%x\n", base);
> +	}
> +
> +	/* Requires key { search }. From kernel 5.3 requires { link } */
> +	retrieved = request_key("user", "private", NULL,
> +				KEY_SPEC_PROCESS_KEYRING);
> +	if (retrieved < 0) {
> +		fprintf(stderr, "Failed to request 'private' key: %s\n",
> +			strerror(errno));
> +		exit(8);
> +	}
> +
> +	/* Requires key { search } */
> +	search = keyctl(KEYCTL_SEARCH, KEY_SPEC_PROCESS_KEYRING, "user",
> +			"base", 0);
> +	if (search < 0) {
> +		fprintf(stderr, "Failed to find 'base' key: %s\n",
> +			strerror(errno));
> +		exit(9);
> +	}
> +
> +	/* Requires key { view } */
> +	result = keyctl(KEYCTL_GET_SECURITY, search, r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain key context: %s\n",
> +			strerror(errno));
> +		exit(10);
> +	}
> +
> +	if (verbose) {
> +		printf("Requested 'private' key ID: 0x%x\n", retrieved);
> +		printf("Searched 'base' key ID:     0x%x\n", search);
> +		printf("Searched 'base' key context:\n\t%s\n", r_con);
> +	}
> +
> +	/* Compute DH key, only obtain the length for test, not the key. */
> +	params.priv = private;
> +	params.prime = prime;
> +	params.base = base;
> +
> +	/* Requires key { create read write } */
> +	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
> +	if (compute < 0) {
> +		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
> +			strerror(errno));
> +		exit(11);
> +	}
> +	if (verbose)
> +		printf("KEYCTL_DH_COMPUTE key ID size: %d\n", compute);
> +
> +	/* To test key { link }, need to generate a new keyring ID first */
> +	newring = add_key("keyring", "my-keyring", NULL, 0,
> +			  KEY_SPEC_PROCESS_KEYRING);
> +	if (newring < 0) {
> +		fprintf(stderr, "Failed to add new keyring: %s\n",
> +			strerror(errno));
> +		exit(12);
> +	}
> +	if (verbose)
> +		printf("New keyring ID: 0x%x\n", newring);
> +
> +	/* Requires key { write link } */
> +	link = keyctl(KEYCTL_LINK, base, newring);
> +	if (link < 0) {
> +		fprintf(stderr, "Failed KEYCTL_LINK: %s\n",
> +			strerror(errno));
> +		exit(13);
> +	}
> +	if (verbose)
> +		printf("Link key ID:    0x%x\n", newring);
> +
> +	/* Requires key { setattr } */
> +	link = keyctl(KEYCTL_SET_TIMEOUT, base, 1);
> +	if (link < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SET_TIMEOUT: %s\n",
> +			strerror(errno));
> +		exit(14);
> +	}
> +	if (verbose)
> +		printf("Set timeout\n");
> +
> +	/* Requires key { search } from 5.X key { inval } */
> +	test_key = keyctl(KEYCTL_INVALIDATE, private);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_INVALIDATE(private): %s\n",
> +			strerror(errno));
> +		exit(15);
> +	}
> +	if (verbose)
> +		printf("Invalidated 'private' key\n");
> +
> +	/* Requires key { write setattr } from 5.X key { revoke } */
> +	test_key = keyctl(KEYCTL_REVOKE, prime);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_REVOKE(prime): %s\n",
> +			strerror(errno));
> +		exit(16);
> +	}
> +	if (verbose)
> +		printf("Revoked 'prime' key\n");
> +
> +	/* Requires key { write } from 5.X key { clear } */
> +	test_key = keyctl(KEYCTL_CLEAR, newring);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_CLEAR(newring): %s\n",
> +			strerror(errno));
> +		exit(17);
> +	}
> +	if (verbose)
> +		printf("Cleared 'newring' keyring\n");
> +
> +	/*
> +	 * To test key { join }, need to join session first.
> +	 * Note that this call sets up the environment that will be
> +	 * used by the 'request_keys' service when it calls:
> +	 *     keyctl(KEYCTL_SESSION_TO_PARENT)
> +	 */
> +	test_key = keyctl(KEYCTL_JOIN_SESSION_KEYRING, "user");
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_JOIN_SESSION_KEYRING,: %s\n",
> +			strerror(errno));
> +		exit(18);
> +	}
> +	/* Requires key { link } from 5.X key { join } */
> +	test_key = keyctl(KEYCTL_SESSION_TO_PARENT);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SESSION_TO_PARENT: %s\n",
> +			strerror(errno));
> +		exit(19);
> +	}
> +	if (verbose)
> +		printf("Joined session to parent\n");
> +
> +	return 0;
> +}
> diff --git a/tests/keys/keyctl_relabel.c b/tests/keys/keyctl_relabel.c
> new file mode 100644
> index 0000000..7bab510
> --- /dev/null
> +++ b/tests/keys/keyctl_relabel.c
> @@ -0,0 +1,93 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <keyutils.h>
> +#include <selinux/selinux.h>
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] newcon\n"
> +		"Where:\n\t"
> +		"-v      Print information.\n\t"
> +		"newcon  New keyring context.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt, result;
> +	char *context, *keycreate_con;
> +	char r_con[256];
> +	bool verbose = false;
> +	key_serial_t newring;
> +
> +	while ((opt = getopt(argc, argv, "v")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		usage(argv[0]);
> +
> +	result = getcon(&context);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain process context\n");
> +		exit(1);
> +	}
> +	if (verbose)
> +		printf("Process context: %s\n", context);
> +	free(context);
> +
> +	result = setkeycreatecon(argv[optind]);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
> +			strerror(errno));
> +		exit(2);
> +	}
> +
> +	result = getkeycreatecon(&keycreate_con);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain keycreate context\n");
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("New keycreate context: %s\n", keycreate_con);
> +	free(keycreate_con);
> +
> +	newring = add_key("keyring", "my-keyring", NULL, 0,
> +			  KEY_SPEC_PROCESS_KEYRING);
> +	if (newring < 0) {
> +		fprintf(stderr, "Failed to add new keyring: %s\n",
> +			strerror(errno));
> +		exit(4);
> +	}
> +
> +	result = keyctl(KEYCTL_GET_SECURITY, newring, r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain key context: %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +
> +	if (strcmp(argv[optind], r_con)) {
> +		fprintf(stderr, "Relabel error - expected: %s got: %s\n",
> +			argv[optind], r_con);
> +		exit(6);
> +	}
> +
> +	if (verbose) {
> +		printf("'my-keyring' key ID: 0x%x\n", newring);
> +		printf("'my-keyring' context:\n\t%s\n", r_con);
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/keys/keyring_service.c b/tests/keys/keyring_service.c
> new file mode 100644
> index 0000000..f150a6d
> --- /dev/null
> +++ b/tests/keys/keyring_service.c
> @@ -0,0 +1,183 @@
> +#include "keys_common.h"
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] newdomain program\n"
> +		"Where:\n\t"
> +		"newdomain  Type for new domain.\n\t"
> +		"program    Program to be exec'd.\n\t"
> +		"-v         Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int opt, pid, result, status;
> +	bool verbose;
> +	char *context_s, *request_keys_argv[4];
> +	context_t context;
> +	key_serial_t private, newring, link, test_key_1, test_key_2;
> +	char newringid_str[30];
> +
> +	verbose = false;
> +	request_keys_argv[3] = NULL;
> +
> +	while ((opt = getopt(argc, argv, "v")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			request_keys_argv[3] = strdup("-v");
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (argc - optind != 2)
> +		usage(argv[0]);
> +
> +	if (verbose)
> +		printf("%s process information:\n", argv[0]);
> +
> +	result = getcon(&context_s);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain process context\n");
> +		exit(1);
> +	}
> +	if (verbose)
> +		printf("\tProcess context:\n\t\t%s\n", context_s);
> +
> +	/* Set context requires process { setkeycreate } and key { create } */
> +	result = setkeycreatecon(context_s);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("\tSet keycreate context:\n\t\t%s\n", context_s);
> +
> +	context = context_new(context_s);
> +	if (!context) {
> +		fprintf(stderr, "Unable to create context structure\n");
> +		exit(2);
> +	}
> +	free(context_s);
> +
> +	if (context_type_set(context, argv[optind])) {
> +		fprintf(stderr, "Unable to set new type\n");
> +		exit(3);
> +	}
> +
> +	context_s = context_str(context);
> +	if (!context_s) {
> +		fprintf(stderr, "Unable to obtain new context string\n");
> +		exit(4);
> +	}
> +	if (verbose)
> +		printf("\t%s process context will transition to:\n\t\t%s\n",
> +		       argv[optind], context_s);
> +
> +	/*
> +	 * Requires key { create write } permissions.
> +	 * The 'newring' key ID is passed over to the 'request_keys'
> +	 * service for various permission checks.
> +	 */
> +	newring = add_key("keyring", "keyring-service", NULL, 0,
> +			  KEY_SPEC_SESSION_KEYRING);
> +	if (newring < 0) {
> +		fprintf(stderr, "Failed to add new keyring: %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +	if (verbose)
> +		printf("\tNew keyring ID:            0x%x\n", newring);
> +
> +	private = add_key("user", "private", payload, strlen(payload),
> +			  KEY_SPEC_SESSION_KEYRING);
> +	if (private < 0) {
> +		fprintf(stderr, "Failed add_key(private): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +	if (verbose)
> +		printf("\tAdded 'private' key ID:    0x%x\n", private);
> +
> +	test_key_1 = add_key("user", "test-key-1", payload, strlen(payload),
> +			     KEY_SPEC_SESSION_KEYRING);
> +	if (test_key_1 < 0) {
> +		fprintf(stderr, "Failed add_key(test-key-1): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +	if (verbose)
> +		printf("\tAdded 'test-key-1' key ID: 0x%x\n", test_key_1);
> +
> +	test_key_2 = add_key("user", "test-key-2", payload, strlen(payload),
> +			     KEY_SPEC_SESSION_KEYRING);
> +	if (test_key_2 < 0) {
> +		fprintf(stderr, "Failed add_key(test-key-2): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +	if (verbose)
> +		printf("\tAdded 'test-key-2' key ID: 0x%x\n", test_key_2);
> +
> +	/* Requires key { write link } */
> +	link = keyctl(KEYCTL_LINK, private, newring);
> +	if (link < 0) {
> +		fprintf(stderr, "Failed KEYCTL_LINK: %s\n",
> +			strerror(errno));
> +		exit(7);
> +	}
> +	if (verbose)
> +		printf("\tLink newring ID:           0x%x\n", newring);
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		fprintf(stderr, "fork failed: %s\n", strerror(errno));
> +		exit(9);
> +	} else if (pid == 0) {
> +		signal(SIGTRAP, SIG_IGN);
> +		request_keys_argv[0] = strdup(argv[optind + 1]);
> +		request_keys_argv[1] = strdup(context_s);
> +		sprintf(newringid_str, "%d", newring);
> +		request_keys_argv[2] = strdup(newringid_str);
> +
> +		if (verbose)
> +			printf("\tExec parameters:\n\t\t%s\n\t\t%s\n\t\t0x%x\n\t\t%s\n",
> +			       request_keys_argv[0],
> +			       request_keys_argv[1],
> +			       atoi(request_keys_argv[2]),
> +			       request_keys_argv[3]);
> +		execv(request_keys_argv[0], request_keys_argv);
> +		fprintf(stderr, "execv of: %s failed: %s\n",
> +			request_keys_argv[0], strerror(errno));
> +		exit(10);
> +	}
> +
> +	pid = wait(&status);
> +	if (pid < 0) {
> +		fprintf(stderr, "wait() failed: %s\n", strerror(errno));
> +		exit(11);
> +	}
> +
> +	if (WIFEXITED(status)) {
> +		fprintf(stderr, "%s exited with status: %d\n", argv[optind + 1],
> +			WEXITSTATUS(status));
> +		exit(WEXITSTATUS(status));
> +	}
> +
> +	if (WIFSIGNALED(status)) {
> +		fprintf(stderr, "%s terminated by signal: %d\n", argv[optind + 1],
> +			WTERMSIG(status));
> +		fprintf(stderr,
> +			"..This is consistent with a %s permission denial - check the audit log.\n",
> +			argv[optind + 1]);
> +		exit(12);
> +	}
> +
> +	fprintf(stderr, "Unexpected exit status 0x%x\n", status);
> +	exit(-1);
> +}
> diff --git a/tests/keys/keys_common.h b/tests/keys/keys_common.h
> new file mode 100644
> index 0000000..df15280
> --- /dev/null
> +++ b/tests/keys/keys_common.h
> @@ -0,0 +1,16 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <sys/wait.h>
> +#include <keyutils.h>
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>
> +
> +/* This is used as the payload for each add_key() */
> +static const char payload[] =
> +	" -----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDN4FHsPjlJf03r9KfNt1Ma9/D6\nQDEiR/cfhZrNUPgHRresult+E4dj52VJSonPFJ6HaLlUi5pZq2t1LqPNrMfFKCNn12m+\nWw4aduBJM7u1RUPSNxrlfDAJZkdtNALOO/ds3U93hZrxOYNetzbnjILDu5JT1nbI\n4aC60SkdlCw1TxmvXwIDAQAB\n-----END PUBLIC KEY-----\n";
> diff --git a/tests/keys/request_keys.c b/tests/keys/request_keys.c
> new file mode 100644
> index 0000000..15ec136
> --- /dev/null
> +++ b/tests/keys/request_keys.c
> @@ -0,0 +1,227 @@
> +#include "keys_common.h"
> +
> +int main(int argc, char **argv)
> +{
> +	int nfi, result;
> +	char r_con[512], type[20], desc[30], *context;
> +	bool verbose = false;
> +	key_serial_t private, prime, base, compute, link, test_key;
> +	key_serial_t test_key_1, test_key_2;
> +	struct keyctl_dh_params params;
> +
> +	/*
> +	 * There are three parameters passed:
> +	 *    1 - The security context for setcon(3)
> +	 *    2 - A string containing the 'newring' key ID required
> +	 *        for various permission checks.
> +	 *    3 - Verbose mode
> +	 */
> +	if (argv[3] != NULL)
> +		verbose = true;
> +
> +	if (verbose)
> +		printf("%s process information:\n", argv[0]);
> +
> +	/*
> +	 * Use setcon() as policy will not allow multiple type_transition
> +	 * statements using the same target with different process types.
> +	 */
> +	result = setcon(argv[1]);
> +	if (result < 0) {
> +		fprintf(stderr, "setcon() failed to set process context: %s\n",
> +			argv[1]);
> +		exit(1);
> +	}
> +
> +	result = getcon(&context);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain process context\n");
> +		exit(2);
> +	}
> +	if (verbose)
> +		printf("\tProcess context:\n\t\t%s\n", context);
> +
> +	free(context);
> +
> +	/* Requires key { search write }. From kernel 5.3 requires { link } */
> +	private = request_key("user", "private", NULL, atoi(argv[2]));
> +	if (private < 0) {
> +		fprintf(stderr, "Failed to request 'private' key: %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("\tRequested 'private' key ID:    0x%x\n", private);
> +
> +	/* Requires key { search }. From kernel 5.3 requires { link } */
> +	test_key_1 = request_key("user", "test-key-1", NULL, atoi(argv[2]));
> +	if (test_key_1 < 0) {
> +		fprintf(stderr, "Failed to request 'test-key-1' key: %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("\tRequested 'test-key-1' key ID: 0x%x\n", private);
> +
> +	test_key_2 = request_key("user", "test-key-2", NULL, atoi(argv[2]));
> +	if (test_key_2 < 0) {
> +		fprintf(stderr, "Failed to request 'test-key-2' key: %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("\tRequested 'test-key-2' key ID: 0x%x\n", private);
> +
> +	/* Requires key { view } */
> +	result = keyctl(KEYCTL_GET_SECURITY, private, r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain key context: %s\n",
> +			strerror(errno));
> +		exit(4);
> +	}
> +	if (verbose)
> +		printf("\t'private' key context:\n\t\t%s\n", r_con);
> +
> +	prime = add_key("user", "prime", payload, strlen(payload),
> +			atoi(argv[2]));
> +	if (prime < 0) {
> +		fprintf(stderr, "Failed add_key(prime): %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +	if (verbose)
> +		printf("\tAdded 'prime' key ID: 0x%x\n", prime);
> +
> +	result = keyctl(KEYCTL_GET_SECURITY, prime, r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain 'prime' key context: %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +	if (verbose)
> +		printf("\t'prime' key context:\n\t\t%s\n", r_con);
> +
> +	base = add_key("user", "base", payload, strlen(payload),
> +		       KEY_SPEC_PROCESS_KEYRING);
> +	if (base < 0) {
> +		fprintf(stderr, "Failed add_key(base): %s\n",
> +			strerror(errno));
> +		exit(7);
> +	}
> +	if (verbose)
> +		printf("\tAdded 'base' key ID: 0x%x\n", base);
> +
> +	result = keyctl(KEYCTL_GET_SECURITY, prime, r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain 'base' key context: %s\n",
> +			strerror(errno));
> +		exit(8);
> +	}
> +	if (verbose)
> +		printf("\t'base' key context:\n\t\t%s\n", r_con);
> +
> +	/* Compute DH key, only obtain the length for test, not the key. */
> +	params.priv = private;
> +	params.prime = prime;
> +	params.base = base;
> +
> +	/* Requires key { create(local) read write } */
> +	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
> +	if (compute < 0) {
> +		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
> +			strerror(errno));
> +		exit(9);
> +	}
> +	if (verbose)
> +		printf("\tKEYCTL_DH_COMPUTE key ID size: %d\n", compute);
> +
> +	/* Requires key { write link } */
> +	link = keyctl(KEYCTL_LINK, private, atoi(argv[2])); /* newring */
> +	if (link < 0) {
> +		fprintf(stderr, "Failed KEYCTL_LINK: %s\n",
> +			strerror(errno));
> +		exit(10);
> +	}
> +	if (verbose)
> +		printf("\tLink key ID:    0x%x\n", atoi(argv[2]));
> +
> +	test_key = keyctl(KEYCTL_DESCRIBE, atoi(argv[2]), r_con, sizeof(r_con));
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_DESCRIBE: %s\n",
> +			strerror(errno));
> +		exit(11);
> +	}
> +	/* Requires key { setattr } */
> +	test_key = keyctl(KEYCTL_SET_TIMEOUT, atoi(argv[2]), 2);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SET_TIMEOUT: %s\n",
> +			strerror(errno));
> +		exit(12);
> +	}
> +	if (verbose) {
> +		nfi = sscanf(r_con, "%[^;];%d;%d;%x;%s",
> +			     type, &nfi, &nfi, &nfi, desc);
> +		printf("\tSet timeout on Key Type: '%s' Description: '%s'\n",
> +		       type, desc);
> +	}
> +
> +	/* Requires key { search } from 5.X key { inval } */
> +	test_key = keyctl(KEYCTL_INVALIDATE, test_key_1);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_INVALIDATE(test-key-1): %s\n",
> +			strerror(errno));
> +		exit(13);
> +	}
> +	if (verbose)
> +		printf("\tInvalidated 'test-key-1' key\n");
> +
> +	/* Requires key { write setattr } from 5.X key { revoke } */
> +	test_key = keyctl(KEYCTL_REVOKE, test_key_2);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_REVOKE(test-key-2): %s\n",
> +			strerror(errno));
> +		exit(14);
> +	}
> +	if (verbose)
> +		printf("\tRevoked 'test-key-2' key\n");
> +
> +	/* Requires key { write } from 5.X key { clear } */
> +	test_key = keyctl(KEYCTL_CLEAR, atoi(argv[2]));
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_CLEAR(newring): %s\n",
> +			strerror(errno));
> +		exit(15);
> +	}
> +	if (verbose)
> +		printf("\tCleared 'newring' keyring\n");
> +
> +	/*
> +	 * The ./keyctl program executed:
> +	 *    keyctl(KEYCTL_JOIN_SESSION_KEYRING, "user")
> +	 * for testing joining a keyring. The session security context will
> +	 * therefore be from ./keyctl as described in keyctl(1):
> +	 *    Each process subscribes to a session keyring that is
> +	 *    inherited across (v)fork, exec and clone.
> +	 *
> +	 * Requires key { link } from 5.X key { join }
> +	 */
> +	test_key = keyctl(KEYCTL_SESSION_TO_PARENT);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SESSION_TO_PARENT: %s\n",
> +			strerror(errno));
> +		exit(16);
> +	}
> +
> +	result = keyctl(KEYCTL_GET_SECURITY, KEY_SPEC_SESSION_KEYRING,
> +			r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain 'KEY_SPEC_SESSION_KEYRING' context: %s\n",
> +			strerror(errno));
> +		exit(17);
> +	}
> +	if (verbose)
> +		printf("\tJoined session to parent. The parent keyring context is:\n\t\t%s\n",
> +		       r_con);
> +
> +	exit(0);
> +}
> diff --git a/tests/keys/test b/tests/keys/test
> new file mode 100755
> index 0000000..e469b9b
> --- /dev/null
> +++ b/tests/keys/test
> @@ -0,0 +1,126 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    $test_count = 17;
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
> +    # From kernel 5.3 request_key() requires additional check of key { link }
> +    $kvercur = `uname -r`;
> +    chomp($kvercur);
> +    $kverminstream = "5.3";
> +    $test_link_53  = 0;
> +
> +    $result = `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $result >= 0 ) {
> +        $test_link_53 = 1;
> +    }
> +
> +    plan tests => $test_count;
> +}
> +
> +############ Test keyctl #############
> +print "Test key class permissions\n";
> +$result = system "runcon -t test_key_t $basedir/keyctl $v";
> +ok( $result eq 0 );
> +
> +# Deny process { setkeycreate }
> +$result = system "runcon -t test_no_setkeycreate_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 3 );
> +
> +# Deny key { create }
> +$result = system "runcon -t test_key_no_create_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 3 );
> +
> +# Deny key { write }
> +$result = system "runcon -t test_key_no_write_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 5 );
> +
> +# Deny key { search }
> +$result = system "runcon -t test_key_no_search_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 8 );
> +
> +# Deny key { view }
> +$result = system "runcon -t test_key_no_view_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 10 );
> +
> +# Deny key { read }
> +$result = system "runcon -t test_key_no_read_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 11 );
> +
> +# Deny key { link }
> +$result = system "runcon -t test_key_no_link_t $basedir/keyctl $v 2>&1";
> +if ($test_link_53) {
> +    ok( $result >> 8 eq 8 );
> +}
> +else {
> +    ok( $result >> 8 eq 13 );
> +}
> +
> +# Deny key { setattr }
> +$result = system "runcon -t test_key_no_setattr_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 14 );
> +
> +########### Change keyring context ##############
> +print "Change keyring context\n";
> +$result = system
> +"runcon -t test_key_t $basedir/keyctl_relabel $v system_u:system_r:test_newcon_key_t:s0";
> +ok( $result eq 0 );
> +
> +##### Test permission checks between a keyring created by a process and ############
> +##### a service in a different security context.
> +print "Test permission checks between a keyring created by another process\n";
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_t $basedir/request_keys 2>&1"
> +);
> +ok( $result eq 0 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_search_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 3 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_read_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 9 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_write_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 3 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_view_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 4 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_setattr_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 12 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_link_t $basedir/request_keys 2>&1"
> +);
> +if ($test_link_53) {
> +    ok( $result >> 8 eq 3 );
> +}
> +else {
> +    ok( $result >> 8 eq 10 );
> +}
> +
> +exit;
> 

