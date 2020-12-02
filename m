Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA65C64E7B
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAD9221FB
	for <selinux@archiver.kernel.org>; Wed,  2 Dec 2020 17:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgLBRwq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbgLBRwq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Dec 2020 12:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606931479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ6CWE9g7bfrd2mPuZQNbhlbOZd/R9sovxA8+ZQFWik=;
        b=iHyD8QBnpo+pPukBf2BE+c7t6zq6ICezd/6lZ0E3p253fr/UgOpCxDUsRSYhcGXpMarVDX
        FvZmuh52Vow+KxhFYNeFwAN9tV5yf/vvdDzXX/H0f5CCm6N7yXf2A1g2EzYS9cTTK5wGwr
        IazC9ql9Lhi+OpoJVXWZygkDqqFQ2M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-pT-U_mbPPNat1xcKtZBuDg-1; Wed, 02 Dec 2020 12:51:16 -0500
X-MC-Unique: pT-U_mbPPNat1xcKtZBuDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BD219CC16;
        Wed,  2 Dec 2020 17:51:15 +0000 (UTC)
Received: from localhost (unknown [10.40.193.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D094219C48;
        Wed,  2 Dec 2020 17:51:14 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Matthew Ife <matthew@ife.onl>, selinux@vger.kernel.org
Subject: Re: Fix Checkmodule when Writing down to older Module Versions
In-Reply-To: <30bf5dca94595b9807b2c79be3f2ea9db4feb0cd.camel@ife.onl>
References: <30bf5dca94595b9807b2c79be3f2ea9db4feb0cd.camel@ife.onl>
Date:   Wed, 02 Dec 2020 18:51:13 +0100
Message-ID: <87blfcp04u.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Matthew Ife <matthew@ife.onl> writes:

> Stumbled over this one when writing a module from F33 to EL6.
>
> Steps to reproduce:
>
> Try to build the following module then make a module from an older
> release:
>
> module test 1.0.0;
>
> require {
>   type default_t;
> }
> attribute_role new_atrole;
>
> Build
>
> $ checkmodule -M -m -c 12 -o test.mod test.te
> $ semodule_package -o test.pp -m test.mod
> $ semodule_package:  Error while reading policy module from test.mod
>
> With fix:
>
> $ checkmodule -o test.mod -M -m -c12 test.te 
> libsepol.policydb_write: Discarding role attribute rules
> $ semodule_package -o test.pp -m test.mod
>
> Failure occurs when the current module gets written out as the scope
> declaration remains intact.
> semodule_package files correctly at policydb.c:3913 doing a hash table
> search on a scope key that is not
> in the symbol table.
>
> This patch fixes the problem by removing the hashtable entries and
> scope declarations properly prior to module write and emits a warning
> to the user of the unsupported statements.
>
> Also altered hashtab_map slightly to allow it to be used for
> hashtab_remove calls in order to support the patch.
>
> I submitted a pull request for this (there is some spacing/tabbing
> issues actually so I can resent a new pull request if necessary).
>
> https://github.com/SELinuxProject/selinux/pull/273


Hello,

This particular patch can't be currently applied to master's HEAD and
it's also missing Signed-of-by: line

It looks like you've rebased it in
https://github.com/SELinuxProject/selinux/pull/273 , added Signed-of-by
and also added more commits. When you think it's a final version, please
merge/squash related commits - e.g. "Retab me" looks like fix up of the first
commit - and resend the patches or patches again to this list for
review.

Thanks!




> diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> index 76b977a9..ff7ef63f 100644
> --- a/libsepol/src/hashtab.c
> +++ b/libsepol/src/hashtab.c
> @@ -230,7 +230,7 @@ int hashtab_map(hashtab_t h,
>  
>  	for (i = 0; i < h->size; i++) {
>  		cur = h->htable[i];
> -		while (curi != NULL) {
> +		while (cur != NULL) {
>  			next = cur->next;
>  			ret = apply(cur->key, cur->datum, args);
>  			if (ret)
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index dd418317..6a59a0c3 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -2170,7 +2170,7 @@ static void scope_write_destroy(hashtab_key_t key __attribute__ ((unused)),
>      free(cur);
>  }
>  
> -static void type_attr_filter(hashtab_key_t key,
> +static int type_attr_filter(hashtab_key_t key,
>                   hashtab_datum_t datum, void *args)
>  {
>      type_datum_t *typdatum = datum;
> @@ -2186,9 +2186,11 @@ static void type_attr_filter(hashtab_key_t key,
>          if (scope) 
>              hashtab_remove(scopetbl, key, scope_write_destroy, scope);
>      }
> +
> +	return 0;
>  }
>  
> -static void role_attr_filter(hashtab_key_t key,
> +static int role_attr_filter(hashtab_key_t key,
>                   hashtab_datum_t datum, void *args)
>  {
>      role_datum_t *role = datum;
> @@ -2204,6 +2206,8 @@ static void role_attr_filter(hashtab_key_t key,
>          if (scope) 
>              hashtab_remove(scopetbl, key, scope_write_destroy, scope);
>      }
> +
> +	return 0;
>  }
>  
>  /*
> @@ -2337,36 +2341,36 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
>  		buf[0] = cpu_to_le32(p->symtab[i].nprim);
>  		buf[1] = p->symtab[i].table->nel;
>  
> -        /*
> -         * A special case when writing type/attribute symbol table.
> -         * The kernel policy version less than 24 does not support
> -         * to load entries of attribute, so we filter the entries
> -         * from the table.
> -         */
> -        if (i == SYM_TYPES &&
> -            p->policyvers < POLICYDB_VERSION_BOUNDARY &&
> -            p->policy_type == POLICY_KERN) {
> -            (void)hashtab_map(p->symtab[i].table, type_attr_filter, p);
> -            if (buf[1] != p->symtab[i].table->nel)
> +		/*
> +		* A special case when writing type/attribute symbol table.
> +		* The kernel policy version less than 24 does not support
> +		* to load entries of attribute, so we filter the entries
> +		* from the table.
> +		*/
> +		if (i == SYM_TYPES &&
> +			p->policyvers < POLICYDB_VERSION_BOUNDARY &&
> +			p->policy_type == POLICY_KERN) {
> +			(void)hashtab_map(p->symtab[i].table, type_attr_filter, p);
> +			if (buf[1] != p->symtab[i].table->nel)
>                  WARN(fp->handle, "Discarding type attribute rules");
> -            buf[1] = p->symtab[i].table->nel;
> -        }
> -
> -        /*
> -         * Another special case when writing role/attribute symbol
> -         * table, role attributes are redundant for policy.X, or
> -         * when the pp's version is not big enough. So filter the entries
> -         * from the table.
> -         */
> -        if ((i == SYM_ROLES) &&
> -            ((p->policy_type == POLICY_KERN) ||
> -             (p->policy_type != POLICY_KERN &&
> -              p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB))) {
> -            (void)hashtab_map(p->symtab[i].table, role_attr_filter, p);
> +			buf[1] = p->symtab[i].table->nel;
> +		}
> +
> +	/*
> +		* Another special case when writing role/attribute symbol
> +		* table, role attributes are redundant for policy.X, or
> +		* when the pp's version is not big enough. So filter the entries
> +		* from the table.
> +		*/
> +		if ((i == SYM_ROLES) &&
> +			((p->policy_type == POLICY_KERN) ||
> +			(p->policy_type != POLICY_KERN &&
> +			p->policyvers < MOD_POLICYDB_VERSION_ROLEATTRIB))) {
> +			(void)hashtab_map(p->symtab[i].table, role_attr_filter, p);
>  			if (buf[1] != p->symtab[i].table->nel)
>  				WARN(fp->handle, "Discarding role attribute rules");
> -            buf[1] = p->symtab[i].table->nel;
> -        }
> +			buf[1] = p->symtab[i].table->nel;
> +		}
>  
>  		buf[1] = cpu_to_le32(buf[1]);
>  		items = put_entry(buf, sizeof(uint32_t), 2, fp);

