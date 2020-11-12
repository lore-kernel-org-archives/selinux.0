Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E8DC56201
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 13:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D69207BB
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 13:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgKLNXz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:23:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7888 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgKLNXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 08:23:54 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CX2Nv0LsNz75wx;
        Thu, 12 Nov 2020 21:23:43 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 21:23:44 +0800
Subject: Re: [PATCH] selinux: Fix error return code in sel_ib_pkey_sid_slow()
To:     <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
        <eparis@parisplace.org>, <danielj@mellanox.com>,
        <dledford@redhat.com>
References: <20201112085542.182692-1-chenzhou10@huawei.com>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <263b9cb9-7d16-91d7-a8ed-02b199f8b105@huawei.com>
Date:   Thu, 12 Nov 2020 21:23:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201112085542.182692-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2020/11/12 16:55, Chen Zhou wrote:
> Fix to return a negative error code from the error handling case
> instead of 0 in function sel_ib_pkey_sid_slow(), as done elsewhere
> in this function.
>
> Fixes: 409dcf31538a ("selinux: Add a cache for quicker retreival of PKey SIDs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  security/selinux/ibpkey.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
> index f68a7617cfb9..680b2dd1520f 100644
> --- a/security/selinux/ibpkey.c
> +++ b/security/selinux/ibpkey.c
> @@ -151,8 +151,10 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
>  	 * is valid, it just won't be added to the cache.
>  	 */
>  	new = kzalloc(sizeof(*new), GFP_ATOMIC);
> -	if (!new)
> +	if (IS_ERR(new)) {
> +		ret = PTR_ERR(new);
>  		goto out;
> +	}
>  
>  	new->psec.subnet_prefix = subnet_prefix;
>  	new->psec.pkey = pkey_num;
Ignore this, will send v2.
