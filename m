Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC5BC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A873821D7D
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="d8f/hNOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfLQRB7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:01:59 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:47007 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfLQRB6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:01:58 -0500
X-EEMSG-check-017: 61410227|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="61410227"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 17:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576602117; x=1608138117;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=0bjdKZSS46IA4A+OOMkCeWEkO3DpQZxhlcdqr4X/2qc=;
  b=d8f/hNOaQiPlBPzPKnmUJNSJ8xnTvGyniE+Yp3oWZkGuFjuYimnPuv8l
   ZWw8FjMWxsX0M0wfreZnIoSjjjy8kwPVlRPuG+UMn1AKEWZ0yshtEnaLK
   dnre5GoKxxXtxBwlQ4xCMIrujGKdLTqtwX7pIYDzMITuL9AygtHXs21QR
   8e5LQqBa/nMd7Ubi3XOgWCoA0uDRL3q4hCmzSnRCttio6kq44QfeMNJh/
   2ir/vGCpcflWbQfY7W02dShtm2kI855xxOCQhntFi3IIidavPk8QYmxut
   U0lXjxvnVSaqaU4LJdkjXwRkwuy+gxd39+RK8ryZ+sL4Pep4nS5WqAq87
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31193794"
IronPort-PHdr: =?us-ascii?q?9a23=3AfMkShxyDfCWo79bXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u4WIJqq85mqBkHD//Il1AaPAdyAragc1KGH6OjJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe61+IAm0oAnessQbj5ZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumaraLZ4hzLkwlo?=
 =?us-ascii?q?ENvkvfBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0BAzzdFD6JJUEL4BOu/8VVftu9PADh82KQ20w+D5B9VmzY4RQn6PAq?=
 =?us-ascii?q?6fMKPOr1CI/OQvLPeQZIMPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZXCjAPtmJ0?=
 =?us-ascii?q?SZYXzxgtYOCmoKoAU+Q/LwiFGYUj5ceWyyX6Qi6TE/Eo6mCp3DRo/+yICGiR?=
 =?us-ascii?q?26FZ1ffGwOKlmNF3rzP9GeWvwMYTieFcRWkjUFU7W6Y4U91BeyuRX8xqYhJe?=
 =?us-ascii?q?3RrGlQrp/n1d5o98XNmhwosz95FcKQ1yeKVW4nsHkPQmoNwK1noUF7gmyG2K?=
 =?us-ascii?q?x8ju0QQcdf/NtVQww6Mtja1OU8BNfsDFGSNuyVQUqrF431SQo6Scg8lppXOB?=
 =?us-ascii?q?dw?=
X-IPAS-Result: =?us-ascii?q?A2B7AgCqCPld/wHyM5BcCRwBAQEBAQcBAREBBAQBAYF+g?=
 =?us-ascii?q?XSBbSASKoQEiQOGcwQGgTeJapFFCQEBAQEBAQEBATcBAYRAAoI8OBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMVUQsYAgImAgJXBgEMBgIBAYJfP4JHA?=
 =?us-ascii?q?wklriaBMoVPgzeBSIEOKIwyeYEHgTgPgl0+ghuBdw2DOoJeBJcMRpczgj6CQ?=
 =?us-ascii?q?pNIBhuCQ5gGjk2BRpsYIoFYKwgCGAghD4MnUBEUjUqOLCMDMI8/gkEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 17:01:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHH1blC123536;
        Tue, 17 Dec 2019 12:01:37 -0500
Subject: Re: [PATCH] selinux-testsuite: Fix policy to allow process {
 setfscreate } testing
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191217134414.25746-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1e1377bc-8d39-356c-0c25-0d20a78e788a@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 12:02:16 -0500
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

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

