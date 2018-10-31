Return-Path: <SRS0=k0zu=NL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D8ECDE44
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 17:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C352080A
	for <selinux@archiver.kernel.org>; Wed, 31 Oct 2018 17:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C352080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeKACI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:08:59 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:47254 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbeKACI7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Oct 2018 22:08:59 -0400
X-EEMSG-check-008: 651313829|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,447,1534809600"; 
   d="scan'208";a="651313829"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Oct 2018 17:09:41 +0000
X-IronPort-AV: E=Sophos;i="5.54,447,1534809600"; 
   d="scan'208";a="17410304"
IronPort-PHdr: =?us-ascii?q?9a23=3AkTEh7B+wvbMTL/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21e8cTK2v8tzYMVDF4r011RmVBdqds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+55/ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRz?=
 =?us-ascii?q?ut86ZrSAfpiCgZMT457HrXgdF0gK5CvR6tuwBzz4vSbY6bLvp+er7Wc80cS2?=
 =?us-ascii?q?RPQ81dUzVNDp2gY4cKCecKIORWoJTnp1YWsBWwGwesCuPsxDFGiHD50q813P?=
 =?us-ascii?q?guHwzdwAwtHcgDvGjIoNj7NqofV/2+wqnSzTXEavNbwSrz6JTWfRA5ofGDQ7?=
 =?us-ascii?q?RwetfMx0kqDQzFilGQppLlPjiI0ekNqHWU7/F7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRk1jYdO8DZdduC6XO5F2T88/WW1kpik3xqMctZ?=
 =?us-ascii?q?KmeiUB1Y4pyATFa/OddoiF+hfjVOGMLjhmnH9lY7e/hwqq8Uin1+38StG40F?=
 =?us-ascii?q?ZUoSpBldnBrmwN2AbJ6siGV/t95V2t2SqP1g/P6uFEJlo4lazHJJ463rE8jJ?=
 =?us-ascii?q?8TsUXHHiPumUX2irGZdlk89+S15Onqba/qq5+BO4NulA3zPboiltaiDeggNw?=
 =?us-ascii?q?gBRWmb+eCy1L35+k35Ra1HjuYrnanCq53aOcQaqbK5Aw9SyIoj7Q2/AC283N?=
 =?us-ascii?q?QXmnkHMkpJeAibgIjxJ1HOPPf4AO+4g1Splzdr3PbGMaf9DZrTNXXDiqnucq?=
 =?us-ascii?q?t960FG1Ao/18xQ55VRCrsZOvL8RlfxtMDEDh8+KwG02PjoCNF81oMYRGKODb?=
 =?us-ascii?q?SUML3dsVCW/OIjOeqMa5EPuDb7Nfcl4+TijXgjmV8SZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWLsjc0cEWcOpQc+VPbliECGUTJKYnayWKU85islB468EYjDQYWt0/S923?=
 =?us-ascii?q?KcGJFMa2IOL1eXF37jeobMD/AJbzmUK8RsuiYJWbioV8kq0hT48Efhxr5mKP?=
 =?us-ascii?q?fE0jMXuIil19Vv4eDX0xYo+ng8N82A1ymoSGZukytcXzYr2IhnqFF5j1KE1r?=
 =?us-ascii?q?J1xfdfEIoAyelOV1IBKZPEz+F8Q+v3UwbFc8bBHE2qWf26EDoxSZQ32NZIbE?=
 =?us-ascii?q?FjTYbxxivf1janVudG34eAA4Y5p+eFhSD8?=
X-IPAS-Result: =?us-ascii?q?A2A6AADi4Nlb/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKoFlKIN2lHYBAQEDBoEQJYkPkBI4AYRAAoM3IjcKDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII2JAGCXwEBAQECARoBCAQRQQULCw4KAgImAgJXBgEMBgIBAYJeP4F1B?=
 =?us-ascii?q?QioUHszhTyEaIELil4XeYEHgREnDIJfhGiDGoJXAokCBIVqQ49sCYoPhnUGG?=
 =?us-ascii?q?IFUiBWGZok9j00iQYEUKwgCGAghD4MngiYXjjYjMIEFAQGISyqCIwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Oct 2018 17:09:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9VH9dUH012481;
        Wed, 31 Oct 2018 13:09:39 -0400
Subject: Re: [PATCH 1/2] selinux: use separate table for initial SID lookup
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov
References: <20181031122718.18735-1-omosnace@redhat.com>
 <20181031122718.18735-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0d74125f-35bd-4713-3dfd-b15dfc9e731a@tycho.nsa.gov>
