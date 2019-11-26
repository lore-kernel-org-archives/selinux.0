Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C548C432C3
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344A720722
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 16:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OKXBemSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKZQBB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:01:01 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:43029 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKZQBB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 11:01:01 -0500
X-EEMSG-check-017: 30505365|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="30505365"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Nov 2019 16:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574784058; x=1606320058;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4bylVySQ35MuAdlbu2nTxq2np4iDAwK7F1iFB1xmhgY=;
  b=OKXBemSCHeWCak3RdJ9qZR8HqwX+iV8qnM+nxrcJz6+rJWdncAwtFBcG
   qcxRGb10q2bPj/jpM7Pj9l7d7EKJGbDOQkiYftWyThLXoKmEHbGP2E57v
   1c1mS6ZCVqbydyusZbT4wER/FgeVw7RyOXjY0GThYZBQ4qLdWRFv+tGrC
   1lhK3slWk3l8MRaMA6wIKGa+2FKfje8xur4LB3lt4AL0uMWegYus3wrHg
   LiS8MWcThBFla0s7py1celFAAxboftJTVWo5PcAhHWIq3CGn9tO6RB400
   KkGj84I0mxKduEr55SRp7sUNJteFH2IL8XGfydhgCYbj/JDU2xqu3bnVq
   A==;
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="36028453"
IronPort-PHdr: =?us-ascii?q?9a23=3AN3BTGBN+k44qmmGNKoYl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/T4rarrMEGX3/hxlliBBdydt6sfzbOI6OuwAiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oATfu8UZgoZvJLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHN09KeAmcgoj1O1DBPPD4DfClj1Sqizdk3erKPrLmApXTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1ddf55dTCrEaJvL8QFP+u8LDAx8jLQO73ubnB89h1o8ERW2PBa?=
 =?us-ascii?q?qZOrvIsVCU/uIvP/WMZIgNtTbmNfcl4//ujXkkmV4SZqSpw5QXZ26iHvh8IE?=
 =?us-ascii?q?WWf2DsgtEfHmcOpAY+S/bqiFKaWz5Je3myR7485i08CI++F4fDR5yigLyb0y?=
 =?us-ascii?q?ehA5JZfnxJBUiMEXjydoWEXekDaDmJL8B6jjwEVL6hS5M/2hG0sg/11aZnIv?=
 =?us-ascii?q?DI9S0fsJKwnORyssrVmQs/93RRCN+b2mqATCkgmWYPXDk/161Xu0Fxyl6fl6?=
 =?us-ascii?q?N/hqocXcde4/JPTxcSK5HR1ap5Bsr0VwaHec2GG3i8RdDzOi08VtI8xZc1Zk?=
 =?us-ascii?q?95H9izxkTY0zGCH64el7vNAoc9tK3bwS6idI5G13/a2fx53BEdScxVODjj3/?=
 =?us-ascii?q?Uu+g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BNAACiS91d/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGUQEBAQEBAQaBEiWJaYoghyQJAQEBAQEBA?=
 =?us-ascii?q?QEBNwEBhEACgho4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbgEFIxVBEAsOC?=
 =?us-ascii?q?gICJgICVwYBDAYCAQGCXz+CRwMJJbMggTKFT4NEgUiBDiiMMHiBB4E4DAOCX?=
 =?us-ascii?q?T6CG4U+gl4ElmJGlwyCNoI5kxcGG4I/jCiLNi2OG4FCmmEigVgrCAIYCCEPg?=
 =?us-ascii?q?ydQERSVLCMDMI9vAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Nov 2019 16:00:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAQG0qiO131820;
        Tue, 26 Nov 2019 11:00:53 -0500
Subject: Re: [PATCH testsuite v4] policy: use the kernel_request_load_module()
 interface
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
References: <20191126154825.754108-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55addfa1-56b6-6997-988c-a33130ed8bdf@tycho.nsa.gov>
Date:   Tue, 26 Nov 2019 11:01:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126154825.754108-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/26/19 10:48 AM, Ondrej Mosnacek wrote:
> ...instead of open-coding the rules. Also define a fallback to allow the
> policy to build even if the interface is not defined.
> 
> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> Cc: Richard Haines <richard_c_haines@btinternet.com>
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> Change in v4: fix copy-paste mistakes spotted by Richard
> Change in v3: use different approach as suggested by Stephen
> Change in v2: update also tests/Makefile for consistency
> 
>   policy/test_key_socket.te | 8 ++++----
>   policy/test_policy.if     | 6 ++++++
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> index cde426b..7be8ac0 100644
> --- a/policy/test_key_socket.te
> +++ b/policy/test_key_socket.te
> @@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
>   allow test_key_sock_t self:capability { net_admin };
>   allow test_key_sock_t self:key_socket { create write read setopt };
>   # For CONFIG_NET_KEY=m
> -allow test_key_sock_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_t)
>   
>   ################## Deny capability { net_admin } ##########################
>   #
> @@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
>   
>   allow test_key_sock_no_net_admin_t self:key_socket { create write read setopt };
> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_no_net_admin_t)
>   
>   ####################### Deny key_socket { create } ##########################
>   type test_key_sock_no_create_t;
> @@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t keysockdomain;
>   
>   allow test_key_sock_no_write_t self:capability { net_admin };
>   allow test_key_sock_no_write_t self:key_socket { create read setopt };
> -allow test_key_sock_no_write_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_no_write_t)
>   
>   ####################### Deny key_socket { read } ##########################
>   type test_key_sock_no_read_t;
> @@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t keysockdomain;
>   
>   allow test_key_sock_no_read_t self:capability { net_admin };
>   allow test_key_sock_no_read_t self:key_socket { create write setopt };
> -allow test_key_sock_no_read_t kernel_t:system { module_request };
> +kernel_request_load_module(test_key_sock_no_read_t)
>   
>   #
>   ########### Allow these domains to be entered from sysadm domain ############
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index e1175e8..3f163cb 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
>       userdom_search_user_home_content($1)
>   ')
>   ')
> +
> +# If the macro isn't defined, then most probably module_request permission
> +# is just not supported (and relevant operations should be just allowed).
> +ifdef(`kernel_request_load_module', `', ` dnl
> +interface(`kernel_request_load_module', `')
> +')
> 

