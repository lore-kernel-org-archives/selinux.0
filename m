Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E3DEB64DA
	for <selinux@archiver.kernel.org>; Wed, 12 Jul 2023 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjGLQBb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjGLQB3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jul 2023 12:01:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED5198A
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 09:01:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso3304640a12.2
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689177686; x=1691769686;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dcvlJP1sYPdB2cQ033LxvBuVpGmlec/5PDVRozlWtQ=;
        b=YA2ZiMtQptlKto8j7lvXHMTQ1sLy3NuZawluMinSpb8RQ25/hjOHqaAaH5ayV0WcQN
         Xy3IiGvv+kKgNumcv9g5tbqlpBOAqy16BzPkZSwdI13SJTsdliSmxq2EFrlUN0vYUIUj
         C7hqfaRQoe30M7nuk9KlbE0LXSEs9eUCj8ayPbjR/hbRK9a75aPs7TxiDO2HlZnUKHYL
         9Z/BAIZBV0BPkJto5fNdjlFw6Ld1J1l7BlaJ2RSgpJVM7RMq6cXi26Nvq715rvHgWZFG
         Npl7iw4udF8ROcnJWrkKqMTP81wrWLknuNegO6feIgHxi15VGmMkJsJvawBXYMfIi5xo
         jXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177686; x=1691769686;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dcvlJP1sYPdB2cQ033LxvBuVpGmlec/5PDVRozlWtQ=;
        b=S1keulYBLOae3KPCgkVoVuZF3m1yNiqon5wd4s4YLjsyWzccd/qcT4k1UQ86MqYFVN
         f0kE9mXROXGkTaG3PNUvoS3J+mXKEWjxno9+Wj1vflDwNGcNVHfgrZ5Y42I18abrLiXu
         t0addnwGkMIot2eHFzoguoJMARdRMVnCmPxX2rWiZdsr/ZaNHh/9TLPjpMxwCTCuJseM
         Kpt+jH+88qtFnt1YmJNMxxklzKcngH2AsnQmQZMpYYb63YX6Coq59s1DCqnRC4w7jbDl
         qIVx3Xsh38oNu/FOzK6PH/PeERm8rOgfW2MuKx9jtC2xuwDV52ZxzuussyQtaWdQ+RUW
         h4EQ==
X-Gm-Message-State: ABy/qLaEPpMxGapbgCQK+qoNma6tl1q/+mKcII+XGuC8/WrmdVpDFOGM
        CoSJCsau8XHOUy3q/d4N9TcHohzR+0x7MqQCH3Y=
X-Google-Smtp-Source: APBJJlE0vYTrfy6mM+EiUsH4AVEHy1f6C4RCqxxtQpL5dU/OmJa6tASQ+UiXAwpXHCqXSK0O/UaZgw==
X-Received: by 2002:aa7:d450:0:b0:51e:1a51:d414 with SMTP id q16-20020aa7d450000000b0051e1a51d414mr15836893edr.32.1689177685593;
        Wed, 12 Jul 2023 09:01:25 -0700 (PDT)
