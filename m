Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8688C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 13:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635C320409
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 13:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AdfRMrBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfLPNrS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:47:18 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:5446 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfLPNrR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 08:47:17 -0500
X-EEMSG-check-017: 36204635|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="36204635"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Dec 2019 13:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576504035; x=1608040035;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oU0d1e5w8vaoWwpG6wmc4HyMzKMPX/hmGNhh71c++jA=;
  b=AdfRMrBIsBmBrDRPg5PBOZNeICg/fEXKIZ8455gO4dMvfHjJTSf0XdVj
   CNEqDBV6X3T5fj17sow/94Rs5v1FT19ggYWGTIC6opHzDJkeI/BK80RON
   T/tzFI51wKeGFOaqZnNQAHzu5Wz4qr5BV/OjA/SLXXvjbsb7MQbtoZoWD
   JJD1a04ymaq8b0HsQ5eThlop+jNqmJx7Gn8V6MVsFqS1FvPn3IsYjRWkc
   calxCkwVAUJEC5LxiceJg3/vRGU7QidsQy8kABKKYMNYxp00X5OYHz5dY
   BhAunmpilZWT0k24REs8wVKb5bUf8LyeYentbVV96Pew2SXX7quJrLtEz
   g==;
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="31131038"
IronPort-PHdr: =?us-ascii?q?9a23=3AaibZFhTpvFjmyoNMGNm/KA5EGdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zZhSN2/xhgRfzUJnB7Loc0qyK6vumAzRdqsvd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUanYtvJqkxxx?=
 =?us-ascii?q?bGv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAmoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MEbEOPvbzWk73tNzFAR40KBK0w+n5B9VnzI8eWnyAAr?=
 =?us-ascii?q?WfMKzMtV+E/OUvI/ODZIUNojbyN+Al5+LyjX8+gVIdZbOm3YYTaH2jBvRpOV?=
 =?us-ascii?q?iZYX71jtcEFmcKuRA+Q/LwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5iqgLyE2y?=
 =?us-ascii?q?e7BZtWaXpaBV+SCnrobZuLVOoMaC2IPs9tiCALVb+kS9xp6Rb7rwL+yrx6Ps?=
 =?us-ascii?q?LK9SAC85Huzt5446vUjx5h2yZzCpGmz2yVT2xy1lgNTjsy0bE39Vdx0X+fwK?=
 =?us-ascii?q?N4hLpeDtUV6PRXBFRpfaXAxvB3XoihEjnKec2EHRP/H4Sr?=
X-IPAS-Result: =?us-ascii?q?A2DcAACBifdd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEBIkDiA0liWqRRQkBAQEBAQEBAQE3AQGEQAKCODgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFUEQCxgCAiYCAlcTBgIBAYJfP4JTJ?=
 =?us-ascii?q?a4ZgTKFT4MvgUiBDiiMMnmBB4E4DAOCXT6ESYMQgl4EjSqJX0Z3ljSCPoI/k?=
 =?us-ascii?q?0AGG4JDjDeLTpASmxQigVgrCAIYCCEPgydQERSbdiMDMJAmAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Dec 2019 13:47:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBGDkpMF134285;
        Mon, 16 Dec 2019 08:46:51 -0500
Subject: Re: [PATCH v4] selinux-testsuite: add lockdown tests
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Ondrej Mosnacek <omosnace@redhat.com>
References: <20191210153945.20635-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4d40e7cb-f191-2327-7160-333c2c100f57@tycho.nsa.gov>
Date:   Mon, 16 Dec 2019 08:47:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210153945.20635-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/19 10:39 AM, Stephen Smalley wrote:
> Test all permissions associated with the lockdown class.
> Also update other test policies to allow lockdown permissions
> where needed.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Barring objections, I will merge this tomorrow Dec 17.

