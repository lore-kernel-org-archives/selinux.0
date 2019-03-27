Return-Path: <SRS0=p2GP=R6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DCDC4360F
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255F221738
	for <selinux@archiver.kernel.org>; Wed, 27 Mar 2019 15:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YhX0YU+x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O3Wob0MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfC0PTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:19:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfC0PTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Mar 2019 11:19:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4646F60A44; Wed, 27 Mar 2019 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553699955;
        bh=51JRxIV5V99TBmU+8ktK+YaBInWdIjpfPvN6rtmpuZs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YhX0YU+x1SA/NVCBBzl02/Hd7Ia1OF8EXtDOZjq81oa1wD2JQfcXfd6fWe68Itoad
         Kj9C4XCCOyar7UanLkrDjlPM4jqiffdcr6rUVV2zxWORpmA+w0ID/L1mbXyjzu3syl
         i3KAkTAQCgvIgCrLZexLggVc8adtNYZxSIEISloI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CF14609EF;
        Wed, 27 Mar 2019 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553699953;
        bh=51JRxIV5V99TBmU+8ktK+YaBInWdIjpfPvN6rtmpuZs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O3Wob0MKpJPqJXa78K44JN/rZUi+IATolzQGGgCCOuf7UMU2yJo+3hTtx2fTAOZ/K
         w6koamr8Gu55pEl0sVdpA1dK6Hjevg3Dnxx4qtpGo5SkUDFSun0ZOtvPWeYNGW101j
         tSjwzbMTcc2O2mQ6ZCxhWZR7b/BLWfDpaAyRWenw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CF14609EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] selinux: Make selinux_kernfs_init_security static
To:     Yue Haibing <yuehaibing@huawei.com>, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20190322140400.18892-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <26670bec-f2cb-30b4-d275-83828a009a45@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:49:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322140400.18892-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 3/22/2019 7:34 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> security/selinux/hooks.c:3389:5: warning:
>   symbol 'selinux_kernfs_init_security' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   security/selinux/hooks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ab4b049..b6e6152 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3386,8 +3386,8 @@ static int selinux_inode_copy_up_xattr(const char *name)
>   
>   /* kernfs node operations */
>   
> -int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
> -				 struct kernfs_node *kn)
> +static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
> +					struct kernfs_node *kn)
>   {
>   	const struct task_security_struct *tsec = current_security();
>   	u32 parent_sid, newsid, clen;
