Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2F4C433F5
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 07:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E5A61215
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 07:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhIVHyc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 03:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233283AbhIVHyc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 03:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632297182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d27ue2RC2k5D3v9Lr/0rKFI4o+5xp95rtQImu/BTZSk=;
        b=W6kRLJu3nkVN8Sr1RSj8pT81K/EJOyFUneN9avIGHM+HpLlRo55xQ7OJDXQLCZuJMP8yQT
        ZcSSyGM7SJy3lVHRpra5Z+z1siTzt9yvRAAnR+BUjkeY9dOdAvoIZZMlexdsYQqUq8Z61Y
        Z6k+TlAqOHTgkMIni4z/nspspsNEx1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-jSxdF1oiNoibRTowtp1SHw-1; Wed, 22 Sep 2021 03:53:00 -0400
X-MC-Unique: jSxdF1oiNoibRTowtp1SHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DE684A5E3;
        Wed, 22 Sep 2021 07:52:59 +0000 (UTC)
Received: from localhost (unknown [10.40.194.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002E45C261;
        Wed, 22 Sep 2021 07:52:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol/cil: Do not use original type and
 typeattribute datums
In-Reply-To: <20210913182600.1016101-1-jwcart2@gmail.com>
References: <20210913182600.1016101-1-jwcart2@gmail.com>
Date:   Wed, 22 Sep 2021 09:52:57 +0200
Message-ID: <87lf3pujvq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> When compiling CIL policy using secilc's "-m" option (which allows
> duplicate declarations for types and type attributes), a segfault
> will occur if the type or type attribute being copied has already
> been declared. This is because a search of the symbol table is made
> during the copy and the original datum will be used if one is found.
> The original datum will be considered a duplicate when an attempt is
> made to add it to the symbol table. The original datum, which is still
> in use, will then be destroyed and a segfault will follow soon after
> that.
>
> Instead, always create a new datum. When it is added the new datum
> will be destroyed if it is a duplicate and duplicate declarations
> are allowed.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libsepol/cil/src/cil_copy_ast.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index 7c5ae9e1..2fad972c 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -590,20 +590,12 @@ int cil_copy_roleallow(__attribute__((unused)) struct cil_db *db, void *data, vo
>  	return SEPOL_OK;
>  }
>  
> -int cil_copy_type(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
> +int cil_copy_type(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
> -	struct cil_type *orig = data;
> -	char *key = orig->datum.name;
> -	struct cil_symtab_datum *datum = NULL;
> +	struct cil_type *new;
>  
> -	cil_symtab_get_datum(symtab, key, &datum);
> -	if (datum == NULL) {
> -		struct cil_type *new;
> -		cil_type_init(&new);
> -		*copy = new;
> -	} else {
> -		*copy = datum;
> -	}
> +	cil_type_init(&new);
> +	*copy = new;
>  
>  	return SEPOL_OK;
>  }
> @@ -622,20 +614,12 @@ int cil_copy_typepermissive(__attribute__((unused)) struct cil_db *db, void *dat
>  	return SEPOL_OK;
>  }
>  
> -int cil_copy_typeattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
> +int cil_copy_typeattribute(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
> -	struct cil_typeattribute *orig = data;
> -	char *key = orig->datum.name;
> -	struct cil_symtab_datum *datum = NULL;
> +	struct cil_typeattribute *new;
>  
> -	cil_symtab_get_datum(symtab, key, &datum);
> -	if (datum == NULL) {
> -		struct cil_typeattribute *new;
> -		cil_typeattribute_init(&new);
> -		*copy = new;
> -	} else {
> -		*copy = datum;
> -	}
> +	cil_typeattribute_init(&new);
> +	*copy = new;
>  
>  	return SEPOL_OK;
>  }
> -- 
> 2.31.1

