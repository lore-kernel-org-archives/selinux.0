Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C62C48BE0
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1AD61040
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 11:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhFILT2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 07:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237111AbhFILT1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 07:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623237452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/EvuWhOmpP5HtgdZKnFM0nVXB2/orSC1ErHoXwsn38=;
        b=Hgj+STDtqRbzme9xn29KA7gdU9hPzY3HX2eWdtVciQbQ51loYShKyVH1ckuvsud739916o
        4+yFFkx5ing5VS+/yxvB8uZkg7ALNFSPjrlq3lGLoJCvLBfRdjq5yjf9LOmKf3Xs+Hp6PI
        Y3Yv0ouAKdOybJIzC7CJ9MvJrvz1UAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-9jIiynNZNO-3r2eyrbK47Q-1; Wed, 09 Jun 2021 07:17:31 -0400
X-MC-Unique: 9jIiynNZNO-3r2eyrbK47Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B35802B78;
        Wed,  9 Jun 2021 11:17:30 +0000 (UTC)
Received: from localhost (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB1681037E81;
        Wed,  9 Jun 2021 11:17:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     liwugang <liwugang@163.com>, selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, liwugang <liwugang@163.com>
Subject: Re: [PATCH v2] checkpolicy: fix the leak memory when uses xperms
In-Reply-To: <20210601151704.2688389-1-liwugang@163.com>
References: <87o8crcljy.fsf@redhat.com>
 <20210601151704.2688389-1-liwugang@163.com>
Date:   Wed, 09 Jun 2021 13:17:28 +0200
Message-ID: <87wnr3nv7b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

liwugang <liwugang@163.com> writes:

> In the define_te_avtab_ioctl function:
> 1. the parameter avrule_template has been copied to
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
> Tested-By: Christian Gttsche <cgzones@googlemail.com>
> Signed-off-by: liwugang <liwugang@163.com>
> ---
>  checkpolicy/policy_define.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 16234f31..52105d3a 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2400,7 +2400,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
>  int define_te_avtab_ioctl(avrule_t *avrule_template)
>  {
>  	avrule_t *avrule;
> -	struct av_ioctl_range_list *rangelist;
> +	struct av_ioctl_range_list *rangelist, *r;
>  	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
>  	unsigned int i;
>  
> @@ -2458,6 +2458,12 @@ done:
>  	if (partial_driver)
>  		free(partial_driver);
>  
> +	while (rangelist != NULL) {
> +		r = rangelist;
> +		rangelist = rangelist->next;
> +		free(r);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2484,6 +2490,8 @@ int define_te_avtab_extended_perms(int which)
>  		free(id);
>  		if (define_te_avtab_ioctl(avrule_template))
>  			return -1;
> +		avrule_destroy(avrule_template);
> +		free(avrule_template);

I still think that avrule_template should be free'd before return -1. If
I'm wrong please explain





>  	} else {
>  		yyerror("only ioctl extended permissions are supported");
>  		free(id);
> -- 
> 2.30.2

