Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532C5C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1F92080F
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="f+pXooDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0RjB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:39:01 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:29635 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0RjB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 12:39:01 -0500
X-EEMSG-check-017: 55443532|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-EEMSG-Attachment-filename: all_perms.spt.diff, lockdown.cil
X-EEMSG-Attachment-filesize: 334, 79
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="diff'?cil'?scan'208";a="55443532"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 17:38:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574876339; x=1606412339;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to;
  bh=Wjn18rpG/YBlX6lMcrDxruZ6Hxv1kIce502JwH/wfAo=;
  b=f+pXooDp98Ldur7Nnr8xSXgLoWI3zSYKu6uqPaSjiAC3fr4F/D9VB746
   rMgo6R0B+T4Ylusvt1wbcCGcqJAq7e8Jp/YoH27mn6lBQ/07J7pdIcPba
   Fb50hYFy00DdD0jgWamTYKv/CLoASkq+90BA+PR+8R8nngpFB+5g8rGZu
   Q6fJ8JHDoAaZg2kRfClIk6Uq6BmQSBupGU59P1MYo9W7wGX+spNklv6X7
   eiuaZX2zGLWoLfdTNQh2az3yhD9adV66P4VbrYY+Rw8BwXsBhUw46UqaG
   CzBWGoiziiCsLbNOdIWu/NORFWjtl130CQ+iY0W8JwH8BUhvLS8PpeIW1
   w==;
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="diff'?cil'?scan'208";a="30568070"
IronPort-PHdr: =?us-ascii?q?9a23=3AR5rZshacxK99wrqaz7L7XrL/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMu4bnLW6fgltlLVR4KTs6sC17ON9fm+BCdZuc7JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusQXgYZuJbs9xg?=
 =?us-ascii?q?fVrnBVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7W/YitZ0jKlGvhyvoRJxyJPQbI2MNPdzeqbRcNUHTm?=
 =?us-ascii?q?RDQ8lRTTRMDJ6iYYsBD+QPPuhWoIfyqFQMsRSzHgysCP/1xzJSmnP706833u?=
 =?us-ascii?q?I8Gg/GxgwgGNcOvWzJotXpKqgSSeC1w7fOzT7ecv1W3C3y6IzMch8/ofCHQL?=
 =?us-ascii?q?V9cdHMxkk0DA7FklWRppDlPzOSzOgNtXOb4PB6WeKgjG4ntRh8rz6yzckvko?=
 =?us-ascii?q?nEnp8Zx1/L+CljwIs5OMe0RFB0bNK6CpdcqieXPJZsTMw4WWFnoiM6x6UDuZ?=
 =?us-ascii?q?68YScF1owqxwXaa/yba4iI5Q/jVPqJLTd4mn1lfLW/ig6u8Ue60O38V9S00E?=
 =?us-ascii?q?1QoipElNnMuHcN1wfN5cebUPd94keg1iqP1wDU8O1EJ1w7lbHHJJI7x74wl5?=
 =?us-ascii?q?4TvVzCHi/whkr2kLebelgr9+Wn8ejqYqjqqoWCO4J7lA3yKLkiltS6AesiMw?=
 =?us-ascii?q?gOW2ab+f671L3m5UD5W6hFjuYtn6nFsJHVOcQbpqmjDw9TyYYs8QyzDzih0N?=
 =?us-ascii?q?QGhXUHNk5KeAqbj4j1PFHDOOv4Aum7g1Stljdr2v/HM6b/ApXCMHfDiq3tfb?=
 =?us-ascii?q?Vj5E5Gzgo809Rf64hTCrEbL/KgEnP24cfVCh4/Lhyc3enqEpN+25kYVGbJBb?=
 =?us-ascii?q?WWY43Itlrd3f4iO+mBYscuvT/5L/U0r6r1gWQRhU4Wfa7v24AeLn+/AKI1cA?=
 =?us-ascii?q?2ifXPwj4JZQi8xtQ0kQbmv1QyP?=
X-IPAS-Result: =?us-ascii?q?A2BbAABytN5d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbAEgEiqEK4kDiA+JaZFECQEBAQEBAQEBAQM0AQGEQAKCJ?=
 =?us-ascii?q?DgTAhABAQEEAQEBAQEFAwEBbIVDgjspgm8BBSNmCxgqAgICVRMGAgEBgl8/A?=
 =?us-ascii?q?YJSJbM8gTKFT4MvgTgQgTaBU4pdeYEHgTgPgl0+hGCCeYJeBI0UiU8NOXSWH?=
 =?us-ascii?q?II3gjmBF4I1j0sGG5ofqm0igVgrCAIYCCEPgydQERSVLCMDMI5DAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Nov 2019 17:38:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARHcjuX082893
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 12:38:45 -0500
Subject: Re: [RFC PATCH v2] selinux-testsuite: add lockdown tests
To:     selinux@vger.kernel.org
References: <20191127173618.4387-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7e3f5e6e-d3e0-aa91-f9f7-3881840d3b5a@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 12:38:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191127173618.4387-1-sds@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------C7724DBD91EB09DF9397E42D"
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------C7724DBD91EB09DF9397E42D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/19 12:36 PM, Stephen Smalley wrote:
> Test all permissions associated with the lockdown class.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

To exercise the tests in the absence of support in the Fedora policy, 
you can do the following:

1) Add the lockdown class and its permissions to 
/usr/share/selinux/devel/include/support/all_perms.spt (diff attached).

2) Insert a cil module that defines the class (attached).

> ---
>   policy/Makefile         |  3 +++
>   policy/test_lockdown.te | 54 +++++++++++++++++++++++++++++++++++++++++
>   tests/Makefile          |  3 +++
>   tests/lockdown/Makefile |  2 ++
>   tests/lockdown/test     | 42 ++++++++++++++++++++++++++++++++
>   5 files changed, 104 insertions(+)
>   create mode 100644 policy/test_lockdown.te
>   create mode 100644 tests/lockdown/Makefile
>   create mode 100755 tests/lockdown/test
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 87b2856ae1ca..c94d40a3a659 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -99,6 +99,9 @@ endif
>   
>   ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   TARGETS+=test_module_load.te
> +
> +ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_lockdown.te
>   endif
>   
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
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
> index 1cdb1ac33875..af2f44c95420 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -76,6 +76,9 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
>   ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
>   SUBDIRS+=module_load
>   endif
> +
> +ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +SUBDIRS += lockdown
>   endif
>   
>   ifeq ($(DISTRO),RHEL4)
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


--------------C7724DBD91EB09DF9397E42D
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

--------------C7724DBD91EB09DF9397E42D
Content-Type: application/vnd.ms-artgalry;
 name="lockdown.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lockdown.cil"

KGNsYXNzIGxvY2tkb3duIChpbnRlZ3JpdHkgY29uZmlkZW50aWFsaXR5KSkKKGNsYXNzb3Jk
ZXIgKHVub3JkZXJlZCBsb2NrZG93bikpCg==
--------------C7724DBD91EB09DF9397E42D--
