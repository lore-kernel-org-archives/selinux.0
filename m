Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A2C433ED
	for <selinux@archiver.kernel.org>; Sat, 24 Apr 2021 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A071B61059
	for <selinux@archiver.kernel.org>; Sat, 24 Apr 2021 15:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhDXPrJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 24 Apr 2021 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhDXPrJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 24 Apr 2021 11:47:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF54C061574;
        Sat, 24 Apr 2021 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xFgFa9UNKtHxWiZ1gGG+Qr1k1cFtE/Qa3neuOLZqyek=; b=R0Ik9e+y8ZIbGEE8kwmSD0kgVg
        cWDkqc34o/J4CiPUBeLdOEApjGuHkaFleHrIMyTe8tc1HsIHsRCl1oe3j8GIrZSTv35EfMuTHdL0l
        XcD5EnWDEwg7hXAqjJi9uqbiPeW2tgfgYGHPMQaCER8rW5360mIpilSIjFgwZSES0tTdnYMsCq02T
        QyvKunE6z8FTxsVJXT5ixnlDTPezMh3rK3VGApd019TNdhmpaef5Y35F2wkgBnd+zbaKsOisbeOPP
        w1Y54tuPJXJNsPIB8DYlYIjHait+YK+Jq6PZ696Pg2PP4IVNUhGRcwaDFjBAiEBGmt9OKLAfmnUUb
        UBXMo9UQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laKUG-0043o1-9s; Sat, 24 Apr 2021 15:46:28 +0000
Subject: Re: [PATCH] selinux: Corrected comment to match kernel-doc comment
To:     Souptick Joarder <jrdr.linux@gmail.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619263085-5047-1-git-send-email-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9428b8d9-976a-cfcb-0a97-01a18b92140a@infradead.org>
Date:   Sat, 24 Apr 2021 08:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1619263085-5047-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/24/21 4:18 AM, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> 
> security/selinux/avc.c:822: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Updated the comment to align with kernel-doc comment.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index ad451cf..04a886b 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -818,7 +818,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
>  	return rc;
>  }
>  
> -/**
> +/*
>   * avc_update_node Update an AVC entry

or

    * avc_update_node - Update an AVC entry

would work also. :)
And leave the /**.

Mostly we want to have kernel-doc for exported (non-static) functions,
but this file doesn't exactly conform to that, so the latter fix
is more preferable IMO.

>   * @event : Updating event
>   * @perms : Permission mask bits
> 


-- 
~Randy

