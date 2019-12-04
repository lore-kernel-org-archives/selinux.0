Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90766C43603
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FE2205F4
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ffd5y9vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfLDOo2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:44:28 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:52659 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfLDOo2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 09:44:28 -0500
X-EEMSG-check-017: 32603924|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="32603924"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2019 14:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575470666; x=1607006666;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=sy2eCHwEZTmbS1hny2NwA8hzNS/47i6+54oqvZc6ozk=;
  b=ffd5y9vPmXDTTmJcQlXGe4AlNhZCRex8UniPEG5QcCbN0Ry/MRgIVZJz
   eIM+ELui/Mh1jYlg/3rSMwDaWBPjVjsHisnLUCD5EUqcEi5usMoGTEtTh
   kz0S446KkE9x+5T6t3g7ZvqFCGqg8C8PVL+wPsONzj1DePxH9WMa3Du74
   Po7Qkt+a8zfNjKFMTdpgCJg8tkK8jkEBCFXgw7haSlu0WMvjmpHoBrG9N
   BOrhLSk9p11bRhy6SktFIjFG8r2YSbNj9sToazC6u1yvtFqK9ZciLCJE1
   j3U+7SAa5ObMbAgRoEbLFJHhjxSG+wcNwcwcFDriFEOuHKLepzqbLR7mL
   g==;
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="36314050"
IronPort-PHdr: =?us-ascii?q?9a23=3AfhT5qB00jiflR/vpsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMSKvad9pjvdHbS+e9qxAeQG9mCsLQd1Lud7fyocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi0qQjducgbjIR/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXwqV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIpzdBe+51UCqsOIOjuVUDpqNPXFh85PBa1w+bhFtp9zZgTVnmTAq?=
 =?us-ascii?q?+YNqPSrUGH5vgpI+aSeI8ZoiryK/8g5/T2l382hUcdfbW13ZsQcH24BeppI0?=
 =?us-ascii?q?GYYXrqn9cAHnwHvhQxTOP0kl2OSz1TaGioX6I6+D47DJiqDYDZRoCi0/S923?=
 =?us-ascii?q?KBH5ZWb3pKQnCFEHHlbM3QQfYHaCuILvhqpTwNVL6sUKcryRCoqALgzbd7aO?=
 =?us-ascii?q?HT/3tc/Ynu0Nlz+v37ix4/73p3At6b3mXLSHt7zU0SQDpj57xyuUxwzB+41K?=
 =?us-ascii?q?F8h/FJXYhI6+hhThYxNZmayfdzTd/1RFSSLZ+yVF+6T4D+UnkKRdUrzopLOh?=
 =?us-ascii?q?0sFg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BdAACjxOdd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGYgaBEiWJaY9dgWcJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgjQ4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbgEFGgkEEVELGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CRwMJJbBafzODS4IEgzCBSIEOKIwxeYEHgREnDAOCXT6CG?=
 =?us-ascii?q?4IWGCyCZIJeBI0miGphRnSWH4I4gjmTGwYbgkGMLYs4jkqcNCKBWCsIAhgII?=
 =?us-ascii?q?Q+DJ1ARFIxyF45BIwMwkQlfAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2019 14:44:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB4EiE94056688;
        Wed, 4 Dec 2019 09:44:14 -0500
