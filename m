Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EECC19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 13:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbiHIN5F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244685AbiHIN4u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 09:56:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530ED18368
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 06:56:49 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id CA8A4210C88A;
        Tue,  9 Aug 2022 06:56:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA8A4210C88A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660053409;
        bh=vxrdjb9ZkD8absxneMVLNxcZFmLmzFEzNL284Ix8cSY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=mC2BpAwQikL2chkHmX8gX3eJ9xhdP3veJu7IPu3E8tbVfkWuehFpj/cfAWGOt28US
         1jJM1pWpd0Nh9+Ov1KE1Sbh0rONrf/0ARITZBtmnqCSMr3VYgQ6nBI4FpNkfLFYPLB
         9yfYnEPjen+ZLST/gF8HkwfukNbRo27x+V0xUYzo=
Message-ID: <d395fef5-379b-faa1-d974-2e58ee8381cd@linux.microsoft.com>
Date:   Tue, 9 Aug 2022 09:56:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] checkpolicy: use strict function prototype for
 definitions
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20220808173620.16760-1-cgzones@googlemail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220808173620.16760-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/8/2022 1:36 PM, Christian Göttsche wrote:
> Clang 15 starts to complain about non strict function definitions:
> 
>      policy_define.c:4907:30: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>      int define_devicetree_context()
>                                   ^
>                                    void
>      policy_define.c:5298:29: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
>      int define_ipv4_node_context()
>                                  ^
>                                   void
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>   checkpolicy/policy_define.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 8bf36859..f3b48870 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4904,7 +4904,7 @@ bad:
>   	return -1;
>   }
>   
> -int define_devicetree_context()
> +int define_devicetree_context(void)
>   {
>   	ocontext_t *newc, *c, *l, *head;
>   
> @@ -5295,7 +5295,7 @@ int define_netif_context(void)
>   	return 0;
>   }
>   
> -int define_ipv4_node_context()
> +int define_ipv4_node_context(void)
>   {	
>   	char *id;
>   	int rc = 0;

Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
