Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB73B27C4
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313835; cv=none; b=o7XQjvrP++4V8EBevlIfVEig6hMThjIG7XL7O7BGXjEsYf/Du91Rp7D+LtwGBAJTINZW+2Pwrc7db+fohqfn/wHRC2ot2MTWBwlRV/54kDgCnsf4U3YwCnYxrg6WgZy/VWkgaoSaPkXXT1204Imli1sgRVv3chksbOr/+IZVJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313835; c=relaxed/simple;
	bh=VEiFmODUdd6yvO46npIpiypfae9WjFkyozXHht+t/Cg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HtjtCSoGlmTmYDjBpiyTn+RCqYVVI8TLTn58I0+YJyEbyrs4Sv+e1U/ctWHV+CgsHvxIn2PWvJnPfsab8laqqwpQ8/8mG5bLs+hocgHLTzHHhcqBTK3xS7vJEyGG35SZPOWis/ofkb02EiZDdj+sTbjxiB2naDm/22q9iQ2hAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaI3QhvP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaI3QhvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777313832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUnffk2U5zLunBxG9nTCf5EmVPyLXlUuZjw1tSm2uKA=;
	b=LaI3QhvPcMP8T7xFybmXucvaBO5bjdPv6FeeJVI/uNkIBJllw1Ys3DbVGWgaUAwFh33YpF
	DdITU+xEJ+S6ql1i4JThg4xda4s4etA2n4cGsmhPELq8xO7+ff17IYKptG0Rz7VOcUKR/R
	MZAdZuwuQxmgyelDcW/2VScHWxbwptE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-dUGKXchoMiyDo65woUuu3A-1; Mon,
 27 Apr 2026 14:17:11 -0400
X-MC-Unique: dUGKXchoMiyDo65woUuu3A-1
X-Mimecast-MFC-AGG-ID: dUGKXchoMiyDo65woUuu3A_1777313830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0AF419560B8;
	Mon, 27 Apr 2026 18:17:09 +0000 (UTC)
Received: from localhost (unknown [10.44.48.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 614401801551;
	Mon, 27 Apr 2026 18:17:09 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 2/3] libsepol: When resolving names check if a block is
 abstract
In-Reply-To: <20260414191120.29067-2-jwcart2@gmail.com>
References: <20260414191120.29067-1-jwcart2@gmail.com>
 <20260414191120.29067-2-jwcart2@gmail.com>
Date: Mon, 27 Apr 2026 20:17:08 +0200
Message-ID: <87340gtgij.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

James Carter <jwcart2@gmail.com> writes:

> Nothing in an abstract block in CIL is instantiated until the block
> is inherited. No declartion, macro, or optional block within an
> abstract block should ever be referred to from outside of the block.
>
> Check for abstract blocks when resolving names and return an error
> if one is found.
>
> This patch is based on a report from the security firm Trail of Bits.


Since this commit, it's not possible to build Fedora selinux-policy:

# semodule -B -n
Failed to resolve pcp_var_lib_t at /var/lib/selinux/targeted/tmp/modules/100/abrt/cil:1241
Failed to resolve pcp_var_lib_t at /var/lib/selinux/targeted/tmp/modules/100/abrt/cil:1244
Failed to resolve pcp_var_lib_t at /var/lib/selinux/targeted/tmp/modules/100/abrt/cil:1245
Failed to resolve dirsrvadmin_config_t at /var/lib/selinux/targeted/tmp/modules/100/apache/cil:2384
Failed to resolve dirsrvadmin_tmp_t at /var/lib/selinux/targeted/tmp/modules/100/apache/cil:2385
Failed to resolve dirsrvadmin_unconfined_script_t at /var/lib/selinux/targeted/tmp/modules/100/apache/cil:2386
...



>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index bcac4026..b0965f1d 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -4355,7 +4355,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
>  		node = ast_node;
>  		if (*name == '.') {
>  			/* Leading '.' */
> -			symtab = &((struct cil_root *)db->ast->root->data)->symtab[CIL_SYM_BLOCKS];
> +			symtab = ((struct cil_root *)db->ast->root->data)->symtab;
>  		} else {
>  			rc = __cil_resolve_name_helper(db, node->parent, current, CIL_SYM_BLOCKS, datum);
>  			if (rc != SEPOL_OK) {
> @@ -4366,14 +4366,20 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
>  		}
>  		/* Keep looking up blocks by name until only last part of name remains */
>  		while (next != NULL) {
> -			rc = cil_symtab_get_datum(symtab, current, datum);
> +			rc = cil_symtab_get_datum(&(symtab[CIL_SYM_BLOCKS]), current, datum);
>  			if (rc != SEPOL_OK) {
>  				free(name_dup);
>  				goto exit;
>  			}
>  			node = NODE(*datum);
>  			if (node->flavor == CIL_BLOCK) {
> -				symtab = &((struct cil_block*)node->data)->symtab[CIL_SYM_BLOCKS];
> +				if (((struct cil_block *)node->data)->is_abstract) {
> +					cil_log(CIL_WARN, "Found %s which is an abstract block and invalid for name resolution\n", current);
> +					free(name_dup);
> +					rc = SEPOL_ERR;
> +					goto exit;
> +				}
> +				symtab = ((struct cil_block*)node->data)->symtab;
>  			} else {
>  				if (ast_node->flavor != CIL_IN) {
>  					cil_log(CIL_WARN, "Can only use %s name for name resolution in \"in\" blocks\n", cil_node_to_string(node));
> @@ -4383,7 +4389,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
>  				}
>  				if (node->flavor == CIL_MACRO) {
>  					struct cil_macro *macro = node->data;
> -					symtab = &macro->symtab[sym_index];
> +					symtab = macro->symtab;
>  				}
>  			}
>  			current = next;
> @@ -4401,6 +4407,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
>  
>  exit:
>  	if (rc != SEPOL_OK) {
> +		cil_tree_log(ast_node, CIL_ERR, "Failed to resolve %s", name);
>  		*datum = NULL;
>  	}
>  
> -- 
> 2.53.0

