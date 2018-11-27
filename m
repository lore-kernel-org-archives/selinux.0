Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6423DC43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA7720645
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 19:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA7720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeK1Ghp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:37:45 -0500
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:18317 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeK1Gho (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Nov 2018 01:37:44 -0500
X-EEMSG-check-008: 360942025|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2018 19:38:43 +0000
X-IronPort-AV: E=Sophos;i="5.56,287,1539648000"; 
   d="scan'208";a="21044180"
IronPort-PHdr: =?us-ascii?q?9a23=3AR8/FDxUqKBMLAmbgCvmy57VtTyPV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSHvqdThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUspXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUOYx2QsY4TGFpviY30rIGuZ?=
 =?us-ascii?q?+nfCgK1ZQo3ATTZOCAc4iN5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvIOcNo9ohQH+NaQigMq/DvgjMg?=
 =?us-ascii?q?cSRWSb/OW81Ln78U34RrVFkOE2n7HEvJ3VKskXvK60DxJP3oo95BuzES2q3M?=
 =?us-ascii?q?kAkXkCNl1FeRaHj4bzO1HJJfD1Fey/jEm3kDpw2/DHPqHuApXKLnTZlrfhZq?=
 =?us-ascii?q?xy51RTyAo009BT/4hUBa0ZIPLvRk/xs8TVDhg8Mwyz2ObnDs9y2Z8AVm+UGK?=
 =?us-ascii?q?+WLr7dsV+S6eIzOeWDeIgVuDPlIfg/+/HulWM5mUMafaSxxpsYdnS4HvVgI0?=
 =?us-ascii?q?WEbnvhmckBEWgUsQokVuDqi0ONUSRVZ3msW6Iw/DY7CJipDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GEkqDEWrsd4ifQ/cDcj+SIst4njwBUrihTJUh2g+0uADmzLpnK7?=
 =?us-ascii?q?mcxipNkpTvztV3r8jUjhc7/jF3R5Ca1maWSWh/k0sSSjM21bw5qkt4nBPLyq?=
 =?us-ascii?q?V8gvpFBfRN6P5TFAQ3L5jRy6p9Ed+2EjrIY9PBbVGhWNjuVSk4U9YZ29YTZw?=
 =?us-ascii?q?N4HNK4g1bI2C/8UJEPkLneP4A56qLR2TDKIs95z3vXnP06g0IOXtpENWrggL?=
 =?us-ascii?q?V2sQfUGdiawA2ii6+2ePFEj2b2/2CZwD/L5RgAXQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6AADRm/1b/wHyM5BjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VUFKWaBAieDeYgYjAdSBoE1fIgTDo4jFIFmMAgBhEACgxgiNAkNAQMBAQEBA?=
 =?us-ascii?q?QECAWwcDII2JAGCYgEFGgEIBBFRCw4KAgImAgIhNgYBDAYCAQEWgkg/AYFpA?=
 =?us-ascii?q?wgND6YBfDOFQIJEDYIXBYELiwIXeIEHgREngjY1gldHAoEmFBODGIJXAokDG?=
 =?us-ascii?q?gYEhjw0To55LgmGfIcIgyYGGIFZiC+HA41GgQqGd4Q2OIFVKwgCGAghDzuCb?=
 =?us-ascii?q?IImARcSgziKUh8hAzCBBQEBijkBJYInAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2018 19:38:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wARJceAk024347;
        Tue, 27 Nov 2018 14:38:41 -0500
Subject: Re: [RFC PATCH v2 3/4] selinux: overhaul sidtab to fix bug and
 improve performance
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20181127103605.32765-1-omosnace@redhat.com>
 <20181127103605.32765-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6b8cea64-8a39-09d7-f2fd-d7dd73374de1@tycho.nsa.gov>
Date:   Tue, 27 Nov 2018 14:41:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127103605.32765-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/18 5:36 AM, Ondrej Mosnacek wrote:
> Before this patch, during a policy reload the sidtab would become frozen
> and trying to map a new context to SID would be unable to add a new
> entry to sidtab and fail with -ENOMEM.
> 
> Such failures are usually propagated into userspace, which has no way of
> distignuishing them from actual allocation failures and thus doesn't
> handle them gracefully. Such situation can be triggered e.g. by the
> following reproducer:
> 
>      while true; do load_policy; echo -n .; sleep 0.1; done &
>      for (( i = 0; i < 1024; i++ )); do
>          runcon -l s0:c$i echo -n x || break
>          # or:
>          # chcon -l s0:c$i <some_file> || break
>      done
> 
> This patch overhauls the sidtab so it doesn't need to be frozen during
> policy reload, thus solving the above problem.
> 
> The new SID table leverages the fact that SIDs are allocated
> sequentially and are never invalidated and stores them in linear buckets
> indexed by a tree structure. This brings several advantages:
>    1. Fast SID -> context lookup - this lookup can now be done in
>       logarithmic time complexity (usually in less than 4 array lookups)
>       and can still be done safely without locking.
>    2. No need to re-search the whole table on reverse lookup miss - after
>       acquiring the spinlock only the newly added entries need to be
>       searched, which means that reverse lookups that end up inserting a
>       new entry are now about twice as fast.
>    3. No need to freeze sidtab during policy reload - it is now possible
>       to handle insertion of new entries even during sidtab conversion.
> 
> The tree structure of the new sidtab is able to grow automatically to up
> to about 2^31 entries (at which point it should not have more than about
> 4 tree levels). The old sidtab had a theoretical capacity of almost 2^32
> entries, but half of that is still more than enough since by that point
> the reverse table lookups would become unusably slow anyway...
> 
> The number of entries per tree node is selected automatically so that
> each node fits into a single page, which should be the easiest size for
> kmalloc() to handle.
> 
> Note that the new implementation does not have a cache for recent
> reverse lookups as the old one had. Such cache is, however, added in a
> subsequent patch.
> 
> Tested by selinux-testsuite and thoroughly tortured by this simple
> stress test:
> ```
> function rand_cat() {
> 	echo $(( $RANDOM % 1024 ))
> }
> 
> function do_work() {
> 	while true; do
> 		echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> 			>/sys/fs/selinux/context 2>/dev/null || true
> 	done
> }
> 
> do_work >/dev/null &
> do_work >/dev/null &
> do_work >/dev/null &
> 
> while load_policy; do echo -n .; sleep 0.1; done
> 
> kill %1
> kill %2
> kill %3
> ```
> 
> Reported-by: Orion Poplawski <orion@nwra.com>
> Reported-by: Li Kun <hw.likun@huawei.com>
> Link: https://github.com/SELinuxProject/selinux-kernel/issues/38
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/mls.c      |  23 +-
>   security/selinux/ss/mls.h      |   3 +-
>   security/selinux/ss/services.c |  90 +++---
>   security/selinux/ss/sidtab.c   | 522 +++++++++++++++++++--------------
>   security/selinux/ss/sidtab.h   |  75 +++--
>   5 files changed, 402 insertions(+), 311 deletions(-)
> 
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 2fe459df3c85..267ae4f9be79 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -436,16 +436,17 @@ int mls_setup_user_range(struct policydb *p,
>   
>   /*
>    * Convert the MLS fields in the security context
> - * structure `c' from the values specified in the
> - * policy `oldp' to the values specified in the policy `newp'.
> + * structure `oldc' from the values specified in the
> + * policy `oldp' to the values specified in the policy `newp',
> + * storing the resulting context in `newc'.
>    */
>   int mls_convert_context(struct policydb *oldp,
>   			struct policydb *newp,
> -			struct context *c)
> +			struct context *oldc,
> +			struct context *newc)
>   {
>   	struct level_datum *levdatum;
>   	struct cat_datum *catdatum;
> -	struct ebitmap bitmap;
>   	struct ebitmap_node *node;
>   	int l, i;
>   
> @@ -455,28 +456,24 @@ int mls_convert_context(struct policydb *oldp,
>   	for (l = 0; l < 2; l++) {
>   		levdatum = hashtab_search(newp->p_levels.table,
>   					  sym_name(oldp, SYM_LEVELS,
> -						   c->range.level[l].sens - 1));
> +						   oldc->range.level[l].sens - 1));
>   
>   		if (!levdatum)
>   			return -EINVAL;
> -		c->range.level[l].sens = levdatum->level->sens;
> +		newc->range.level[l].sens = levdatum->level->sens;
>   
> -		ebitmap_init(&bitmap);
> -		ebitmap_for_each_positive_bit(&c->range.level[l].cat, node, i) {
> +		ebitmap_for_each_positive_bit(&oldc->range.level[l].cat, node, i) {
>   			int rc;
>   
>   			catdatum = hashtab_search(newp->p_cats.table,
>   						  sym_name(oldp, SYM_CATS, i));
>   			if (!catdatum)
>   				return -EINVAL;
> -			rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
> +			rc = ebitmap_set_bit(&newc->range.level[l].cat,
> +					     catdatum->value - 1, 1);
>   			if (rc)
>   				return rc;
> -
> -			cond_resched();
>   		}
> -		ebitmap_destroy(&c->range.level[l].cat);
> -		c->range.level[l].cat = bitmap;
>   	}
>   
>   	return 0;
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 67093647576d..7954b1e60b64 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -46,7 +46,8 @@ int mls_range_set(struct context *context, struct mls_range *range);
>   
>   int mls_convert_context(struct policydb *oldp,
>   			struct policydb *newp,
> -			struct context *context);
> +			struct context *oldc,
> +			struct context *newc);
>   
>   int mls_compute_sid(struct policydb *p,
>   		    struct context *scontext,
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 30170d4c567a..3c5887838e12 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1907,19 +1907,16 @@ struct convert_context_args {
>   
>   /*
>    * Convert the values in the security context
> - * structure `c' from the values specified
> + * structure `oldc' from the values specified
>    * in the policy `p->oldp' to the values specified
> - * in the policy `p->newp'.  Verify that the
> - * context is valid under the new policy.
> + * in the policy `p->newp', storing the new context
> + * in `newc'.  Verify that the context is valid
> + * under the new policy.
>    */
> -static int convert_context(u32 key,
> -			   struct context *c,
> -			   void *p)
> +static int convert_context(struct context *oldc, struct context *newc, void *p)
>   {
>   	struct convert_context_args *args;
> -	struct context oldc;
>   	struct ocontext *oc;
> -	struct mls_range *range;
>   	struct role_datum *role;
>   	struct type_datum *typdatum;
>   	struct user_datum *usrdatum;
> @@ -1929,23 +1926,18 @@ static int convert_context(u32 key,
>   
>   	args = p;
>   
> -	if (c->str) {
> -		struct context ctx;
> -
> +	if (oldc->str) {
>   		rc = -ENOMEM;
> -		s = kstrdup(c->str, GFP_KERNEL);
> +		s = kstrdup(oldc->str, GFP_KERNEL);
>   		if (!s)
>   			goto out;
>   
>   		rc = string_to_context_struct(args->newp, NULL, s,
> -					      &ctx, SECSID_NULL);
> +					      newc, SECSID_NULL);
>   		kfree(s);
>   		if (!rc) {
>   			pr_info("SELinux:  Context %s became valid (mapped).\n",
> -			       c->str);
> -			/* Replace string with mapped representation. */
> -			kfree(c->str);
> -			memcpy(c, &ctx, sizeof(*c));
> +				oldc->str);
>   			goto out;
>   		} else if (rc == -EINVAL) {
>   			/* Retain string representation for later mapping. */
I haven't looked closely at the new sidtab implementation yet, but I was 
encountering KASAN failures in testing and noticed that they seemed to 
be tied to invalid/unmapped contexts in the filesystem.

Reproducer:
$ su
# setenforce 0
# touch foo
# setfattr -n security.selinux -v thisisnotavalidcontext foo
# ls -Z foo
# load_policy
# ls -Z foo

The issue in this case seems to be that you aren't actually retaining 
the string representation of the invalid/unmapped context across a 
reload after this patch because you never copy it to newc, e.g. replace 
the rc = 0; line with rc = context_cpy(newc, oldc); in the EINVAL case 
above.  Otherwise, you'll be left with an uninitialized newc. 
Previously we didn't have to do anything here because we were just 
leaving c (oldc) intact.

> @@ -1954,51 +1946,42 @@ static int convert_context(u32 key,
>   		} else {
>   			/* Other error condition, e.g. ENOMEM. */
>   			pr_err("SELinux:   Unable to map context %s, rc = %d.\n",
> -			       c->str, -rc);
> +			       oldc->str, -rc);
>   			goto out;
>   		}
>   	}
>   
> -	rc = context_cpy(&oldc, c);
> -	if (rc)
> -		goto out;
> +	context_init(newc);
>   
>   	/* Convert the user. */
>   	rc = -EINVAL;
>   	usrdatum = hashtab_search(args->newp->p_users.table,
> -				  sym_name(args->oldp, SYM_USERS, c->user - 1));
> +				  sym_name(args->oldp, SYM_USERS, oldc->user - 1));
>   	if (!usrdatum)
>   		goto bad;
> -	c->user = usrdatum->value;
> +	newc->user = usrdatum->value;
>   
>   	/* Convert the role. */
>   	rc = -EINVAL;
>   	role = hashtab_search(args->newp->p_roles.table,
> -			      sym_name(args->oldp, SYM_ROLES, c->role - 1));
> +			      sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
>   	if (!role)
>   		goto bad;
> -	c->role = role->value;
> +	newc->role = role->value;
>   
>   	/* Convert the type. */
>   	rc = -EINVAL;
>   	typdatum = hashtab_search(args->newp->p_types.table,
> -				  sym_name(args->oldp, SYM_TYPES, c->type - 1));
> +				  sym_name(args->oldp, SYM_TYPES, oldc->type - 1));
>   	if (!typdatum)
>   		goto bad;
> -	c->type = typdatum->value;
> +	newc->type = typdatum->value;
>   
>   	/* Convert the MLS fields if dealing with MLS policies */
>   	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
> -		rc = mls_convert_context(args->oldp, args->newp, c);
> +		rc = mls_convert_context(args->oldp, args->newp, oldc, newc);
>   		if (rc)
>   			goto bad;
> -	} else if (args->oldp->mls_enabled && !args->newp->mls_enabled) {
> -		/*
> -		 * Switching between MLS and non-MLS policy:
> -		 * free any storage used by the MLS fields in the
> -		 * context for all existing entries in the sidtab.
> -		 */
> -		mls_context_destroy(c);
>   	} else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
>   		/*
>   		 * Switching between non-MLS and MLS policy:
> @@ -2016,36 +1999,31 @@ static int convert_context(u32 key,
>   				" the initial SIDs list\n");
>   			goto bad;
>   		}
> -		range = &oc->context[0].range;
> -		rc = mls_range_set(c, range);
> +		rc = mls_range_set(newc, &oc->context[0].range);
>   		if (rc)
>   			goto bad;
>   	}
>   
>   	/* Check the validity of the new context. */
> -	if (!policydb_context_isvalid(args->newp, c)) {
> -		rc = convert_context_handle_invalid_context(args->state,
> -							    &oldc);
> +	if (!policydb_context_isvalid(args->newp, newc)) {
> +		rc = convert_context_handle_invalid_context(args->state, oldc);
>   		if (rc)
>   			goto bad;
>   	}
>   
> -	context_destroy(&oldc);
> -
>   	rc = 0;
>   out:
>   	return rc;
>   bad:
>   	/* Map old representation to string and save it. */
> -	rc = context_struct_to_string(args->oldp, &oldc, &s, &len);
> +	rc = context_struct_to_string(args->oldp, oldc, &s, &len);
>   	if (rc)
>   		return rc;
> -	context_destroy(&oldc);
> -	context_destroy(c);
> -	c->str = s;
> -	c->len = len;
> +	context_destroy(newc);
> +	newc->str = s;
> +	newc->len = len;
>   	pr_info("SELinux:  Context %s became invalid (unmapped).\n",
> -	       c->str);
> +		newc->str);
>   	rc = 0;
>   	goto out;
>   }
> @@ -2091,6 +2069,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	struct policydb *oldpolicydb, *newpolicydb;
>   	struct selinux_mapping *oldmapping;
>   	struct selinux_map newmap;
> +	struct sidtab_convert_params convert_params;
>   	struct convert_context_args args;
>   	u32 seqno;
>   	int rc = 0;
> @@ -2147,12 +2126,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		goto out;
>   	}
>   
> -	oldsidtab = state->ss->sidtab;
> -
> -#if 0
> -	sidtab_hash_eval(oldsidtab, "sids");
> -#endif
> -
>   	rc = policydb_read(newpolicydb, fp);
>   	if (rc) {
>   		kfree(newsidtab);
> @@ -2184,6 +2157,8 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		goto err;
>   	}
>   
> +	oldsidtab = state->ss->sidtab;
> +
>   	/*
>   	 * Convert the internal representations of contexts
>   	 * in the new SID table.
> @@ -2191,7 +2166,12 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	args.state = state;
>   	args.oldp = policydb;
>   	args.newp = newpolicydb;
> -	rc = sidtab_convert(oldsidtab, newsidtab, convert_context, &args);
> +
> +	convert_params.func = convert_context;
> +	convert_params.args = &args;
> +	convert_params.target = newsidtab;
> +
> +	rc = sidtab_convert(oldsidtab, &convert_params);
>   	if (rc) {
>   		pr_err("SELinux:  unable to convert the internal"
>   			" representation of contexts in the new SID"
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e157d8240cf1..a82deecfac09 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -2,88 +2,38 @@
>   /*
>    * Implementation of the SID table type.
>    *
> - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> + * Original author: Stephen Smalley, <sds@tycho.nsa.gov>
> + * Author: Ondrej Mosnacek, <omosnacek@gmail.com>
> + *
> + * Copyright (C) 2018 Red Hat, Inc.
>    */
> +#include <linux/errno.h>
>   #include <linux/kernel.h>
>   #include <linux/slab.h>
> +#include <linux/sched.h>
>   #include <linux/spinlock.h>
> -#include <linux/errno.h>
> +#include <linux/atomic.h>
>   #include "flask.h"
>   #include "security.h"
>   #include "sidtab.h"
>   
> -#define SIDTAB_HASH(sid) \
> -(sid & SIDTAB_HASH_MASK)
> -
>   int sidtab_init(struct sidtab *s)
>   {
> -	int i;
> +	u32 i;
>   
> -	s->htable = kmalloc_array(SIDTAB_SIZE, sizeof(*s->htable), GFP_ATOMIC);
> -	if (!s->htable)
> -		return -ENOMEM;
> +	memset(s->roots, 0, sizeof(s->roots));
>   
>   	for (i = 0; i < SECINITSID_NUM; i++)
>   		s->isids[i].set = 0;
>   
> -	for (i = 0; i < SIDTAB_SIZE; i++)
> -		s->htable[i] = NULL;
> +	atomic_set(&s->count, 0);
>   
> -	for (i = 0; i < SIDTAB_CACHE_LEN; i++)
> -		s->cache[i] = NULL;
> +	s->convert = NULL;
>   
> -	s->nel = 0;
> -	s->next_sid = 0;
> -	s->shutdown = 0;
>   	spin_lock_init(&s->lock);
>   	return 0;
>   }
>   
> -static int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
> -{
> -	int hvalue;
> -	struct sidtab_node *prev, *cur, *newnode;
> -
> -	if (!s)
> -		return -ENOMEM;
> -
> -	hvalue = SIDTAB_HASH(sid);
> -	prev = NULL;
> -	cur = s->htable[hvalue];
> -	while (cur && sid > cur->sid) {
> -		prev = cur;
> -		cur = cur->next;
> -	}
> -
> -	if (cur && sid == cur->sid)
> -		return -EEXIST;
> -
> -	newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
> -	if (!newnode)
> -		return -ENOMEM;
> -
> -	newnode->sid = sid;
> -	if (context_cpy(&newnode->context, context)) {
> -		kfree(newnode);
> -		return -ENOMEM;
> -	}
> -
> -	if (prev) {
> -		newnode->next = prev->next;
> -		wmb();
> -		prev->next = newnode;
> -	} else {
> -		newnode->next = s->htable[hvalue];
> -		wmb();
> -		s->htable[hvalue] = newnode;
> -	}
> -
> -	s->nel++;
> -	if (sid >= s->next_sid)
> -		s->next_sid = sid + 1;
> -	return 0;
> -}
> -
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>   {
>   	struct sidtab_isid_entry *entry;
> @@ -102,20 +52,90 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>   	return 0;
>   }
>   
> -static struct context *sidtab_lookup(struct sidtab *s, u32 sid)
> +static u32 sidtab_level_from_count(u32 count)
>   {
> -	int hvalue;
> -	struct sidtab_node *cur;
> +	u32 capacity = SIDTAB_LEAF_ENTRIES;
> +	u32 level = 0;
>   
> -	hvalue = SIDTAB_HASH(sid);
> -	cur = s->htable[hvalue];
> -	while (cur && sid > cur->sid)
> -		cur = cur->next;
> +	while (count > capacity) {
> +		capacity <<= SIDTAB_INNER_SHIFT;
> +		++level;
> +	}
> +	return level;
> +}
> +
> +static int sidtab_alloc_roots(struct sidtab *s, u32 level)
> +{
> +	u32 l;
> +
> +	if (!s->roots[0].ptr_leaf) {
> +		s->roots[0].ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
> +					       GFP_ATOMIC);
> +		if (!s->roots[0].ptr_leaf)
> +			return -ENOMEM;
> +	}
> +	for (l = 1; l <= level; ++l)
> +		if (!s->roots[l].ptr_inner) {
> +			s->roots[l].ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
> +							GFP_ATOMIC);
> +			if (!s->roots[l].ptr_inner)
> +				return -ENOMEM;
> +			s->roots[l].ptr_inner->entries[0] = s->roots[l - 1];
> +		}
> +	return 0;
> +}
>   
> -	if (!cur || sid != cur->sid)
> +static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
> +{
> +	union sidtab_entry_inner *entry;
> +	u32 level, capacity_shift, leaf_index = index / SIDTAB_LEAF_ENTRIES;
> +
> +	/* find the level of the subtree we need */
> +	level = sidtab_level_from_count(index + 1);
> +	capacity_shift = level * SIDTAB_INNER_SHIFT;
> +
> +	/* allocate roots if needed */
> +	if (alloc && sidtab_alloc_roots(s, level) != 0)
>   		return NULL;
>   
> -	return &cur->context;
> +	/* lookup inside the subtree */
> +	entry = &s->roots[level];
> +	while (level != 0) {
> +		capacity_shift -= SIDTAB_INNER_SHIFT;
> +		--level;
> +
> +		entry = &entry->ptr_inner->entries[leaf_index >> capacity_shift];
> +		leaf_index &= ((u32)1 << capacity_shift) - 1;
> +
> +		if (!entry->ptr_inner) {
> +			if (alloc)
> +				entry->ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
> +							   GFP_ATOMIC);
> +			if (!entry->ptr_inner)
> +				return NULL;
> +		}
> +	}
> +	if (!entry->ptr_leaf) {
> +		if (alloc)
> +			entry->ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
> +						  GFP_ATOMIC);
> +		if (!entry->ptr_leaf)
> +			return NULL;
> +	}
> +	return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES].context;
> +}
> +
> +static struct context *sidtab_lookup(struct sidtab *s, u32 index)
> +{
> +	u32 count = (u32)atomic_read(&s->count);
> +
> +	if (index >= count)
> +		return NULL;
> +
> +	/* read entries after reading count */
> +	smp_rmb();
> +
> +	return sidtab_do_lookup(s, index, 0);
>   }
>   
>   static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> @@ -123,7 +143,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>   	struct context *context;
>   	struct sidtab_isid_entry *entry;
>   
> -	if (!s || sid == 0)
> +	if (sid == 0)
>   		return NULL;
>   
>   	if (sid > SECINITSID_NUM) {
> @@ -149,140 +169,126 @@ struct context *sidtab_search_force(struct sidtab *s, u32 sid)
>   	return sidtab_search_core(s, sid, 1);
>   }
>   
> -static int sidtab_map(struct sidtab *s,
> -		      int (*apply)(u32 sid,
> -				   struct context *context,
> -				   void *args),
> -		      void *args)
> +static int sidtab_find_context(union sidtab_entry_inner entry,
> +			       u32 *pos, u32 count, u32 level,
> +			       struct context *context, u32 *index)
>   {
> -	int i, rc = 0;
> -	struct sidtab_node *cur;
> +	int rc;
> +	u32 i;
>   
> -	if (!s)
> -		goto out;
> +	if (level != 0) {
> +		struct sidtab_node_inner *node = entry.ptr_inner;
>   
> -	for (i = 0; i < SIDTAB_SIZE; i++) {
> -		cur = s->htable[i];
> -		while (cur) {
> -			rc = apply(cur->sid, &cur->context, args);
> -			if (rc)
> -				goto out;
> -			cur = cur->next;
> +		i = 0;
> +		while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
> +			rc = sidtab_find_context(node->entries[i],
> +						 pos, count, level - 1,
> +						 context, index);
> +			if (rc == 0)
> +				return 0;
> +			i++;
>   		}
> -	}
> -out:
> -	return rc;
> -}
> +	} else {
> +		struct sidtab_node_leaf *node = entry.ptr_leaf;
>   
> -/* Clone the SID into the new SID table. */
> -static int clone_sid(u32 sid, struct context *context, void *arg)
> -{
> -	struct sidtab *s = arg;
> -	return sidtab_insert(s, sid, context);
> +		i = 0;
> +		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
> +			if (context_cmp(&node->entries[i].context, context)) {
> +				*index = *pos;
> +				return 0;
> +			}
> +			(*pos)++;
> +			i++;
> +		}
> +	}
> +	return -ENOENT;
>   }
>   
> -int sidtab_convert(struct sidtab *s, struct sidtab *news,
> -		   int (*convert)(u32 sid,
> -				  struct context *context,
> -				  void *args),
> -		   void *args)
> +static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> +				 u32 *index)
>   {
>   	unsigned long flags;
> +	u32 count = (u32)atomic_read(&s->count);
> +	u32 count_locked, level, pos;
> +	struct sidtab_convert_params *convert;
> +	struct context *dst, *dst_convert;
>   	int rc;
>   
> -	spin_lock_irqsave(&s->lock, flags);
> -	s->shutdown = 1;
> -	spin_unlock_irqrestore(&s->lock, flags);
> +	level = sidtab_level_from_count(count);
>   
> -	rc = sidtab_map(s, clone_sid, news);
> -	if (rc)
> -		return rc;
> +	/* read entries after reading count */
> +	smp_rmb();
>   
> -	return sidtab_map(news, convert, args);
> -}
> +	pos = 0;
> +	rc = sidtab_find_context(s->roots[level], &pos, count, level,
> +				 context, index);
> +	if (rc == 0)
> +		return 0;
>   
> -static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc)
> -{
> -	BUG_ON(loc >= SIDTAB_CACHE_LEN);
> +	/* lock-free search failed: lock, re-search, and insert if not found */
> +	spin_lock_irqsave(&s->lock, flags);
>   
> -	while (loc > 0) {
> -		s->cache[loc] = s->cache[loc - 1];
> -		loc--;
> -	}
> -	s->cache[0] = n;
> -}
> +	convert = s->convert;
> +	count_locked = (u32)atomic_read(&s->count);
> +	level = sidtab_level_from_count(count_locked);
>   
> -static inline int sidtab_search_context(struct sidtab *s,
> -					struct context *context, u32 *sid)
> -{
> -	int i;
> -	struct sidtab_node *cur;
> -
> -	for (i = 0; i < SIDTAB_SIZE; i++) {
> -		cur = s->htable[i];
> -		while (cur) {
> -			if (context_cmp(&cur->context, context)) {
> -				sidtab_update_cache(s, cur, SIDTAB_CACHE_LEN - 1);
> -				*sid = cur->sid;
> -				return 0;
> -			}
> -			cur = cur->next;
> +	/* if count has changed before we acquired the lock, then catch up */
> +	while (count < count_locked) {
> +		if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
> +			rc = 0;
> +			*index = count;
> +			goto out_unlock;
>   		}
> +		++count;
>   	}
> -	return -ENOENT;
> -}
>   
> -static inline int sidtab_search_cache(struct sidtab *s, struct context *context,
> -				      u32 *sid)
> -{
> -	int i;
> -	struct sidtab_node *node;
> -
> -	for (i = 0; i < SIDTAB_CACHE_LEN; i++) {
> -		node = s->cache[i];
> -		if (unlikely(!node))
> -			return -ENOENT;
> -		if (context_cmp(&node->context, context)) {
> -			sidtab_update_cache(s, node, i);
> -			*sid = node->sid;
> -			return 0;
> -		}
> -	}
> -	return -ENOENT;
> -}
> +	/* insert context into new entry */
> +	rc = -ENOMEM;
> +	dst = sidtab_do_lookup(s, count, 1);
> +	if (!dst)
> +		goto out_unlock;
>   
> -static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> -				 u32 *sid)
> -{
> -	int ret;
> -	unsigned long flags;
> +	rc = context_cpy(dst, context);
> +	if (rc)
> +		goto out_unlock;
> +
> +	/*
> +	 * if we are building a new sidtab, we need to convert the context
> +	 * and insert it there as well
> +	 */
> +	if (convert) {
> +		rc = -ENOMEM;
> +		dst_convert = sidtab_do_lookup(convert->target, count, 1);
> +		if (!dst_convert) {
> +			context_destroy(dst);
> +			goto out_unlock;
> +		}
>   
> -	ret = sidtab_search_cache(s, context, sid);
> -	if (ret)
> -		ret = sidtab_search_context(s, context, sid);
> -	if (ret) {
> -		spin_lock_irqsave(&s->lock, flags);
> -		/* Rescan now that we hold the lock. */
> -		ret = sidtab_search_context(s, context, sid);
> -		if (!ret)
> -			goto unlock_out;
> -		/* No SID exists for the context.  Allocate a new one. */
> -		if (s->next_sid == (UINT_MAX - SECINITSID_NUM - 1) || s->shutdown) {
> -			ret = -ENOMEM;
> -			goto unlock_out;
> +		rc = convert->func(context, dst_convert, convert->args);
> +		if (rc) {
> +			context_destroy(dst);
> +			goto out_unlock;
>   		}
> -		*sid = s->next_sid++;
> -		if (context->len)
> -			pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
> -			       context->str);
> -		ret = sidtab_insert(s, *sid, context);
> -		if (ret)
> -			s->next_sid--;
> -unlock_out:
> -		spin_unlock_irqrestore(&s->lock, flags);
> +
> +		/* at this point we know the insert won't fail */
> +		atomic_set(&convert->target->count, count + 1);
>   	}
>   
> -	return ret;
> +	if (context->len)
> +		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
> +			context->str);
> +
> +	*index = count;
> +
> +	/* write entries before writing new count */
> +	smp_wmb();
> +
> +	atomic_set(&s->count, count + 1);
> +
> +	rc = 0;
> +out_unlock:
> +	spin_unlock_irqrestore(&s->lock, flags);
> +	return rc;
>   }
>   
>   int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
> @@ -306,58 +312,134 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
>   	return 0;
>   }
>   
> -void sidtab_hash_eval(struct sidtab *h, char *tag)
> +static int sidtab_convert_tree(union sidtab_entry_inner *edst,
> +			       union sidtab_entry_inner *esrc,
> +			       u32 *pos, u32 count, u32 level,
> +			       struct sidtab_convert_params *convert)
>   {
> -	int i, chain_len, slots_used, max_chain_len;
> -	struct sidtab_node *cur;
> -
> -	slots_used = 0;
> -	max_chain_len = 0;
> -	for (i = 0; i < SIDTAB_SIZE; i++) {
> -		cur = h->htable[i];
> -		if (cur) {
> -			slots_used++;
> -			chain_len = 0;
> -			while (cur) {
> -				chain_len++;
> -				cur = cur->next;
> -			}
> +	int rc;
> +	u32 i;
>   
> -			if (chain_len > max_chain_len)
> -				max_chain_len = chain_len;
> +	if (level != 0) {
> +		if (!edst->ptr_inner) {
> +			edst->ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_KERNEL);
> +			if (!edst->ptr_inner)
> +				return -ENOMEM;
> +		}
> +		i = 0;
> +		while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
> +			rc = sidtab_convert_tree(&edst->ptr_inner->entries[i],
> +						 &esrc->ptr_inner->entries[i],
> +						 pos, count, level - 1, convert);
> +			if (rc)
> +				return rc;
> +			i++;
>   		}
> +	} else {
> +		if (!edst->ptr_leaf) {
> +			edst->ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE, GFP_KERNEL);
> +			if (!edst->ptr_leaf)
> +				return -ENOMEM;
> +		}
> +		i = 0;
> +		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
> +			rc = convert->func(&esrc->ptr_leaf->entries[i].context,
> +					   &edst->ptr_leaf->entries[i].context,
> +					   convert->args);
> +			if (rc)
> +				return rc;
> +			(*pos)++;
> +			i++;
> +		}
> +		cond_resched();
> +	}
> +	return 0;
> +}
> +
> +int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
> +{
> +	unsigned long flags;
> +	u32 count, level, pos;
> +	int rc;
> +
> +	spin_lock_irqsave(&s->lock, flags);
> +
> +	/* concurrent policy loads are not allowed */
> +	if (s->convert) {
> +		spin_unlock_irqrestore(&s->lock, flags);
> +		return -EBUSY;
> +	}
> +
> +	count = (u32)atomic_read(&s->count);
> +	level = sidtab_level_from_count(count);
> +
> +	/* allocate last leaf in the new sidtab (to avoid race with live convert) */
> +	rc = sidtab_do_lookup(params->target, count - 1, 1) ? 0 : -ENOMEM;
> +	if (rc) {
> +		spin_unlock_irqrestore(&s->lock, flags);
> +		return rc;
> +	}
> +
> +	/* set count in case no new entries are added during conversion */
> +	atomic_set(&params->target->count, count);
> +
> +	/* enable live convert of new entries */
> +	s->convert = params;
> +
> +	/* we can safely do the rest of the conversion outside the lock */
> +	spin_unlock_irqrestore(&s->lock, flags);
> +
> +	pr_info("SELinux:  Converting %u SID table entries...\n", count);
> +
> +	/* convert all entries not covered by live convert */
> +	pos = 0;
> +	rc = sidtab_convert_tree(&params->target->roots[level], &s->roots[level],
> +				 &pos, count, level, params);
> +	if (rc) {
> +		/* we need to keep the old table - disable live convert */
> +		spin_lock_irqsave(&s->lock, flags);
> +		s->convert = NULL;
> +		spin_unlock_irqrestore(&s->lock, flags);
>   	}
> +	return rc;
> +}
> +
> +static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
> +{
> +	u32 i;
> +
> +	if (level != 0) {
> +		struct sidtab_node_inner *node = entry.ptr_inner;
>   
> -	pr_debug("%s:  %d entries and %d/%d buckets used, longest "
> -	       "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
> -	       max_chain_len);
> +		if (!node)
> +			return;
> +
> +		for (i = 0; i < SIDTAB_INNER_ENTRIES; i++)
> +			sidtab_destroy_tree(node->entries[i], level - 1);
> +		kfree(node);
> +	} else {
> +		struct sidtab_node_leaf *node = entry.ptr_leaf;
> +
> +		if (!node)
> +			return;
> +
> +		for (i = 0; i < SIDTAB_LEAF_ENTRIES; i++)
> +			context_destroy(&node->entries[i].context);
> +		kfree(node);
> +	}
>   }
>   
>   void sidtab_destroy(struct sidtab *s)
>   {
> -	int i;
> -	struct sidtab_node *cur, *temp;
> -
> -	if (!s)
> -		return;
> +	u32 i, level;
>   
>   	for (i = 0; i < SECINITSID_NUM; i++)
>   		if (s->isids[i].set)
>   			context_destroy(&s->isids[i].context);
>   
> +	level = SIDTAB_MAX_LEVEL;
> +	while (level && !s->roots[level].ptr_inner)
> +		--level;
>   
> -	for (i = 0; i < SIDTAB_SIZE; i++) {
> -		cur = s->htable[i];
> -		while (cur) {
> -			temp = cur;
> -			cur = cur->next;
> -			context_destroy(&temp->context);
> -			kfree(temp);
> -		}
> -		s->htable[i] = NULL;
> -	}
> -	kfree(s->htable);
> -	s->htable = NULL;
> -	s->nel = 0;
> -	s->next_sid = 1;
> +	sidtab_destroy_tree(s->roots[level], level);
>   }
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index e657ae6bf996..292512792a70 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -1,39 +1,75 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * A security identifier table (sidtab) is a hash table
> + * A security identifier table (sidtab) is a lookup table
>    * of security context structures indexed by SID value.
>    *
> - * Author : Stephen Smalley, <sds@tycho.nsa.gov>
> + * Original author: Stephen Smalley, <sds@tycho.nsa.gov>
> + * Author: Ondrej Mosnacek, <omosnacek@gmail.com>
> + *
> + * Copyright (C) 2018 Red Hat, Inc.
>    */
>   #ifndef _SS_SIDTAB_H_
>   #define _SS_SIDTAB_H_
>   
> +#include <linux/spinlock_types.h>
> +#include <linux/log2.h>
> +
>   #include "context.h"
>   
> -struct sidtab_node {
> -	u32 sid;		/* security identifier */
> -	struct context context;	/* security context structure */
> -	struct sidtab_node *next;
> +struct sidtab_entry_leaf {
> +	struct context context;
> +};
> +
> +struct sidtab_node_inner;
> +struct sidtab_node_leaf;
> +
> +union sidtab_entry_inner {
> +	struct sidtab_node_inner *ptr_inner;
> +	struct sidtab_node_leaf  *ptr_leaf;
>   };
>   
> -#define SIDTAB_HASH_BITS 7
> -#define SIDTAB_HASH_BUCKETS (1 << SIDTAB_HASH_BITS)
> -#define SIDTAB_HASH_MASK (SIDTAB_HASH_BUCKETS-1)
> +/* align node size to page boundary */
> +#define SIDTAB_NODE_ALLOC_SHIFT PAGE_SHIFT
> +#define SIDTAB_NODE_ALLOC_SIZE  PAGE_SIZE
> +
> +#define size_to_shift(size) ((size) == 1 ? 1 : (const_ilog2((size) - 1) + 1))
> +
> +#define SIDTAB_INNER_SHIFT \
> +	(SIDTAB_NODE_ALLOC_SHIFT - size_to_shift(sizeof(union sidtab_entry_inner)))
>   
> -#define SIDTAB_SIZE SIDTAB_HASH_BUCKETS
> +#define SIDTAB_LEAF_ENTRIES  (PAGE_SIZE / sizeof(struct sidtab_entry_leaf))
> +#define SIDTAB_INNER_ENTRIES ((size_t)1 << SIDTAB_INNER_SHIFT)
> +
> +#define SIDTAB_MAX_BITS 31 /* limited to INT_MAX due to atomic_t range */
> +#define SIDTAB_MAX (((u32)1 << SIDTAB_MAX_BITS) - 1)
> +/* ensure enough tree levels for SIDTAB_MAX entries */
> +#define SIDTAB_MAX_LEVEL \
> +	DIV_ROUND_UP(SIDTAB_MAX_BITS - size_to_shift(SIDTAB_LEAF_ENTRIES), \
> +		     SIDTAB_INNER_SHIFT)
> +
> +struct sidtab_node_leaf {
> +	struct sidtab_entry_leaf entries[SIDTAB_LEAF_ENTRIES];
> +};
> +
> +struct sidtab_node_inner {
> +	union sidtab_entry_inner entries[SIDTAB_INNER_ENTRIES];
> +};
>   
>   struct sidtab_isid_entry {
>   	int set;
>   	struct context context;
>   };
>   
> +struct sidtab_convert_params {
> +	int (*func)(struct context *oldc, struct context *newc, void *args);
> +	void *args;
> +	struct sidtab *target;
> +};
> +
>   struct sidtab {
> -	struct sidtab_node **htable;
> -	unsigned int nel;	/* number of elements */
> -	unsigned int next_sid;	/* next SID to allocate */
> -	unsigned char shutdown;
> -#define SIDTAB_CACHE_LEN	3
> -	struct sidtab_node *cache[SIDTAB_CACHE_LEN];
> +	union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
> +	atomic_t count;
> +	struct sidtab_convert_params *convert;
>   	spinlock_t lock;
>   
>   	/* index == SID - 1 (no entry for SECSID_NULL) */
> @@ -45,15 +81,10 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context);
>   struct context *sidtab_search(struct sidtab *s, u32 sid);
>   struct context *sidtab_search_force(struct sidtab *s, u32 sid);
>   
> -int sidtab_convert(struct sidtab *s, struct sidtab *news,
> -		   int (*apply)(u32 sid,
> -				struct context *context,
> -				void *args),
> -		   void *args);
> +int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
>   
>   int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
>   
> -void sidtab_hash_eval(struct sidtab *h, char *tag);
>   void sidtab_destroy(struct sidtab *s);
>   
>   #endif	/* _SS_SIDTAB_H_ */
> 

