Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB4C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFBF2086A
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dpTS20mK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgBCSxp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:53:45 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:25465 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgBCSxo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 13:53:44 -0500
X-EEMSG-check-017: 52852881|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="52852881"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 18:53:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580756014; x=1612292014;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=c0tNOfoenOczbEUNoUXRS3C9BeX4as5DpwOpBqZAVok=;
  b=dpTS20mK6qCqQHGHFGc5lfOyoOFz/TPdWN9fSTP6TtKvOtrtw59aaBzR
   LqUD70V0+SqRrAc/7QgWdxjDxn+uFQyqX1vl52wQtc/Iw6+UeJKoxP4fI
   nYRRh2Kedkevyab70M0sufRc8lF6xsBRUZQngXQ1xdkXC/fLzii//ZLXn
   Ak92J+DGFfjnAot+fOwmSEDtQcjWYlEMgRAB5P2AQNEyNfJR4UShX0d6K
   u9W/6snw8g+ReKxAPCSY2/hxDFxxbqKqRRmk278TwO848X8CpQNVM5KJu
   Umuk92hUGXnvnlouhsAhT7A+ehuOvTeaYsEaS4tv87Escv04E2ZTSJXEf
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="32623636"
IronPort-PHdr: =?us-ascii?q?9a23=3AKFTXShASMP2+qGqR08PIUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3+p8uwAkXT6L1XgUPTWs2DsrQY0raQ7/+rADVcqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6orxR?=
 =?us-ascii?q?bEoHREd/lLyW5nOFmfmwrw6tqq8JNs7ihdtegt+9JcXan/Yq81UaFWADM6Pm?=
 =?us-ascii?q?4v+cblrwPDTQyB5nsdVmUZjB9FCBXb4R/5Q5n8rDL0uvJy1yeGM8L2S6s0WS?=
 =?us-ascii?q?m54KdwVBDokiYHOCUn/2zRl8d9kbhUoBOlpxx43o7UfISYP+dwc6/BYd8XQ3?=
 =?us-ascii?q?dKU91PXCJdHIyzc4oPD/IAPelGqYn9u0AOpga6CQW1Ge/j1iNEinrw0KI0ye?=
 =?us-ascii?q?QhFRzN0hImEdwArX/YqMz5OakWXOywyqTD0DfNYO5M2Trl9YbGbB4hr/GPU7?=
 =?us-ascii?q?x+f8XexksgGB/KgFiLtYzoPSmY2vgRv2WV7edtU/+khW49qwF2pzii3toiip?=
 =?us-ascii?q?XXiYINylDL6yN5y5soK929UkF7ZdqkH4VQtiqHMIZ2Wd4tQ3pztSYmyrwJpZ?=
 =?us-ascii?q?67fC8QxJQh3B7QceaLc4eP4hL9TeucJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4igD4MqQgncy/Gvo3PR?=
 =?us-ascii?q?QUU2iH+eWzyL3j/UrjTLVMkvI2ibXWvIrfJcQaoq61Gw5V0oA95BajFzqqzd?=
 =?us-ascii?q?sVkHYdIF9FZR6LlZblNl7QLPziEPuzm1Gsny1qx/DCML3hGJLNLn3bnbf6YL?=
 =?us-ascii?q?l98FVRyBYzzN9D55JUDasNIPToWkDrrtDYARg5MxKsz+b9FNp9zp8eWX6IAq?=
 =?us-ascii?q?KBLKzdq0SI6fwvIuSXf48apDb9JOI45/7giX82h0UdcbC10pQNcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHylFKNSyVTaGiyXq4m/TE0FIKmAp3eRoCjhLyOwj?=
 =?us-ascii?q?27E4ZXZmBAFlCDD3Poe5+YVPcLbSKYOtVhnSAcVbi9V48h0gmjtA3/y7pgNO?=
 =?us-ascii?q?rU4CwYtYn42dhz/eLTkA899T1uA8SayWGNQHl+nnkUSD8uwKB/vUt9x0+H0a?=
 =?us-ascii?q?h5hfxYCNNS6+pSUggkKZHc0vZ6C9HuWgPBZ9uJTVGmTci7ATE1UN082MEOY0?=
 =?us-ascii?q?ljFNW4lBzD3DSlA6UTl7OVAJw46KXc32L+J8xl0XbJyLEhj0U6QstILWCmnb?=
 =?us-ascii?q?Bw9wzSB47PjkWYmL2ndboT3CHT7meP12mOs19CUA52T6rFWWoTZkzMrdT2/k?=
 =?us-ascii?q?nCVaOhCaw7Mgtdzs6PMqhKZcP3glVdWPjjP9PeY2GqlmisBRaI3LSMbI/re2?=
 =?us-ascii?q?UA2SXREk8Ekxoc/XyeLwgxGj+ho37CDDxpDV/vYUTs8el4qH+hTE80yAGKYF?=
 =?us-ascii?q?dn17qu5BEVg+eRRO8J0bICvychrTR0E0qn0NLSEdaPuw1hfKBEa9Mn/FhHzX?=
 =?us-ascii?q?7ZtxB6PpG4N6BtmFgecwtqv0Pv0RV7E4ZAntYwrHMs0gVyLbmV0FJYezOc2p?=
 =?us-ascii?q?DwJKPYJnPp/B+1aK7Wx0ve38yM9qcJ9vs0sVfjvBmxHEo473pny8VV02eb5p?=
 =?us-ascii?q?jSFAodS4/xUkIs+hhivb7afy0965rR1X1rNqm0qCHN18g1C+sizxbzN+tYZY?=
 =?us-ascii?q?iNDwLjW/YRB8GzJugngRD9ZRsfMfF676U0Nt6oc/acnaWieu1nmWTixW9O+4?=
 =?us-ascii?q?1slFmH9yNhROrFxb4Exe2V2k2MUDK4xFWktdrtmJtsYzgXE2v5zjLrQMZVZ6?=
 =?us-ascii?q?tvbcMQBGyzOcyr15B7gJLwX3Nw6lGuHRUF1dWvdB7UaEbymUVL2EAWp2G3sT?=
 =?us-ascii?q?W3wiYykDwzqKebmivUzLfMbh0Cb1VXSXFigFGkGo29i9QXTQD8dAQyvAe07k?=
 =?us-ascii?q?b9ga5AreJwKHeFEhQARDT/M2w3Cvj4jbGFecMarcpz4Cg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BdAACnaDhe/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BbSASKoQUiQOGXgEBBoE3iW+RSQkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCWDgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYMBAQEBAQMjFUEQCxEDAQIBA?=
 =?us-ascii?q?gImAgJPCAYBDAYCAQGCYz+CVyWrZ3WBMoVKg0aBPoEOKogshA55gQeBOA+CX?=
 =?us-ascii?q?T6HW4JeBJZXYUaXZIJFgk6TbAYbmwiOYZ0rIoFYKwgCGAghD4MnUBgNnQEjA?=
 =?us-ascii?q?zCPCQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 03 Feb 2020 18:53:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013IqeQ6060853;
        Mon, 3 Feb 2020 13:52:40 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 13:54:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/20 5:10 PM, Casey Schaufler wrote:
