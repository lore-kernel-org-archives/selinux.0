Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3897EC35247
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31EE21741
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 21:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="k5Lioe9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBDVW5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:22:57 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:54132 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDVW4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 16:22:56 -0500
X-EEMSG-check-017: 54514113|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,403,1574121600"; 
   d="scan'208";a="54514113"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Feb 2020 19:06:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580843165; x=1612379165;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=fAP9EuV5DuqSfaHxf25LoPW/TGXbkxduPHcOvT97caw=;
  b=k5Lioe9NGUclPnluvT5/HFzrl+AuklfUbk0RCzJqDSqcLLn7MYp4JoRC
   lD2xQ63FKe1frmu+SaaSNrSEvYNBi2T+he0DfO1YWUSUT1P/WA1u+xxov
   dSeLyOHR94GOJjKjUBNP+vQlemQrjsseGJiniEN3kloUOD2JsCHMs6nvu
   BEuJY6l53cEmGbtk3b0i2dy/aw3y/8uOwrIwf/u5y92mNM2CJQ+q31ZEv
   a37W/J2v8m5MIipYQHQmFIROvF5dTkj7YT6XCdMI/gnLAD/Fnox/ThyCV
   5qva77Q2mHAelqNoAXEKxicgdaW7JbOGOoYKx3bwVNcIp2zoHq55YsYeR
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,402,1574121600"; 
   d="scan'208";a="32673371"
IronPort-PHdr: =?us-ascii?q?9a23=3AqQkvIxRV5FGshoMTmk9Wn8DMptpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYBSN2/xhgRfzUJnB7Loc0qyK6vymBT1LuM/Y+DBaKdoQDk?=
 =?us-ascii?q?RD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs+xx?=
 =?us-ascii?q?fTrXZFf+tayX51KV6Ogh3w4tu88IN5/ylfpv4s+dRMXbnmc6g9ULdVECkoP2?=
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
X-IPAS-Result: =?us-ascii?q?A2C0AgBFvzle/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRhVIBIWFIQUiQOIJps4CQEBAQEBAQEBASMUAQGCE4ItAoJbOBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTcMgjspgwMBBSMEEVELCQUKAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJjPwEqAYJQrT5/M4VKg0GBPoEOKo18QIERJw+CXT6HW4JeBIE/AYwaBIh6Y?=
 =?us-ascii?q?UaXZAaCP40QiS0GG5sIjmGPAI4rIoFYKwpBgWiBTglHGA2OKRcViAyGICMDM?=
 =?us-ascii?q?IwMLYE1XwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Feb 2020 19:06:03 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 014J55UY021546;
        Tue, 4 Feb 2020 14:05:13 -0500
Subject: Re: [PATCH v2] libsepol,checkpolicy: support omitting unused initial
 sid contexts
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200129150104.50720-1-sds@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <947974f0-2e70-d2ba-017a-954ccb9be079@tycho.nsa.gov>
Date:   Tue, 4 Feb 2020 14:07:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129150104.50720-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/29/20 10:01 AM, Stephen Smalley wrote:
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
> policy will cause sysctl(2) or /proc/sys accesses to end up
> performing permission checks against the unlabeled context and
> likely encounter denials for kernels < 2.6.39.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Carter <jwcart2@tycho.nsa.gov>

