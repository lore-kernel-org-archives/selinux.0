Return-Path: <SRS0=XRjJ=4B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E125C2BA83
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF52320873
	for <selinux@archiver.kernel.org>; Thu, 13 Feb 2020 14:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AW1/e0zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgBMONW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:13:22 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:7513 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgBMONW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Feb 2020 09:13:22 -0500
X-EEMSG-check-017: 71341807|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,436,1574121600"; 
   d="scan'208";a="71341807"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2020 14:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581603123; x=1613139123;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0dXg/10zvmxh9Jw7EMznxla+Ue1jdrUgBpKKEmr1jTU=;
  b=AW1/e0zm+6NgKHLzecOUu/c7NzU7uIaC+dY2uijTaenD8KFoXT0MGrFH
   hseD58qNS4F9KP/TZ+A3GLvS7XiIyufC7Pjg6NQo+DUiq978Y9uuo4h0a
   RowE8UkIpIqsLCxSOBkLnRLu6sP31zcSdxxngRyd4aOhvszm6DXneu+LT
   um8nnojBiALflDljmAoOwMHGPcVqKoI/99+H2lsfh9+HEyCOEexRjHTjR
   HnedYyGVPe5Scb2oqklFY5wBuh2m7igw66QcRXhSsJzHreCbYcE2nswnW
   QbkYMVDHh+9JMadhML/VlQpvTzasQLZVt8fIrpM9St0cOj/+Of+q9AvAY
   g==;
X-IronPort-AV: E=Sophos;i="5.70,436,1574121600"; 
   d="scan'208";a="33021953"
IronPort-PHdr: =?us-ascii?q?9a23=3AmG6/yhZLuDyOEfFM5EqduVP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrs2zbnLW6fgltlLVR4KTs6sC17OK9f6wEjFQqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLt8QbgoRuJ6Yyxx?=
 =?us-ascii?q?DUvnZGZuNayH9nKl6Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU7FWDykoPn?=
 =?us-ascii?q?4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Xi?=
 =?us-ascii?q?mi77tuRRT1hioLKyI1/WfKgcN+lqJbpA+qqQJ5zYDafYqZMONyc63ZcN8fQ2?=
 =?us-ascii?q?dKQ8RfWDFbAo6kcoUBEeQBM+ZboYfzqVQBohmxChWjCu701j9FhGX70bEm3+?=
 =?us-ascii?q?kvEwzL2hErEdIUsHTTqdX4LLocUfyrw6nQzTXMcfVW0irg5ojNaB8hpfWMUq?=
 =?us-ascii?q?xwcMHMzkQvDB7Kjk6LpIz5PzKayuQNs2+B4+pmTuKgkXQrqw52ojix38ohjJ?=
 =?us-ascii?q?TCiIwSylDB7yp5wYA1KMW3SE56fd6kEIZQuDqAO4RqRcMiRmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?ASsUTFEC/2n172g7GKeUk+5uip6/joYrXhppOGMY97lhr+Pbg0lsy6AOQ4Nh?=
 =?us-ascii?q?ACX2md+euiyL3u5VD1TbpFg/EskqTVrYrWKdoUq6KnGQNZz54v6xOlADen1N?=
 =?us-ascii?q?QYk2MHLFVAeB+flIjmJkrOLevkDfa/n1uskDBry+rAPr36GJrBNHfDkLD/fb?=
 =?us-ascii?q?pl8U5T1BIzzcxD55JTErwBOOj8WlL1tNHDFh82KRG0w+L+BNV40YMeXniPDb?=
 =?us-ascii?q?GDPKzOtl+I4/olI/OQa48NpDb9N/8l6ub1jXAnnV8dfK+p3YYYaX2jAPRmLF?=
 =?us-ascii?q?uWYWD2jtcCD2gKpAw+Q/LuiFGYVj5TfXmyVbom5j4nEIKmEZvDRoe1jbyG2S?=
 =?us-ascii?q?e7GYZWZmZcBV+QD3jlbJ+EVOkRZyKSOMBhjiYIWqSmS48khlmSs1riwqdjBv?=
 =?us-ascii?q?Ld5yldsJXkztUz7OrWxj8o8jkhNNiQy2GASSlPm2oMQzInlPRkrVdV1kaI0a?=
 =?us-ascii?q?8+hedRU9NU+aUaAU8BKZfAwrkiWJjJUQXbc4LMEwer?=