>  From c4085435215653b7c4d07a35a9df308120441d79 Mon Sep 17 00:00:00 2001
> From: Casey Schaufler <casey@schaufler-ca.com>
> Date: Fri, 31 Jan 2020 13:57:23 -0800
> Subject: [PATCH v14] LSM: Move "context" format enforcement into security
>   modules
> 
> Document in lsm_hooks.h what is expected of a security module that
> supplies the "context" attribute.  Add handling of the "context"
> attribute to SELinux, Smack and AppArmor security modules. The
> AppArmor implementation provides a different string for "context"
> than it does for other attributes to conform with the "context"
> format.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h            |  6 ++++++
>   security/apparmor/include/procattr.h |  2 +-
>   security/apparmor/lsm.c              |  8 ++++++--
>   security/apparmor/procattr.c         | 11 +++++++----
>   security/security.c                  |  2 +-
>   security/selinux/hooks.c             |  2 +-
>   security/smack/smack_lsm.c           |  2 +-
>   7 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2bf82e1cf347..61977a33f2c3 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1321,6 +1321,12 @@
>    *	@pages contains the number of pages.
>    *	Return 0 if permission is granted.
>    *
> + * @getprocattr:
> + *	Provide the named process attribute for display in special files in
> + *	the /proc/.../attr directory.  Attribute naming and the data displayed
> + *	is at the discretion of the security modules.  The exception is the
> + *	"context" attribute, which will contain the security context of the
> + *	task as a nul terminated text string without trailing whitespace.

I'd suggest something like the following instead:
* @getprocattr
*   Get the value of process attribute @name for task @p into a buffer
*   allocated by the security module and returned via @value.  The
*   caller will free the returned buffer via kfree.  The set of
*   attribute names is fixed by proc but the format of @value is up
*   to the security module authors except for the "context" attribute,
*   whose value is required to be a NUL-terminated printable ASCII
*   string without trailing whitespace.
*   @p the task whose attribute is being fetched
*   @name the name of the process attribute being fetched
*   @value set to point to the buffer containing the attribute value
*   Return the length of @value including the NUL on success, or -errno 
on error.

The printable ASCII bit is based on what the dbus maintainer requested 
in previous discussions.  The question of whether the terminating NUL 
should be included in the returned length was otherwise left ambiguous 
and inconsistent in your patch among the different security modules; if 
you prefer not including it in the length returned by the security 
modules, you'll need to adjust SELinux at least to not do so for "context".
