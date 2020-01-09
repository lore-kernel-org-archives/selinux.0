Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16170C282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21B2067D
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 17:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jIhSj2Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgAIRTJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:19:09 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:38218 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgAIRTJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 12:19:09 -0500
X-EEMSG-check-017: 44005904|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="44005904"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2020 17:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578590346; x=1610126346;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9S17D97TKkWT/dV/cIKLeMDMM8ndS85SX5WttY4m/+4=;
  b=jIhSj2AdwXWzQa8MgG6bSQtn9pWyhh2pPekjT8wZuK1vHWq57H+1/L4T
   eTQmmEnHLt2eRnFCFl+pLCQvE6G70/laSho0tso2wQ2op8XoAIMNiDOne
   wGZH+IQWs8N0XolCt0d6igSWfJ2NTrw3WLlZenFlVbh00EkKVfbk1WKlV
   /gP6+RcRkJ2AFmynmfLLvybAHtaui1KbT6QD3Mpuj+hFQy39Zw7KYjzi8
   LeOidxPiwYg33bUM7DYIAYIxnmzinOXp2ynlgyYfUSH60kdigJKXtbdWi
   U2U1w4C+xrBaRgqYsWE0xEA/LApf19lmynuIIxBpc/rK67nMJdhRkk5lE
   g==;
X-IronPort-AV: E=Sophos;i="5.69,414,1571702400"; 
   d="scan'208";a="31776642"
IronPort-PHdr: =?us-ascii?q?9a23=3AaBKd+h1s6QogCapCsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMfLvad9pjvdHbS+e9qxAeQG9mCsLQe1bOd7fqocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBi3sAnducgbjZV/Iast1x?=
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
 =?us-ascii?q?GYYXrqn9cAHnwHvhQxTOP0kl2OSz1TaGioX6I6+D47DJiqDYDZRoCimLaBxj?=
 =?us-ascii?q?u0HoVKZmBaDVCBCXDod4CDW/cXbiKdONNunSIfWLi7VYAuyBGuuxXmy7Z9Mu?=
 =?us-ascii?q?XU/SgY5trf041P5ubTnAs+vRx9DsKQyCnZVWB/nmoSSwg966B2oEpw0X+Jza?=
 =?us-ascii?q?l+n/FCE9FPofhOV1F+fYXRy+18FsDaRA3MZJGKRUygT9HgBis+HfwrxNpbWF?=
 =?us-ascii?q?pwA9WviFj42iOuB7IE3+iQCIcc7rPX33+3Id10jXnByv9y3BEdXsJTODj+1e?=
 =?us-ascii?q?ZE/A/JCtuMyh7Img=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AbAQAtYBde/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF9gWwBIBIqhAmJA4ZgAQEBAQEBBoE3iW6RSAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCEzgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIxVBBQsLGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCYz+CSwMJBSCqeHWBMoVPg0KBPYEOKIwzeYEHgTgPgl0+g?=
 =?us-ascii?q?huFPoI8IgSXH0aXR4JAgkWTXAYbgkeMQYtcjliBSZs0IoFYKwgCGAghD4MnU?=
 =?us-ascii?q?BgNm3YjAzCRFQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2020 17:18:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 009HI626211796;
        Thu, 9 Jan 2020 12:18:06 -0500
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <20200109150709.360345-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <aa333bd1-9fd8-b4a4-eba2-aa8d722cbc7e@tycho.nsa.gov>
Date:   Thu, 9 Jan 2020 12:19:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109150709.360345-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/20 10:07 AM, Richard Haines wrote:
> Test filesystem permissions and setfscreatecon(3).
> 
>  From kernels 5.5 filesystem { watch } is also tested.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> new file mode 100644
> index 0000000..2eee1fc
> --- /dev/null
> +++ b/policy/test_filesystem.te
> @@ -0,0 +1,324 @@
> +#
> +######### Test filesystem permissions policy module ##########
> +#
> +attribute filesystemdomain;
> +
> +#################### Create a test file context ######################
> +type test_filesystem_filecon_t;
> +unconfined_runs_test(test_filesystem_filecon_t)
> +
> +################# Test all functions ##########################
> +type test_filesystem_t;
> +domain_type(test_filesystem_t)
> +unconfined_runs_test(test_filesystem_t)
> +typeattribute test_filesystem_t testdomain;
> +typeattribute test_filesystem_t filesystemdomain;
> +
> +allow test_filesystem_t self:capability { sys_admin };
> +allow test_filesystem_t self:filesystem { mount remount quotamod relabelfrom relabelto unmount quotaget };
> +allow test_filesystem_t self:dir { mounton add_name write };
> +allow test_filesystem_t test_file_t:dir { mounton write remove_name rmdir };
> +# Create test file
> +allow test_filesystem_t self:dir { add_name write };
> +allow test_filesystem_t self:file { create relabelfrom relabelto };
> +
> +fs_mount_all_fs(test_filesystem_t)
> +fs_remount_all_fs(test_filesystem_t)
> +fs_unmount_all_fs(test_filesystem_t)
> +fs_relabelfrom_all_fs(test_filesystem_t)
> +fs_get_xattr_fs_quotas(test_filesystem_t)
> +files_search_all(test_filesystem_t)
> +# Required for mount opts "rootcontext=system_u:object_r:test_filesystem_t:s0";
> +fs_associate(test_filesystem_t)
> +fs_getattr_xattr_fs(test_filesystem_t)
> +
> +# For running quotacheck(8)
> +files_type(test_filesystem_t)
> +# Update quotas
> +fs_set_all_quotas(test_filesystem_t)
> +allow test_filesystem_t self:file { quotaon };
> +# Create test file and change context:
> +fs_associate(test_filesystem_filecon_t)
> +allow test_filesystem_t test_filesystem_filecon_t:file { open read getattr relabelto write };
> +dontaudit test_filesystem_t kernel_t:process { setsched };

Why do you need these dontaudit statements?  It seems like a kernel bug 
if something is triggering a setsched permission check on the kernel_t 
domain?  Something the kernel module is doing during initialization?