> ---
>   policy/Makefile            |  5 ++++
>   policy/test_global.te      |  8 ++++++
>   policy/test_lockdown.te    | 54 ++++++++++++++++++++++++++++++++++++++
>   policy/test_module_load.te |  2 ++
>   policy/test_perf_event.te  |  5 ++++
>   tests/Makefile             |  4 +++
>   tests/lockdown/Makefile    |  2 ++
>   tests/lockdown/test        | 42 +++++++++++++++++++++++++++++
>   8 files changed, 122 insertions(+)
>   create mode 100644 policy/test_lockdown.te
>   create mode 100644 tests/lockdown/Makefile
>   create mode 100755 tests/lockdown/test
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index f0de669be631..c3e5b4460e84 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -109,6 +109,11 @@ ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo
>   TARGETS += test_perf_event.te
>   endif
>   
> +ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_lockdown.te
> +export M4PARAM += -Dlockdown_defined
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
> diff --git a/policy/test_global.te b/policy/test_global.te
> index 90f9b6513731..1a1a127697f6 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -99,3 +99,11 @@ ifdef(`distro_redhat', `
>   define(`allow_map',
>   ifdef(`map_permission_defined', `allow $1 $2:$3 map;')
>   )
> +
> +define(`allow_lockdown_integrity',
> +ifdef(`lockdown_defined', `allow $1 self:lockdown integrity;')
> +)
> +
> +define(`allow_lockdown_confidentiality',
> +ifdef(`lockdown_defined', `allow $1 self:lockdown confidentiality;')
> +)
> diff --git a/policy/test_lockdown.te b/policy/test_lockdown.te
> new file mode 100644
> index 000000000000..a7a4b6bb8aec
> --- /dev/null
> +++ b/policy/test_lockdown.te
> @@ -0,0 +1,54 @@
> +#################################
> +#
> +# Policy for testing lockdown
> +#
> +
> +attribute lockdowndomain;
> +
> +# Domain for lockdown (all operations allowed)
> +type test_lockdown_all_t;
> +domain_type(test_lockdown_all_t)
> +unconfined_runs_test(test_lockdown_all_t)
> +typeattribute test_lockdown_all_t lockdowndomain;
> +typeattribute test_lockdown_all_t testdomain;
> +
> +dev_read_raw_memory(test_lockdown_all_t)
> +kernel_read_core_if(test_lockdown_all_t)
> +corecmd_bin_entry_type(test_lockdown_all_t)
> +allow test_lockdown_all_t self:lockdown integrity;
> +allow test_lockdown_all_t self:lockdown confidentiality;
> +
> +# Domain for integrity
> +type test_lockdown_integrity_t;
> +domain_type(test_lockdown_integrity_t)
> +unconfined_runs_test(test_lockdown_integrity_t)
> +typeattribute test_lockdown_integrity_t lockdowndomain;
> +typeattribute test_lockdown_integrity_t testdomain;
> +
> +dev_read_raw_memory(test_lockdown_integrity_t)
> +kernel_read_core_if(test_lockdown_integrity_t)
> +corecmd_bin_entry_type(test_lockdown_integrity_t)
> +allow test_lockdown_integrity_t self:lockdown integrity;
> +
> +# Domain for confidentiality
> +type test_lockdown_confidentiality_t;
> +domain_type(test_lockdown_confidentiality_t)
> +unconfined_runs_test(test_lockdown_confidentiality_t)
> +typeattribute test_lockdown_confidentiality_t lockdowndomain;
> +typeattribute test_lockdown_confidentiality_t testdomain;
> +
> +dev_read_raw_memory(test_lockdown_confidentiality_t)
> +kernel_read_core_if(test_lockdown_confidentiality_t)
> +corecmd_bin_entry_type(test_lockdown_confidentiality_t)
> +allow test_lockdown_confidentiality_t self:lockdown confidentiality;
> +
> +# Domain for lockdown (all operations denied)
> +type test_lockdown_none_t;
> +domain_type(test_lockdown_none_t)
> +unconfined_runs_test(test_lockdown_none_t)
> +typeattribute test_lockdown_none_t lockdowndomain;
> +typeattribute test_lockdown_none_t testdomain;
> +
> +dev_read_raw_memory(test_lockdown_none_t)
> +kernel_read_core_if(test_lockdown_none_t)
> +corecmd_bin_entry_type(test_lockdown_none_t)
> diff --git a/policy/test_module_load.te b/policy/test_module_load.te
> index ec8be67cbbf7..455acea97ab6 100644
> --- a/policy/test_module_load.te
> +++ b/policy/test_module_load.te
> @@ -35,6 +35,7 @@ allow test_kmodule_t test_file_t:system { module_load };
>   # Required for init_module(2):
>   allow test_kmodule_t self:system { module_load };
>   allow test_kmodule_t kernel_t:system { module_request };
> +allow_lockdown_integrity(test_kmodule_t)
>   
>   ############### Deny cap sys_module ######################
>   type test_kmodule_deny_sys_module_t;
> @@ -63,6 +64,7 @@ typeattribute test_kmodule_deny_module_request_t testdomain, kmoduledomain;
>   allow test_kmodule_deny_module_request_t self:capability { sys_module };
>   allow test_kmodule_deny_module_request_t test_file_t:system { module_load };
>   allow test_kmodule_deny_module_request_t self:system { module_load };
> +allow_lockdown_integrity(test_kmodule_deny_module_request_t)
>   neverallow test_kmodule_deny_module_request_t kernel_t:system { module_request };
>   
>   #
> diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
> index 67250a4ff047..275cebf1b3e9 100644
> --- a/policy/test_perf_event.te
> +++ b/policy/test_perf_event.te
> @@ -12,6 +12,7 @@ typeattribute test_perf_t perfdomain;
>   
>   allow test_perf_t self:capability { sys_admin };
>   allow test_perf_t self:perf_event { open cpu kernel tracepoint read write };
> +allow_lockdown_confidentiality(test_perf_t)
>   
>   ################# Deny capability { sys_admin } ##########################
>   type test_perf_no_admin_t;
> @@ -41,6 +42,7 @@ typeattribute test_perf_no_cpu_t perfdomain;
>   
>   allow test_perf_no_cpu_t self:capability { sys_admin };
>   allow test_perf_no_cpu_t self:perf_event { open kernel tracepoint read write };
> +allow_lockdown_confidentiality(test_perf_no_cpu_t)
>   
>   ################# Deny perf_event { kernel } ##########################
>   type test_perf_no_kernel_t;
> @@ -61,6 +63,7 @@ typeattribute test_perf_no_tracepoint_t perfdomain;
>   
>   allow test_perf_no_tracepoint_t self:capability { sys_admin };
>   allow test_perf_no_tracepoint_t self:perf_event { open cpu kernel read write };
> +allow_lockdown_confidentiality(test_perf_no_tracepoint_t)
>   
>   ################# Deny perf_event { read } ##########################
>   type test_perf_no_read_t;
> @@ -71,6 +74,7 @@ typeattribute test_perf_no_read_t perfdomain;
>   
>   allow test_perf_no_read_t self:capability { sys_admin };
>   allow test_perf_no_read_t self:perf_event { open cpu kernel tracepoint write };
> +allow_lockdown_confidentiality(test_perf_no_read_t)
>   
>   ################# Deny perf_event { write } ##########################
>   type test_perf_no_write_t;
> @@ -81,6 +85,7 @@ typeattribute test_perf_no_write_t perfdomain;
>   
>   allow test_perf_no_write_t self:capability { sys_admin };
>   allow test_perf_no_write_t self:perf_event { open cpu kernel tracepoint read };
> +allow_lockdown_confidentiality(test_perf_no_write_t)
>   
>   #
>   ########### Allow these domains to be entered from sysadm domain ############
> diff --git a/tests/Makefile b/tests/Makefile
> index 9a890be4f9aa..167c1375e9c9 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -87,6 +87,10 @@ ifeq ($(shell grep -q perf_event $(POLDEV)/include/support/all_perms.spt && echo
>   SUBDIRS += perf_event
>   endif
>   
> +ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +SUBDIRS += lockdown
> +endif
> +
>   ifeq ($(DISTRO),RHEL4)
>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>   endif
> diff --git a/tests/lockdown/Makefile b/tests/lockdown/Makefile
> new file mode 100644
> index 000000000000..e7c006f270c5
> --- /dev/null
> +++ b/tests/lockdown/Makefile
> @@ -0,0 +1,2 @@
> +all:
> +clean:
> diff --git a/tests/lockdown/test b/tests/lockdown/test
> new file mode 100755
> index 000000000000..0b81cb16c1a6
> --- /dev/null
> +++ b/tests/lockdown/test
> @@ -0,0 +1,42 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests => 8 }
> +
> +# everything is allowed
> +$result =
> +  system "runcon -t test_lockdown_all_t -- head /dev/mem > /dev/null 2>&1";
> +ok( $result, 0 );
> +
> +$result =
> +  system "runcon -t test_lockdown_all_t -- head /proc/kcore > /dev/null 2>&1";
> +ok( $result, 0 );
> +
> +# only integrity operations allowed
> +$result = system
> +  "runcon -t test_lockdown_integrity_t -- head /dev/mem > /dev/null 2>&1";
> +ok( $result, 0 );
> +
> +$result = system
> +  "runcon -t test_lockdown_integrity_t -- head /proc/kcore > /dev/null 2>&1";
> +ok($result);
> +
> +# only confidentiality operations allowed
> +$result = system
> +  "runcon -t test_lockdown_confidentiality_t -- head /dev/mem > /dev/null 2>&1";
> +ok($result);
> +
> +$result = system
> +"runcon -t test_lockdown_confidentiality_t -- head /proc/kcore > /dev/null 2>&1";
> +ok( $result, 0 );
> +
> +# nothing is allowed
> +$result =
> +  system "runcon -t test_lockdown_none_t -- head /dev/mem > /dev/null 2>&1";
> +ok($result);
> +
> +$result =
> +  system "runcon -t test_lockdown_none_t -- head /proc/kcore > /dev/null 2>&1";
> +ok($result);
> +
> +exit;
> 

