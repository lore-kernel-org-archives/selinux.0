Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F8C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKIQF3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKIQF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 11:05:28 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A8620F5F
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668009926; bh=G8Gfzc7hbnLb+rs8yJvrSOrDYkhe/hV7KooIT9EsLsw=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=F16qbu7oI5td6fAkzhIDEc+arQVgPEGSiepYdf0CdF0HXX7m96l5M/2nucEiNl8OZw3mNvMOlo7FWLLC0cO02sxb1tbVHy/9Bw37v7CHJkqHJHH+Rhcs7yyq++BKb8UiN+qQJtDlhyGnOxzm497MaMN7FvJpOmBxs+KhwLWp5+U9tOZ8r1UQnXgQEJi3HhGNIBhUB+JjU1NCtYdTz7ndYaUt62DfTvUKp/tEf8QJr9riRf1dVYWRJtQtr8vwsGEznbDW6VYGAF25y1h0zcCbcPX/dHmEZPfJ5OFRlI0pfDUlbqix5TLV72pJjq6P8TNZEk7+YcIgYWLtI9eMPy14sg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668009926; bh=oZfeicaPgVIIFWQAPAXFZ+VQfbu1JdtrhJbtlcDjKiI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=c2ELyOOFD2JgPOhSRcCfEkQ28zdR4rzU54DpE4frFCz/2oDIPCUKyOJBZh9A8DfB2F0pjFr94MywoGYaBAUd6RN2JuwxRU3RpRhk/SNgVkDWv6t79ZBMAKNgRajnoS9ZKjQVyX48fHERYHuUqwXjSr+N5CBsZPJzlK+GKaBJX56ZvzO/CX/M9OZkN1ug3LlUJEdiespv+ASMZoTz9nTcg2id69flKTaQfP60cT0yv1ZaaMeMnZyxABQRkWWzaz3BDkDE4BQG+HkXdPmaGZR/WnyPijnKT7D3ZMbbdkRXpYowf9OlZqW+ng4ds0c3emnTlKNCz/y+qVZs57PiT2G0cg==
X-YMail-OSG: 2qk.Rx0VM1nDlgJGG05sdYG5wkuvl9g7aG8vgjN9ILU6_0bNaKyqnZlPcwbDOd4
 zkH1busZjZdXdeUagTmdYEz_OL9yapqfIdT5nPUGo8DtCptNcLFmy0SvtZTV9lYo_eRAeyOSB45o
 5XPAYBzFpJ4tsdIGCI00_g50mY0H8Xxecj6txD3XpoxcgB8bl_k2lBDAWaLmO9zNaN5C_L1Sysiw
 EIyKY8Phuiq4175Ld.p.3Naj_Eaqpz2DgLbnJT3BWT1S84gqoU09lvUZIirXStHjiU9BJEjaVMuX
 RkgjgKwnracQVM0cUKA2cuHRIVfJM_DPGpP6rLQ4bedm2EAYfupAIfbqNjQwTRenNmXM41Oh7bl2
 Ar32LmT_p6ypNZEf8P1poW2FK.xJJAXxFn._wJ7y1Yc.81.PAJhZmCiMOXoocVYyl8i7ZgrsKmOM
 _O20TgY.igwNAAxdWCVS55FK9MuoDuQWmyu5zXokLCCkpZxvganpH4ccpsU2vJ6dEihu4tTTlkOh
 0JepFUNsqXytihpj.7hSzltPCzHqaukv1Dyr46Dc1VC7s8_EmxE933GvweYT_x0QH8yaO.77feDg
 8pUtsAzcWdrufYY.srsxwDiiq0m40rPgti2CmUJkNGCDAshKufUtQiTFFDPEJR5foTINvZegU8aW
 VeDnMWHHnKSpC2oWhjIqW97dh5fKXiV7N_116TKDN0TSeWRQrDXWiTK1dydrQgA1EwNA2vU9muO2
 t38fo1csGQ3Yu1008WjSj9g_mftWqTE7apo34hp463RI3_UGkmbuoZ2QmOIWUDXJo5aC6bo8n6DV
 rBtHZ2wEFQ5rnVXfFUB6EVQdhI96OB1ajuUj2_GCxDx8O4R10EXWt7_ZPZQi_gmdYK30enqmFqs9
 6Yn7M_j9VNYm_CKVg4l5MK.iGuluvxbq7ieVb916eXl3abSZuivmUg2vP3jvs1gm5DKGKJyGHVlk
 wbogoj4s.thW4EgfPtTdbZz9GpsBgIAF4A9WA1JSTW5F9Qa4mG7sZ1okIZtwOwP0Ud1nO8fVKAps
 WXrR385m.9.K5oIZ2ufMnC9WbIeDVQjVGTWINtlL_0Br9MBVPPguHF6f1VPsQo0V9eHafmsiaIyd
 EuZuMpZryyOCQ2d91DPRzHFXEHKxHS0eCCA7n5T5JRZLcVi.kVb3KQ.rfu4EAS5ZDRJDc32I1l3e
 HXuHgclGgmexdfm..QMUeDLl6TVxNeZ.v83e8OWwasX4GYlzat6.sf_L3fam3da0493s1RzOAybq
 UAwh4HSdXZA84qfVw9YwiZscx2giq8LexcrvA32ZXxG89eXUCG7e7eChzi6npTZrXnxvx40baODf
 PxEVsFRZQmN9dOVxK0RkZESMAkFS8D_9TkBCtDv.Z7F2rhnnJi5NF2kzDJBjcK7AGqypwgLIvvq2
 KNoMksETd6It9T7rlYVrsYJl5SNSvxiGWr7I96ZVP2b3UuX4yg1d46UoC9Ot7MDLWc3YgXBQWM81
 cXOyaV6V2QDJOhXF5SIOV6x_Dp6S6gFncGaXci.o6SzbloJwbZ76._YMB9Jn9wh9zzhFHPsRnBnp
 W.m9DuGE.AzzNjrj_SpAbgNQwJ2rFUc9nLxbIDT7tIEUmckWD34hHBVvGn1Yev2iIx6SasTFxbqn
 j0LIBEwLT9_XRn7lksWus7kH_QfClg5FYspMfd8NezcwzqnIe6nNhlIh7lMNTUT9jX1gG9eyz0zM
 4lp.mgTatCLYerKKC4aX1vyrHBGvug5Hvlbv4H7uk9qAHFfjBD0YSiXGmqWsmKBb85qxL8StlR3e
 K1OFAhygVCKGjTCdkP13xEm7FAwAdcBzBCrz8dm5_spEZGgX9nCszX_kZlHDXmoWQDhzq0HmTqJW
 gbKwgnLnKdlCo0XCTL2BoBSn9FAPAIh.bSfxyCgkTKtBUyojruj_1dBa5StKwDub0HVz1JjKgRYa
 q9heSFWAk49ZyEQzkC75dgwg09sh682HByyJ_pYefaxgKvck1gnulSLTbKnZFta9YtOxnetOzVuV
 xpevYUUXLLBQ8eLOitDGWpJTL4rKEMhGE4blWaIMnH3rjy.ZBW7V8_0Y56am750rgS1nX5IjNJTY
 f3JPmn8BhL5wriHfou_X1ODxTCdW1iktFR7eEhaBFSUnr0CpGXuHujey_dNHSx3gMRL2IKVm3qU7
 JaT6uMJ.mLsn0wQ7lr9HRGsjmWP1553MJqyq0.LAzwYvaZLMNxJm_VF3CdW9dxfZyYGfMogCzpVa
 QXD.FEzCrB_hYwIwwYN59xQKtp23Q743xZZlD9PXqj5LgvV7QFqGZUUyW.mwLvTdBa_lSKfRpD_c
 K0LC9
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Nov 2022 16:05:26 +0000
Received: by hermes--production-bf1-5878955b5f-tg9fx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 627bdd68051818f2ebe1abdf76337b66;
          Wed, 09 Nov 2022 16:05:23 +0000 (UTC)