Received: from [192.168.24.24] (dynamic-077-010-019-195.77.10.pool.telefonica.de. [77.10.19.195])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640206d000b0051e0bf5807bsm2944237edy.49.2023.07.12.09.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:01:25 -0700 (PDT)
Message-ID: <fbad54d3-07e6-c364-2547-0730f4d69cd7@googlemail.com>
Date:   Wed, 12 Jul 2023 18:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] libsepol/cil: Fix class permission verification in CIL
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20230420125801.999381-1-jwcart2@gmail.com>
From:   =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
In-Reply-To: <20230420125801.999381-1-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/20/23 14:58, James Carter wrote:
> Before the CIL post processing phase (where expressions are evaluated,
> various ebitmaps are set, etc) there is a pre-verification where
> checks are made to find self references or loops in bounds, attribute
> sets, and class permissions. The class permission checking is faulty
> in two ways.
>
> First, it does not check for the use of "all" in a permission expression
> for a class that has no permissions. An error will still be generated
> later and secilc will exit cleanly, but without an error message that
> explains the problem.
>
> Second, it does not properly handle lists in permission expressions.
> For example, "(C ((P)))" is a legitimate class permission. The
> permissions expression contains one item that is a list containing
> one permission. This permission expression will be properly evaluated.
> Unfortunately, the class permission verification assumes that each
> item in the permission expression is either an operator or a
> permission datum and a segmenation fault will occur.
>
> Refactor the class permission checking to give a proper error when
> "all" is used in a permission expression for a class that has no
> permissions and so that it can handle lists in permission
> expressions. Also, check for the actual flavor of each item in
> the permission expression and return an error if an unexpected
> flavor is found.
>
> The failure to properly handle lists in permission expressions was
> found by oss-fuzz (#58085).


For what it's worth:

Verified the fuzzer no longer crashes and no new issues arose after 
running for ~1h.

Successfully build DSSP5.


Tested-by: Christian Göttsche <cgzones@googlemail.com>


>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>   libsepol/cil/src/cil_verify.c | 167 +++++++++++++++++++++++-----------
>   1 file changed, 114 insertions(+), 53 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 4640dc59..3f58969d 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1700,31 +1700,109 @@ static int __add_perm_to_list(__attribute__((unused)) hashtab_key_t k, hashtab_d
>   	return SEPOL_OK;
>   }
>   
> -static int __cil_verify_classperms(struct cil_list *classperms,
> -				   struct cil_symtab_datum *orig,
> -				   struct cil_symtab_datum *parent,
> -				   struct cil_symtab_datum *cur,
> -				   enum cil_flavor flavor,
> -				   unsigned steps, unsigned limit)
> +static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, unsigned limit);
> +
> +static int __cil_verify_map_perm(struct cil_class *class, struct cil_perm *perm, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
> +{
> +	int rc;
> +
> +	if (!perm->classperms) {
> +		cil_tree_log(NODE(class), CIL_ERR, "No class permissions for map class %s, permission %s", DATUM(class)->name, DATUM(perm)->name);
> +		goto exit;
> +	}
> +
> +	rc = __cil_verify_classperms(perm->classperms, orig, &perm->datum, steps, limit);
> +	if (rc != SEPOL_OK) {
> +		cil_tree_log(NODE(class), CIL_ERR, "There was an error verifying class permissions for map class %s, permission %s", DATUM(class)->name, DATUM(perm)->name);
> +		goto exit;
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return SEPOL_ERR;
> +}
> +
> +
> +static int __cil_verify_perms(struct cil_class *class, struct cil_list *perms, struct cil_symtab_datum *orig, unsigned steps, unsigned limit)
>   {
>   	int rc = SEPOL_ERR;
> -	struct cil_list_item *curr;
> +	int count = 0;
> +	struct cil_list_item *i = NULL;
>   
> -	if (classperms == NULL) {
> -		if (flavor == CIL_MAP_PERM) {
> -			cil_tree_log(NODE(cur), CIL_ERR, "Map class %s does not have a classmapping for %s", parent->name, cur->name);
> +	if (!perms) {
> +		cil_tree_log(NODE(class), CIL_ERR, "No permissions for class %s in class permissions", DATUM(class)->name);
> +		goto exit;
> +	}
> +
> +	cil_list_for_each(i, perms) {
> +		count++;
> +		if (i->flavor == CIL_LIST) {
> +			rc = __cil_verify_perms(class, i->data, orig, steps, limit);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
> +			}
> +		} else if (i->flavor == CIL_DATUM) {
> +			struct cil_perm *perm = i->data;
> +			if (FLAVOR(perm) == CIL_MAP_PERM) {
> +				rc = __cil_verify_map_perm(class, perm, orig, steps, limit);
> +				if (rc != SEPOL_OK) {
> +					goto exit;
> +				}
> +			}
> +		} else if (i->flavor == CIL_OP) {
> +			enum cil_flavor op = (enum cil_flavor)(uintptr_t)i->data;
> +			if (op == CIL_ALL) {
> +				struct cil_list *perm_list;
> +				struct cil_list_item *j = NULL;
> +				int count2 = 0;
> +				cil_list_init(&perm_list, CIL_MAP_PERM);
> +				cil_symtab_map(&class->perms, __add_perm_to_list, perm_list);
> +				cil_list_for_each(j, perm_list) {
> +					count2++;
> +					struct cil_perm *perm = j->data;
> +					if (FLAVOR(perm) == CIL_MAP_PERM) {
> +						rc = __cil_verify_map_perm(class, perm, orig, steps, limit);
> +						if (rc != SEPOL_OK) {
> +							cil_list_destroy(&perm_list, CIL_FALSE);
> +							goto exit;
> +						}
> +					}
> +				}
> +				cil_list_destroy(&perm_list, CIL_FALSE);
> +				if (count2 == 0) {
> +					cil_tree_log(NODE(class), CIL_ERR, "Operator \"all\" used for %s which has no permissions associated with it", DATUM(class)->name);
> +					goto exit;
> +				}
> +			}
>   		} else {
> -			cil_tree_log(NODE(cur), CIL_ERR, "Classpermission %s does not have a classpermissionset", cur->name);
> +			cil_tree_log(NODE(class), CIL_ERR, "Permission list for %s has an unexpected flavor: %d", DATUM(class)->name, i->flavor);
> +			goto exit;
>   		}
> +	}
> +
> +	if (count == 0) {
> +		cil_tree_log(NODE(class), CIL_ERR, "Empty permissions list for class %s in class permissions", DATUM(class)->name);
> +		goto exit;
> +	}
> +
> +	return SEPOL_OK;
> +
> +exit:
> +	return SEPOL_ERR;
> +}
> +
> +static int __cil_verify_classperms(struct cil_list *classperms, struct cil_symtab_datum *orig, struct cil_symtab_datum *cur, unsigned steps, unsigned limit)
> +{
> +	int rc;
> +	struct cil_list_item *i;
> +
> +	if (classperms == NULL) {
>   		goto exit;
>   	}
>   
>   	if (steps > 0 && orig == cur) {
> -		if (flavor == CIL_MAP_PERM) {
> -			cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving the map class %s and permission %s", parent->name, cur->name);
> -		} else {
> -			cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving the set %s", cur->name);
> -		}
> +		cil_tree_log(NODE(cur), CIL_ERR, "Found circular class permissions involving %s", cur->name);
>   		goto exit;
>   	} else {
>   		steps++;
> @@ -1735,44 +1813,20 @@ static int __cil_verify_classperms(struct cil_list *classperms,
>   		}
>   	}
>   
> -	cil_list_for_each(curr, classperms) {
> -		if (curr->flavor == CIL_CLASSPERMS) {
> -			struct cil_classperms *cp = curr->data;
> -			if (FLAVOR(cp->class) != CIL_CLASS) { /* MAP */
> -				struct cil_list_item *i = NULL;
> -				cil_list_for_each(i, cp->perms) {
> -					if (i->flavor != CIL_OP) {
> -						struct cil_perm *cmp = i->data;
> -						rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
> -						if (rc != SEPOL_OK) {
> -							goto exit;
> -						}
> -					} else {
> -						enum cil_flavor op = (enum cil_flavor)(uintptr_t)i->data;
> -						if (op == CIL_ALL) {
> -							struct cil_class *mc = cp->class;
> -							struct cil_list *perm_list;
> -							struct cil_list_item *j = NULL;
> -
> -							cil_list_init(&perm_list, CIL_MAP_PERM);
> -							cil_symtab_map(&mc->perms, __add_perm_to_list, perm_list);
> -							cil_list_for_each(j, perm_list) {
> -								struct cil_perm *cmp = j->data;
> -								rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
> -								if (rc != SEPOL_OK) {
> -									cil_list_destroy(&perm_list, CIL_FALSE);
> -									goto exit;
> -								}
> -							}
> -							cil_list_destroy(&perm_list, CIL_FALSE);
> -						}
> -					}
> -				}
> +	cil_list_for_each(i, classperms) {
> +		if (i->flavor == CIL_CLASSPERMS) {
> +			struct cil_classperms *cp = i->data;
> +			rc = __cil_verify_perms(cp->class, cp->perms, orig, steps, limit);
> +			if (rc != SEPOL_OK) {
> +				goto exit;
>   			}
>   		} else { /* SET */
> -			struct cil_classperms_set *cp_set = curr->data;
> +			struct cil_classperms_set *cp_set = i->data;
>   			struct cil_classpermission *cp = cp_set->set;
> -			rc = __cil_verify_classperms(cp->classperms, orig, NULL, &cp->datum, CIL_CLASSPERMISSION, steps, limit);
> +			if (!cp->classperms) {
> +				cil_tree_log(NODE(cur), CIL_ERR, "Classpermission %s does not have a classpermissionset", DATUM(cp)->name);
> +			}
> +			rc = __cil_verify_classperms(cp->classperms, orig, &cp->datum, steps, limit);
>   			if (rc != SEPOL_OK) {
>   				goto exit;
>   			}
> @@ -1787,9 +1841,15 @@ exit:
>   
>   static int __cil_verify_classpermission(struct cil_tree_node *node)
>   {
> +	int rc;
>   	struct cil_classpermission *cp = node->data;
>   
> -	return __cil_verify_classperms(cp->classperms, &cp->datum, NULL, &cp->datum, CIL_CLASSPERMISSION, 0, 2);
> +	rc = __cil_verify_classperms(cp->classperms, &cp->datum, &cp->datum, 0, 2);
> +	if (rc != SEPOL_OK) {
> +		cil_tree_log(node, CIL_ERR, "Error verifying class permissions for classpermission %s", DATUM(cp)->name);
> +	}
> +
> +	return rc;
>   }
>   
>   struct cil_verify_map_args {
> @@ -1804,8 +1864,9 @@ static int __verify_map_perm_classperms(__attribute__((unused)) hashtab_key_t k,
>   	struct cil_perm *cmp = (struct cil_perm *)d;
>   	int rc;
>   
> -	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &map_args->class->datum, &cmp->datum, CIL_MAP_PERM, 0, 2);
> +	rc = __cil_verify_classperms(cmp->classperms, &cmp->datum, &cmp->datum, 0, 2);
>   	if (rc != SEPOL_OK) {
> +		cil_tree_log(NODE(cmp), CIL_ERR, "Error verifying class permissions for map class %s, permission %s", DATUM(map_args->class)->name, DATUM(cmp)->name);
>   		map_args->rc = rc;
>   	}
>   