Subject: Re: [PATCH] selinux-testsuite: Add TUN/TAP driver tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191201165820.285680-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e66ce128-9f65-d939-1906-9baa7f1126ca@tycho.nsa.gov>
Date:   Wed, 4 Dec 2019 09:44:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191201165820.285680-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/1/19 11:58 AM, Richard Haines wrote:
> Test TUN/TAP tun_socket permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> Changes from RFC patch:
> Remove BPF tests
> Replace gen_require 'tun_tap_device_t' with corenet_rw_tun_tap_dev
> 
>   defconfig                   |   4 ++
>   policy/Makefile             |   4 ++
>   policy/test_tun_tap.te      | 113 ++++++++++++++++++++++++++++++++
>   tests/Makefile              |   4 ++
>   tests/tun_tap/.gitignore    |   2 +
>   tests/tun_tap/Makefile      |  10 +++
>   tests/tun_tap/test          |  88 +++++++++++++++++++++++++
>   tests/tun_tap/tun_common.c  | 100 +++++++++++++++++++++++++++++
>   tests/tun_tap/tun_common.h  |  22 +++++++
>   tests/tun_tap/tun_relabel.c | 124 ++++++++++++++++++++++++++++++++++++
>   tests/tun_tap/tun_tap.c     | 123 +++++++++++++++++++++++++++++++++++
>   11 files changed, 594 insertions(+)
>   create mode 100644 policy/test_tun_tap.te
>   create mode 100644 tests/tun_tap/.gitignore
>   create mode 100644 tests/tun_tap/Makefile
>   create mode 100755 tests/tun_tap/test
>   create mode 100644 tests/tun_tap/tun_common.c
>   create mode 100644 tests/tun_tap/tun_common.h
>   create mode 100644 tests/tun_tap/tun_relabel.c
>   create mode 100644 tests/tun_tap/tun_tap.c
> 
> diff --git a/defconfig b/defconfig
> index 0574f1d..abf8df4 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -78,3 +78,7 @@ CONFIG_KEY_DH_OPERATIONS=y
>   # Test key management socket.
>   # This is not required for SELinux operation itself.
>   CONFIG_NET_KEY=m
> +
> +# Test TUN/TAP driver support.
> +# This is not required for SELinux operation itself.
> +CONFIG_TUN=m
> diff --git a/policy/Makefile b/policy/Makefile
> index 87b2856..46a6ab4 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -101,6 +101,10 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
>   TARGETS+=test_module_load.te
>   endif
>   
> +ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_tun_tap.te
> +endif
> +
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
>   endif
> diff --git a/policy/test_tun_tap.te b/policy/test_tun_tap.te
> new file mode 100644
> index 0000000..e1731ff
> --- /dev/null
> +++ b/policy/test_tun_tap.te
> @@ -0,0 +1,113 @@
> +#
> +########### Test TUN/TAP device driver support - 'tun_socket' ##############
> +#
> +attribute tuntapdomain;
> +
> +# For CONFIG_TUN=m
> +kernel_request_load_module(tuntapdomain)
> +
> +type test_tun_tap_t;
> +domain_type(test_tun_tap_t)
> +unconfined_runs_test(test_tun_tap_t)
> +typeattribute test_tun_tap_t testdomain;
> +typeattribute test_tun_tap_t tuntapdomain;
> +
> +# tun_socket rules:
> +allow test_tun_tap_t self:capability { net_admin };
> +corenet_rw_tun_tap_dev(test_tun_tap_t)
> +allow test_tun_tap_t self:tun_socket { create attach_queue };
> +
> +################## Deny capability { net_admin } ##########################
> +#
> +# Note that when capability { net_admin } is removed for the test
> +# there will not be an audit message in the log as the Fedora policy
> +# is built with 'hide_broken_symptoms' that adds the following:
> +#   dontaudit test_tun_tap_no_net_admin_t self:capability { net_admin sys_module };
> +#
> +type test_tun_tap_no_net_admin_t;
> +domain_type(test_tun_tap_no_net_admin_t)
> +unconfined_runs_test(test_tun_tap_no_net_admin_t)
> +typeattribute test_tun_tap_no_net_admin_t testdomain;
> +typeattribute test_tun_tap_no_net_admin_t tuntapdomain;
> +
> +neverallow test_tun_tap_t self:capability { net_admin };
> +corenet_rw_tun_tap_dev(test_tun_tap_no_net_admin_t)
> +allow test_tun_tap_no_net_admin_t self:tun_socket { create write read setopt };
> +
> +####################### Deny tun_socket { create } ##########################
> +type test_tun_tap_no_create_t;
> +domain_type(test_tun_tap_no_create_t)
> +unconfined_runs_test(test_tun_tap_no_create_t)
> +typeattribute test_tun_tap_no_create_t testdomain;
> +typeattribute test_tun_tap_no_create_t tuntapdomain;
> +
> +allow test_tun_tap_no_create_t self:capability { net_admin };
> +corenet_rw_tun_tap_dev(test_tun_tap_no_create_t)
> +neverallow test_tun_tap_no_create_t self:tun_socket { create };
> +
> +################## Deny tun_socket { attach_queue } ########################
> +type test_tun_tap_no_queue_t;
> +domain_type(test_tun_tap_no_queue_t)
> +unconfined_runs_test(test_tun_tap_no_queue_t)
> +typeattribute test_tun_tap_no_queue_t testdomain;
> +typeattribute test_tun_tap_no_queue_t tuntapdomain;
> +
> +allow test_tun_tap_no_queue_t self:capability { net_admin };
> +corenet_rw_tun_tap_dev(test_tun_tap_no_queue_t)
> +allow test_tun_tap_no_queue_t self:tun_socket { create };
> +neverallow test_tun_tap_no_queue_t self:tun_socket { attach_queue };
> +
> +#
> +############ Test relabelto/relabelfrom via new context #####################
> +type test_newcon_tun_tap_t;
> +domain_type(test_newcon_tun_tap_t)
> +unconfined_runs_test(test_newcon_tun_tap_t)
> +typeattribute test_newcon_tun_tap_t testdomain;
> +typeattribute test_newcon_tun_tap_t keydomain;
> +
> +allow test_tun_tap_t test_newcon_tun_tap_t:process { dyntransition };
> +corenet_rw_tun_tap_dev(test_newcon_tun_tap_t)
> +allow test_newcon_tun_tap_t test_tun_tap_t:tun_socket { relabelfrom };
> +allow test_newcon_tun_tap_t self:tun_socket { relabelto };
> +
> +# For error handling when switching back to original context:
> +allow test_newcon_tun_tap_t test_tun_tap_t:fd use;
> +allow test_newcon_tun_tap_t test_tun_tap_t:process dyntransition;
> +
> +############ Deny relabelto via new context #####################
> +type test_newcon_no_to_tun_tap_t;
> +domain_type(test_newcon_no_to_tun_tap_t)
> +unconfined_runs_test(test_newcon_no_to_tun_tap_t)
> +typeattribute test_newcon_no_to_tun_tap_t testdomain;
> +typeattribute test_newcon_no_to_tun_tap_t keydomain;
> +
> +allow test_tun_tap_t test_newcon_no_to_tun_tap_t:process { dyntransition };
> +allow test_tun_tap_t test_newcon_no_to_tun_tap_t:fd { use };
> +corenet_rw_tun_tap_dev(test_newcon_no_to_tun_tap_t)
> +allow test_newcon_no_to_tun_tap_t test_tun_tap_t:tun_socket { relabelfrom };
> +neverallow test_newcon_no_to_tun_tap_t self:tun_socket { relabelto };
> +
> +# For switch back on error:
> +allow test_newcon_no_to_tun_tap_t test_tun_tap_t:process { dyntransition };
> +
> +############ Deny relabelfrom via new context #####################
> +type test_newcon_no_from_tun_tap_t;
> +domain_type(test_newcon_no_from_tun_tap_t)
> +unconfined_runs_test(test_newcon_no_from_tun_tap_t)
> +typeattribute test_newcon_no_from_tun_tap_t testdomain;
> +typeattribute test_newcon_no_from_tun_tap_t keydomain;
> +
> +allow test_tun_tap_t test_newcon_no_from_tun_tap_t:process { dyntransition };
> +corenet_rw_tun_tap_dev(test_newcon_no_from_tun_tap_t)
> +neverallow test_newcon_no_from_tun_tap_t test_tun_tap_t:tun_socket { relabelfrom };
> +allow test_newcon_no_from_tun_tap_t self:tun_socket { relabelto };
> +
> +# For switch back on error:
> +allow test_tun_tap_t test_newcon_no_from_tun_tap_t:fd { use };
> +allow test_newcon_no_from_tun_tap_t test_tun_tap_t:process { dyntransition };
> +
> +#
> +########### Allow these domains to be entered from sysadm domain ############
> +#
> +miscfiles_domain_entry_test_files(tuntapdomain)
> +userdom_sysadm_entry_spec_domtrans_to(tuntapdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 1cdb1ac..df79099 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -78,6 +78,10 @@ SUBDIRS+=module_load
>   endif
>   endif
>   
> +ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +SUBDIRS += tun_tap
> +endif
> +
>   ifeq ($(DISTRO),RHEL4)
>       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
>   endif
> diff --git a/tests/tun_tap/.gitignore b/tests/tun_tap/.gitignore
> new file mode 100644
> index 0000000..0c0c5e7
> --- /dev/null
> +++ b/tests/tun_tap/.gitignore
> @@ -0,0 +1,2 @@
> +tun_tap
> +tun_relabel
> diff --git a/tests/tun_tap/Makefile b/tests/tun_tap/Makefile
> new file mode 100644
> index 0000000..11f5b03
> --- /dev/null
> +++ b/tests/tun_tap/Makefile
> @@ -0,0 +1,10 @@
> +TARGETS = tun_tap tun_relabel
> +DEPS = tun_common.c tun_common.h
> +LDLIBS += -lselinux
> +
> +all: $(TARGETS)
> +
> +clean:
> +	rm -f $(TARGETS)
> +
> +$(TARGETS): $(DEPS)
> diff --git a/tests/tun_tap/test b/tests/tun_tap/test
> new file mode 100755
> index 0000000..3daf2eb
> --- /dev/null
> +++ b/tests/tun_tap/test
> @@ -0,0 +1,88 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
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
> +    plan tests => 14;
> +}
> +
> +############ Test tun_socket TUN #############
> +print "Test TUN device driver support - 'tun_socket'\n";
> +$result = system "runcon -t test_tun_tap_t $basedir/tun_tap $v -s";
> +ok( $result eq 0 );
> +
> +# Deny capability { net_admin } - EPERM
> +$result =
> +  system "runcon -t test_tun_tap_no_net_admin_t $basedir/tun_tap $v 2>&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny tun_socket { create } - EACCES
> +$result = system "runcon -t test_tun_tap_no_create_t $basedir/tun_tap $v 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny tun_socket { attach_queue } - EACCES
> +$result = system "runcon -t test_tun_tap_no_queue_t $basedir/tun_tap $v 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +$result = system
> +  "runcon -t test_tun_tap_t $basedir/tun_relabel $v test_newcon_tun_tap_t";
> +ok( $result eq 0 );
> +
> +# Deny tun_socket { relabelto } - EACCES
> +$result = system
> +"runcon -t test_tun_tap_t $basedir/tun_relabel $v test_newcon_no_to_tun_tap_t 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny tun_socket { relabelfrom } - EACCES
> +$result = system
> +"runcon -t test_tun_tap_t $basedir/tun_relabel $v test_newcon_no_from_tun_tap_t 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +############ Test tun_socket TAP #############
> +print "Test TAP device driver support - 'tun_socket'\n";
> +$result = system "runcon -t test_tun_tap_t $basedir/tun_tap -p $v";
> +ok( $result eq 0 );
> +
> +# Deny capability { net_admin } - EPERM
> +$result =
> +  system "runcon -t test_tun_tap_no_net_admin_t $basedir/tun_tap -p $v 2>&1";
> +ok( $result >> 8 eq 1 );
> +
> +# Deny tun_socket { create } - EACCES
> +$result =
> +  system "runcon -t test_tun_tap_no_create_t $basedir/tun_tap -p $v 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny tun_socket { attach_queue } - EACCES
> +$result =
> +  system "runcon -t test_tun_tap_no_queue_t $basedir/tun_tap -p $v 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +$result = system
> +  "runcon -t test_tun_tap_t $basedir/tun_relabel -p $v test_newcon_tun_tap_t";
> +ok( $result eq 0 );
> +
> +# Deny tun_socket { relabelto } - EACCES
> +$result = system
> +"runcon -t test_tun_tap_t $basedir/tun_relabel -p $v test_newcon_no_to_tun_tap_t 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +# Deny tun_socket { relabelfrom } - EACCES
> +$result = system
> +"runcon -t test_tun_tap_t $basedir/tun_relabel -p $v test_newcon_no_from_tun_tap_t 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +exit;
> diff --git a/tests/tun_tap/tun_common.c b/tests/tun_tap/tun_common.c
> new file mode 100644
> index 0000000..5a4a5ee
> --- /dev/null
> +++ b/tests/tun_tap/tun_common.c
> @@ -0,0 +1,100 @@
> +#include "tun_common.h"
> +
> +int open_dev(int *fd, char *test_str, bool verbose)
> +{
> +	char *tun_dev = "/dev/net/tun";
> +
> +	*fd = open(tun_dev, O_RDWR);
> +	if (fd < 0) {
> +		fprintf(stderr, "Failed to open device: %s\n",
> +			strerror(errno));
> +		return errno;
> +	}
> +	if (verbose)
> +		printf("Opened: %s and testing %s service.\n",
> +		       tun_dev, test_str);
> +
> +	return 0;
> +}
> +
> +int setiff(int fd, struct ifreq *ifr, bool verbose)
> +{
> +	int result;
> +
> +	result = ioctl(fd, TUNSETIFF, ifr);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed ioctl(TUNSETIFF): %s\n",
> +			strerror(errno));
> +		return errno;
> +	}
> +	if (verbose)
> +		printf("ioctl(TUNSETIFF) name: %s\n", ifr->ifr_name);
> +
> +	return 0;
> +}
> +
> +int persist(int fd, int op, char *name, bool verbose)
> +{
> +	int result;
> +
> +	result = ioctl(fd, TUNSETPERSIST, op);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed ioctl(TUNSETPERSIST %s): %s\n",
> +			op ? "Set" : "Unset", strerror(errno));
> +		return errno;
> +	}
> +	if (verbose)
> +		printf("%s ioctl(TUNSETPERSIST) name: %s\n",
> +		       op ? "Set" : "Unset", name);
> +
> +	return 0;
> +}
> +
> +int tunsetqueue(int fd, int op, char *name, bool verbose)
> +{
> +	int result;
> +	struct ifreq ifr;
> +
> +	memset(&ifr, 0, sizeof(ifr));
> +	ifr.ifr_flags = (op ? IFF_ATTACH_QUEUE : IFF_DETACH_QUEUE);
> +	result = ioctl(fd, TUNSETQUEUE, &ifr);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed ioctl(TUNSETQUEUE %s): %s\n",
> +			op ? "IFF_ATTACH_QUEUE" : "IFF_DETACH_QUEUE",
> +			strerror(errno));
> +		return errno;
> +	}
> +	if (verbose)
> +		printf("ioctl(TUNSETQUEUE) %s name: %s\n",
> +		       op ? "IFF_ATTACH_QUEUE" : "IFF_DETACH_QUEUE", name);
> +
> +	return 0;
> +}
> +
> +int switch_context(char *newcon, bool verbose)
> +{
> +	int result;
> +
> +	result = setcon(newcon);
> +	if (result < 0) {
> +		fprintf(stderr, "setcon() failed to set new process context:\n\t%s\n",
> +			newcon);
> +		return -1;
> +	}
> +
> +	if (verbose)
> +		printf("New process context:\n\t%s\n", newcon);
> +
> +	free(newcon);
> +
> +	return 0;
> +}
> +
> +void del_tuntap_name(int fd, char *context, char *name, bool verbose)
> +{
> +	if (verbose)
> +		printf("Switching back to orig context to remove persistent name: %s\n",
> +		       name);
> +	switch_context(context, verbose);
> +	persist(fd, 0, name, verbose);
> +}
> diff --git a/tests/tun_tap/tun_common.h b/tests/tun_tap/tun_common.h
> new file mode 100644
> index 0000000..0259563
> --- /dev/null
> +++ b/tests/tun_tap/tun_common.h
> @@ -0,0 +1,22 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <fcntl.h>
> +#include <net/if.h>
> +#include <linux/if_tun.h>
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>
> +
> +extern int open_dev(int *fd, char *test_str, bool verbose);
> +extern int setiff(int fd, struct ifreq *ifr, bool verbose);
> +/* Persistent state 'op': 0 = unset, 1 = set */
> +extern int persist(int fd, int op, char *name, bool verbose);
> +/* Queue state 'op': 0 = IFF_DETACH_QUEUE, 1 = IFF_ATTACH_QUEUE */
> +extern int tunsetqueue(int fd, int op, char *name, bool verbose);
> +extern int switch_context(char *newcon, bool verbose);
> +extern void del_tuntap_name(int fd, char *context, char *name, bool verbose);
> diff --git a/tests/tun_tap/tun_relabel.c b/tests/tun_tap/tun_relabel.c
> new file mode 100644
> index 0000000..7aeabd1
> --- /dev/null
> +++ b/tests/tun_tap/tun_relabel.c
> @@ -0,0 +1,124 @@
> +#include "tun_common.h"
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-v] newcon\n"
> +		"Where:\n\t"
> +		"-p      Test TAP driver, default is TUN driver.\n\t"
> +		"-v      Print information.\n\t"
> +		"newcon  New process context.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *origcon, *newcon, *test_str;
> +	char alloc_name[IFNAMSIZ];
> +	int opt, result, test, fd1, fd2;
> +	bool verbose = false;
> +	context_t con_t;
> +	struct ifreq ifr;
> +
> +	test = IFF_TUN;
> +	test_str = "TUN";
> +
> +	while ((opt = getopt(argc, argv, "pv")) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			test = IFF_TAP;
> +			test_str = "TAP";
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		print_usage(argv[0]);
> +
> +	/*
> +	 * Need to keep a copy of this to switch back when testing deny
> +	 * relabelto/from in newcon. This will allow the removal of the
> +	 * allocated TUN/TAP name.
> +	 */
> +	result = getcon(&origcon);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain process context\n");
> +		exit(-1);
> +	}
> +	if (verbose)
> +		printf("Current process context:\n\t%s\n", origcon);
> +
> +	/* Build new context for transition */
> +	con_t = context_new(origcon);
> +	if (!con_t) {
> +		fprintf(stderr, "Unable to create context structure\n");
> +		exit(-1);
> +	}
> +
> +	if (context_type_set(con_t, argv[optind])) {
> +		fprintf(stderr, "Unable to set new type\n");
> +		exit(-1);
> +	}
> +
> +	newcon = context_str(con_t);
> +	if (!newcon) {
> +		fprintf(stderr, "Unable to obtain new context string\n");
> +		exit(-1);
> +	}
> +
> +	/* Start TUN/TAP */
> +	result = open_dev(&fd1, test_str, verbose);
> +	if (result != 0)
> +		exit(result);
> +
> +	/* Let TUNSETIFF allocate the ifr_name for later use */
> +	memset(&ifr, 0, sizeof(struct ifreq));
> +	ifr.ifr_flags = test | IFF_MULTI_QUEUE;
> +	result = setiff(fd1, &ifr, verbose);
> +	if (result != 0)
> +		goto err1;
> +
> +	strcpy(alloc_name, ifr.ifr_name);
> +
> +	/* Make this name persist */
> +	result = persist(fd1, 1, alloc_name, verbose);
> +	if (result != 0)
> +		goto err1;
> +
> +	/* Switch to new context for relabel tests */
> +	result = switch_context(newcon, verbose);
> +	if (result < 0) { /* If fail remove the persistent one */
> +		del_tuntap_name(fd1, origcon, alloc_name, verbose);
> +		goto err1;
> +	}
> +
> +	/* Start TUN/TAP in new context */
> +	result = open_dev(&fd2, test_str, verbose);
> +	if (result != 0) {
> +		del_tuntap_name(fd1, origcon, alloc_name, verbose);
> +		goto err1;
> +	}
> +
> +	memset(&ifr, 0, sizeof(struct ifreq));
> +	ifr.ifr_flags = test | IFF_MULTI_QUEUE;
> +	/* Use the TUN/TAP name allocated initially */
> +	strcpy(ifr.ifr_name, alloc_name);
> +	result = setiff(fd2, &ifr, verbose);
> +	if (result != 0) {
> +		del_tuntap_name(fd1, origcon, alloc_name, verbose);
> +		goto now_ok;
> +	}
> +
> +	persist(fd2, 0, alloc_name, verbose);
> +now_ok:
> +	close(fd2);
> +err1:
> +	close(fd1);
> +
> +	return result;
> +}
> diff --git a/tests/tun_tap/tun_tap.c b/tests/tun_tap/tun_tap.c
> new file mode 100644
> index 0000000..a3db6c9
> --- /dev/null
> +++ b/tests/tun_tap/tun_tap.c
> @@ -0,0 +1,123 @@
> +#include "tun_common.h"
> +
> +static void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-p] [-s ] [-v]\n"
> +		"Where:\n\t"
> +		"-p  Test TAP driver, default is TUN driver.\n\t"
> +		"-s  If -v, then show TUN/TAP Features.\n\t"
> +		"-v  Print information.\n", progname);
> +	exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *context, *test_str;
> +	int opt, result, fd, bit, count, test;
> +	unsigned int features, f_switch;
> +	bool verbose = false, show = false;
> +	struct ifreq ifr;
> +
> +	test = IFF_TUN;
> +	test_str = "TUN";
> +
> +	while ((opt = getopt(argc, argv, "psv")) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			test = IFF_TAP;
> +			test_str = "TAP";
> +			break;
> +		case 's':
> +			show = true;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			print_usage(argv[0]);
> +		}
> +	}
> +
> +	if (verbose) {
> +		result = getcon(&context);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed to obtain process context\n");
> +			exit(-1);
> +		}
> +
> +		printf("Process context:\n\t%s\n", context);
> +		free(context);
> +	}
> +
> +	/* Start TUN/TAP */
> +	result = open_dev(&fd, test_str, verbose);
> +	if (result != 0)
> +		exit(result);
> +
> +	if (verbose && show) {
> +		result = ioctl(fd, TUNGETFEATURES, &features);
> +		if (result < 0) {
> +			fprintf(stderr, "Failed ioctl(TUNGETFEATURES): %s\n",
> +				strerror(errno));
> +			exit(-1);
> +		}
> +
> +		bit = 1;
> +		count = 0xffff;
> +		printf("TUN/TAP supported features:\n");
> +		while (count) {
> +			f_switch = bit & features;
> +			switch (f_switch) {
> +			case IFF_TUN:
> +				printf("\tIFF_TUN\n");
> +				break;
> +			case IFF_TAP:
> +				printf("\tIFF_TAP\n");
> +				break;
> +			case IFF_NAPI:
> +				printf("\tIFF_NAPI\n");
> +				break;
> +			case IFF_NAPI_FRAGS:
> +				printf("\tIFF_NAPI_FRAGS\n");
> +				break;
> +			case IFF_NO_PI:
> +				printf("\tIFF_NO_PI\n");
> +				break;
> +			case IFF_ONE_QUEUE:
> +				printf("\tIFF_ONE_QUEUE\n");
> +				break;
> +			case IFF_VNET_HDR:
> +				printf("\tIFF_VNET_HDR\n");
> +				break;
> +			/* Added in kernel 3.8 */
> +			case IFF_MULTI_QUEUE:
> +				printf("\tIFF_MULTI_QUEUE\n");
> +				break;
> +			}
> +			bit <<= 1;
> +			count >>= 1;
> +		}
> +	}
> +
> +	/* Let TUNSETIFF allocate the ifr_name */
> +	memset(&ifr, 0, sizeof(struct ifreq));
> +	ifr.ifr_flags = test | IFF_MULTI_QUEUE;
> +	result = setiff(fd, &ifr, verbose);
> +	if (result != 0)
> +		goto err;
> +
> +	/*
> +	 * Test 'tun_socket { attach_queue }' permission by removing
> +	 * the queue. Adding it back then generates the call to:
> +	 *     selinux_tun_dev_attach_queue().
> +	 */
> +	result = tunsetqueue(fd, 0, ifr.ifr_name, verbose);
> +	if (result != 0)
> +		goto err;
> +
> +	result = tunsetqueue(fd, 1, ifr.ifr_name, verbose);
> +err:
> +	close(fd);
> +	return result;
> +}
> 