Message-ID: <8cd26ce1-1d73-31ee-834e-dc6e50f74842@schaufler-ca.com>
Date:   Wed, 9 Nov 2022 08:05:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selinux: remove the sidtab context conversion indirect
 calls
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <20221109040039.732341-1-paul@paul-moore.com>
Content-Language: en-US
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221109040039.732341-1-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/8/2022 8:00 PM, Paul Moore wrote:
> The sidtab conversion code has support for multiple context
> conversion routines through the use of function pointers and
> indirect calls.  However, the reality is that all current users rely
> on the same conversion routine: convert_context().  This patch does
> away with this extra complexity and replaces the indirect calls
> with direct function calls; allowing us to remove a layer of
> obfuscation and create cleaner, more maintainable code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

The SELinux code is enhanced by this sort of clean-up.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/ss/services.c | 51 ++++++++++++++--------------------
>  security/selinux/ss/services.h | 14 ++++++++--
>  security/selinux/ss/sidtab.c   | 21 ++++++++------
>  security/selinux/ss/sidtab.h   |  3 +-
>  4 files changed, 45 insertions(+), 44 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index fe5fcf571c564..e63c4f942fd6a 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -68,12 +68,6 @@
>  #include "policycap_names.h"
>  #include "ima.h"
>  
> -struct convert_context_args {
> -	struct selinux_state *state;
> -	struct policydb *oldp;
> -	struct policydb *newp;
> -};
> -
>  struct selinux_policy_convert_data {
>  	struct convert_context_args args;
>  	struct sidtab_convert_params sidtab_params;
> @@ -2014,17 +2008,20 @@ static inline int convert_context_handle_invalid_context(
>  	return 0;
>  }
>  
> -/*
> - * Convert the values in the security context
> - * structure `oldc' from the values specified
> - * in the policy `p->oldp' to the values specified
> - * in the policy `p->newp', storing the new context
> - * in `newc'.  Verify that the context is valid
> - * under the new policy.
> +/**
> + * services_convert_context - Convert a security context across policies.
> + * @args: populated convert_context_args struct
> + * @oldc: original context
> + * @newc: converted context
> + *
> + * Convert the values in the security context structure @oldc from the values
> + * specified in the policy @args->oldp to the values specified in the policy
> + * @args->newp, storing the new context in @newc, and verifying that the
> + * context is valid under the new policy.
>   */
> -static int convert_context(struct context *oldc, struct context *newc, void *p)
> +int services_convert_context(struct convert_context_args *args,
> +			     struct context *oldc, struct context *newc)
>  {
> -	struct convert_context_args *args;
>  	struct ocontext *oc;
>  	struct role_datum *role;
>  	struct type_datum *typdatum;
> @@ -2033,15 +2030,12 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>  	u32 len;
>  	int rc;
>  
> -	args = p;
> -
>  	if (oldc->str) {
>  		s = kstrdup(oldc->str, GFP_KERNEL);
>  		if (!s)
>  			return -ENOMEM;
>  
> -		rc = string_to_context_struct(args->newp, NULL, s,
> -					      newc, SECSID_NULL);
> +		rc = string_to_context_struct(args->newp, NULL, s, newc, SECSID_NULL);
>  		if (rc == -EINVAL) {
>  			/*
>  			 * Retain string representation for later mapping.
> @@ -2072,8 +2066,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>  
>  	/* Convert the user. */
>  	usrdatum = symtab_search(&args->newp->p_users,
> -				 sym_name(args->oldp,
> -					  SYM_USERS, oldc->user - 1));
> +				 sym_name(args->oldp, SYM_USERS, oldc->user - 1));
>  	if (!usrdatum)
>  		goto bad;
>  	newc->user = usrdatum->value;
> @@ -2087,8 +2080,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>  
>  	/* Convert the type. */
>  	typdatum = symtab_search(&args->newp->p_types,
> -				 sym_name(args->oldp,
> -					  SYM_TYPES, oldc->type - 1));
> +				 sym_name(args->oldp, SYM_TYPES, oldc->type - 1));
>  	if (!typdatum)
>  		goto bad;
>  	newc->type = typdatum->value;
> @@ -2122,8 +2114,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>  	/* Check the validity of the new context. */
>  	if (!policydb_context_isvalid(args->newp, newc)) {
>  		rc = convert_context_handle_invalid_context(args->state,
> -							args->oldp,
> -							oldc);
> +							    args->oldp, oldc);
>  		if (rc)
>  			goto bad;
>  	}
> @@ -2332,21 +2323,21 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
>  		goto err_free_isids;
>  	}
>  
> +	/*
> +	 * Convert the internal representations of contexts
> +	 * in the new SID table.
> +	 */
> +
>  	convert_data = kmalloc(sizeof(*convert_data), GFP_KERNEL);
>  	if (!convert_data) {
>  		rc = -ENOMEM;
>  		goto err_free_isids;
>  	}
>  
> -	/*
> -	 * Convert the internal representations of contexts
> -	 * in the new SID table.
> -	 */
>  	convert_data->args.state = state;
>  	convert_data->args.oldp = &oldpolicy->policydb;
>  	convert_data->args.newp = &newpolicy->policydb;
>  
> -	convert_data->sidtab_params.func = convert_context;
>  	convert_data->sidtab_params.args = &convert_data->args;
>  	convert_data->sidtab_params.target = newpolicy->sidtab;
>  
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index 9555ad074303c..6348c95ff0e52 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -29,10 +29,18 @@ struct selinux_policy {
>  	u32 latest_granting;
>  } __randomize_layout;
>  
> -void services_compute_xperms_drivers(struct extended_perms *xperms,
> -				struct avtab_node *node);
> +struct convert_context_args {
> +	struct selinux_state *state;
> +	struct policydb *oldp;
> +	struct policydb *newp;
> +};
>  
> +void services_compute_xperms_drivers(struct extended_perms *xperms,
> +				     struct avtab_node *node);
>  void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
> -					struct avtab_node *node);
> +				      struct avtab_node *node);
> +
> +int services_convert_context(struct convert_context_args *args,
> +			     struct context *oldc, struct context *newc);
>  
>  #endif	/* _SS_SERVICES_H_ */
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index a54b8652bfb50..1c3d2cda6b92a 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -18,6 +18,7 @@
>  #include "flask.h"
>  #include "security.h"
>  #include "sidtab.h"
> +#include "services.h"
>  
>  struct sidtab_str_cache {
>  	struct rcu_head rcu_member;
> @@ -292,7 +293,6 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
>  	}
>  
>  	count = s->count;
> -	convert = s->convert;
>  
>  	/* bail out if we already reached max entries */
>  	rc = -EOVERFLOW;
> @@ -316,25 +316,28 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context,
>  	 * if we are building a new sidtab, we need to convert the context
>  	 * and insert it there as well
>  	 */
> +	convert = s->convert;
>  	if (convert) {
> +		struct sidtab *target = convert->target;
> +
>  		rc = -ENOMEM;
> -		dst_convert = sidtab_do_lookup(convert->target, count, 1);
> +		dst_convert = sidtab_do_lookup(target, count, 1);
>  		if (!dst_convert) {
>  			context_destroy(&dst->context);
>  			goto out_unlock;
>  		}
>  
> -		rc = convert->func(context, &dst_convert->context,
> -				   convert->args);
> +		rc = services_convert_context(convert->args,
> +					      context, &dst_convert->context);
>  		if (rc) {
>  			context_destroy(&dst->context);
>  			goto out_unlock;
>  		}
>  		dst_convert->sid = index_to_sid(count);
>  		dst_convert->hash = context_compute_hash(&dst_convert->context);
> -		convert->target->count = count + 1;
> +		target->count = count + 1;
>  
> -		hash_add_rcu(convert->target->context_to_sid,
> +		hash_add_rcu(target->context_to_sid,
>  			     &dst_convert->list, dst_convert->hash);
>  	}
>  
> @@ -402,9 +405,9 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>  		}
>  		i = 0;
>  		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
> -			rc = convert->func(&esrc->ptr_leaf->entries[i].context,
> -					   &edst->ptr_leaf->entries[i].context,
> -					   convert->args);
> +			rc = services_convert_context(convert->args,
> +					&esrc->ptr_leaf->entries[i].context,
> +					&edst->ptr_leaf->entries[i].context);
>  			if (rc)
>  				return rc;
>  			(*pos)++;
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index 4eff0e49dcb22..72810a080e77b 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -65,8 +65,7 @@ struct sidtab_isid_entry {
>  };
>  
>  struct sidtab_convert_params {
> -	int (*func)(struct context *oldc, struct context *newc, void *args);
> -	void *args;
> +	struct convert_context_args *args;
>  	struct sidtab *target;
>  };
>  
