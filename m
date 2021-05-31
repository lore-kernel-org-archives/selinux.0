Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD80C47082
	for <selinux@archiver.kernel.org>; Mon, 31 May 2021 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B173661287
	for <selinux@archiver.kernel.org>; Mon, 31 May 2021 12:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEaMHZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 May 2021 08:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231560AbhEaMHA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 May 2021 08:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622462712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DkvnXGJlpJB6IsSemBsxlWxTiZ783GbvAZVdrpyZrhs=;
        b=amLpjGi5LH4ESUpJ81cQafRFTlb4QqG0rUeo0VWNfl86q/dHQZZWrRgV6ND3acIDjFfafw
        ZqNCODUMeD9f9iBFA9+sloF+Uzwk+J1nKEYLW3CrRLL/DzyY8YJ8UiY/u7ObQ8x1069fSn
        3v7Oj4/NebmIvfyg+NoenPpwfVUfOoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-8SuIaevVNte_qsnceUB6pQ-1; Mon, 31 May 2021 08:05:10 -0400
X-MC-Unique: 8SuIaevVNte_qsnceUB6pQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A3D5801107;
        Mon, 31 May 2021 12:05:09 +0000 (UTC)
Received: from localhost (unknown [10.40.192.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36805C1B4;
        Mon, 31 May 2021 12:05:08 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 2/2] secilc/docs: Document the order that inherited
 rules are resolved in
In-Reply-To: <20210506170537.146337-2-jwcart2@gmail.com>
References: <20210506170537.146337-1-jwcart2@gmail.com>
 <20210506170537.146337-2-jwcart2@gmail.com>
Date:   Mon, 31 May 2021 14:05:07 +0200
Message-ID: <87k0nfcdn0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> In the blockinherit section of the CIL documentation clearly state
> the order in which inherited rules are resolved.
>
> That order is:
>
> 1) The parent namespaces (if any) where the blockinherit rule is
>    located with the exception of the global namespace.
>
> 2) The parent namespaces of the block being inherited (but not that
>    block's namespace) with the exception of the global namespace.
>
> 3) The global namespace.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Both
Acked-by: Petr Lautrbach <plautrba@redhat.com>

and merged.

Thanks!


> ---
>  secilc/docs/cil_container_statements.md | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
> index 7a7f67cc..41a4612c 100644
> --- a/secilc/docs/cil_container_statements.md
> +++ b/secilc/docs/cil_container_statements.md
> @@ -103,6 +103,14 @@ blockinherit
>  
>  Used to add common policy rules to the current namespace via a template that has been defined with the [`blockabstract`](cil_container_statements.md#blockabstract) statement. All [`blockinherit`](cil_container_statements.md#blockinherit) statements are resolved first and then the contents of the block are copied. This is so that inherited blocks will not be inherited. For a concrete example, please see the examples section.
>  
> +Inherited rules are resolved by searching namespaces in the following order:
> +
> +-  The parent namespaces (if any) where the [`blockinherit`](cil_container_statements.md#blockinherit) rule is located with the exception of the global namespace.
> +
> +-  The parent namespaces of the block being inherited (but not that block's namespace) with the exception of the global namespace.
> +
> +-  The global namespace.
> +
>  Not allowed in [`macro`](cil_call_macro_statements.md#macro) blocks.
>  
>  **Statement definition:**
> -- 
> 2.26.3

