Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186AEB64D9
	for <selinux@archiver.kernel.org>; Tue, 27 Jun 2023 14:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjF0O6c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjF0O61 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Jun 2023 10:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8FD2D5B
        for <selinux@vger.kernel.org>; Tue, 27 Jun 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687877857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHktP/NX0uniTDW6GRXp2dXaTTfDzocoQ7gia+inYrw=;
        b=MuvMZsgReQAPlIPiwf92hwIBdQsqjjJiqFoaf+mNBRWFdqvBD7PmO8EBl9r1XxWDNGju0Q
        L1wWR62Ww4MkYQjO8rwKHfOOu4gl4kLikvbIwufP27XRVRAKEM1ORRZ8o1+qwZ4gJyddNi
        +m10CrC6CExk7FIizlZKiURyYBDDPVM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357--xW3ZtEDNFmHOHZWFtiqyg-1; Tue, 27 Jun 2023 10:57:34 -0400
X-MC-Unique: -xW3ZtEDNFmHOHZWFtiqyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC9293C24445;
        Tue, 27 Jun 2023 14:57:32 +0000 (UTC)
Received: from localhost (unknown [10.45.225.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6D214682FB;
        Tue, 27 Jun 2023 14:57:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Huaxin Lu <luhuaxin1@huawei.com>, selinux@vger.kernel.org
Cc:     shenyining@huawei.com, fangxiuning@huawei.com,
        zhujianwei7@huawei.com
Subject: Re: [PATCH] libselinux: add check for calloc in check_booleans
In-Reply-To: <20230618231702.118125-1-luhuaxin1@huawei.com>
References: <20230618231702.118125-1-luhuaxin1@huawei.com>
Date:   Tue, 27 Jun 2023 16:57:31 +0200
Message-ID: <87sfad0x7o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Huaxin Lu <luhuaxin1@huawei.com> writes:

> Check the return value of calloc() to avoid null pointer reference.
>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
> ---
>  libselinux/src/audit2why.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index ba1a66e..2def89f 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -149,6 +149,12 @@ static int check_booleans(struct boolean_t **bools)
>  
>  	if (fcnt > 0) {
>  		*bools = calloc(sizeof(struct boolean_t), fcnt + 1);
> +		if (!*bools) {
> +			PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
> +			free(foundlist);
> +			return 0;
> +		}
> +	

There's a trailing whitespace, but it's not necessary to resend the patch.

Acked-by: Petr Lautrbach <lautrbach@redhat.com>


>  		struct boolean_t *b = *bools;
>  		for (i = 0; i < fcnt; i++) {
>  			int ctr = foundlist[i];
> -- 
> 2.33.0