X-IPAS-Result: =?us-ascii?q?A2CdBACUWEVe/wHyM5BmHQEBAQkBEQUFAYF7gX2BGFUgE?=
 =?us-ascii?q?iqEFIkDhl4GgTeJcJFKCQEBAQEBAQEBASsMBAEBhEACgnA4EwIQAQEBBQEBA?=
 =?us-ascii?q?QEBBQMBAWyFNwyCOymDAwEFIwQRQRALGAICJgICVxMGAgEBgmM/AYJWJQ+se?=
 =?us-ascii?q?38zhUqDRYE4BoEOKow+eYEHgREnD4JdPoJkAoFlgxCCXgSNXgSIf2RGl2uCR?=
 =?us-ascii?q?IJPhH6OfgYcgkiYT5AzhyOUUCKBWCsIAhgIIQ87gmxQGA2OKReDUIpxIwMwj?=
 =?us-ascii?q?GAtgTVfAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Feb 2020 14:12:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01DEB5mu201168;
        Thu, 13 Feb 2020 09:11:05 -0500
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve
 handling
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
References: <20200129164256.3190-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <966793d8-4bd2-5d3e-d674-d900c0728f98@tycho.nsa.gov>
Date:   Thu, 13 Feb 2020 09:13:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129164256.3190-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/29/20 11:42 AM, Stephen Smalley wrote:
> Remove initial SIDs that have never been used or are no longer
> used by the kernel from its string table, which is also used
> to generate the SECINITSID_* symbols referenced in code.
> Update the code to gracefully handle the fact that these can
> now be NULL. Stop treating it as an error if a policy defines
> additional initial SIDs unknown to the kernel.  Do not
> load unused initial SID contexts into the sidtab.
> Fix the incorrect usage of the name from the ocontext in error
> messages when loading initial SIDs since these are not presently
> written to the kernel policy and are therefore always NULL.
> 
> This is a first step toward enabling future evolution of
> initial SIDs. Further changes are required to both userspace
> and the kernel to fully address
> https://github.com/SELinuxProject/selinux-kernel/issues/12
> but this takes a small step toward that end.
> 
> Fully decoupling the policy and kernel initial SID values will
> require introducing a mapping between them and dyhamically
> mapping them at load time.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Any objections, acks/reviews, or other questions/comments on this patch?
The GitHub issue has a more detailed discussion of how we can safely 
reuse and eventually increase the number of initial SIDs in the future.