Date:   Wed, 31 Oct 2018 13:12:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031122718.18735-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/31/2018 08:27 AM, Ondrej Mosnacek wrote:
> This patch separates the lookup of the initial SIDs into a separate
> lookup table (implemented simply by a fixed-size array), in order to
> pave the way for improving the process of converting the sidtab to a new
> policy during a policy reload.
> 
> The initial SIDs are loaded directly and are skipped during sidtab
> conversion, so handling them separately makes things somewhat simpler.
> Since there is only a small fixed number of them, they can be stored in
> a simple lookup table.
> 
> This patch also moves the fallback-to-unlabeled logic from sidtab.c to
> the new helper functions in services.c that now handle the unified
> lookup in both sidtab and isidtab, simplifying the sidtab interface.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/include/security.h |   3 +
>   security/selinux/ss/mls.c           |   6 +-
>   security/selinux/ss/mls.h           |   2 +-
>   security/selinux/ss/policydb.c      |  24 ++-
>   security/selinux/ss/policydb.h      |  26 ++-
>   security/selinux/ss/services.c      | 238 +++++++++++++++-------------
>   security/selinux/ss/services.h      |   1 +
>   security/selinux/ss/sidtab.c        |  29 +---
>   security/selinux/ss/sidtab.h        |   3 +-
>   9 files changed, 187 insertions(+), 145 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 23e762d529fa..a1b4b13c2300 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -221,6 +221,9 @@ struct extended_perms {
>   /* definitions of av_decision.flags */
>   #define AVD_FLAGS_PERMISSIVE	0x0001
>   
> +struct context *security_sid_to_context_struct(struct selinux_state *state,
> +					       u32 sid, int force);

This header is for interfaces exposed by the security server (i.e. the 
policy engine) to the AVC, hooks, and other policy enforcement code. The 
context structure is private to the security server in order to 
encapsulate the policy logic and should never be returned directly to 
code outside of the security server.  Technically you aren't actually 
exposing the structure definition but this interface isn't useful 
without doing so, so it shouldn't live here.

You could make this a services_sid_to_context_struct() interface defined 
in security/selinux/ss/services.h instead.  Or you could keep all of 
this within the sidtab, just making the isidtab part of its internal 
state, and moving this logic inside of sidtab_search() instead of 
splitting it out.

> +
>   void security_compute_av(struct selinux_state *state,
>   			 u32 ssid, u32 tsid,
>   			 u16 tclass, struct av_decision *avd,
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index 2fe459df3c85..cd637ee3fb11 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -235,7 +235,7 @@ int mls_context_to_sid(struct policydb *pol,
>   		       char oldc,
>   		       char *scontext,
>   		       struct context *context,
> -		       struct sidtab *s,
> +		       struct selinux_state *state,
>   		       u32 def_sid)
>   {
>   	char *sensitivity, *cur_cat, *next_cat, *rngptr;
> @@ -257,10 +257,10 @@ int mls_context_to_sid(struct policydb *pol,
>   	if (!oldc) {
>   		struct context *defcon;
>   
> -		if (def_sid == SECSID_NULL)
> +		if (def_sid == SECSID_NULL || state == NULL)

When can state be legitimately NULL here?

>   			return -EINVAL;
>   
> -		defcon = sidtab_search(s, def_sid);
> +		defcon = security_sid_to_context_struct(state, def_sid, 0);
>   		if (!defcon)
>   			return -EINVAL;
>   
> diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> index 67093647576d..1eca02c8bc5f 100644
> --- a/security/selinux/ss/mls.h
> +++ b/security/selinux/ss/mls.h
> @@ -36,7 +36,7 @@ int mls_context_to_sid(struct policydb *p,
>   		       char oldc,
>   		       char *scontext,
>   		       struct context *context,
> -		       struct sidtab *s,
> +		       struct selinux_state *state,
>   		       u32 def_sid);
>   
>   int mls_from_string(struct policydb *p, char *str, struct context *context,
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f4eadd3f7350..8f7cd5f6e033 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -892,16 +892,12 @@ void policydb_destroy(struct policydb *p)
>    * Load the initial SIDs specified in a policy database
>    * structure into a SID table.
>    */
> -int policydb_load_isids(struct policydb *p, struct sidtab *s)
> +int policydb_load_isids(struct policydb *p, struct isidtab *s)
>   {
>   	struct ocontext *head, *c;
>   	int rc;
>   
> -	rc = sidtab_init(s);
> -	if (rc) {
> -		pr_err("SELinux:  out of memory on SID table init\n");
> -		goto out;
> -	}
> +	isidtab_init(s);
>   
>   	head = p->ocontexts[OCON_ISID];
>   	for (c = head; c; c = c->next) {
> @@ -911,16 +907,30 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>   				c->u.name);
>   			goto out;
>   		}
> +		if (c->sid[0] > SECINITSID_NUM) {
> +			pr_err("SELinux:  Initial SID %u out of range.\n",
> +				(unsigned)c->sid[0]);

Does it really complain w/o the cast?  It is a u32.

> +			goto out;
> +		}
> +		if (s->entries[c->sid[0]].set) {
> +			pr_err("SELinux:  Duplicit initial SID %u.\n",
> +				(unsigned)c->sid[0]);
> +			goto out;
> +		}
>   
> -		rc = sidtab_insert(s, c->sid[0], &c->context[0]);
> +		rc = context_cpy(&s->entries[c->sid[0]].context, &c->context[0]);
>   		if (rc) {
>   			pr_err("SELinux:  unable to load initial SID %s.\n",
>   				c->u.name);
>   			goto out;
>   		}
> +
> +		s->entries[c->sid[0]].set = 1;

This would be nicer to read if you just set unsigned sid = c->sid[0]; 
and used sid thereafter.

>   	}
>   	rc = 0;
>   out:
> +	if (rc != 0)
> +		isidtab_destroy(s);
>   	return rc;
>   }
>   
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 215f8f30ac5a..0e246bc45c72 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -312,8 +312,32 @@ struct policydb {
>   	u32 process_trans_perms;
>   };
>   
> +struct isidtab_entry {
> +	int set;
> +	struct context context;
> +};
> +
> +struct isidtab {
> +	struct isidtab_entry entries[SECINITSID_NUM + 1];

SID 0 aka SECSID_NULL is never valid, so you are wasting an array entry 
currently.

> +};
> +
> +static inline void isidtab_init(struct isidtab *t)
> +{
> +	u32 i;
> +	for (i = 0; i <= SECINITSID_NUM; i++)
> +		t->entries[i].set = 0;
> +}
> +
> +static inline void isidtab_destroy(struct isidtab *t)
> +{
> +	u32 i;
> +	for (i = 0; i <= SECINITSID_NUM; i++)
> +		if (t->entries[i].set)
> +			context_destroy(&t->entries[i].context);
> +}
> +
>   extern void policydb_destroy(struct policydb *p);
> -extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
> +extern int policydb_load_isids(struct policydb *p, struct isidtab *s);
>   extern int policydb_context_isvalid(struct policydb *p, struct context *c);
>   extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
>   extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 12e414394530..550a00004139 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -89,6 +89,42 @@ void selinux_ss_init(struct selinux_ss **ss)
>   	*ss = &selinux_ss;
>   }
>   
> +struct context *security_sid_to_context_struct(struct selinux_state *state,
> +					       u32 sid, int force)
> +{
> +	struct isidtab *isidtab = state->ss->isidtab;
> +	struct sidtab *sidtab = &state->ss->sidtab;
> +
> +	if (sid <= SECINITSID_NUM) {
> +		if (isidtab->entries[sid].set)
> +			return &isidtab->entries[sid].context;
> +	} else {
> +		struct context *context = sidtab_lookup(sidtab, sid);
> +		if (context && (!context->len || force))
> +			return context;
> +	}
> +	if (isidtab->entries[SECINITSID_UNLABELED].set)
> +		return &isidtab->entries[SECINITSID_UNLABELED].context;
> +	return NULL;
> +}
> +
> +static int security_context_struct_to_sid(struct selinux_state *state,
> +					  struct context *context, u32 *sid)
> +{
> +	struct isidtab *isidtab = state->ss->isidtab;
> +	struct sidtab *sidtab = &state->ss->sidtab;
> +	u32 i;
> +
> +	for (i = 0; i <= SECINITSID_NUM; i++)
> +		if (isidtab->entries[i].set &&
> +		    context_cmp(context, &isidtab->entries[i].context)) {
> +			*sid = i;
> +			return 0;
> +		}
> +
> +	return sidtab_context_to_sid(sidtab, context, sid);
> +}

What's the motivation for keeping the isidtab external to the sidtab, 
and introducing another layer of functions, as opposed to just making it 
an extra part of the sidtab state and having sidtab_search and 
sidtab_context_to_sid check it first?  The only caveat to your approach 
is that we have to make sure that no one ever calls sidtab_lookup or 
sidtab_context_to_sid with an initial SID/context.  I guess all users 
are localized to services.c so that isn't too onerous. Not saying it has 
to change, but just noting it.

> +
>   /* Forward declaration. */
>   static int context_struct_to_string(struct policydb *policydb,
>   				    struct context *context,
> @@ -760,7 +796,6 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   					  u16 orig_tclass, bool user)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct context *ocontext;
>   	struct context *ncontext;
>   	struct context *tcontext;
> @@ -776,7 +811,6 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	if (!user)
>   		tclass = unmap_class(&state->ss->map, orig_tclass);
> @@ -789,7 +823,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   	}
>   	tclass_datum = policydb->class_val_to_struct[tclass - 1];
>   
> -	ocontext = sidtab_search(sidtab, oldsid);
> +	ocontext = security_sid_to_context_struct(state, oldsid, 0);
>   	if (!ocontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, oldsid);
> @@ -797,7 +831,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   		goto out;
>   	}
>   
> -	ncontext = sidtab_search(sidtab, newsid);
> +	ncontext = security_sid_to_context_struct(state, newsid, 0);
>   	if (!ncontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, newsid);
> @@ -805,7 +839,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>   		goto out;
>   	}
>   
> -	tcontext = sidtab_search(sidtab, tasksid);
> +	tcontext = security_sid_to_context_struct(state, tasksid, 0);
>   	if (!tcontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, tasksid);
> @@ -864,7 +898,6 @@ int security_bounded_transition(struct selinux_state *state,
>   				u32 old_sid, u32 new_sid)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct context *old_context, *new_context;
>   	struct type_datum *type;
>   	int index;
> @@ -876,10 +909,9 @@ int security_bounded_transition(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	rc = -EINVAL;
> -	old_context = sidtab_search(sidtab, old_sid);
> +	old_context = security_sid_to_context_struct(state, old_sid, 0);
>   	if (!old_context) {
>   		pr_err("SELinux: %s: unrecognized SID %u\n",
>   		       __func__, old_sid);
> @@ -887,7 +919,7 @@ int security_bounded_transition(struct selinux_state *state,
>   	}
>   
>   	rc = -EINVAL;
> -	new_context = sidtab_search(sidtab, new_sid);
> +	new_context = security_sid_to_context_struct(state, new_sid, 0);
>   	if (!new_context) {
>   		pr_err("SELinux: %s: unrecognized SID %u\n",
>   		       __func__, new_sid);
> @@ -1014,7 +1046,6 @@ void security_compute_xperms_decision(struct selinux_state *state,
>   				      struct extended_perms_decision *xpermd)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	u16 tclass;
>   	struct context *scontext, *tcontext;
>   	struct avtab_key avkey;
> @@ -1034,16 +1065,15 @@ void security_compute_xperms_decision(struct selinux_state *state,
>   		goto allow;
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
> -	scontext = sidtab_search(sidtab, ssid);
> +	scontext = security_sid_to_context_struct(state, ssid, 0);
>   	if (!scontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, ssid);
>   		goto out;
>   	}
>   
> -	tcontext = sidtab_search(sidtab, tsid);
> +	tcontext = security_sid_to_context_struct(state, tsid, 0);
>   	if (!tcontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, tsid);
> @@ -1112,7 +1142,6 @@ void security_compute_av(struct selinux_state *state,
>   			 struct extended_perms *xperms)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	u16 tclass;
>   	struct context *scontext = NULL, *tcontext = NULL;
>   
> @@ -1123,9 +1152,8 @@ void security_compute_av(struct selinux_state *state,
>   		goto allow;
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
> -	scontext = sidtab_search(sidtab, ssid);
> +	scontext = security_sid_to_context_struct(state, ssid, 0);
>   	if (!scontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, ssid);
> @@ -1136,7 +1164,7 @@ void security_compute_av(struct selinux_state *state,
>   	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
>   		avd->flags |= AVD_FLAGS_PERMISSIVE;
>   
> -	tcontext = sidtab_search(sidtab, tsid);
> +	tcontext = security_sid_to_context_struct(state, tsid, 0);
>   	if (!tcontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, tsid);
> @@ -1168,7 +1196,6 @@ void security_compute_av_user(struct selinux_state *state,
>   			      struct av_decision *avd)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct context *scontext = NULL, *tcontext = NULL;
>   
>   	read_lock(&state->ss->policy_rwlock);
> @@ -1177,9 +1204,8 @@ void security_compute_av_user(struct selinux_state *state,
>   		goto allow;
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
> -	scontext = sidtab_search(sidtab, ssid);
> +	scontext = security_sid_to_context_struct(state, ssid, 0);
>   	if (!scontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, ssid);
> @@ -1190,7 +1216,7 @@ void security_compute_av_user(struct selinux_state *state,
>   	if (ebitmap_get_bit(&policydb->permissive_map, scontext->type))
>   		avd->flags |= AVD_FLAGS_PERMISSIVE;
>   
> -	tcontext = sidtab_search(sidtab, tsid);
> +	tcontext = security_sid_to_context_struct(state, tsid, 0);
>   	if (!tcontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, tsid);
> @@ -1284,7 +1310,6 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   					u32 *scontext_len, int force)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct context *context;
>   	int rc = 0;
>   
> @@ -1315,11 +1340,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   	}
>   	read_lock(&state->ss->policy_rwlock);
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> -	if (force)
> -		context = sidtab_search_force(sidtab, sid);
> -	else
> -		context = sidtab_search(sidtab, sid);
> +	context = security_sid_to_context_struct(state, sid, force);
>   	if (!context) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, sid);
> @@ -1363,7 +1384,7 @@ int security_sid_to_context_force(struct selinux_state *state, u32 sid,
>    * Caveat:  Mutates scontext.
>    */
>   static int string_to_context_struct(struct policydb *pol,
> -				    struct sidtab *sidtabp,
> +				    struct selinux_state *state,
>   				    char *scontext,
>   				    struct context *ctx,
>   				    u32 def_sid)
> @@ -1425,7 +1446,7 @@ static int string_to_context_struct(struct policydb *pol,
>   
>   	ctx->type = typdatum->value;
>   
> -	rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> +	rc = mls_context_to_sid(pol, oldc, p, ctx, state, def_sid);
>   	if (rc)
>   		goto out;
>   
> @@ -1446,7 +1467,6 @@ static int security_context_to_sid_core(struct selinux_state *state,
>   					int force)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	char *scontext2, *str = NULL;
>   	struct context context;
>   	int rc = 0;
> @@ -1483,16 +1503,17 @@ static int security_context_to_sid_core(struct selinux_state *state,
>   	}
>   	read_lock(&state->ss->policy_rwlock);
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> -	rc = string_to_context_struct(policydb, sidtab, scontext2,
> +
> +	rc = string_to_context_struct(policydb, state, scontext2,
>   				      &context, def_sid);
> +
>   	if (rc == -EINVAL && force) {
>   		context.str = str;
>   		context.len = strlen(str) + 1;
>   		str = NULL;
>   	} else if (rc)
>   		goto out_unlock;
> -	rc = sidtab_context_to_sid(sidtab, &context, sid);
> +	rc = security_context_struct_to_sid(state, &context, sid);
>   	context_destroy(&context);
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
> @@ -1631,7 +1652,6 @@ static int security_compute_sid(struct selinux_state *state,
>   				bool kern)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct class_datum *cladatum = NULL;
>   	struct context *scontext = NULL, *tcontext = NULL, newcontext;
>   	struct role_trans *roletr = NULL;
> @@ -1668,16 +1688,15 @@ static int security_compute_sid(struct selinux_state *state,
>   	}
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
> -	scontext = sidtab_search(sidtab, ssid);
> +	scontext = security_sid_to_context_struct(state, ssid, 0);
>   	if (!scontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, ssid);
>   		rc = -EINVAL;
>   		goto out_unlock;
>   	}
> -	tcontext = sidtab_search(sidtab, tsid);
> +	tcontext = security_sid_to_context_struct(state, tsid, 0);
>   	if (!tcontext) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, tsid);
> @@ -1793,7 +1812,7 @@ static int security_compute_sid(struct selinux_state *state,
>   			goto out_unlock;
>   	}
>   	/* Obtain the sid for the context. */
> -	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> +	rc = security_context_struct_to_sid(state, &newcontext, out_sid);
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
>   	context_destroy(&newcontext);
> @@ -1881,16 +1900,9 @@ int security_change_sid(struct selinux_state *state,
>   }
>   
>   /* Clone the SID into the new SID table. */
> -static int clone_sid(u32 sid,
> -		     struct context *context,
> -		     void *arg)
> +static int clone_sid(u32 sid, struct context *context, void *arg)
>   {
> -	struct sidtab *s = arg;
> -
> -	if (sid > SECINITSID_NUM)
> -		return sidtab_insert(s, sid, context);
> -	else
> -		return 0;
> +	return sidtab_insert((struct sidtab *)arg, sid, context);
>   }
>   
>   static inline int convert_context_handle_invalid_context(
> @@ -1925,9 +1937,7 @@ struct convert_context_args {
>    * in the policy `p->newp'.  Verify that the
>    * context is valid under the new policy.
>    */
> -static int convert_context(u32 key,
> -			   struct context *c,
> -			   void *p)
> +static int convert_context(u32 key, struct context *c, void *p)
>   {
>   	struct convert_context_args *args;
>   	struct context oldc;
> @@ -1938,10 +1948,7 @@ static int convert_context(u32 key,
>   	struct user_datum *usrdatum;
>   	char *s;
>   	u32 len;
> -	int rc = 0;
> -
> -	if (key <= SECINITSID_NUM)
> -		goto out;
> +	int rc;
>   
>   	args = p;
>   
> @@ -2104,6 +2111,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   {
>   	struct policydb *policydb;
>   	struct sidtab *sidtab;
> +	struct isidtab *newisidtab = NULL;
>   	struct policydb *oldpolicydb, *newpolicydb;
>   	struct sidtab oldsidtab, newsidtab;
>   	struct selinux_mapping *oldmapping;
> @@ -2120,6 +2128,12 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	}
>   	newpolicydb = oldpolicydb + 1;
>   
> +	newisidtab = kmalloc(sizeof(*newisidtab), GFP_KERNEL);
> +	if (!newisidtab) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
>   	policydb = &state->ss->policydb;
>   	sidtab = &state->ss->sidtab;
>   
> @@ -2128,20 +2142,31 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		if (rc)
>   			goto out;
>   
> +		rc = sidtab_init(sidtab);
> +		if (rc) {
> +			policydb_destroy(policydb);
> +			goto out;
> +		}
> +
>   		policydb->len = len;
>   		rc = selinux_set_mapping(policydb, secclass_map,
>   					 &state->ss->map);
>   		if (rc) {
> +			sidtab_destroy(sidtab);
>   			policydb_destroy(policydb);
>   			goto out;
>   		}
>   
> -		rc = policydb_load_isids(policydb, sidtab);
> +		rc = policydb_load_isids(policydb, newisidtab);
>   		if (rc) {
> +			sidtab_destroy(sidtab);
>   			policydb_destroy(policydb);
>   			goto out;
>   		}
>   
> +		state->ss->isidtab = newisidtab;
> +		newisidtab = NULL; /* do not free new isidtab */
> +
>   		security_load_policycaps(state);
>   		state->initialized = 1;
>   		seqno = ++state->ss->latest_granting;
> @@ -2162,6 +2187,12 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	if (rc)
>   		goto out;
>   
> +	rc = sidtab_init(&newsidtab);
> +	if (rc) {
> +		policydb_destroy(newpolicydb);
> +		goto out;
> +	}
> +
>   	newpolicydb->len = len;
>   	/* If switching between different policy types, log MLS status */
>   	if (policydb->mls_enabled && !newpolicydb->mls_enabled)
> @@ -2169,9 +2200,10 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
>   		pr_info("SELinux: Enabling MLS support...\n");
>   
> -	rc = policydb_load_isids(newpolicydb, &newsidtab);
> +	rc = policydb_load_isids(newpolicydb, newisidtab);
>   	if (rc) {
>   		pr_err("SELinux:  unable to load the initial SIDs\n");
> +		sidtab_destroy(&newsidtab);
>   		policydb_destroy(newpolicydb);
>   		goto out;
>   	}
> @@ -2214,13 +2246,21 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   
>   	/* Install the new policydb and SID table. */
>   	write_lock_irq(&state->ss->policy_rwlock);
> +
>   	memcpy(policydb, newpolicydb, sizeof(*policydb));
>   	sidtab_set(sidtab, &newsidtab);
> +
> +	isidtab_destroy(state->ss->isidtab);
> +	kfree(state->ss->isidtab);
> +	state->ss->isidtab = newisidtab;
> +	newisidtab = NULL;
> +

Any particular reason we don't just save the old isidtab to a temporary 
variable and defer freeing of it until after we are out of the critical 
section?  Eventually we want to turn this into a single pointer update 
and seqno increment.

>   	security_load_policycaps(state);
>   	oldmapping = state->ss->map.mapping;
>   	state->ss->map.mapping = newmap.mapping;
>   	state->ss->map.size = newmap.size;
>   	seqno = ++state->ss->latest_granting;
> +
>   	write_unlock_irq(&state->ss->policy_rwlock);
>   
>   	/* Free the old policydb and SID table. */
> @@ -2241,8 +2281,10 @@ err:
>   	kfree(newmap.mapping);
>   	sidtab_destroy(&newsidtab);
>   	policydb_destroy(newpolicydb);
> +	isidtab_destroy(newisidtab);
>   
>   out:
> +	kfree(newisidtab);
>   	kfree(oldpolicydb);
>   	return rc;
>   }
> @@ -2269,14 +2311,12 @@ int security_port_sid(struct selinux_state *state,
>   		      u8 protocol, u16 port, u32 *out_sid)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct ocontext *c;
>   	int rc = 0;
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	c = policydb->ocontexts[OCON_PORT];
>   	while (c) {
> @@ -2289,9 +2329,9 @@ int security_port_sid(struct selinux_state *state,
>   
>   	if (c) {
>   		if (!c->sid[0]) {
> -			rc = sidtab_context_to_sid(sidtab,
> -						   &c->context[0],
> -						   &c->sid[0]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[0],
> +							    &c->sid[0]);
>   			if (rc)
>   				goto out;
>   		}
> @@ -2315,14 +2355,12 @@ int security_ib_pkey_sid(struct selinux_state *state,
>   			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct ocontext *c;
>   	int rc = 0;
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	c = policydb->ocontexts[OCON_IBPKEY];
>   	while (c) {
> @@ -2336,9 +2374,9 @@ int security_ib_pkey_sid(struct selinux_state *state,
>   
>   	if (c) {
>   		if (!c->sid[0]) {
> -			rc = sidtab_context_to_sid(sidtab,
> -						   &c->context[0],
> -						   &c->sid[0]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[0],
> +							    &c->sid[0]);
>   			if (rc)
>   				goto out;
>   		}
> @@ -2361,14 +2399,12 @@ int security_ib_endport_sid(struct selinux_state *state,
>   			    const char *dev_name, u8 port_num, u32 *out_sid)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct ocontext *c;
>   	int rc = 0;
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	c = policydb->ocontexts[OCON_IBENDPORT];
>   	while (c) {
> @@ -2383,9 +2419,9 @@ int security_ib_endport_sid(struct selinux_state *state,
>   
>   	if (c) {
>   		if (!c->sid[0]) {
> -			rc = sidtab_context_to_sid(sidtab,
> -						   &c->context[0],
> -						   &c->sid[0]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[0],
> +							    &c->sid[0]);
>   			if (rc)
>   				goto out;
>   		}
> @@ -2407,14 +2443,12 @@ int security_netif_sid(struct selinux_state *state,
>   		       char *name, u32 *if_sid)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	int rc = 0;
>   	struct ocontext *c;
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	c = policydb->ocontexts[OCON_NETIF];
>   	while (c) {
> @@ -2425,14 +2459,14 @@ int security_netif_sid(struct selinux_state *state,
>   
>   	if (c) {
>   		if (!c->sid[0] || !c->sid[1]) {
> -			rc = sidtab_context_to_sid(sidtab,
> -						  &c->context[0],
> -						  &c->sid[0]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[0],
> +							    &c->sid[0]);
>   			if (rc)
>   				goto out;
> -			rc = sidtab_context_to_sid(sidtab,
> -						   &c->context[1],
> -						   &c->sid[1]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[1],
> +							    &c->sid[1]);
>   			if (rc)
>   				goto out;
>   		}
> @@ -2472,14 +2506,12 @@ int security_node_sid(struct selinux_state *state,
>   		      u32 *out_sid)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	int rc;
>   	struct ocontext *c;
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	switch (domain) {
>   	case AF_INET: {
> @@ -2521,9 +2553,9 @@ int security_node_sid(struct selinux_state *state,
>   
>   	if (c) {
>   		if (!c->sid[0]) {
> -			rc = sidtab_context_to_sid(sidtab,
> -						   &c->context[0],
> -						   &c->sid[0]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[0],
> +							    &c->sid[0]);
>   			if (rc)
>   				goto out;
>   		}
> @@ -2561,7 +2593,6 @@ int security_get_user_sids(struct selinux_state *state,
>   			   u32 *nel)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	struct context *fromcon, usercon;
>   	u32 *mysids = NULL, *mysids2, sid;
>   	u32 mynel = 0, maxnel = SIDS_NEL;
> @@ -2579,12 +2610,11 @@ int security_get_user_sids(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	context_init(&usercon);
>   
>   	rc = -EINVAL;
> -	fromcon = sidtab_search(sidtab, fromsid);
> +	fromcon = security_sid_to_context_struct(state, fromsid, 0);
>   	if (!fromcon)
>   		goto out_unlock;
>   
> @@ -2610,7 +2640,7 @@ int security_get_user_sids(struct selinux_state *state,
>   						 &usercon))
>   				continue;
>   
> -			rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
> +			rc = security_context_struct_to_sid(state, &usercon, &sid);
>   			if (rc)
>   				goto out_unlock;
>   			if (mynel < maxnel) {
> @@ -2681,7 +2711,6 @@ static inline int __security_genfs_sid(struct selinux_state *state,
>   				       u32 *sid)
>   {
>   	struct policydb *policydb = &state->ss->policydb;
> -	struct sidtab *sidtab = &state->ss->sidtab;
>   	int len;
>   	u16 sclass;
>   	struct genfs *genfs;
> @@ -2716,7 +2745,8 @@ static inline int __security_genfs_sid(struct selinux_state *state,
>   		goto out;
>   
>   	if (!c->sid[0]) {
> -		rc = sidtab_context_to_sid(sidtab, &c->context[0], &c->sid[0]);
> +		rc = security_context_struct_to_sid(state, &c->context[0],
> +						    &c->sid[0]);
>   		if (rc)
>   			goto out;
>   	}
> @@ -2758,7 +2788,6 @@ int security_genfs_sid(struct selinux_state *state,
>   int security_fs_use(struct selinux_state *state, struct super_block *sb)
>   {
>   	struct policydb *policydb;
> -	struct sidtab *sidtab;
>   	int rc = 0;
>   	struct ocontext *c;
>   	struct superblock_security_struct *sbsec = sb->s_security;
> @@ -2767,7 +2796,6 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
>   
>   	c = policydb->ocontexts[OCON_FSUSE];
>   	while (c) {
> @@ -2779,8 +2807,9 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>   	if (c) {
>   		sbsec->behavior = c->v.behavior;
>   		if (!c->sid[0]) {
> -			rc = sidtab_context_to_sid(sidtab, &c->context[0],
> -						   &c->sid[0]);
> +			rc = security_context_struct_to_sid(state,
> +							    &c->context[0],
> +							    &c->sid[0]);
>   			if (rc)
>   				goto out;
>   		}
> @@ -2973,7 +3002,6 @@ int security_sid_mls_copy(struct selinux_state *state,
>   			  u32 sid, u32 mls_sid, u32 *new_sid)
>   {
>   	struct policydb *policydb = &state->ss->policydb;
> -	struct sidtab *sidtab = &state->ss->sidtab;
>   	struct context *context1;
>   	struct context *context2;
>   	struct context newcon;
> @@ -2992,7 +3020,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	rc = -EINVAL;
> -	context1 = sidtab_search(sidtab, sid);
> +	context1 = security_sid_to_context_struct(state, sid, 0);
>   	if (!context1) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, sid);
> @@ -3000,7 +3028,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>   	}
>   
>   	rc = -EINVAL;
> -	context2 = sidtab_search(sidtab, mls_sid);
> +	context2 = security_sid_to_context_struct(state, mls_sid, 0);
>   	if (!context2) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   			__func__, mls_sid);
> @@ -3030,7 +3058,7 @@ int security_sid_mls_copy(struct selinux_state *state,
>   		}
>   	}
>   
> -	rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
> +	rc = security_context_struct_to_sid(state, &newcon, new_sid);
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
>   	context_destroy(&newcon);
> @@ -3064,7 +3092,6 @@ int security_net_peersid_resolve(struct selinux_state *state,
>   				 u32 *peer_sid)
>   {
>   	struct policydb *policydb = &state->ss->policydb;
> -	struct sidtab *sidtab = &state->ss->sidtab;
>   	int rc;
>   	struct context *nlbl_ctx;
>   	struct context *xfrm_ctx;
> @@ -3097,14 +3124,14 @@ int security_net_peersid_resolve(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	rc = -EINVAL;
> -	nlbl_ctx = sidtab_search(sidtab, nlbl_sid);
> +	nlbl_ctx = security_sid_to_context_struct(state, nlbl_sid, 0);
>   	if (!nlbl_ctx) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, nlbl_sid);
>   		goto out;
>   	}
>   	rc = -EINVAL;
> -	xfrm_ctx = sidtab_search(sidtab, xfrm_sid);
> +	xfrm_ctx = security_sid_to_context_struct(state, xfrm_sid, 0);
>   	if (!xfrm_ctx) {
>   		pr_err("SELinux: %s:  unrecognized SID %d\n",
>   		       __func__, xfrm_sid);
> @@ -3425,7 +3452,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
>   		goto out;
>   	}
>   
> -	ctxt = sidtab_search(&state->ss->sidtab, sid);
> +	ctxt = security_sid_to_context_struct(state, sid, 0);
>   	if (unlikely(!ctxt)) {
>   		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
>   			  sid);
> @@ -3588,7 +3615,6 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   				   u32 *sid)
>   {
>   	struct policydb *policydb = &state->ss->policydb;
> -	struct sidtab *sidtab = &state->ss->sidtab;
>   	int rc;
>   	struct context *ctx;
>   	struct context ctx_new;
> @@ -3606,7 +3632,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   		*sid = secattr->attr.secid;
>   	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
>   		rc = -EIDRM;
> -		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
> +		ctx = security_sid_to_context_struct(state, SECINITSID_NETMSG, 0);
>   		if (ctx == NULL)
>   			goto out;
>   
> @@ -3624,7 +3650,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   		if (!mls_context_isvalid(policydb, &ctx_new))
>   			goto out_free;
>   
> -		rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
> +		rc = security_context_struct_to_sid(state, &ctx_new, sid);
>   		if (rc)
>   			goto out_free;
>   
> @@ -3666,7 +3692,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>   	read_lock(&state->ss->policy_rwlock);
>   
>   	rc = -ENOENT;
> -	ctx = sidtab_search(&state->ss->sidtab, sid);
> +	ctx = security_sid_to_context_struct(state, sid, 0);
>   	if (ctx == NULL)
>   		goto out;
>   
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index 24c7bdcc8075..18a2fb386120 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -25,6 +25,7 @@ struct selinux_map {
>   
>   struct selinux_ss {
>   	struct sidtab sidtab;
> +	struct isidtab *isidtab;
>   	struct policydb policydb;
>   	rwlock_t policy_rwlock;
>   	u32 latest_granting;
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index fd75a12fa8fc..98710657a596 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -25,7 +25,7 @@ int sidtab_init(struct sidtab *s)
>   	for (i = 0; i < SIDTAB_SIZE; i++)
>   		s->htable[i] = NULL;
>   	s->nel = 0;
> -	s->next_sid = 1;
> +	s->next_sid = SECINITSID_NUM + 1;
>   	s->shutdown = 0;
>   	spin_lock_init(&s->lock);
>   	return 0;
> @@ -76,7 +76,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>   	return 0;
>   }
>   
> -static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> +struct context *sidtab_lookup(struct sidtab *s, u32 sid)
>   {
>   	int hvalue;
>   	struct sidtab_node *cur;
> @@ -89,33 +89,12 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>   	while (cur && sid > cur->sid)
>   		cur = cur->next;
>   
> -	if (force && cur && sid == cur->sid && cur->context.len)
> -		return &cur->context;
> -
> -	if (!cur || sid != cur->sid || cur->context.len) {
> -		/* Remap invalid SIDs to the unlabeled SID. */
> -		sid = SECINITSID_UNLABELED;
> -		hvalue = SIDTAB_HASH(sid);
> -		cur = s->htable[hvalue];
> -		while (cur && sid > cur->sid)
> -			cur = cur->next;
> -		if (!cur || sid != cur->sid)
> -			return NULL;
> -	}
> +	if (!cur || sid != cur->sid)
> +		return NULL;
>   
>   	return &cur->context;
>   }
>   
> -struct context *sidtab_search(struct sidtab *s, u32 sid)
> -{
> -	return sidtab_search_core(s, sid, 0);
> -}
> -
> -struct context *sidtab_search_force(struct sidtab *s, u32 sid)
> -{
> -	return sidtab_search_core(s, sid, 1);
> -}
> -
>   int sidtab_map(struct sidtab *s,
>   	       int (*apply) (u32 sid,
>   			     struct context *context,
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index a1a1d2617b6f..2eadd09a1100 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -34,8 +34,7 @@ struct sidtab {
>   
>   int sidtab_init(struct sidtab *s);
>   int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
> -struct context *sidtab_search(struct sidtab *s, u32 sid);
> -struct context *sidtab_search_force(struct sidtab *s, u32 sid);
> +struct context *sidtab_lookup(struct sidtab *s, u32 sid);
>   
>   int sidtab_map(struct sidtab *s,
>   	       int (*apply) (u32 sid,
> 

