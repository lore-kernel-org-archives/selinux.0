Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF5EC43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443A820836
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="X/9Cmk3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLJPnV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:43:21 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:2696 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfLJPnU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 10:43:20 -0500
X-EEMSG-check-017: 34126817|USFB19PA31_ESA_OUT01.csd.disa.mil
X-EEMSG-Attachment-filename: all_perms.spt.diff, lockdown.cil
X-EEMSG-Attachment-filesize: 334, 79
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="diff'?cil'?scan'208";a="34126817"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 15:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575992598; x=1607528598;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=oRblMm4Dl6r4RDH+fJ18XrTK9whYF6MiATThMNgOljY=;
  b=X/9Cmk3J3PCVbU4sseXD6BGewaLt/SNCQw7RYXvrUVNaWii9t2/R+qxB
   nUb7Z/GruHvArbWqt1p62z9L4t5aZhvgPxHb5aKTnEP6CPit5Z3P93Kgq
   q1RKuIkwPhaZTdCe5f9DOYtTH+6YPcVPlCMT5HZ0JlwbMKVdM/CrWwoWn
   CoqoSok6/3IxUdoLPS6E0H7rI7P9esX7RnLEB95hpevJx9Fg2p9pzK5VK
   dlpdpw03AyRZYDk9YCiphfI/p+lEG/IvNBXisHs8y88JqB7hTRetqgOK6
   Lv6lgarBB1hIGavJXYltZGeQh3nke6ZjiFx9PjJo7bJBpGrdjp6O0Kg72
   g==;
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="diff'?cil'?scan'208";a="30944067"
IronPort-PHdr: =?us-ascii?q?9a23=3AfH30pRL2rNEJLh6Xt9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeKP/xwZ3uMQTl6Ol3ixeRBMOHsqkC0ruN+P+wEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7qQvcusYUjIZhN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhykdNz497WrZlMp+gqxGqx6lvhByw4rZbISTOfFjfK3SYMkaSH?=
 =?us-ascii?q?JcUMhPWSxPAoCyYYUBAOUOP+lXs5Lwp14SoRakHwSgGO3ixz1Oi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QI9A9IBrmzUrNXrO6cUTOu70azIwi/Hb/NSxzj86JXDfxc6of6RRr?=
 =?us-ascii?q?J9atbRyEkzGAPFiVWcs4rlPyiP2egXvGib6PRgWPuphmU6qA9xuiCiytojh4?=
 =?us-ascii?q?TGnI4Yyk3I+T9nzIs6O9G0UlN3bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJ5Yr2/nRey8VW7yuHmV8m01l?=
 =?us-ascii?q?hKri1ektbSqn8BzQDT68ibRft9+UetwzCP2BzI6u5YO0w0kKvbK5o5zr4xkJ?=
 =?us-ascii?q?ocr1jDEzfrlEj5g6KabEUp9vWy5+j5bbjquIWQO5JshgH7KKsum8i/AeoiMg?=
 =?us-ascii?q?gJWmiW4f+826D4/UDiXLVLjuE5kqnesJzAI8QbvbS2DxVa0oYk9RazFy2m38?=
 =?us-ascii?q?gAnXkbMFJFfwqKj5P3NFHKIfD4C+q/glu3nTd1yPDJIKfhDo/OLnfdirfhe6?=
 =?us-ascii?q?hy60pGxAo019Bf6IpeCqsdL/LrRk/xqNvYAwchMwOu3ubnDM5w1psEVmKSBq?=
 =?us-ascii?q?+VKabSsViP5uI1PeaAfpMauDH4K6tt2/m7lnI9mFkAbYG30pYNLnO1BPJrJw?=
 =?us-ascii?q?Oee3W/rM0GFDIxogcmTOHswGaHWDpXamf6C7kw/RknGYmmCsHFXYnrj7ufin?=
 =?us-ascii?q?ToVqZKb3xLXwjfWUzjcJ+JDrJROS8=3D?=
X-IPAS-Result: =?us-ascii?q?A2BVAAB5vO9d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQDiQOIKYlpkUYJAQEBAQEBAQEBAzQBAYRAAoInO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOymCegEBAQECASNWBQsLGCoCAgJVEwYCA?=
 =?us-ascii?q?QGCXz8BglIFIK0VdYEyhU+DN4E4EIE2gVOKX3mBB4E4D4JdPoRggnmCXgSNI?=
 =?us-ascii?q?YlbDTl2liyCOYI7gRmCNo9gBhuCQow3iz+QD5p9IoFYKwgCGAghD4MnUBEUj?=
 =?us-ascii?q?HIXjkEjAzCPKwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Dec 2019 15:43:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAFh28g022644;
        Tue, 10 Dec 2019 10:43:02 -0500
Subject: Re: [PATCH v4] selinux-testsuite: add lockdown tests
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20191210153945.20635-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <742bcbb7-32e9-c21b-1d5c-bed22e6f016b@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 10:43:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210153945.20635-1-sds@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------94F8308DA93C863A52988604"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------94F8308DA93C863A52988604
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/19 10:39 AM, Stephen Smalley wrote:
> Test all permissions associated with the lockdown class.
> Also update other test policies to allow lockdown permissions
> where needed.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---

This is on top of the perf tests which I expect to merge shortly. To 
exercise these tests in the absence of support in the Fedora policy, one 
can do the following:

1) Add the lockdown class and its permissions to 
/usr/share/selinux/devel/include/support/all_perms.spt (sample diff 
attached; may require tweaking for your base policy or if you already 
did the same for the perf class).

2) Insert a cil module that defines the lockdown class (attached).

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


--------------94F8308DA93C863A52988604
Content-Type: text/x-patch; charset=UTF-8;
 name="all_perms.spt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="all_perms.spt.diff"

--- all_perms.spt.orig	2019-10-25 05:25:31.000000000 -0400
+++ all_perms.spt	2019-10-30 09:22:21.848626880 -0400
@@ -230,6 +230,7 @@
 	class smc_socket all_smc_socket_perms;
 	class bpf all_bpf_perms;
 	class xdp_socket all_xdp_socket_perms;
+	class lockdown { integrity confidentiality };
 ')
 
 define(`all_userspace_class_perms',`

--------------94F8308DA93C863A52988604
Content-Type: application/vnd.ms-artgalry;
 name="lockdown.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lockdown.cil"

KGNsYXNzIGxvY2tkb3duIChpbnRlZ3JpdHkgY29uZmlkZW50aWFsaXR5KSkKKGNsYXNzb3Jk
ZXIgKHVub3JkZXJlZCBsb2NrZG93bikpCg==
--------------94F8308DA93C863A52988604--
