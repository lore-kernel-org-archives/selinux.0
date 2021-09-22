Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D275C433F5
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 10:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231DB61209
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 10:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhIVK2x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234876AbhIVK2x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 06:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632306442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAbJ1SjjrLjIpkCZSRKGhJwQ/6Rdv3nElL2KTm8EsSk=;
        b=cKkEedbrQbyksc6IbcifTU8dLQXRA9QhuV8Ugl8ZZ2wSDkSYy7OHKeEHeyWQ2IEowFCpni
        2nYxdvOd9N9PiMF3HCSjz2ESgp0txO0RWnXz/Lla2iIrhiVvui8Vr9FpX64OKSSRq2FK7c
        90rbdsmf1GcK2ppCc5NtZTIm+b/8Jvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-81jWwr0iO5m61kkMTViCDg-1; Wed, 22 Sep 2021 06:27:21 -0400
X-MC-Unique: 81jWwr0iO5m61kkMTViCDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44097108468A;
        Wed, 22 Sep 2021 10:27:20 +0000 (UTC)
Received: from localhost (unknown [10.40.194.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4E8019C79;
        Wed, 22 Sep 2021 10:27:19 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol/cil: Handle operations in a class mapping when
 verifying
In-Reply-To: <20210916202900.1157917-1-jwcart2@gmail.com>
References: <20210916202900.1157917-1-jwcart2@gmail.com>
Date:   Wed, 22 Sep 2021 12:27:18 +0200
Message-ID: <87czp0vrax.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> When checking for circular class permission declarations and a class
> mapping is encountered, the class permissions for each map permission
> must be checked. An assumption was made that there were no operators
> in the class permissions. An operator in the class permissions would
> cause a segfault.
>
> Example causing segault:
>   (classmap cm1 (mp1))
>   (classmapping cm1 mp1 (CLASS (PERM)))
>   (classpermission cp1)
>   (classpermissionset cp1 (cm1 (all)))
>
> For map class permissions, check each item in the permission list to
> see if it is an operator. If it is not, then verify the class
> permissions associated with the map permission. If it is an operator
> and the operator is "all", then create a list of all permissions for
> that map class and verify the class permissions associated with each
> map permission. If it is a different operator, then it can be skipped.
>
> This bug was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
>  libsepol/cil/src/cil_verify.c | 40 ++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 5502c4d5..dc29ea66 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1689,6 +1689,15 @@ exit:
>  	return rc;
>  }
>  
> +static int __add_perm_to_list(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
> +{
> +	struct cil_list *perm_list = (struct cil_list *)args;
> +
> +	cil_list_append(perm_list, CIL_DATUM, d);
> +
> +	return SEPOL_OK;
> +}
> +
>  static int __cil_verify_classperms(struct cil_list *classperms,
>  				   struct cil_symtab_datum *orig,
>  				   struct cil_symtab_datum *parent,
> @@ -1730,13 +1739,34 @@ static int __cil_verify_classperms(struct cil_list *classperms,
>  			if (FLAVOR(cp->class) != CIL_CLASS) { /* MAP */
>  				struct cil_list_item *i = NULL;
>  				cil_list_for_each(i, cp->perms) {
> -					struct cil_perm *cmp = i->data;
> -					rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
> -					if (rc != SEPOL_OK) {
> -						goto exit;
> +					if (i->flavor != CIL_OP) {
> +						struct cil_perm *cmp = i->data;
> +						rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
> +						if (rc != SEPOL_OK) {
> +							goto exit;
> +						}
> +					} else {
> +						enum cil_flavor op = (enum cil_flavor)i->data;
> +						if (op == CIL_ALL) {
> +							struct cil_class *mc = cp->class;
> +							struct cil_list *perm_list;
> +							struct cil_list_item *j = NULL;
> +
> +							cil_list_init(&perm_list, CIL_MAP_PERM);
> +							cil_symtab_map(&mc->perms, __add_perm_to_list, perm_list);
> +							cil_list_for_each(j, perm_list) {
> +								struct cil_perm *cmp = j->data;
> +								rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
> +								if (rc != SEPOL_OK) {
> +									cil_list_destroy(&perm_list, CIL_FALSE);
> +									goto exit;
> +								}
> +							}
> +							cil_list_destroy(&perm_list, CIL_FALSE);
> +						}
>  					}
>  				}
> -			}	
> +			}
>  		} else { /* SET */
>  			struct cil_classperms_set *cp_set = curr->data;
>  			struct cil_classpermission *cp = cp_set->set;
> -- 
> 2.31.1

