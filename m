Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE5C32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A0B2075D
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eslNfXIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfI3VdO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:33:14 -0400
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:31541 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VdN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 17:33:13 -0400
X-EEMSG-check-017: 31584224|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,568,1559520000"; 
   d="scan'208";a="31584224"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 19:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569870638; x=1601406638;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VHJynESd100aSVfwxXjJQWpzdmF/s7oSHUfazDxTHzM=;
  b=eslNfXIZ8cs+8iOilZFVKpFcrVM0Dpsv6UvcEGjbuRBu48WzJrCKpGkP
   2YGKNu5p7ySdVJo9bQb+dGJLuz8jsvGKH9axSUBRtuUym6dSHghcaQFES
   Yj1ZbuYxkMen+lqPdsqG+rTFrCvatC+b2r33MpRKDhP8OKABbzhH/VaNU
   1JPYksl4UsUUNANzOcHckYjecWj1e61SyUU5GfzW+OvL3XDgaeCCa3tUb
   TXb0Nh+j8mTGMNzd3ESnfqj2zXkchH6vDGB9AIleeyU2Av0nAyaGnf8v8
   9iKjeY3z/NU9KS0glY8TM2LKkZYyCHc5TOArIu8yaLlRCktQK9ZfsND8U
   g==;
X-IronPort-AV: E=Sophos;i="5.64,568,1559520000"; 
   d="scan'208";a="33542340"
IronPort-PHdr: =?us-ascii?q?9a23=3A30065RUkJZpCz9XeNxcVwWQY3iTV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRaDt8tkgFKBZ4jH8fUM07OQ7/m7HzBaqs/b4TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrMYbjZVtJqos1B?=
 =?us-ascii?q?fEpmZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5Z7?=
 =?us-ascii?q?Z96lJTyAopwtBF+p1bEq0OL+rzWkDrtdzYCAE2Mxevzun8FNV914UeWX6RDa?=
 =?us-ascii?q?+DNqPdr0OI6vgzLOmLYY8foCz9JOQ95/7ykX85nkcQfbK30psTaXC4GOlmIk?=
 =?us-ascii?q?qCbHryjdcOD30KshA9TOP0kl2CVyBcZ3KoU6I7/DE7B9HuMYCWfIGmgLWb0G?=
 =?us-ascii?q?+bF5xQa3sOXkqNGnfhbYmzUMAMYSOUL9RJmCAFU6SsUYksyVelswqsj/J8I+?=
 =?us-ascii?q?7V/DAInYzs2cIz5ODJkxw2sztuAJezyWaIGlpok3sISjl+56V2pUhw2x/Xyq?=
 =?us-ascii?q?Rjq+BJHtxUofVSW0E1MoCKnL8yMMz7Rg+UJoTBc12hWNjzRGhqH98=3D?=
X-IPAS-Result: =?us-ascii?q?A2AKAABtUpJd/wHyM5BmGgEBAQEBAgEBAQEMAgEBAQGBU?=
 =?us-ascii?q?wUBAQEBCwGBcyptUgEyKoQiiByGVFABAQEGgRElfoh3jy+BewkBAQEBAQEBA?=
 =?us-ascii?q?QEjEQECAQGEQAKDQyM0CQ4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJnAQEBA?=
 =?us-ascii?q?QIBGgEIBBFGCwsYAgImAgJXBgEMBgIBAYJfPwGBagMJBQ+uEHV/M4VNgyaBS?=
 =?us-ascii?q?IEMKAGMDRh4gQeBEScMgio1PoIagiqDDYJYBIxyiSCBM5VagiyCLoRXjgAGG?=
 =?us-ascii?q?4I3cosGiweOIZsZOYFYKwgCGAghD4MnCUcQFIFbF4dYhmclAzCBBgEBkBoBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Sep 2019 19:10:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UJAaW1020816;
        Mon, 30 Sep 2019 15:10:36 -0400
