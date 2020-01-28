Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE0C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2FA206A2
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 19:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qYU97vp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1To5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:44:57 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:10711 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1To4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 14:44:56 -0500
X-EEMSG-check-017: 50982443|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,375,1574121600"; 
   d="scan'208";a="50982443"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2020 19:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580240686; x=1611776686;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=R9blcinJsHFJO95BPra8L8Ra5y+mv9s9F145q+seh1I=;
  b=qYU97vp+vX5ZXGJ4XtxOzTfzF3bdM/jyQEhkHx7yQO12m/oHjnsw6Qj8
   rfRBH+MWA0XB670+TM4Ag3gI/phRIP0K7RREslFmAmD+/ynfd+aIBzRfM
   J444PPivehQJQU6JnAQ+Dr/t7EkouKVwYGEBDqao8pGprPR24Zdp1uU1B
   GUEULAgVgrJRRYRjEqocvLQ3t9IoA0xlO9CTRJ/6WwEv/3xOF1s8Kz03Z
   naIv+q7Tsy3o4rQaNzL+ycT2w4hC4j5DlvZ83g6TrzjC008qoT9T7xmgH
   xL3vXBelM/LFtEchzAob1Vpb5LGMWGwYIB6+k14/gNG4uTef1nki9LiQq
   A==;
X-IronPort-AV: E=Sophos;i="5.70,375,1574121600"; 
   d="scan'208";a="38367509"
IronPort-PHdr: =?us-ascii?q?9a23=3Aq/IMkBRm0wIferDYp0YXTalvd9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYBSN2/xhgRfzUJnB7Loc0qyK6vymAjBLuMzY+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTrHZFdOtayX52KV6Ogh3w4tu88IN5/ylfpv4s+dRMXbnmc6g9ULdVECkoP2?=
 =?us-ascii?q?cp6cPxqBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVMsPqQ780Xy?=
 =?us-ascii?q?+i77pwRx/zlCgHLT85/3rJhcF2kalWvQiupx17w47TfYGVKP9zdb7TcN8GWW?=
 =?us-ascii?q?ZMWNtaWCJbAoO4coABEewPM+hFpIX5vlcDrR+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJy0kuGR/KgU+KqYz5IT+ey+MAs2qV7uV8T+2vkXInpx9qrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIUEylarVLJ4h2aA/mY?=
 =?us-ascii?q?YJvUTfHi75hEX2jKiMekUi5ueo8Pjobq/jpp+dM494kgD+MqIwlcyjGek0Lw?=
 =?us-ascii?q?cDUmeB9em8ybHv51P1TbpUgvEsj6XVqJXaKt4apq69DQ9VyIEj6xOnAjek3t?=
 =?us-ascii?q?UXgWMILEhZeB6ZlIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhE551KDrEBIfTzWlL+tdHDEB85PBK7w/z9BNV+yIweQ2SPDb?=
 =?us-ascii?q?GdMK/Itl+I/O0vcKGwY9oupDvlK/Ujr8XrhHs9lE5VKbKlxrMLeXu4GbJgOE?=
 =?us-ascii?q?zfbn3y1JNJCmoOvwwjXMT0h1CYFz1efXC/W+Q7/D5oJpihCNLBWYukmqDblH?=
 =?us-ascii?q?O5AZZffHwcIkydGnfvMYOfUrEDbzzEcZwpqSANSbX0E9xp7hqprgKvjuc2Iw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CDAgCUjjBe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRh1EhYUhBSJA4g7mzgJAQEBAQEBAQEBIxQBAYITgi0Cgko4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFNwyCOymCewEFIwQRUQsJBQoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/ASoBglCuMX8zhUqDQ4E+gQ4qjXhAgREnD4JdPodZgl4EgT8BjBgEiHdhR?=
 =?us-ascii?q?pdeBoI9jQaJKwYbgkiMT4tljmCOeY4lIoFYKwpBgWiBTglHGA2OKReIIYYgI?=
 =?us-ascii?q?wMwi3MtgTVfAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jan 2020 19:44:44 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00SJhxZN011376;
        Tue, 28 Jan 2020 14:44:01 -0500
