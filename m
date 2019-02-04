Return-Path: <SRS0=wOFf=QL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FBC282C4
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299562175B
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 17:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfBDRoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:44:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfBDRoQ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 4 Feb 2019 12:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6CB281DE3;
        Mon,  4 Feb 2019 17:44:15 +0000 (UTC)
Received: from workstation (ovpn-204-191.brq.redhat.com [10.40.204.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 003316E704;
        Mon,  4 Feb 2019 17:44:14 +0000 (UTC)
References: <20190201210802.8822-1-jwcart2@tycho.nsa.gov>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol: Fix RESOURCE_LEAK defects reported by coverity scan
In-reply-to: <20190201210802.8822-1-jwcart2@tycho.nsa.gov>
Date:   Mon, 04 Feb 2019 18:44:13 +0100
Message-ID: <pjd8syv1maa.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 04 Feb 2019 17:44:15 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


James Carter <jwcart2@tycho.nsa.gov> writes:

> These were reported by Petr Lautrbach (plautrba@redhat.com) and 
> this
> patch was based on his patch with only a few changes.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

The following list of Coverity scan defects are fixed by this 
patch
https://plautrba.fedorapeople.org/selinux/20190204-libsepol-fixed-RESOURCE_LEAK.txt

Thanks!

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  libsepol/cil/src/cil_binary.c      | 13 ++++++++++++-
>  libsepol/cil/src/cil_resolve_ast.c |  9 +++++++++
>  libsepol/cil/src/cil_symtab.c      |  1 +
>  libsepol/src/expand.c              |  6 ++++++
>  libsepol/src/kernel_to_cil.c       |  2 ++
>  libsepol/src/kernel_to_conf.c      |  2 ++
>  6 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c 
> b/libsepol/cil/src/cil_binary.c
> index 0cc6eeb1..a10c3763 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -54,6 +54,7 @@
>  #include "cil_binary.h"
>  #include "cil_symtab.h"
>  #include "cil_find.h"
> +#include "cil_build_ast.h"
>  
>  /* There are 44000 filename_trans in current fedora policy. 
>  1.33 times this is the recommended
>   * size of a hashtable. The next power of 2 of this is 2 ** 16.
> @@ -930,7 +931,7 @@ int cil_sensalias_to_policydb(policydb_t 
> *pdb, struct cil_alias *cil_alias)
>  
>  exit:
>  	level_datum_destroy(sepol_alias);
> -	free(sepol_level);
> +	free(sepol_alias);
>  	free(key);
>  	return rc;
>  }
> @@ -1763,11 +1764,13 @@ int 
> __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, 
> uint32_t src, u
>  		hashtab_xperms = cil_malloc(sizeof(*hashtab_xperms));
>  		rc = ebitmap_cpy(hashtab_xperms, xperms);
>  		if (rc != SEPOL_OK) {
> +			free(hashtab_xperms);
>  			free(avtab_key);
>  			goto exit;
>  		}
>  		rc = hashtab_insert(h, (hashtab_key_t)avtab_key, 
>  hashtab_xperms);
>  		if (rc != SEPOL_OK) {
> +			free(hashtab_xperms);
>  			free(avtab_key);
>  			goto exit;
>  		}
> @@ -2157,6 +2160,7 @@ static int 
> __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct 
> cil_list
>  			op->expr_type = COND_NEQ;
>  			break;
>  		default:
> +			free(op);
>  			goto exit;
>  		}
>  
> @@ -2283,6 +2287,7 @@ int cil_booleanif_to_policydb(policydb_t 
> *pdb, const struct cil_db *db, struct c
>  
>  	cond_expr_destroy(tmp_cond->expr);
>  	free(tmp_cond);
> +	tmp_cond = NULL;
>  
>  	for (cb_node = node->cl_head; cb_node != NULL; cb_node = 
>  cb_node->next) {
>  		if (cb_node->flavor == CIL_CONDBLOCK) {
> @@ -2327,6 +2332,11 @@ int cil_booleanif_to_policydb(policydb_t 
> *pdb, const struct cil_db *db, struct c
>  	return SEPOL_OK;
>  
>  exit:
> +	if (tmp_cond) {
> +		if (tmp_cond->expr)
> +			cond_expr_destroy(tmp_cond->expr);
> +		free(tmp_cond);
> +	}
>  	return rc;
>  }
>  
> @@ -4797,6 +4807,7 @@ static struct cil_list 
> *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
>  	return cp_list;
>  
>  exit:
> +	cil_destroy_classperms(cp);
>  	cil_log(CIL_ERR,"Failed to create CIL class-permissions from 
>  sepol values\n");
>  	return NULL;
>  }
> diff --git a/libsepol/cil/src/cil_resolve_ast.c 
> b/libsepol/cil/src/cil_resolve_ast.c
> index fb9d9174..ea08087d 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -1535,6 +1535,7 @@ int cil_resolve_sidorder(struct 
> cil_tree_node *current, void *extra_args)
>  	return SEPOL_OK;
>  
>  exit:
> +	cil_list_destroy(&new, CIL_FALSE);
>  	return rc;
>  }
>  
> @@ -1591,6 +1592,7 @@ int cil_resolve_catorder(struct 
> cil_tree_node *current, void *extra_args)
>  	return SEPOL_OK;
>  
>  exit:
> +	cil_list_destroy(&new, CIL_FALSE);
>  	return rc;
>  }
>  
> @@ -1624,6 +1626,7 @@ int cil_resolve_sensitivityorder(struct 
> cil_tree_node *current, void *extra_args
>  	return SEPOL_OK;
>  
>  exit:
> +	cil_list_destroy(&new, CIL_FALSE);
>  	return rc;
>  }
>  
> @@ -2853,6 +2856,7 @@ int cil_resolve_call1(struct cil_tree_node 
> *current, void *extra_args)
>  					rc = cil_fill_cats(pc, &catset->cats);
>  					if (rc != SEPOL_OK) {
>  						cil_destroy_catset(catset);
> +						cil_destroy_args(new_arg);
>  						goto exit;
>  					}
>  					cil_tree_node_init(&cat_node);
> @@ -2877,6 +2881,7 @@ int cil_resolve_call1(struct cil_tree_node 
> *current, void *extra_args)
>  					if (rc != SEPOL_OK) {
>  						cil_log(CIL_ERR, "Failed to create anonymous level, 
>  rc: %d\n", rc);
>  						cil_destroy_level(level);
> +						cil_destroy_args(new_arg);
>  						goto exit;
>  					}
>  					cil_tree_node_init(&lvl_node);
> @@ -2901,6 +2906,7 @@ int cil_resolve_call1(struct cil_tree_node 
> *current, void *extra_args)
>  					if (rc != SEPOL_OK) {
>  						cil_log(CIL_ERR, "Failed to create anonymous 
>  levelrange, rc: %d\n", rc);
>  						cil_destroy_levelrange(range);
> +						cil_destroy_args(new_arg);
>  						goto exit;
>  					}
>  					cil_tree_node_init(&range_node);
> @@ -2925,6 +2931,7 @@ int cil_resolve_call1(struct cil_tree_node 
> *current, void *extra_args)
>  					if (rc != SEPOL_OK) {
>  						cil_log(CIL_ERR, "Failed to create anonymous ip 
>  address, rc: %d\n", rc);
>  						cil_destroy_ipaddr(ipaddr);
> +						cil_destroy_args(new_arg);
>  						goto exit;
>  					}
>  					cil_tree_node_init(&addr_node);
> @@ -2955,6 +2962,7 @@ int cil_resolve_call1(struct cil_tree_node 
> *current, void *extra_args)
>  					if (rc != SEPOL_OK) {
>  						cil_log(CIL_ERR, "Failed to create anonymous 
>  classpermission\n");
>  						cil_destroy_classpermission(cp);
> +						cil_destroy_args(new_arg);
>  						goto exit;
>  					}
>  					cil_tree_node_init(&cp_node);
> @@ -2970,6 +2978,7 @@ int cil_resolve_call1(struct cil_tree_node 
> *current, void *extra_args)
>  			default:
>  				cil_log(CIL_ERR, "Unexpected flavor: %d\n", 
>  						(((struct cil_param*)item->data)->flavor));
> +				cil_destroy_args(new_arg);
>  				rc = SEPOL_ERR;
>  				goto exit;
>  			}
> diff --git a/libsepol/cil/src/cil_symtab.c 
> b/libsepol/cil/src/cil_symtab.c
> index 3769979b..2970b863 100644
> --- a/libsepol/cil/src/cil_symtab.c
> +++ b/libsepol/cil/src/cil_symtab.c
> @@ -185,6 +185,7 @@ int cil_complex_symtab_insert(struct 
> cil_complex_symtab *symtab,
>  			ckey->key2 == curr->ckey->key2 &&
>  			ckey->key3 == curr->ckey->key3 &&
>  			ckey->key4 == curr->ckey->key4) {
> +			free(node);
>  			return SEPOL_EEXIST;
>  		}
>  
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 6f1b235e..312d137b 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1451,6 +1451,7 @@ static int 
> expand_filename_trans(expand_state_t *state, 
> filename_trans_rule_t *r
>  				new_trans->name = strdup(cur_rule->name);
>  				if (!new_trans->name) {
>  					ERR(state->handle, "Out of memory!");
> +					free(new_trans);
>  					return -1;
>  				}
>  				new_trans->stype = i + 1;
> @@ -1460,6 +1461,8 @@ static int 
> expand_filename_trans(expand_state_t *state, 
> filename_trans_rule_t *r
>  				otype = calloc(1, sizeof(*otype));
>  				if (!otype) {
>  					ERR(state->handle, "Out of memory!");
> +					free(new_trans->name);
> +					free(new_trans);
>  					return -1;
>  				}
>  				otype->otype = mapped_otype;
> @@ -1469,6 +1472,9 @@ static int 
> expand_filename_trans(expand_state_t *state, 
> filename_trans_rule_t *r
>  						    otype);
>  				if (rc) {
>  					ERR(state->handle, "Out of memory!");
> +					free(otype);
> +					free(new_trans->name);
> +					free(new_trans);
>  					return -1;
>  				}
>  			}
> diff --git a/libsepol/src/kernel_to_cil.c 
> b/libsepol/src/kernel_to_cil.c
> index 63e4d489..ec82f597 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2031,6 +2031,8 @@ static int write_cond_av_list_to_cil(FILE 
> *out, struct policydb *pdb, cond_av_li
>  	return 0;
>  
>  exit:
> +	strs_free_all(strs);
> +	strs_destroy(&strs);
>  	return rc;
>  }
>  
> diff --git a/libsepol/src/kernel_to_conf.c 
> b/libsepol/src/kernel_to_conf.c
> index 215d940c..afadca6b 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1999,6 +1999,8 @@ static int write_cond_av_list_to_conf(FILE 
> *out, struct policydb *pdb, cond_av_l
>  	return 0;
>  
>  exit:
> +	strs_free_all(strs);
> +	strs_destroy(&strs);
>  	return rc;
>  }

