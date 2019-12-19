Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF33C43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56318206EC
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="F63bA1wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSQ0n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:26:43 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:2474 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSQ0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 11:26:43 -0500
X-EEMSG-check-017: 62413350|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="62413350"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2019 16:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576772786; x=1608308786;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=f+eK6uzKkNrSPaOVbS6LbDbXfQfKRqRqlUssD4KKksU=;
  b=F63bA1wIE/9riUm5iEoCcMH+Omc1leRi+EgBSx0PTgEQaan1BENIT5L/
   cOLLdds+G7XQy+DBIHMH1xw3j4WfYPfpfzGhdjfqY7+BmRId5cKE6QXPg
   MsXVGTCaTlUCEqPDxZq6ZaD22mqhFaqr4MbFCe3jwqX6+Mb4bpB3B2tbY
   HFv/AhNY9y3WtKcKbNNdhSQMO07LLK5U+s8ZBgB3O+kzWnFAFDhi17JYz
   oh6OUtcx5QAcrxIrXImpLBG7NzGSoLLt902mV7N+00X6SVhFUdFSCbggD
   LbxavohiSiVrAjPW5Xut3nDqqsac/lRMlFne02lKWSUAZtlG6OIgUJ1jy
   g==;
X-IronPort-AV: E=Sophos;i="5.69,332,1571702400"; 
   d="scan'208";a="36975454"
IronPort-PHdr: =?us-ascii?q?9a23=3AStTqFB8TKGg4Jv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21+ocTK2v8tzYMVDF4r011RmVBN6dsasdwLqK+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanf79+MQi6oQrSu8QZnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uoof5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRa?=
 =?us-ascii?q?9+cdbPxkk3FwPKkFOQopH4MTOQzOsNt2yb4PRgVOmyjGMnsBx+oiO0y8cwio?=
 =?us-ascii?q?jGmoIVylfe+SV/24Y6P8e0SEF8Yd66CZZdsTyROYhuQs46Xm1ltyk3xqcGtJ?=
 =?us-ascii?q?KmZiQG1psqywDFZ/CadYWD/wjtW/yLIThigXJoYLe/hxGv/ke+0uD8Tcy00E?=
 =?us-ascii?q?pSripCj9nMqmgB1xzN5ciDTftw5luh1iyV1wDS9+FEOlo4lavdK54vxb4wjY?=
 =?us-ascii?q?QcvljZEi/qmET5kK+WdkI+9uiu9+vneanpqoWZN491jgHyKqUumsqhDuQkKg?=
 =?us-ascii?q?UCQmeW9Oum2LDj4EH1WqtGg/IonqXDrZzWPcEbqbS4Aw9R3IYj8RG/DzK+3d?=
 =?us-ascii?q?QDgHYHN0lIeA6Hjof1O1HOJ+r0DfGkg1u2ijtryPfGPqP5DpXXMnfDiKvhfa?=
 =?us-ascii?q?p660NE0gozzMxQ55JOBbEbPf38QlP+u8TYDhAjMgy0xfjoCM5m24wFRWKPA6?=
 =?us-ascii?q?mZML/Mvl+S4OIgPfWMaJUJtzb6Lvgv/+TugmMhmV8BYamp2oMaaGumEfRiIk?=
 =?us-ascii?q?WZZ2fsg9gaHGcUsQoxUvbqhEeBUTFNfXayWbwz5jUhBIKhF4fDSdPlvLvU5i?=
 =?us-ascii?q?awHpRMaihmA1GKHGygI5+FUPcFci6lKfhhmz0CWKOJQZMg0w2jrgn31/xsKe?=
 =?us-ascii?q?+CvmUDuJbi0sVlz/PcmAt09jFuCcmZlWaXQDJahGQNEgQq0bh/rEo18VKK1a?=
 =?us-ascii?q?x1krQMDtBIz+9YWQc9c5jHxqp1DM6kCVGJRcuAVFvzGobuOjo2VN9khoZVMk?=
 =?us-ascii?q?s=3D?=