Subject: Re: [PATCH V3] selinux-testsuite: Add keys tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20190930154258.17444-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9088810b-ce1c-6744-4b35-3585d0d55577@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 15:10:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930154258.17444-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 11:42 AM, Richard Haines wrote:
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
> V3 Changes:
> Fixed KEYCTL_SESSION_TO_PARENT: Operation not permitted
> Remove kernel 5.X checks as not yet relevant
> Tested on latest Fedora 30 + Rawhide from user->su->make test
> 
>   README.md                    |   4 +-
>   defconfig                    |   7 ++
>   policy/Makefile              |   4 +
>   policy/test_global.te        |   2 +-
>   policy/test_keys.te          | 226 +++++++++++++++++++++++++++++++++++
>   tests/Makefile               |   4 +
>   tests/keys/.gitignore        |   4 +
>   tests/keys/Makefile          |   7 ++
>   tests/keys/keyctl.c          | 188 +++++++++++++++++++++++++++++
>   tests/keys/keyctl_relabel.c  |  93 ++++++++++++++
>   tests/keys/keyring_service.c | 166 +++++++++++++++++++++++++
>   tests/keys/keys_common.h     |  16 +++
>   tests/keys/request_keys.c    | 138 +++++++++++++++++++++
>   tests/keys/test              | 109 +++++++++++++++++
>   14 files changed, 966 insertions(+), 2 deletions(-)
>   create mode 100644 policy/test_keys.te
>   create mode 100644 tests/keys/.gitignore
>   create mode 100644 tests/keys/Makefile
>   create mode 100644 tests/keys/keyctl.c
>   create mode 100644 tests/keys/keyctl_relabel.c
>   create mode 100644 tests/keys/keyring_service.c
>   create mode 100644 tests/keys/keys_common.h
>   create mode 100644 tests/keys/request_keys.c
>   create mode 100755 tests/keys/test
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
> diff --git a/policy/test_global.te b/policy/test_global.te
> index b77e025..90f9b65 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -42,7 +42,7 @@ allow testdomain self:process setfscreate;
>   
>   # General permissions commonly required for test operation.
>   # general_domain_access
> -allow testdomain self:process ~{ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap};
> +allow testdomain self:process ~{ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap setkeycreate};
>   allow testdomain self:fd use;
>   allow testdomain self:fifo_file rw_file_perms;
>   allow testdomain self:unix_dgram_socket create_socket_perms;
> diff --git a/policy/test_keys.te b/policy/test_keys.te
> new file mode 100644
> index 0000000..78c0663
> --- /dev/null
> +++ b/policy/test_keys.te
> @@ -0,0 +1,226 @@
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
> +allow test_request_keys_t test_keyring_service_t:key { search read write view link setattr };
> +
> +################### request_keys deny { search } ############################
> +type test_request_keys_no_search_t;
> +key_domain_type(test_request_keys_no_search_t)
> +unconfined_runs_test(test_request_keys_no_search_t)
> +typeattribute test_request_keys_no_search_t testdomain;
> +typeattribute test_request_keys_no_search_t keydomain;
> +
> +allow test_request_keys_no_search_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_search_t test_keyring_service_t:key { write link view setattr };
> +
> +################### request_keys deny { read } ############################
> +type test_request_keys_no_read_t;
> +key_domain_type(test_request_keys_no_read_t)
> +unconfined_runs_test(test_request_keys_no_read_t)
> +typeattribute test_request_keys_no_read_t testdomain;
> +typeattribute test_request_keys_no_read_t keydomain;
> +
> +allow test_request_keys_no_read_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_read_t test_keyring_service_t:key { write search view setattr link };
> +
> +################### request_keys deny { write } ############################
> +type test_request_keys_no_write_t;
> +key_domain_type(test_request_keys_no_write_t)
> +unconfined_runs_test(test_request_keys_no_write_t)
> +typeattribute test_request_keys_no_write_t testdomain;
> +typeattribute test_request_keys_no_write_t keydomain;
> +
> +allow test_request_keys_no_write_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_write_t test_keyring_service_t:key { read search view setattr link };
> +
> +################### request_keys deny { view } ############################
> +type test_request_keys_no_view_t;
> +key_domain_type(test_request_keys_no_view_t)
> +unconfined_runs_test(test_request_keys_no_view_t)
> +typeattribute test_request_keys_no_view_t testdomain;
> +typeattribute test_request_keys_no_view_t keydomain;
> +
> +allow test_request_keys_no_view_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_view_t test_keyring_service_t:key { search write setattr link };
> +
> +################### request_keys deny { setattr } ############################
> +type test_request_keys_no_setattr_t;
> +key_domain_type(test_request_keys_no_setattr_t)
> +unconfined_runs_test(test_request_keys_no_setattr_t)
> +typeattribute test_request_keys_no_setattr_t testdomain;
> +typeattribute test_request_keys_no_setattr_t keydomain;
> +
> +allow test_request_keys_no_setattr_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_setattr_t test_keyring_service_t:key { search read write link view };
> +
> +################### request_keys deny { link } ############################
> +type test_request_keys_no_link_t;
> +key_domain_type(test_request_keys_no_link_t)
> +unconfined_runs_test(test_request_keys_no_link_t)
> +typeattribute test_request_keys_no_link_t testdomain;
> +typeattribute test_request_keys_no_link_t keydomain;
> +
> +allow test_request_keys_no_link_t self:key { create write search read view link setattr };
> +allow test_request_keys_no_link_t test_keyring_service_t:key { read write search view setattr };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(keydomain)
> +userdom_sysadm_entry_spec_domtrans_to(keydomain)
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