> ---
> v2 issues informational messages about missing initial SID contexts
> so that policy developers can detect unintended inconsistencies,
> and ensures that the entries are stripped before writing kernel policy
> rather than accepting them when reading.  Something isn't quite right
> here though; I see the messages when compiling monolithic policy with
> checkpolicy but not with a modular build (even upon make validate) or
> semodule -v -i of a modified base module that removes some initial
> SID contexts.
> 
>   checkpolicy/test/dismod.c     |  4 ++--
>   libsepol/cil/src/cil_binary.c |  4 +++-
>   libsepol/cil/src/cil_verify.c |  3 +--
>   libsepol/src/expand.c         | 24 ++++++++++++------------
>   libsepol/src/policydb.c       |  4 ----
>   libsepol/src/write.c          | 22 ++++++++++++++++++++--
>   6 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 8d6be2ff9522..3408e9b6b767 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -444,8 +444,8 @@ void display_initial_sids(policydb_t * p, FILE * fp)
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
> index 018514dc1bb9..d1a6538be651 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -439,8 +439,7 @@ int __cil_verify_initsids(struct cil_list *sids)
>   		struct cil_sid *sid = i->data;
>   		if (sid->context == NULL) {
>   			struct cil_tree_node *node = sid->datum.nodes->head->data;
> -			cil_tree_log(node, CIL_ERR, "No context assigned to SID %s declared",sid->datum.name);
> -			rc = SEPOL_ERR;
> +			cil_tree_log(node, CIL_INFO, "No context assigned to SID %s, omitting from policy",sid->datum.name);
>   		}
>   	}
>   
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 796121cf5ad8..5738b598ee39 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2093,6 +2093,12 @@ static int ocontext_copy_xen(expand_state_t *state)
>   	for (i = 0; i < OCON_NUM; i++) {
>   		l = NULL;
>   		for (c = state->base->ocontexts[i]; c; c = c->next) {
> +			if (i == OCON_XEN_ISID && !c->context[0].user) {
> +				INFO(state->handle,
> +				     "No context assigned to SID %s, omitting from policy",
> +				     c->u.name);
> +				continue;
> +			}
>   			n = malloc(sizeof(ocontext_t));
>   			if (!n) {
>   				ERR(state->handle, "Out of memory!");
> @@ -2106,12 +2112,6 @@ static int ocontext_copy_xen(expand_state_t *state)
>   			l = n;
>   			switch (i) {
>   			case OCON_XEN_ISID:
> -				if (c->context[0].user == 0) {
> -					ERR(state->handle,
> -					    "Missing context for %s initial sid",
> -					    c->u.name);
> -					return -1;
> -				}
>   				n->sid[0] = c->sid[0];
>   				break;
>   			case OCON_XEN_PIRQ:
> @@ -2159,6 +2159,12 @@ static int ocontext_copy_selinux(expand_state_t *state)
>   	for (i = 0; i < OCON_NUM; i++) {
>   		l = NULL;
>   		for (c = state->base->ocontexts[i]; c; c = c->next) {
> +			if (i == OCON_ISID && !c->context[0].user) {
> +				INFO(state->handle,
> +				     "No context assigned to SID %s, omitting from policy",
> +				     c->u.name);
> +				continue;
> +			}
>   			n = malloc(sizeof(ocontext_t));
>   			if (!n) {
>   				ERR(state->handle, "Out of memory!");
> @@ -2172,12 +2178,6 @@ static int ocontext_copy_selinux(expand_state_t *state)
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
> index 745e546baa3a..5b289a523a94 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1610,10 +1610,6 @@ int policydb_load_isids(policydb_t * p, sidtab_t * s)
>   
>   	head = p->ocontexts[OCON_ISID];
>   	for (c = head; c; c = c->next) {
> -		if (!c->context[0].user) {
> -			ERR(NULL, "SID %s was never defined", c->u.name);
> -			return -1;
> -		}
>   		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
>   			ERR(NULL, "unable to load initial SID %s", c->u.name);
>   			return -1;
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 7e634510d038..1fd6a16a248b 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1293,8 +1293,15 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
>   	ocontext_t *c;
>   	for (i = 0; i < info->ocon_num; i++) {
>   		nel = 0;
> -		for (c = p->ocontexts[i]; c; c = c->next)
> +		for (c = p->ocontexts[i]; c; c = c->next) {
> +			if (i == OCON_XEN_ISID && !c->context[0].user) {
> +				INFO(fp->handle,
> +				     "No context assigned to SID %s, omitting from policy",
> +				     c->u.name);
> +				continue;
> +			}
>   			nel++;
> +		}
>   		buf[0] = cpu_to_le32(nel);
>   		items = put_entry(buf, sizeof(uint32_t), 1, fp);
>   		if (items != 1)
> @@ -1302,6 +1309,8 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
>   		for (c = p->ocontexts[i]; c; c = c->next) {
>   			switch (i) {
>   			case OCON_XEN_ISID:
> +				if (!c->context[0].user)
> +					break;
>   				buf[0] = cpu_to_le32(c->sid[0]);
>   				items = put_entry(buf, sizeof(uint32_t), 1, fp);
>   				if (items != 1)
> @@ -1392,8 +1401,15 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
>   	ocontext_t *c;
>   	for (i = 0; i < info->ocon_num; i++) {
>   		nel = 0;
> -		for (c = p->ocontexts[i]; c; c = c->next)
> +		for (c = p->ocontexts[i]; c; c = c->next) {
> +			if (i == OCON_ISID && !c->context[0].user) {
> +				INFO(fp->handle,
> +				     "No context assigned to SID %s, omitting from policy",
> +				     c->u.name);
> +				continue;
> +			}
>   			nel++;
> +		}
>   		buf[0] = cpu_to_le32(nel);
>   		items = put_entry(buf, sizeof(uint32_t), 1, fp);
>   		if (items != 1)
> @@ -1401,6 +1417,8 @@ static int ocontext_write_selinux(struct policydb_compat_info *info,
>   		for (c = p->ocontexts[i]; c; c = c->next) {
>   			switch (i) {
>   			case OCON_ISID:
> +				if (!c->context[0].user)
> +					break;
>   				buf[0] = cpu_to_le32(c->sid[0]);
>   				items = put_entry(buf, sizeof(uint32_t), 1, fp);
>   				if (items != 1)
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