Subject: Re: [PATCH] libsepol, checkpolicy: support omitting unused initial
 sid contexts
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200128172600.12896-1-sds@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <ae10e60a-7a9d-b954-5bf5-23577a5feadc@tycho.nsa.gov>
Date:   Tue, 28 Jan 2020 14:45:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200128172600.12896-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/28/20 12:26 PM, Stephen Smalley wrote:
> Remove restrictions in libsepol and checkpolicy that required all
> declared initial SIDs to be assigned a context.  With this patch,
> it is possible to build and load a policy that drops the sid <sidname>
> <context> declarations for the unused initial SIDs.  It is still
> required to retain the sid <sidname> declarations (in the flask
> definitions) in order to preserve the initial SID ordering/values.
> The unused initial SIDs can be renamed, e.g. to add an unused_
> prefix or similar, if desired, since the names used in the policy
> are not stored in the kernel binary policy.
> 
> In CIL policies, the (sid ...) and (sidorder (...)) statements
> must be left intact for compatibility but the (sidcontext ...)
> statements for the unused initial SIDs can be omitted after this change.
> 
> With current kernels, if one removes an unused initial SID context
> from policy, builds policy with this change applied and loads the
> policy into the kernel, cat /sys/fs/selinux/initial_contexts/<sidname>
> will show the unlabeled context.  With the kernel patch to remove unused
> initial SIDs, the /sys/fs/selinux/initial_contexts/<sidname>
> file will not be created for unused initial SIDs in the first place.
> 
> NB If an unused initial SID was assigned a context different from
> the unlabeled context in existing policy, then it is not safe to
> remove that initial SID context from policy and reload policy on
> the running kernel that was booted with the original policy.  This
> is because that kernel may have assigned that SID to various kernel
> objects already and those objects will then be treated as having
> the unlabeled context after the removal.  In refpolicy, examples
> of such initial SIDs are the "fs" SID and the "sysctl" SID.  Even
> though these initial SIDs are not directly used (in code) by the current
> kernel, their contexts are being applied to filesystems and sysctl files by
> policy and therefore the SIDs are being assigned to objects.
> 
> NB The "sysctl" SID was in use by the kernel up until
> commit 8e6c96935fcc1ed3dbebc96fddfef3f2f2395afc ("security/selinux:
> fix /proc/sys/ labeling) circa v2.6.39.  Removing its context from
> policy will break kernels < 2.6.39.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   checkpolicy/test/dismod.c     |  6 +++--
>   libsepol/cil/src/cil_binary.c |  4 ++-
>   libsepol/cil/src/cil_verify.c | 10 -------
>   libsepol/src/expand.c         |  8 ++----
>   libsepol/src/policydb.c       | 51 ++++++++++++++++++++++++-----------
>   5 files changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 8d6be2ff9522..49d610d94b00 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -441,11 +441,13 @@ void display_initial_sids(policydb_t * p, FILE * fp)
>   
>   	fprintf(fp, "Initial SIDs:\n");
>   	for (cur = p->ocontexts[OCON_ISID]; cur != NULL; cur = cur->next) {
> +		if (!cur->context[0].user)
> +			continue;
>   		user = p->p_user_val_to_name[cur->context[0].user - 1];
>   		role = p->p_role_val_to_name[cur->context[0].role - 1];
>   		type = p->p_type_val_to_name[cur->context[0].type - 1];
> -		fprintf(fp, "\t%s: sid %d, context %s:%s:%s\n",
> -			cur->u.name, cur->sid[0], user, role, type);
> +		fprintf(fp, "\tsid %d, context %s:%s:%s\n",
> +			cur->sid[0], user, role, type);
>   	}
>   #if 0
>   	fprintf(fp, "Policy Initial SIDs:\n");
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index f8e20d32f9f1..e52b6679c289 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -3067,9 +3067,11 @@ int cil_sidorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
>   		struct cil_sid *cil_sid = (struct cil_sid*)curr->data;
>   		struct cil_context *cil_context = cil_sid->context;
>   
> +		/* even if no context, we must preserve initial SID values */
> +		count++;
> +
>   		if (cil_context != NULL) {
>   			ocontext_t *new_ocon = cil_add_ocontext(&pdb->ocontexts[OCON_ISID], &tail);
> -			count++;
>   			new_ocon->sid[0] = count;
>   			new_ocon->u.name = cil_strdup(cil_sid->datum.fqn);
>   			rc = __cil_context_to_sepol_context(pdb, cil_context, &new_ocon->context[0]);
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 018514dc1bb9..0367a8e58273 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -428,22 +428,12 @@ int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor)
>   int __cil_verify_initsids(struct cil_list *sids)
>   {
>   	int rc = SEPOL_OK;
> -	struct cil_list_item *i;
>   
>   	if (sids->head == NULL) {
>   		cil_log(CIL_ERR, "At least one initial sid must be defined in the policy\n");
>   		return SEPOL_ERR;
>   	}
>   
> -	cil_list_for_each(i, sids) {
> -		struct cil_sid *sid = i->data;
> -		if (sid->context == NULL) {
> -			struct cil_tree_node *node = sid->datum.nodes->head->data;
> -			cil_tree_log(node, CIL_ERR, "No context assigned to SID %s declared",sid->datum.name);
> -			rc = SEPOL_ERR;
> -		}
> -	}
> -
>   	return rc;

Can just return SEPOL_OK here and get rid of the variable rc.

>   }
>   
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 796121cf5ad8..5f8e75c38632 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2159,6 +2159,8 @@ static int ocontext_copy_selinux(expand_state_t *state)
>   	for (i = 0; i < OCON_NUM; i++) {
>   		l = NULL;
>   		for (c = state->base->ocontexts[i]; c; c = c->next) {
> +			if (i == OCON_ISID && c->context[0].user == 0)
> +				continue;
>   			n = malloc(sizeof(ocontext_t));
>   			if (!n) {
>   				ERR(state->handle, "Out of memory!");
> @@ -2172,12 +2174,6 @@ static int ocontext_copy_selinux(expand_state_t *state)
>   			l = n;
>   			switch (i) {
>   			case OCON_ISID:
> -				if (c->context[0].user == 0) {
> -					ERR(state->handle,
> -					    "Missing context for %s initial sid",
> -					    c->u.name);
> -					return -1;
> -				}
>   				n->sid[0] = c->sid[0];
>   				break;
>   			case OCON_FS:	/* FALLTHROUGH */
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 745e546baa3a..03360c88e7d3 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1610,10 +1610,8 @@ int policydb_load_isids(policydb_t * p, sidtab_t * s)
>   
>   	head = p->ocontexts[OCON_ISID];
>   	for (c = head; c; c = c->next) {
> -		if (!c->context[0].user) {
> -			ERR(NULL, "SID %s was never defined", c->u.name);
> -			return -1;
> -		}
> +		if (!c->context[0].user)
> +			continue;
>   		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
>   			ERR(NULL, "unable to load initial SID %s", c->u.name);
>   			return -1;
> @@ -2020,12 +2018,8 @@ static int mls_range_to_semantic(mls_range_t * r, mls_semantic_range_t * sr)
>   	return 0;
>   }
>   
> -/*
> - * Read and validate a security context structure
> - * from a policydb binary representation file.
> - */
> -static int context_read_and_validate(context_struct_t * c,
> -				     policydb_t * p, struct policy_file *fp)
> +static int context_read_no_validate(context_struct_t * c,
> +				    policydb_t * p, struct policy_file *fp)
>   {
>   	uint32_t buf[3];
>   	int rc;
> @@ -2049,6 +2043,19 @@ static int context_read_and_validate(context_struct_t * c,
>   		}
>   	}
>   
> +	return 0;
> +}
> +
> +/*
> + * Read and validate a security context structure
> + * from a policydb binary representation file.
> + */
> +static int context_read_and_validate(context_struct_t * c,
> +				     policydb_t * p, struct policy_file *fp)
> +{
> +	if (context_read_no_validate(c, p, fp))
> +		return -1;
> +
>   	if (!policydb_context_isvalid(p, c)) {
>   		ERR(fp->handle, "invalid security context");
>   		context_destroy(c);
> @@ -2797,6 +2804,7 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   	unsigned int i, j;
>   	size_t nel, len;
>   	ocontext_t *l, *c;
> +	context_struct_t tmpc;
>   	uint32_t buf[8];
>   	int rc;
>   
> @@ -2807,6 +2815,22 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   		nel = le32_to_cpu(buf[0]);
>   		l = NULL;
>   		for (j = 0; j < nel; j++) {
> +			if (i == OCON_ISID) {
> +				rc = next_entry(buf, fp, sizeof(uint32_t));
> +				if (rc < 0)
> +					return -1;
> +				context_init(&tmpc);
> +				if (context_read_no_validate
> +				    (&tmpc, p, fp))
> +					return -1;
> +				if (!tmpc.user)
> +					continue;
> +				if (!policydb_context_isvalid(p, &tmpc)) {
> +				  ERR(fp->handle, "invalid security context");
> +				  context_destroy(&tmpc);
> +				  return -1;
> +				}
> +			}
>   			c = calloc(1, sizeof(ocontext_t));
>   			if (!c) {
>   				return -1;
> @@ -2819,13 +2843,8 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   			l = c;
>   			switch (i) {
>   			case OCON_ISID:
> -				rc = next_entry(buf, fp, sizeof(uint32_t));
> -				if (rc < 0)
> -					return -1;
>   				c->sid[0] = le32_to_cpu(buf[0]);
> -				if (context_read_and_validate
> -				    (&c->context[0], p, fp))
> -					return -1;
> +				memcpy(&c->context[0], &tmpc, sizeof tmpc);
>   				break;
>   			case OCON_FS:
>   			case OCON_NETIF:
> 

I see that you don't do anything with ocontext_read_xen(), so Xen policies still 
require initial sid contexts? If so, doesn't that mean that CIL behavior needs 
to depend on whether or not a Xen policy is being created?

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
