Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA7C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7E2053B
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dzhwgf27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbfIST1H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:27:07 -0400
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:29620 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404419AbfIST1G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 15:27:06 -0400
X-EEMSG-check-017: 29982862|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="29982862"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2019 19:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568920964; x=1600456964;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=sZ1LP9Pim6kF822wDWyfLsSr/VL/yPSy+w4ICRVASu4=;
  b=dzhwgf27E2PYkkVRIgxB21484K1ow0ESa9WDFo7TfXMevGsy0K6tFDhd
   0pItE6U1rW+LmAXuawI3haL3h5Nnn14mBNAk31D1KU6OYZEQQT0CPQwp3
   VNg8KERMvhnEtC6v12Wjdp0UxGFTB8LlI53AFftDNI1L8xd1k1Aj5Eup3
   9TF++RWnea1aW4RA6EIHQHR9D8GiKjW92jUGmIVZ5adKy2Xx31waQDD4e
   CZicFSRhXErX2zliF+Dwk9m9HmYq6vuQdL/S/mZbRhKgAKm/5GzpqmOGL
   okKJuuI/2KD0hPQoRF62MhFyaajsmT4M78zNKGERa5D3XkSGG5Jzooggz
   A==;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="28118706"
IronPort-PHdr: =?us-ascii?q?9a23=3A0ylKERbTPph9SaeXiC/PlCD/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs6/bnLW6fgltlLVR4KTs6sC17ON9fq4EjVbvt7B6ClELMUWEU?=
 =?us-ascii?q?ddyI0/pE8JOIa9E0r1LfrnPWQRPf9pcxtbxUy9KlVfA83kZlff8TWY5D8WHQ?=
 =?us-ascii?q?jjZ0IufrymUoHdgN6q2O+s5pbdfxtHhCanYbN1MR66sRjdutMZjId/JKs90A?=
 =?us-ascii?q?XFrmdHd+hLy25lJ0+YkxLg6sut5pJu/Dlct+w7+8JcTan2erkzQKBFAjghL2?=
 =?us-ascii?q?07/tDguwPZTQuI6HscU2EWnQRNDgPY8hz0XYr/vzXjuOZl1yaUIcP5TbYvWT?=
 =?us-ascii?q?S/9KhrUwPniD0GNzEi7m7ajNF7gb9BrxKgoxx/xJPUYJ2QOfFjcK7RYc8WSG?=
 =?us-ascii?q?xcVctKSSdPHp2zYJcOD+oZPOZXsY/9p0cVrRCjAQWgHf7jxiNUinPz26A13f?=
 =?us-ascii?q?4hEQXb1wI+GdwAvmnfoNHsOKocVe25ya/FxijBYfxLwzfw8JXGfA4vof+MXr?=
 =?us-ascii?q?x+f8TexkYtGAzZgVudspDlMjGP2+gRr2SW4ehtWOSygGAnsQFxpT2vy98xhI?=
 =?us-ascii?q?nVmI0V0lDE+jt/wI0oONO4TVR0YdqgEJROtyCRKox7Qtg/TGFzoys61r0Hto?=
 =?us-ascii?q?K7fCgN0pgnwQXfZOadf4iH5RLjSv+cLDFlj3xmYLKynwu+/Eevx+HmVsS4zU?=
 =?us-ascii?q?xGojRKn9XSrHwByhre4dWdRPRn5EeuwzOP2hjW6uFDPE87i7LWK4Ukwr4sjp?=
 =?us-ascii?q?oTtlnDHjPulEX2kqCWckIk9/C06+v9eLXmp4KcN5RuhgHiMqUhhsy/AeMiPg?=
 =?us-ascii?q?gIQ2eb4viz2Kfm/U34RLVGlvw2kq/Hv5DGPckXu6G0DgBP3osj9hqzFSmq3d?=
 =?us-ascii?q?sGkXUdMV5JYBeHgJLoO1HKLvD4F/C/g1G0nTdw2v/GJabsAonNL3ffkLfheq?=
 =?us-ascii?q?xx60hHyAUp19xf6JVUCq8ZLPLpRkDxrMDYDgM+MwGsxObnDdJ91pgYWW2VHq?=
 =?us-ascii?q?CWLrjfsUWW6e0yI+mDfpMVtCzhJPgi4v7klWU5lkMFfam1wZsXb2i1Hu94LE?=
 =?us-ascii?q?WdYHrshMoBEGgRswogQ+zllkeCXSRQZ3msRaI84C80CIa8AYfEXICtj+/J4C?=
 =?us-ascii?q?DuOZtafG1EQnWLCnHhfIiHE6MLbSWJJMZqnxQeWLShQpNn3har4kuy0LdjL+?=
 =?us-ascii?q?zJ6gUGup/5ktt4/evekVc17zMnId6a1jS2U2xsnm4ODwQz1aR7rF01nkyPyo?=
 =?us-ascii?q?BkkvdYEppV/PoPXQAkY82Ph9dmAsz/D1qSNuyCT0yrF5D/WmA8?=
