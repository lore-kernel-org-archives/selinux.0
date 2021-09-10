Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F76BC433EF
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 08:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E10610C7
	for <selinux@archiver.kernel.org>; Fri, 10 Sep 2021 08:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhIJIbi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhIJIbh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Sep 2021 04:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631262626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fCR1mBVegqCwSw7ZzcWonDH5tjefCKFvwRMVnC3J5ak=;
        b=flj0ctiuoJhbw2TfEYP/ImrOSUMg0GZERTUXf5M1NgJEeWNLz8BVbt4A+CrYdflyPUtpAq
        iX6XD7M+qmtfF/JWawCqBDHS0m8ugg+BvvT9Bxza4XwDL72ZuQ28TVVQf8UoIUXp/ueZuB
        pFbvmhqo3ThU5k++wTAMIdypZ9moXLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-ATheJQH4PVGQQlU8zJDLOQ-1; Fri, 10 Sep 2021 04:30:23 -0400
X-MC-Unique: ATheJQH4PVGQQlU8zJDLOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E89835DE2;
        Fri, 10 Sep 2021 08:30:22 +0000 (UTC)
Received: from localhost (unknown [10.40.192.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 898D477F29;
        Fri, 10 Sep 2021 08:30:22 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libsepol/cil: Free duplicate datums in original calling
 function
In-Reply-To: <20210909212759.894402-1-jwcart2@gmail.com>
References: <20210909212759.894402-1-jwcart2@gmail.com>
Date:   Fri, 10 Sep 2021 10:30:21 +0200
Message-ID: <87zgsk96jm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Duplicate declarations are allowed for type, typeattribute, and
> optional statements. When an allowed duplicate declaration is found,
> the duplicate datum is free'd in cil_add_decl_to_symtab() and SEPOL_OK
> is returned. This works for all the rules where a duplicate declaration
> is allowed, but it confuses scanning tools.
>
> When cil_add_decl_to_symtab() finds an allowed duplicate declaration,
> return SEPOL_EEXIST and free the duplicate datum in the original
> calling function.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
>

I've tested the patch and the scanner doesn't report defects from
https://lore.kernel.org/selinux/874kat9dch.fsf@redhat.com/T/#t anymore.

Thanks!

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  libsepol/cil/src/cil_build_ast.c | 27 +++++++++++++++++++++------
>  libsepol/cil/src/cil_copy_ast.c  |  9 ++++++++-
>  2 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index f1f09f11..9c34be23 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -134,8 +134,7 @@ int cil_add_decl_to_symtab(struct cil_db *db, symtab_t *symtab, hashtab_key_t ke
>  		/* multiple_decls is enabled and works for this datum type, add node */
>  		cil_list_append(prev->nodes, CIL_NODE, node);
>  		node->data = prev;
> -		cil_symtab_datum_destroy(datum);
> -		free(datum);
> +		return SEPOL_EEXIST;
>  	}
>  
>  	return SEPOL_OK;
> @@ -2367,7 +2366,12 @@ int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct
>  	key = parse_current->next->data;
>  	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)type, (hashtab_key_t)key, CIL_SYM_TYPES, CIL_TYPE);
>  	if (rc != SEPOL_OK) {
> -		goto exit;
> +		if (rc == SEPOL_EEXIST) {
> +			cil_destroy_type(type);
> +			type = NULL;
> +		} else {
> +			goto exit;
> +		}
>  	}
>  
>  	return SEPOL_OK;
> @@ -2415,7 +2419,12 @@ int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current
>  	key = parse_current->next->data;
>  	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)attr, (hashtab_key_t)key, CIL_SYM_TYPES, CIL_TYPEATTRIBUTE);
>  	if (rc != SEPOL_OK) {
> -		goto exit;
> +		if (rc == SEPOL_EEXIST) {
> +			cil_destroy_typeattribute(attr);
> +			attr = NULL;
> +		} else {
> +			goto exit;
> +		}
>  	}
>  
>  	return SEPOL_OK;
> @@ -5480,8 +5489,14 @@ int cil_gen_optional(struct cil_db *db, struct cil_tree_node *parse_current, str
>  	key = parse_current->next->data;
>  
>  	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)optional, (hashtab_key_t)key, CIL_SYM_BLOCKS, CIL_OPTIONAL);
> -	if (rc != SEPOL_OK)
> -		goto exit;
> +	if (rc != SEPOL_OK) {
> +		if (rc == SEPOL_EEXIST) {
> +			cil_destroy_optional(optional);
> +			optional = NULL;
> +		} else {
> +			goto exit;
> +		}
> +	}
>  
>  	return SEPOL_OK;
>  
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index cdbc84e7..7c5ae9e1 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -2056,7 +2056,14 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void
>  
>  			rc = cil_add_decl_to_symtab(db, symtab, DATUM(orig->data)->name, DATUM(data), new);
>  			if (rc != SEPOL_OK) {
> -				goto exit;
> +				if (rc == SEPOL_EEXIST) {
> +					cil_symtab_datum_destroy(data);
> +					free(data);
> +					data = NULL;
> +					rc = SEPOL_OK;
> +				} else {
> +					goto exit;
> +				}
>  			}
>  
>  			namespace = new;
> -- 
> 2.31.1

