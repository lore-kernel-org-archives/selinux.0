Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A61AC35280
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116A6216F4
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="flz0LRFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfI3NYz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:24:55 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:34859 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3NYz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:24:55 -0400
X-EEMSG-check-017: 33799115|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="33799115"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 13:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569849894; x=1601385894;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9yJsKv8eM3WWGikpRK8FUmVOMONuWYETnsUtLfhD/G8=;
  b=flz0LRFKqMFs72xdrMVWIQ3jc9riUrYanlaSWURpIiO7pVqJA7X2ZYwm
   uutjyCcIbCQGo+ZZ/+Cm4M28lewdNqIlupk2mTiP5PbiZX99rZ5pIJywA
   Qy07jzwc3M5KXnELCBTV01ZAmm6qfDafY6BJgDRn/HWz/T3/azUfCSnFd
   IBtWe9MZ+UZjGxHOrC9VyEb7VaT/zkibeUDxzbjmuffqv/yW/qoBgmy5h
   KYzPNFH9+5ASXos+zk5r62fgITNYSDq4cupm/rvtxdpls3dMqIllGyHUl
   8Ra60zHCZ8H9cwiHXB7ZQ8lunLwEZxrxikmAn21zEiiXUvyca/5tSqnnU
   g==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="33512303"
IronPort-PHdr: =?us-ascii?q?9a23=3A19n7ChT0Kb1JLKgqSEzAoOJZV9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBKN2/xhgRfzUJnB7Loc0qyK6vumBTZLvMnJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/eu8UIjodvKqQ8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXDl7Lhfb?=
 =?us-ascii?q?Fm605a0gU80c5Q6olOCr4fPf3zWlX+tMDCAhAlNAy0xv7tCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvJsVCW4uIvIu+MZJIauTvmNfgl6ODhjWUjlV8eY6apx50XZ268Hvh8JE?=
 =?us-ascii?q?WZe3Xs0Z89FjItuAYkQe6irVqZVzdYanX6C6U54So9AYmrJZ3OSoCknPqK2y?=
 =?us-ascii?q?LtWtVNa2RHDE2cOWnnep/CWPoWbi+WZMh7nW8qT7+kHrQ92AmuuQmy8L9uKu?=
 =?us-ascii?q?7Z62VMrp74/MRk7O3U0xcp/Hp7CNrLgDLFdH19gm5dH2x+56t4u0Eojw7YgK?=
 =?us-ascii?q?U=3D?=
X-IPAS-Result: =?us-ascii?q?A2BYDABRAJJd/wHyM5BmHQEBBQEMBQGBZ4F0KoFAMiqEI?=
 =?us-ascii?q?o5wUAMGgREliXWRKgkBAQEBAQEBAQE0AQIBAYRAAoNDIzgTAgwBAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIU5gjopAYJoAQUjFVELDgoCAiYCAlcGAQwGAgEBgl8/gXcUrTSBM?=
 =?us-ascii?q?oVNgyaBSIEMKIwOGHiBB4E4DIJfPodPglgElgqXDYIsgi6SVwYbmTaOIZswI?=
 =?us-ascii?q?YFYKwgCGAghD4MnUBAUkC8lAzCBBgEBj3gBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Sep 2019 13:24:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UDOqqJ022345;
        Mon, 30 Sep 2019 09:24:53 -0400
Subject: Re: [PATCH testsuite 1/3] policy: consolidate macros for home dirs
 access
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190930104850.5482-1-omosnace@redhat.com>
 <20190930104850.5482-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6df6dafe-56a6-7de0-0196-d2b714b453bb@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 09:24:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930104850.5482-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
> Use userdom_search_generic_user_home_dirs(), which is always defined,
> and redefine it to match what overlayfs was doing (just in case),
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policy/test_overlayfs.te | 6 ++----
>   policy/test_policy.if    | 9 +++++++--
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> index 6f1756e..f56ef78 100644
> --- a/policy/test_overlayfs.te
> +++ b/policy/test_overlayfs.te
> @@ -50,8 +50,7 @@ fs_mount_xattr_fs(test_overlay_mounter_t)
>   corecmd_shell_entry_type(test_overlay_mounter_t)
>   corecmd_exec_bin(test_overlay_mounter_t)
>   
> -userdom_search_admin_dir(test_overlay_mounter_t)
> -userdom_search_user_home_content(test_overlay_mounter_t)
> +userdom_search_generic_user_home_dirs(test_overlay_mounter_t)
>   
>   mount_exec(test_overlay_mounter_t)
>   mount_rw_pid_files(test_overlay_mounter_t)
> @@ -122,8 +121,7 @@ corecmd_exec_bin(test_overlay_client_t)
>   kernel_read_system_state(test_overlay_client_t)
>   kernel_read_proc_symlinks(test_overlay_client_t)
>   
> -userdom_search_admin_dir(test_overlay_client_t)
> -userdom_search_user_home_content(test_overlay_client_t)
> +userdom_search_generic_user_home_dirs(test_overlay_client_t)
>   
>   fs_getattr_xattr_fs(test_overlay_client_t)
>   
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index 5f4000f..40e7499 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -61,8 +61,13 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
>   ')
>   ')
>   
> -ifdef(`userdom_search_generic_user_home_dirs', `', ` dnl
> +ifdef(`userdom_search_admin_dir', ` dnl
>   interface(`userdom_search_generic_user_home_dirs', `
> -    userdom_search_user_home_dirs($1)
> +    userdom_search_user_home_content($1)
> +    userdom_search_admin_dir($1)
> +')
> +', ` dnl
> +interface(`userdom_search_generic_user_home_dirs', `
> +    userdom_search_user_home_content($1)
>   ')
>   ')

Previously, if userdom_search_generic_user_home_dirs() was defined by 
the base policy (as it used to be), we would use that definition, else 
we would use userdom_search_user_home_dirs(). After, we will always 
redefine it, and the redefinition is more expansive than just search 
access to $HOME and its ancestors in the hierarchy.  Might not affect 
the tests themselves but it seems a bit confusing.


