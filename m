Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669AAC7EE23
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 19:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjFATX5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFATX5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 15:23:57 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1210D98
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685647436; x=1717183436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vntPPY4b/rD0pELZr3vAZEI41k3shZCddJYx5jb1gZE=;
  b=Hi7t4Wy9jQDmOyRNtVkx4Ko6yKPgGDDuzweMDFPt31RkYJdGTjmo0ZSf
   0sc3F8czA3LuKfQzHtCsdzSciOhjtnIw5reBUFZFjDYNNLMBqKtojSzry
   GvxdGK6oW5+vH0AXtZAcqLR0LtlIohkmmn4BZz8GqgadgZmBcpvyvOQlL
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="1135110352"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 19:23:50 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 0354BCB3E2;
        Thu,  1 Jun 2023 19:23:49 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 19:22:55 +0000
Received: from [192.168.209.155] (10.106.239.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 19:22:54 +0000
Message-ID: <275be495-96f3-8ad6-33ca-815068f3a4f2@amazon.com>
Date:   Thu, 1 Jun 2023 15:22:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selinux: don't use make's grouped targets feature yet
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, <selinux@vger.kernel.org>
CC:     Erwan Velu <e.velu@criteo.com>
References: <20230601180643.211112-1-paul@paul-moore.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <20230601180643.211112-1-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.239.22]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2023-06-01 14:06, Paul Moore wrote:

> 
> 
> 
> The Linux Kernel currently only requires make v3.82 while the grouped
> target functionality requires make v4.3.  Removed the grouped target
> introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
> built when needed") as well as the multiple header file targets in
> the make rule.  This effectively reverts the problem commit.
> 
> We will revisit this change when make >= 4.3 is required by the rest
> of the kernel.

Tested-by: Luiz Capitulino <luizcap@amazon.com>

Note for -stable: this is needed in all kernels that backported
commit 4ce1f694eb5d

Thanks, Paul!

> 
> Cc: stable@vger.kernel.org
> Fixes: 4ce1f694eb5d ("selinux: ensure av_permissions.h is built when needed")
> Reported-by: Erwan Velu <e.velu@criteo.com>
> Reported-by: Luiz Capitulino <luizcap@amazon.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   security/selinux/Makefile | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 0aecf9334ec3..8b21520bd4b9 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -26,5 +26,9 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
>         cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
> 
>   targets += flask.h av_permissions.h
> -$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
> +# once make >= 4.3 is required, we can use grouped targets in the rule below,
> +# which basically involves adding both headers and a '&' before the colon, see
> +# the example below:
> +#   $(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/...
> +$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
>          $(call if_changed,flask)
> --
> 2.40.1
> 
