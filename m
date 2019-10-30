Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A7CA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDAD20856
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YHslVaDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfJ3NYY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:24:24 -0400
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:35931 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3NYX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 09:24:23 -0400
X-EEMSG-check-017: 26877518|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-EEMSG-Attachment-filename: all_perms.spt.diff, lockdown.cil
X-EEMSG-Attachment-filesize: 334, 79
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="diff'?cil'?scan'208";a="26877518"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Oct 2019 13:24:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572441861; x=1603977861;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=QI86Y20M1ROz7LpHQFRcH3ttEHd1uKdhqV3toSA9nCM=;
  b=YHslVaDu1/7NZNPAMvHJsKSEvJ2tEQsMBY42rw1a2JLNUVBM4i+YPtRX
   gE7hFCb5QsR6tIB1JKtmCI+7Fst1kLnZx4u4mvHXVmvec5nK3S/IPsBDx
   tPXXLwsbe/5zbp5becZx2c6i6Ipqf30caVI05A0k8+bikBKBLAdlNShoY
   j5j8/vC9b0qtviXya1w1aZCkQlUFnsEPivmYGE6VESQRmH3USiPSaiqzK
   hKtBAH9RinJALBJv2+fCPM8B95OaIoISVgkoKZk3qAps/0FOebrZZIEYh
   +zMa3SR54Z9tP80N0JFvH0gnHoaEqLG5ZlWNQJgo1ASTAR1/Vq/rChw97
   w==;
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="diff'?cil'?scan'208";a="34869121"
IronPort-PHdr: =?us-ascii?q?9a23=3AH+hy4xQPx567genB/ewgdyQj5tpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yZBON2/xhgRfzUJnB7Loc0qyK6vumADRbqsrQ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UanYVvJqk+xx?=
 =?us-ascii?q?bNv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/2/Nisx0kalVvhSvqRJiyILQeY2YNP5zcqbbcNgHR2?=
 =?us-ascii?q?ROQ9xRWjRcDI2iYYsBD+kPM+hWoIbypVQBsQCzBQywCO710DJEmnH70K883u?=
 =?us-ascii?q?88EQ/GxgsgH9cWvXrJsNX6Kr8SUeCrw6nO0D7NcvZW1i356IjMbB8goeyHUL?=
 =?us-ascii?q?VrccXM0kkiDB/Fj1WMpozlODOZzOINs3OB4OZ6WuKvjHAnphh3rzOyxckskp?=
 =?us-ascii?q?HEip8ax13L7yl0wJs5KcemREN0f9KoCoZcuieHPIVsWMwiWXtnuCMix70Dvp?=
 =?us-ascii?q?60YTYFxYw8xx7ad/yHa4+I4g//VOqJITd3mnZleLWnihau60eg0Oz8VtSv0F?=
 =?us-ascii?q?pQsipEksXDtnAK1xDJ7MiIVuB98Vu71TaK1gDT7vlIIUEylaXFN54s2qM8m5?=
 =?us-ascii?q?UcvEjZHiL6hV/6gLGZe0k64OSk9vzrYrD8qZ+dM490hBv+MqMrmsGnGuQ3Lx?=
 =?us-ascii?q?MOUnOH+eW8yLLj/Ur5TK9Mjv0tiKbVqp/aJcMFpqKhGQ9azp4j6wqjDzehyN?=
 =?us-ascii?q?kYhmcILFZEeBKBkojoNErDIO73DfihmVSgijRryO7cPr3nHJrNKmLPkLD7fb?=
 =?us-ascii?q?Zy80Rc0hY8zchD55JIDbEMOOrzVVXstNzcFRI5Kxa7w/vjCNlk04MeXmWPAr?=
 =?us-ascii?q?WHP6/IrVCI4ecvcKGwY9oOtTL8LeU1z+DhgGV/mlIHe6Stm5wNZyOWBPNjdn?=
 =?us-ascii?q?6FbGLsj9FJKmIDug4zXaS+k1GZeSJCbHa1GaQn73c0D5zwXtSLfZyknLHUhH?=
 =?us-ascii?q?TzJZZRfG0TTw3dHA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AYAABDjrld/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBaQYBAQELAYFzLIFBMiqEKIgjiE4liWOPNoF7CQEBAQEBAQEBAQMxAQIBA?=
 =?us-ascii?q?YRAAoNmJDQJDgIMAQEBBAEBAQEBBQMBAWyFQ4I7KYJtAQEBAQIBI1YQCxgqA?=
 =?us-ascii?q?gICVRMGAgEBgl8/AYJSBSCyYnWBMoVOg0KBOBCBNgGBUoo+GHiBB4E4DIJfP?=
 =?us-ascii?q?oRcgnmCXgSMfok8DYEnlgCCLoIzgROCM48yBhuZXqoIOYFYKwgCGAghD4MnU?=
 =?us-ascii?q?BAUkWglAzCBBQEBjWUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Oct 2019 13:24:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9UDOJ3j017394;
        Wed, 30 Oct 2019 09:24:19 -0400
Subject: Re: [RFC PATCH] selinux-testsuite: add lockdown tests
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20191030131850.9517-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <25e11d30-cb8c-bfb9-2671-e70fabec001f@tycho.nsa.gov>
Date:   Wed, 30 Oct 2019 09:24:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030131850.9517-1-sds@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------0D6B65E2CDFF9C21DC3982B1"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------0D6B65E2CDFF9C21DC3982B1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/19 9:18 AM, Stephen Smalley wrote:
> Test all permissions associated with the lockdown class.
> 
> (original patch authored by an intern who wishes to remain
> anonymous; I am signing off on his behalf)

To exercise the tests in the absence of support in the Fedora policy, 
you can do the following:

1) Add the lockdown class and its permissions to 
/usr/share/selinux/devel/include/support/all_perms.spt (diff attached).

2) Insert a cil module that defines the class (attached).

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   policy/Makefile         |  4 +++
>   policy/test_lockdown.te | 54 +++++++++++++++++++++++++++++++++++++++++
>   tests/Makefile          |  4 +++
>   tests/lockdown/Makefile |  2 ++
>   tests/lockdown/test     | 42 ++++++++++++++++++++++++++++++++
>   5 files changed, 106 insertions(+)
>   create mode 100644 policy/test_lockdown.te
>   create mode 100644 tests/lockdown/Makefile
>   create mode 100755 tests/lockdown/test
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 5c2c4384cc86..7cc06504f724 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -86,6 +86,10 @@ ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && e
>   TARGETS += test_keys.te
>   endif
>   
> +ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_lockdown.te
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
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
> diff --git a/tests/Makefile b/tests/Makefile
> index 42f7f4026e4a..0a3c68ea9715 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -64,6 +64,10 @@ ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
>   SUBDIRS += cgroupfs_label
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


--------------0D6B65E2CDFF9C21DC3982B1
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

--------------0D6B65E2CDFF9C21DC3982B1
Content-Type: application/vnd.ms-artgalry;
 name="lockdown.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lockdown.cil"

KGNsYXNzIGxvY2tkb3duIChpbnRlZ3JpdHkgY29uZmlkZW50aWFsaXR5KSkKKGNsYXNzb3Jk
ZXIgKHVub3JkZXJlZCBsb2NrZG93bikpCg==
--------------0D6B65E2CDFF9C21DC3982B1--