X-IPAS-Result: =?us-ascii?q?A2A4AgAE1YNd/wHyM5BmHQEBBQEHBQGBVQYBCwGBbSqBP?=
 =?us-ascii?q?wEyKoQijxNNAQEBAQEHgTaJdI8tgXsJAQEBAQEBAQEBNAECAQGEPwKDAyM2B?=
 =?us-ascii?q?w4CDAEBAQQBAQEBAQUDAQFshTmCOikBgmYBAQEBAgEjFVELDgoCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/gXcFD61kgTKFTIMwgUmBDCgBjAgYeIEHgTiCaz6BBAGGSoJYB?=
 =?us-ascii?q?JYAlwaCLIIuklQGG4I2i3CKfY4WmxIGK4FYKwgCGAghD4MnUBAUgWaOSSQDM?=
 =?us-ascii?q?IEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Sep 2019 19:22:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8JJMhkW024378;
        Thu, 19 Sep 2019 15:22:43 -0400
Subject: Re: [PATCH] policy: fix some build errors under refpolicy
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190919081058.8860-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3d39baf3-8ac8-1ce5-47c3-6a4bd8bad299@tycho.nsa.gov>
Date:   Thu, 19 Sep 2019 15:22:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919081058.8860-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/19 4:10 AM, Ondrej Mosnacek wrote:
> Replace deprecated macros with new ones. Fedora's policy has both;
> refpolicy just the new ones.
> 
> Partially addresses issue #57.

Thanks, applied.

> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policy/test_atsecure.te    | 4 ++--
>   policy/test_capable_net.te | 2 +-
>   policy/test_file.te        | 4 ++--
>   policy/test_inherit.te     | 4 ++--
>   policy/test_readlink.te    | 2 +-
>   policy/test_rxdir.te       | 2 +-
>   policy/test_setnice.te     | 4 ++--
>   policy/test_stat.te        | 2 +-
>   policy/test_transition.te  | 2 +-
>   9 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/policy/test_atsecure.te b/policy/test_atsecure.te
> index 7255553..486faf6 100644
> --- a/policy/test_atsecure.te
> +++ b/policy/test_atsecure.te
> @@ -32,8 +32,8 @@ corecmd_bin_entry_type(atsecuredomain)
>   corecmd_shell_entry_type(atsecuredomain)
>   corecmd_exec_bin(atsecuredomain)
>   domain_entry_file(test_atsecure_newdomain_t, test_file_t)
> -domain_trans(test_atsecure_denied_t, test_file_t, test_atsecure_newdomain_t)
> -domain_trans(test_atsecure_allowed_t, test_file_t, test_atsecure_newdomain_t)
> +domain_transition_pattern(test_atsecure_denied_t, test_file_t, test_atsecure_newdomain_t)
> +domain_transition_pattern(test_atsecure_allowed_t, test_file_t, test_atsecure_newdomain_t)
>   allow test_atsecure_newdomain_t test_atsecure_denied_t:fd use;
>   allow test_atsecure_newdomain_t test_atsecure_allowed_t:fd use;
>   allow_map(atsecuredomain, test_file_t, file)
> diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
> index fab6650..80559f6 100644
> --- a/policy/test_capable_net.te
> +++ b/policy/test_capable_net.te
> @@ -53,7 +53,7 @@ sysadm_bin_spec_domtrans_to(capabledomain)
>   require {
>   	type ifconfig_exec_t;
>   }
> -domain_trans(sysadm_t, ifconfig_exec_t, capabledomain)
> +domain_transition_pattern(sysadm_t, ifconfig_exec_t, capabledomain)
>   domain_entry_file(capabledomain, ifconfig_exec_t)
>   
>   # Permissions for the good domain
> diff --git a/policy/test_file.te b/policy/test_file.te
> index 1f1da3a..828c0f4 100644
> --- a/policy/test_file.te
> +++ b/policy/test_file.te
> @@ -67,13 +67,13 @@ corecmd_bin_entry_type(fileopdomain)
>   sysadm_bin_spec_domtrans_to(fileopdomain)
>   
>   domain_entry_file(fileop_t, fileop_exec_t)
> -domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
> +domain_auto_transition_pattern(test_fileop_t, fileop_exec_t, fileop_t)
>   allow test_fileop_t fileop_t:fd use;
>   allow fileop_t test_fileop_t:fd use;
>   allow fileop_t test_fileop_t:fifo_file rw_file_perms;
>   allow fileop_t test_fileop_t:process sigchld;
>   
> -domain_auto_trans(test_nofileop_t, fileop_exec_t, fileop_t)
> +domain_auto_transition_pattern(test_nofileop_t, fileop_exec_t, fileop_t)
>   allow test_nofileop_t fileop_t:fd use;
>   allow fileop_t test_nofileop_t:fd use;
>   allow fileop_t test_nofileop_t:fifo_file rw_file_perms;
> diff --git a/policy/test_inherit.te b/policy/test_inherit.te
> index 28bfd63..8303fc5 100644
> --- a/policy/test_inherit.te
> +++ b/policy/test_inherit.te
> @@ -47,7 +47,7 @@ userdom_sysadm_entry_spec_domtrans_to(inheritdomain)
>   allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
>   
>   # Grant the necessary permissions for the child domain.
> -domain_trans(test_inherit_parent_t, test_file_t, test_inherit_child_t)
> +domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inherit_child_t)
>   allow test_inherit_parent_t test_inherit_child_t:fd use;
>   allow test_inherit_child_t test_inherit_parent_t:fd use;
>   allow test_inherit_child_t test_inherit_parent_t:fifo_file rw_file_perms;
> @@ -60,7 +60,7 @@ allow test_inherit_nouse_t test_file_t:file { read getattr execute entrypoint };
>   allow test_inherit_nouse_t test_inherit_file_t:file rw_file_perms;
>   
>   # Grant the nowrite domain all of the same permissions except for file write.
> -domain_trans(test_inherit_parent_t, test_file_t, test_inherit_nowrite_t)
> +domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inherit_nowrite_t)
>   allow test_inherit_parent_t test_inherit_nowrite_t:fd use;
>   allow test_inherit_nowrite_t test_inherit_parent_t:fd use;
>   allow test_inherit_nowrite_t test_inherit_parent_t:fifo_file rw_file_perms;
> diff --git a/policy/test_readlink.te b/policy/test_readlink.te
> index 1126fd5..b0d8cd5 100644
> --- a/policy/test_readlink.te
> +++ b/policy/test_readlink.te
> @@ -34,5 +34,5 @@ allow test_noreadlink_t test_readlink_link_t:lnk_file { getattr };
>   require {
>   	type ls_exec_t;
>   }
> -domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
> +domain_transition_pattern(sysadm_t, ls_exec_t, test_readlink_domain)
>   domain_entry_file(test_readlink_domain, ls_exec_t)
> diff --git a/policy/test_rxdir.te b/policy/test_rxdir.te
> index cbe1897..50d5ad1 100644
> --- a/policy/test_rxdir.te
> +++ b/policy/test_rxdir.te
> @@ -33,4 +33,4 @@ require {
>   	type ls_exec_t;
>   }
>   domain_entry_file(test_rxdir_domain, ls_exec_t)
> -domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
> +domain_transition_pattern(sysadm_t, ls_exec_t, test_rxdir_domain)
> diff --git a/policy/test_setnice.te b/policy/test_setnice.te
> index dac0dc5..d956598 100644
> --- a/policy/test_setnice.te
> +++ b/policy/test_setnice.te
> @@ -38,8 +38,8 @@ libs_exec_lib_files(setnicedomain)
>   # Allow all of these domains to be entered from sysadm domain
>   # via a shell script in the test directory or by....
>   miscfiles_domain_entry_test_files(setnicedomain)
> -domain_trans(sysadm_t, test_file_t, setnicedomain)
> -domain_trans(test_setnice_change_t, test_file_t, {test_setnice_set_t test_setnice_noset_t})
> +domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
> +domain_transition_pattern(test_setnice_change_t, test_file_t, {test_setnice_set_t test_setnice_noset_t})
>   allow test_setnice_change_t test_setnice_set_t:fd use;
>   allow test_setnice_set_t test_setnice_change_t:fd use;
>   allow test_setnice_set_t test_setnice_change_t:fifo_file rw_file_perms;
> diff --git a/policy/test_stat.te b/policy/test_stat.te
> index 2e068d1..0204e71 100644
> --- a/policy/test_stat.te
> +++ b/policy/test_stat.te
> @@ -29,5 +29,5 @@ typeattribute test_nostat_t testdomain;
>   require {
>   	type ls_exec_t;
>   }
> -domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
> +domain_transition_pattern(sysadm_t, ls_exec_t, test_stat_domain)
>   domain_entry_file(test_stat_domain, ls_exec_t)
> diff --git a/policy/test_transition.te b/policy/test_transition.te
> index c487825..1eee2b4 100644
> --- a/policy/test_transition.te
> +++ b/policy/test_transition.te
> @@ -28,7 +28,7 @@ typeattribute test_transition_todomain_t testdomain;
>   
>   # Allow the fromdomain to transition to the new domain.
>   corecmd_bin_entry_type(transitiondomain)
> -domain_trans(test_transition_fromdomain_t,bin_t,test_transition_todomain_t)
> +domain_transition_pattern(test_transition_fromdomain_t,bin_t,test_transition_todomain_t)
>   allow test_transition_fromdomain_t test_transition_todomain_t:fd use;
>   allow test_transition_todomain_t test_transition_fromdomain_t:fd use;
>   
> 