X-IPAS-Result: =?us-ascii?q?A2B5AgA4o/td/wHyM5BcCRwBAQEBAQcBAREBBAQBAYF8g?=
 =?us-ascii?q?XaBbAEgEiqEBokDhlwGgRIliWyRRQkBAQEBAQEBAQE3AQGEQAKCQDgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFVELGAICJgICVwYBDAYCAQGCXz+CR?=
 =?us-ascii?q?wMJJax7gTKFT4NGgT2BDiiMM3mBB4E4DAOCXT6CG4F3DYM6gl4Elw9GlzaCP?=
 =?us-ascii?q?oJEk04GG4JDmA6OUYFGmxwigVgrCAIYCCEPgydQGA2NSo4sIwMwjlWCQQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Dec 2019 16:26:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBJGQ23s188004;
        Thu, 19 Dec 2019 11:26:03 -0500
Subject: Re: [PATCH] selinux-testsuite: Fix policy to allow process {
 setfscreate } testing
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191217134414.25746-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bd3dd2b7-e336-3583-7ebd-a1d93dc27142@tycho.nsa.gov>
Date:   Thu, 19 Dec 2019 11:26:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217134414.25746-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/17/19 8:44 AM, Richard Haines wrote:
> The global test policy allows process { setfscreate } for all tests.
> To specifically test this, need to remove it globally and update test
> policy that rely on it (mkdir & mac_admin).
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>   policy/test_global.te    | 1 -
>   policy/test_mac_admin.te | 2 ++
>   policy/test_mkdir.te     | 2 ++
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/policy/test_global.te b/policy/test_global.te
> index 90f9b65..97f51e4 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -38,7 +38,6 @@ allow testdomain self:process setcurrent;
>   #domain_dyntrans_type(testdomain)
>   #selinux_get_fs_mount(testdomain)
>   allow testdomain self:process setexec;
> -allow testdomain self:process setfscreate;
>   
>   # General permissions commonly required for test operation.
>   # general_domain_access
> diff --git a/policy/test_mac_admin.te b/policy/test_mac_admin.te
> index 579a017..790a731 100644
> --- a/policy/test_mac_admin.te
> +++ b/policy/test_mac_admin.te
> @@ -10,6 +10,7 @@ domain_type(test_mac_admin_t)
>   unconfined_runs_test(test_mac_admin_t)
>   typeattribute test_mac_admin_t mac_admintestdomain;
>   typeattribute test_mac_admin_t testdomain;
> +allow test_mac_admin_t self:process { setfscreate };
>   
>   # Relabeling a file to an undefined label remaps it to the unlabeled context,
>   # which may have a different SELinux user identity (e.g. system_u).
> @@ -26,6 +27,7 @@ domain_type(test_no_mac_admin_t)
>   unconfined_runs_test(test_no_mac_admin_t)
>   typeattribute test_no_mac_admin_t mac_admintestdomain;
>   typeattribute test_no_mac_admin_t testdomain;
> +allow test_no_mac_admin_t self:process { setfscreate };
>   
>   # See above.
>   domain_obj_id_change_exemption(test_no_mac_admin_t)
> diff --git a/policy/test_mkdir.te b/policy/test_mkdir.te
> index 1410a96..a5ba9b1 100644
> --- a/policy/test_mkdir.te
> +++ b/policy/test_mkdir.te
> @@ -45,6 +45,7 @@ unconfined_runs_test(test_create_t)
>   typeattribute test_create_t test_mkdir_domain;
>   typeattribute test_create_t testdomain;
>   domain_obj_id_change_exemption(test_create_t)
> +allow test_create_t self:process { setfscreate };
>   allow test_create_t test_mkdir_dir_t:dir { search getattr write add_name };
>   allow test_create_t test_create_dir_t:dir { search getattr write create };
>   
> @@ -56,6 +57,7 @@ unconfined_runs_test(test_nocreate_t)
>   typeattribute test_nocreate_t test_mkdir_domain;
>   typeattribute test_nocreate_t testdomain;
>   domain_obj_id_change_exemption(test_nocreate_t)
> +allow test_nocreate_t self:process { setfscreate };
>   allow test_nocreate_t test_mkdir_dir_t:dir { search getattr write add_name };
>   allow test_nocreate_t test_create_dir_t:dir { search getattr };
>   
> 