Should be "request_keys". Noticed by running git status after applying 
and building/running the testsuite.

Otherwise, everything looks good to me and ran fine.

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
> index 0000000..5aff8d8
> --- /dev/null
> +++ b/tests/keys/keyctl.c
> @@ -0,0 +1,188 @@
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
> +	int opt, nr, result;
> +	unsigned int timeout = 5;
> +	char *context, *keycreate_con, type[20], desc[30];
> +	char r_con[256];
> +	bool verbose = false;
> +	key_serial_t retrieved, search, link, compute,
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
> +		printf("Process context:\n\t%s\n", context);
> +
> +	result = getkeycreatecon(&keycreate_con);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain keycreate context\n");
> +		exit(2);
> +	}
> +	if (verbose)
> +		printf("Current keycreate context:\n\t%s\n", keycreate_con);
> +	free(keycreate_con);
> +
> +	/* Set context requires key { create } and process { setkeycreate } */
> +	result = setkeycreatecon(context);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +	if (verbose)
> +		printf("Set keycreate context:\n\t%s\n", context);
> +	free(context);
> +
> +	result = getkeycreatecon(&keycreate_con);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain keycreate context\n");
> +		exit(4);
> +	}
> +	if (verbose)
> +		printf("New keycreate context:\n\t%s\n", keycreate_con);
> +	free(keycreate_con);
> +
> +	/*
> +	 * Add three keys to the KEY_SPEC_PROCESS_KEYRING as these will be
> +	 * required by the keyctl(KEYCTL_DH_COMPUTE, ..) function.
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
> +		exit(5);
> +	}
> +
> +	base = add_key("user", "base", payload, strlen(payload),
> +		       KEY_SPEC_PROCESS_KEYRING);
> +	if (base < 0) {
> +		fprintf(stderr, "Failed add_key(base): %s\n",
> +			strerror(errno));
> +		exit(5);
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
> +		exit(6);
> +	}
> +
> +	/* Requires key { search } */
> +	search = keyctl(KEYCTL_SEARCH, KEY_SPEC_PROCESS_KEYRING,
> +			"user", "base", 0);
> +	if (search < 0) {
> +		fprintf(stderr, "Failed to find 'base' key: %s\n",
> +			strerror(errno));
> +		exit(7);
> +	}
> +
> +	/* Requires key { view } */
> +	result = keyctl(KEYCTL_GET_SECURITY, private, r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain 'private' key context: %s\n",
> +			strerror(errno));
> +		exit(8);
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
> +		exit(9);
> +	}
> +	if (verbose)
> +		printf("KEYCTL_DH_COMPUTE key ID size: %d\n", compute);
> +
> +	/* Requires key { write link } */
> +	link = keyctl(KEYCTL_LINK, base, KEY_SPEC_PROCESS_KEYRING);
> +	if (link < 0) {
> +		fprintf(stderr, "Failed KEYCTL_LINK: %s\n",
> +			strerror(errno));
> +		exit(10);
> +	}
> +	if (verbose)
> +		printf("Link key ID:    0x%x\n", KEY_SPEC_PROCESS_KEYRING);
> +
> +	/* Requires key { setattr } */
> +	link = keyctl(KEYCTL_SET_TIMEOUT, base, timeout);
> +	if (link < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SET_TIMEOUT: %s\n",
> +			strerror(errno));
> +		exit(11);
> +	}
> +	if (verbose) {
> +		test_key = keyctl(KEYCTL_DESCRIBE, base, r_con, sizeof(r_con));
> +		if (test_key < 0) {
> +			fprintf(stderr, "Failed KEYCTL_DESCRIBE: %s\n",
> +				strerror(errno));
> +			exit(11);
> +		}
> +		result = sscanf(r_con, "%[^;];%d;%d;%x;%s",
> +				type, &nr, &nr, &nr, desc);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed sscanf(): %s\n",
> +				strerror(errno));
> +			exit(11);
> +		}
> +		printf("Set %d second timeout on key Type: '%s' Description: '%s'\n",
> +		       timeout, type, desc);
> +	}
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
> index 0000000..e5dcab0
> --- /dev/null
> +++ b/tests/keys/keyring_service.c
> @@ -0,0 +1,166 @@
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
> +	char *context_s, *request_keys_argv[4] = { NULL };
> +	context_t context;
> +	key_serial_t private, prime, base, newring;
> +
> +	verbose = false;
> +
> +	while ((opt = getopt(argc, argv, "v")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			request_keys_argv[2] = strdup("-v");
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
> +	 * This sets up the environment the for 'request_keys' service when it
> +	 * calls: keyctl(KEYCTL_SESSION_TO_PARENT)
> +	 */
> +	newring = keyctl(KEYCTL_JOIN_SESSION_KEYRING, "test-session");
> +	if (newring < 0) {
> +		fprintf(stderr, "Failed KEYCTL_JOIN_SESSION_KEYRING,: %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +	if (verbose)
> +		printf("\tKEYCTL_JOIN_SESSION_KEYRING newkey ID: 0x%x\n",
> +		       newring);
> +
> +	private = add_key("user", "private", payload, strlen(payload),
> +			  KEY_SPEC_SESSION_KEYRING);
> +	if (private < 0) {
> +		fprintf(stderr, "Failed add_key(private): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +
> +	prime = add_key("user", "prime", payload, strlen(payload),
> +			KEY_SPEC_SESSION_KEYRING);
> +	if (prime < 0) {
> +		fprintf(stderr, "Failed add_key(prime): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +
> +	base = add_key("user", "base", payload, strlen(payload),
> +		       KEY_SPEC_SESSION_KEYRING);
> +	if (base < 0) {
> +		fprintf(stderr, "Failed add_key(base): %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +	if (verbose) {
> +		printf("\tAdded 'private' key ID: 0x%x\n", private);
> +		printf("\tAdded 'prime'   key ID: 0x%x\n", prime);
> +		printf("\tAdded 'base'    key ID: 0x%x\n", base);
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		fprintf(stderr, "fork failed: %s\n", strerror(errno));
> +		exit(9);
> +	} else if (pid == 0) {
> +		signal(SIGTRAP, SIG_IGN);
> +		request_keys_argv[0] = strdup(argv[optind + 1]);
> +		request_keys_argv[1] = strdup(context_s);
> +		if (verbose)
> +			printf("\tExec parameters:\n\t\t%s\n\t\t%s\n\t\t%s\n",
> +			       request_keys_argv[0],
> +			       request_keys_argv[1],
> +			       request_keys_argv[2]);
> +
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
> +		fprintf(stderr, "%s exited with status: %d\n",
> +			argv[optind + 1], WEXITSTATUS(status));
> +		exit(WEXITSTATUS(status));
> +	}
> +
> +	if (WIFSIGNALED(status)) {
> +		fprintf(stderr, "%s terminated by signal: %d\n",
> +			argv[optind + 1], WTERMSIG(status));
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
> index 0000000..43b20d9
> --- /dev/null
> +++ b/tests/keys/request_keys.c
> @@ -0,0 +1,138 @@
> +#include "keys_common.h"
> +
> +int main(int argc, char **argv)
> +{
> +	int result, nr;
> +	unsigned int timeout = 5;
> +	char r_con[512], type[20], desc[30], *context;
> +	bool verbose = false;
> +	key_serial_t private, prime, base, compute, test_key;
> +	struct keyctl_dh_params params;
> +
> +	/*
> +	 * There are two parameters passed:
> +	 *    1 - The security context for setcon(3)
> +	 *    2 - Verbose mode
> +	 */
> +	if (argv[2] != NULL)
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
> +	/*
> +	 * Join this session to the parent as ./keyring_service executed:
> +	 *    keyctl(KEYCTL_JOIN_SESSION_KEYRING, "test-session")
> +	 *
> +	 * Requires key { link }
> +	 */
> +	test_key = keyctl(KEYCTL_SESSION_TO_PARENT);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SESSION_TO_PARENT: %s\n",
> +			strerror(errno));
> +		exit(3);
> +	}
> +
> +	/* Requires key { view } */
> +	result = keyctl(KEYCTL_GET_SECURITY, KEY_SPEC_SESSION_KEYRING,
> +			r_con, sizeof(r_con));
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain parent session context: %s\n",
> +			strerror(errno));
> +		exit(4);
> +	}
> +	if (verbose)
> +		printf("\tJoined session to parent. Parent keyring context:\n\t\t%s\n",
> +		       r_con);
> +
> +	/* Requires key { search write }. From kernel 5.3 requires { link } */
> +	private = request_key("user", "private", NULL,
> +			      KEY_SPEC_SESSION_KEYRING);
> +	if (private < 0) {
> +		fprintf(stderr, "Failed to request 'private' key: %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +
> +	prime = request_key("user", "prime", NULL, KEY_SPEC_SESSION_KEYRING);
> +	if (prime < 0) {
> +		fprintf(stderr, "Failed to request 'prime' key: %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +
> +	base = request_key("user", "base", NULL, KEY_SPEC_SESSION_KEYRING);
> +	if (base < 0) {
> +		fprintf(stderr, "Failed to request 'base' key: %s\n",
> +			strerror(errno));
> +		exit(5);
> +	}
> +	if (verbose) {
> +		printf("\tRequested 'private' key ID: 0x%x\n", private);
> +		printf("\tRequested 'prime'   key ID: 0x%x\n", prime);
> +		printf("\tRequested 'base'    key ID: 0x%x\n", base);
> +	}
> +
> +	/* Requires key { setattr } */
> +	test_key = keyctl(KEYCTL_SET_TIMEOUT, base, timeout);
> +	if (test_key < 0) {
> +		fprintf(stderr, "Failed KEYCTL_SET_TIMEOUT: %s\n",
> +			strerror(errno));
> +		exit(6);
> +	}
> +	if (verbose) {
> +		test_key = keyctl(KEYCTL_DESCRIBE, base, r_con, sizeof(r_con));
> +		if (test_key < 0) {
> +			fprintf(stderr, "Failed KEYCTL_DESCRIBE: %s\n",
> +				strerror(errno));
> +			exit(7);
> +		}
> +		result = sscanf(r_con, "%[^;];%d;%d;%x;%s",
> +				type, &nr, &nr, &nr, desc);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed sscanf(): %s\n",
> +				strerror(errno));
> +			exit(7);
> +		}
> +		printf("\tSet %d second timeout on key Type: '%s' Description: '%s'\n",
> +		       timeout, type, desc);
> +	}
> +
> +	/* Compute DH key, only obtain the length for test, not the key. */
> +	params.priv = private;
> +	params.prime = prime;
> +	params.base = base;
> +
> +	/* Requires key { read write } */
> +	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
> +	if (compute < 0) {
> +		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
> +			strerror(errno));
> +		exit(8);
> +	}
> +	if (verbose)
> +		printf("\tKEYCTL_DH_COMPUTE key ID size: %d\n", compute);
> +
> +	exit(0);
> +}
> diff --git a/tests/keys/test b/tests/keys/test
> new file mode 100755
> index 0000000..2dafb17
> --- /dev/null
> +++ b/tests/keys/test
> @@ -0,0 +1,109 @@
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
> +    # From kernel 5.3 request_key() requires { link } not { search } perm
> +    $kvercur = `uname -r`;
> +    chomp($kvercur);
> +    $kverminstream = "5.3";
> +    $test_link_53  = 0;
> +
> +    $result = `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $result > 0 ) {
> +        $test_link_53 = 1;
> +    }
> +
> +    plan tests => $test_count;
> +}
> +
> +print "Test key class permissions\n";
> +$result = system "runcon -t test_key_t $basedir/keyctl $v";
> +ok( $result eq 0 );
> +
> +$result = system "runcon -t test_no_setkeycreate_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 3 );
> +
> +$result = system "runcon -t test_key_no_create_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 3 );
> +
> +$result = system "runcon -t test_key_no_write_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 5 );
> +
> +$result = system "runcon -t test_key_no_search_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 6 );
> +
> +$result = system "runcon -t test_key_no_view_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 8 );
> +
> +$result = system "runcon -t test_key_no_read_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 9 );
> +
> +$result = system "runcon -t test_key_no_link_t $basedir/keyctl $v 2>&1";
> +if ($test_link_53) {
> +    ok( $result >> 8 eq 6 );
> +}
> +else {
> +    ok( $result >> 8 eq 10 );
> +}
> +
> +$result = system "runcon -t test_key_no_setattr_t $basedir/keyctl $v 2>&1";
> +ok( $result >> 8 eq 11 );
> +
> +print "Change keyring context\n";
> +$result = system
> +"runcon -t test_key_t $basedir/keyctl_relabel $v system_u:system_r:test_newcon_key_t:s0";
> +ok( $result eq 0 );
> +
> +print "Test permission checks between a keyring created by another process\n";
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_t $basedir/request_keys 2>&1"
> +);
> +ok( $result eq 0 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_link_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 3 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_write_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 5 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_view_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 4 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_search_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 5 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_setattr_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 6 );
> +
> +$result = system(
> +"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_read_t $basedir/request_keys 2>&1"
> +);
> +ok( $result >> 8 eq 8 );
> +
> +exit;
> 

