Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0495C433B4
	for <selinux@archiver.kernel.org>; Mon, 26 Apr 2021 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C09661027
	for <selinux@archiver.kernel.org>; Mon, 26 Apr 2021 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhDZL5c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhDZL5b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Apr 2021 07:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619438209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eqBdIn8k2Fk8huXuWbDqLkP5OxXVK2UAuqAKFBE3naQ=;
        b=ZbsO9/3MN/DdJ1xW9/4+7anhA9SDywHp6sojZXV52rxVqqYfXxu1SYOaiT2RvnMrWj240N
        LZ4UZeo+ZxduwgDznU4+Fzpg2zPUCiyYKTe0IylnkwRepEWGoYqRQZgd2aX6Uf+4nMShvl
        T2mBqmxE9xSsDDY7gSGxVrpbZBxCl6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-vIOlrtrgP6y7Q5_YurOl7A-1; Mon, 26 Apr 2021 07:56:46 -0400
X-MC-Unique: vIOlrtrgP6y7Q5_YurOl7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6530C8030D5;
        Mon, 26 Apr 2021 11:56:45 +0000 (UTC)
Received: from localhost (unknown [10.40.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3D4E61F38;
        Mon, 26 Apr 2021 11:56:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: do not duplicate make target when going
 into subdirectory
In-Reply-To: <20210422064356.249361-1-nicolas.iooss@m4x.org>
References: <20210422064356.249361-1-nicolas.iooss@m4x.org>
Date:   Mon, 26 Apr 2021 13:56:43 +0200
Message-ID: <87bla1w96s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> When running "make install-pywrap", make displays:
>
>     make[1]: Entering directory '/root/selinux/libselinux'
>     make -C src install-pywrap install-pywrap
>     make[2]: Entering directory '/root/selinux/libselinux/src'
>
> The duplicated "install-pywrap" is not expected. Remove it from the
> Makefile.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
>  libselinux/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index ac16c15e8d0a..439bc6a9b7fd 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -50,24 +50,24 @@ all install relabel clean distclean indent:
>  	done
>  
>  swigify: all
> -	$(MAKE) -C src swigify $@
> +	$(MAKE) -C src $@
>  
>  pywrap: 
> -	$(MAKE) -C src pywrap $@
> +	$(MAKE) -C src $@
>  
>  rubywrap: 
> -	$(MAKE) -C src rubywrap $@
> +	$(MAKE) -C src $@
>  
>  install-pywrap: 
> -	$(MAKE) -C src install-pywrap $@
> +	$(MAKE) -C src $@
>  
>  install-rubywrap: 
> -	$(MAKE) -C src install-rubywrap $@
> +	$(MAKE) -C src $@
>  
>  clean-pywrap:
> -	$(MAKE) -C src clean-pywrap $@
> +	$(MAKE) -C src $@
>  
>  clean-rubywrap:
> -	$(MAKE) -C src clean-rubywrap $@
> +	$(MAKE) -C src $@
>  
>  test:
> -- 
> 2.31.0