> ---
> v2 avoids loading all unused initial SID contexts into the sidtab,
> not just ones beyond SECINITSID_NUM.  It also drops the unnecessary
> check for an undefined context because all contexts in the OCON_ISID
> list were already validated at load time via context_read_and_validate().
> 
>   scripts/selinux/genheaders/genheaders.c       | 11 +++-
>   .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
>   security/selinux/selinuxfs.c                  |  6 +-
>   security/selinux/ss/policydb.c                | 25 ++++----
>   security/selinux/ss/services.c                | 26 ++++-----
>   5 files changed, 66 insertions(+), 59 deletions(-)
> 
> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index 544ca126a8a8..f355b3e0e968 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -67,8 +67,12 @@ int main(int argc, char *argv[])
>   	}
>   
>   	isids_len = sizeof(initial_sid_to_string) / sizeof (char *);
> -	for (i = 1; i < isids_len; i++)
> -		initial_sid_to_string[i] = stoupperx(initial_sid_to_string[i]);
> +	for (i = 1; i < isids_len; i++) {
> +		const char *s = initial_sid_to_string[i];
> +
> +		if (s)
> +			initial_sid_to_string[i] = stoupperx(s);
> +	}
>   
>   	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
>   	fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
> @@ -82,7 +86,8 @@ int main(int argc, char *argv[])
>   
>   	for (i = 1; i < isids_len; i++) {
>   		const char *s = initial_sid_to_string[i];
> -		fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
> +		if (s)
> +			fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
>   	}
>   	fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
>   	fprintf(fout, "\nstatic inline bool security_is_socket_class(u16 kern_tclass)\n");
> diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
> index 4f93f697f71c..5d332aeb8b6c 100644
> --- a/security/selinux/include/initial_sid_to_string.h
> +++ b/security/selinux/include/initial_sid_to_string.h
> @@ -1,34 +1,33 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -/* This file is automatically generated.  Do not edit. */
>   static const char *initial_sid_to_string[] =
>   {
> -    "null",
> -    "kernel",
> -    "security",
> -    "unlabeled",
> -    "fs",
> -    "file",
> -    "file_labels",
> -    "init",
> -    "any_socket",
> -    "port",
> -    "netif",
> -    "netmsg",
> -    "node",
> -    "igmp_packet",
> -    "icmp_socket",
> -    "tcp_socket",
> -    "sysctl_modprobe",
> -    "sysctl",
> -    "sysctl_fs",
> -    "sysctl_kernel",
> -    "sysctl_net",
> -    "sysctl_net_unix",
> -    "sysctl_vm",
> -    "sysctl_dev",
> -    "kmod",
> -    "policy",
> -    "scmp_packet",
> -    "devnull",
> +	NULL,
> +	"kernel",
> +	"security",
> +	"unlabeled",
> +	NULL,
> +	"file",
> +	NULL,
> +	NULL,
> +	"any_socket",
> +	"port",
> +	"netif",
> +	"netmsg",
> +	"node",
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	NULL,
> +	"devnull",
>   };
>   
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79c710911a3c..daddc880ebfc 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1692,7 +1692,11 @@ static int sel_make_initcon_files(struct dentry *dir)
>   	for (i = 1; i <= SECINITSID_NUM; i++) {
>   		struct inode *inode;
>   		struct dentry *dentry;
> -		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
> +		const char *s = security_get_initial_sid_context(i);
> +
> +		if (!s)
> +			continue;
> +		dentry = d_alloc_name(dir, s);
>   		if (!dentry)
>   			return -ENOMEM;
>   
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2aa7f2e1a8e7..768a9d4e0b86 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -865,29 +865,28 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>   
>   	head = p->ocontexts[OCON_ISID];
>   	for (c = head; c; c = c->next) {
> -		rc = -EINVAL;
> -		if (!c->context[0].user) {
> -			pr_err("SELinux:  SID %s was never defined.\n",
> -				c->u.name);
> -			sidtab_destroy(s);
> -			goto out;
> -		}
> -		if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
> -			pr_err("SELinux:  Initial SID %s out of range.\n",
> -				c->u.name);
> +		u32 sid = c->sid[0];
> +		const char *name = security_get_initial_sid_context(sid);
> +
> +		if (sid == SECSID_NULL) {
> +			pr_err("SELinux:  SID null was assigned a context.\n");
>   			sidtab_destroy(s);
>   			goto out;
>   		}
> +
> +		/* Ignore initial SIDs unused by this kernel. */
> +		if (!name)
> +			continue;
> +
>   		rc = context_add_hash(p, &c->context[0]);
>   		if (rc) {
>   			sidtab_destroy(s);
>   			goto out;
>   		}
> -
> -		rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
> +		rc = sidtab_set_initial(s, sid, &c->context[0]);
>   		if (rc) {
>   			pr_err("SELinux:  unable to load initial SID %s.\n",
> -				c->u.name);
> +			       name);
>   			sidtab_destroy(s);
>   			goto out;
>   		}
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 216ce602a2b5..bd924a9a6388 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1323,23 +1323,22 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   	if (!selinux_initialized(state)) {
>   		if (sid <= SECINITSID_NUM) {
>   			char *scontextp;
> +			const char *s = initial_sid_to_string[sid];
>   
> -			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
> +			if (!s)
> +				return -EINVAL;
> +			*scontext_len = strlen(s) + 1;
>   			if (!scontext)
> -				goto out;
> -			scontextp = kmemdup(initial_sid_to_string[sid],
> -					    *scontext_len, GFP_ATOMIC);
> -			if (!scontextp) {
> -				rc = -ENOMEM;
> -				goto out;
> -			}
> +				return 0;
> +			scontextp = kmemdup(s, *scontext_len, GFP_ATOMIC);
> +			if (!scontextp)
> +				return -ENOMEM;
>   			*scontext = scontextp;
> -			goto out;
> +			return 0;
>   		}
>   		pr_err("SELinux: %s:  called before initial "
>   		       "load_policy on unknown SID %d\n", __func__, sid);
> -		rc = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>   	}
>   	read_lock(&state->ss->policy_rwlock);
>   	policydb = &state->ss->policydb;
> @@ -1363,7 +1362,6 @@ static int security_sid_to_context_core(struct selinux_state *state,
>   
>   out_unlock:
>   	read_unlock(&state->ss->policy_rwlock);
> -out:
>   	return rc;
>   
>   }
> @@ -1553,7 +1551,9 @@ static int security_context_to_sid_core(struct selinux_state *state,
>   		int i;
>   
>   		for (i = 1; i < SECINITSID_NUM; i++) {
> -			if (!strcmp(initial_sid_to_string[i], scontext2)) {
> +			const char *s = initial_sid_to_string[i];
> +
> +			if (s && !strcmp(s, scontext2)) {
>   				*sid = i;
>   				goto out;
>   			}
> 

