Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9FC4708F
	for <selinux@archiver.kernel.org>; Mon, 31 May 2021 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1421160FDA
	for <selinux@archiver.kernel.org>; Mon, 31 May 2021 09:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhEaJPy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 May 2021 05:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhEaJPy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 May 2021 05:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622452454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQNjY1fRgruQ4QcWkYBY69oNI4eBGaAgZQKTZYUGaDg=;
        b=AEHoFQbLCUJwKBo/4FfUep/DIsEDKmhY5phio1M8BioDbgMtTOMlQEjXpqFGBrPBg7xuKF
        L+4IFrknqPy14IUmOlX1ok3MeSkM/U9ayGnFp/F2QIg1ZOyxOfTZ/mlFnPoNrSaX4yyz63
        5EnSppJ4AWAQ2GBm5L8NNqOjOWRKoy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-jn3_GTrYMTOf8GCe57v7MA-1; Mon, 31 May 2021 05:14:12 -0400
X-MC-Unique: jn3_GTrYMTOf8GCe57v7MA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46CEC802B78;
        Mon, 31 May 2021 09:14:11 +0000 (UTC)
Received: from localhost (unknown [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA43178620;
        Mon, 31 May 2021 09:14:10 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     liwugang <liwugang@163.com>, selinux@vger.kernel.org
Cc:     liwugang <liwugang@163.com>
Subject: Re: [PATCH] checkpolicy: fix the leak memory when uses xperms
In-Reply-To: <20210510110354.3585-1-liwugang@163.com>
References: <20210510110354.3585-1-liwugang@163.com>
Date:   Mon, 31 May 2021 11:14:09 +0200
Message-ID: <87o8crcljy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

liwugang <liwugang@163.com> writes:

> In the define_te_avtab_ioctl function:
> 1. the parameter avrule_template has been copies to

typo? "copied" instead of "copies" ?

> new elements which added to avrule list through
> the function avrule_cpy, so it should free avrule_template.
> 2. And for rangelist, it does not free the allocated memory.
>
> The memory leak can by found by using memory sanitizer:
> =================================================================
> ==20021==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 10336 byte(s) in 76 object(s) allocated from:
>     #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
>     #1 0x55c2e9447fb3 in define_te_avtab_xperms_helper /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2046
>     #2 0x55c2e944a6ca in define_te_avtab_extended_perms /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2479
>     #3 0x55c2e943126b in yyparse /mnt/sources/tools/selinux/checkpolicy/policy_parse.y:494
>     #4 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/checkpolicy/parse_util.c:64
>     #5 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/checkpolicy.c:619
>     #6 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
> Direct leak of 240 byte(s) in 15 object(s) allocated from:
>     #0 0x7f8f96d9cb50 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb50)
>     #1 0x55c2e9446cd9 in avrule_sort_ioctls /mnt/sources/tools/selinux/checkpolicy/policy_define.c:1846
>     #2 0x55c2e9447d8f in avrule_ioctl_ranges /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2020
>     #3 0x55c2e944a0de in define_te_avtab_ioctl /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2409
>     #4 0x55c2e944a744 in define_te_avtab_extended_perms /mnt/sources/tools/selinux/checkpolicy/policy_define.c:2485
>     #5 0x55c2e94312bf in yyparse /mnt/sources/tools/selinux/checkpolicy/policy_parse.y:503
>     #6 0x55c2e9440221 in read_source_policy /mnt/sources/tools/selinux/checkpolicy/parse_util.c:64
>     #7 0x55c2e945a3df in main /mnt/sources/tools/selinux/checkpolicy/checkpolicy.c:619
>     #8 0x7f8f968eeb96 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21b96)
>
> Signed-off-by: liwugang <liwugang@163.com>
> ---
>  checkpolicy/policy_define.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 16234f31..04064af2 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2400,7 +2400,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
>  int define_te_avtab_ioctl(avrule_t *avrule_template)
>  {
>  	avrule_t *avrule;
> -	struct av_ioctl_range_list *rangelist;
> +	struct av_ioctl_range_list *rangelist, *r, *r2;
>  	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
>  	unsigned int i;
>  
> @@ -2458,6 +2458,13 @@ done:
>  	if (partial_driver)
>  		free(partial_driver);
>  
> +	r = rangelist;
> +	while (r != NULL) {


Seems like you could loop using `rangelist` directly only with `r`
instead of `r2`


> +		r2 = r;
> +		r = r->next;
> +		free(r2);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2484,6 +2491,8 @@ int define_te_avtab_extended_perms(int which)
>  		free(id);
>  		if (define_te_avtab_ioctl(avrule_template))
>  			return -1;
> +		avrule_destroy(avrule_template);
> +		free(avrule_template);

avrule_template should be probably free()'d before `return -1`

>  	} else {
>  		yyerror("only ioctl extended permissions are supported");
>  		free(id);
> -- 
> 2.17.1

