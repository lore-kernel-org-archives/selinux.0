Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27BFC43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156E20828
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 16:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeK1D5G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:57:06 -0500
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:19184 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730260AbeK1D5F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 22:57:05 -0500
X-EEMSG-check-008: 146414418|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2018 16:58:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,287,1539648000"; 
   d="scan'208";a="21028344"
IronPort-PHdr: =?us-ascii?q?9a23=3AmfG+bRB8m070VZHc/Nd0UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX9osbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiDBrx/XBPr36BJXCNGTMn6n6cL?=
 =?us-ascii?q?Zn9UFT1QozwspD555OFr4BJ/fzUFfrtNPEFh85LxC0w+H/BdVmyIweXWOPAq?=
 =?us-ascii?q?mEMKLdqlKI+O0vLPeWZIMPuzbyNeIl5/jwgn89g1MderOp3ZQPYnCiAvtmO1?=
 =?us-ascii?q?mZYWbrgtoZCWcFpBc+TOjxhV2aSzFTenKyU7s55jE8D4KmF5nMSpqxj7yG2S?=
 =?us-ascii?q?foVqFRM0dABkqBEz/NcJ6CUvwBa2rGJcpmiToNXrWJUYIt1Riy8gT9zuwjZv?=
 =?us-ascii?q?HZ/iweqILLytd4/avQmAs0+DgyCN6Slym1Rnxw1kYPQCU7lPRnqFF54k+KzK?=
 =?us-ascii?q?w9hvtfD9EV7PRMBFQUL5nZmtdmBsjyVwSJRdKATFKrU53yGj0qZs4gyN8JJU?=
 =?us-ascii?q?BmEpOtiQ6VjHniOKMci7HeXM98yanbxXWkYp8nk3s=3D?=
X-IPAS-Result: =?us-ascii?q?A2AmAABhd/1b/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopgTUzJ4N5iBiMCEwBAQEBAQEGgRAliR2OI4F6OAGEQAKEOCI0CQ0BAwEBA?=
 =?us-ascii?q?QEBAQIBbCiCNiQBgmEBAQEBAgEjBBFRCw4KAgImAgJXBgEMBgIBAYJeP4F1B?=
 =?us-ascii?q?QilR3wzhUCEaYELiwIXeIEHgREnDIJfiAWCVwKPIEM0j3UJkSoGGJELLJlRO?=
 =?us-ascii?q?IFVKwgCGAghD4MngicXjjshAzCBBQEBjQ8BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2018 16:58:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wARGwRFB003604;
        Tue, 27 Nov 2018 11:58:28 -0500
Subject: Re: [RFC PATCH v2 2/4] [squash] do not store entry for SECSID_NULL
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20181127103605.32765-1-omosnace@redhat.com>
 <20181127103605.32765-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1bd2a5dd-d8cb-1081-76ca-5f4f3de6111f@tycho.nsa.gov>
Date:   Tue, 27 Nov 2018 12:00:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127103605.32765-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/18 5:36 AM, Ondrej Mosnacek wrote:
> This patch is kept separate only for review. Eventually it will be
> folded into the previous patch.

This one triggers a lot of warnings (security_compute_av: unrecognized 
SID 0, security_sid_to_context_core: unrecognized SID 0) and some 
failures during selinux-testsuite inet_socket tests.  While the policy 
doesn't provide an entry for SECSID_NULL, the sidtab search logic was 
remapping it to the unlabeled context and that was apparently being 
relied upon by the labeled networking code IIUC.


> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/policydb.c |  2 +-
>   security/selinux/ss/sidtab.c   | 25 ++++++++++++++++---------
>   security/selinux/ss/sidtab.h   |  3 ++-
>   3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 59359fa0bd74..a50d625e7946 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -912,7 +912,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>   			sidtab_destroy(s);
>   			goto out;
>   		}
> -		if (c->sid[0] > SECINITSID_NUM) {
> +		if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
>   			pr_err("SELinux:  Initial SID %s out of range.\n",
>   				c->u.name);
>   			sidtab_destroy(s);
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index fd8115b211a6..e157d8240cf1 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -23,7 +23,7 @@ int sidtab_init(struct sidtab *s)
>   	if (!s->htable)
>   		return -ENOMEM;
>   
> -	for (i = 0; i <= SECINITSID_NUM; i++)
> +	for (i = 0; i < SECINITSID_NUM; i++)
>   		s->isids[i].set = 0;
>   
>   	for (i = 0; i < SIDTAB_SIZE; i++)
> @@ -86,8 +86,15 @@ static int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>   
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>   {
> -	struct sidtab_isid_entry *entry = &s->isids[sid];
> -	int rc = context_cpy(&entry->context, context);
> +	struct sidtab_isid_entry *entry;
> +	int rc;
> +
> +	if (sid == 0 || sid > SECINITSID_NUM)
> +		return -EINVAL;
> +
> +	entry = &s->isids[sid - 1];
> +
> +	rc = context_cpy(&entry->context, context);
>   	if (rc)
>   		return rc;
>   
> @@ -116,19 +123,19 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>   	struct context *context;
>   	struct sidtab_isid_entry *entry;
>   
> -	if (!s)
> +	if (!s || sid == 0)
>   		return NULL;
>   
>   	if (sid > SECINITSID_NUM) {
>   		context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
>   	} else {
> -		entry = &s->isids[sid];
> +		entry = &s->isids[sid - 1];
>   		context = entry->set ? &entry->context : NULL;
>   	}
>   	if (context && (!context->len || force))
>   		return context;
>   
> -	entry = &s->isids[SECINITSID_UNLABELED];
> +	entry = &s->isids[SECINITSID_UNLABELED - 1];
>   	return entry->set ? &entry->context : NULL;
>   }
>   
> @@ -283,11 +290,11 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
>   	int rc;
>   	u32 i;
>   
> -	for (i = 0; i <= SECINITSID_NUM; i++) {
> +	for (i = 0; i < SECINITSID_NUM; i++) {
>   		struct sidtab_isid_entry *entry = &s->isids[i];
>   
>   		if (entry->set && context_cmp(context, &entry->context)) {
> -			*sid = i;
> +			*sid = i + 1;
>   			return 0;
>   		}
>   	}
> @@ -334,7 +341,7 @@ void sidtab_destroy(struct sidtab *s)
>   	if (!s)
>   		return;
>   
> -	for (i = 0; i <= SECINITSID_NUM; i++)
> +	for (i = 0; i < SECINITSID_NUM; i++)
>   		if (s->isids[i].set)
>   			context_destroy(&s->isids[i].context);
>   
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index dc0a80bc8894..e657ae6bf996 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -36,7 +36,8 @@ struct sidtab {
>   	struct sidtab_node *cache[SIDTAB_CACHE_LEN];
>   	spinlock_t lock;
>   
> -	struct sidtab_isid_entry isids[SECINITSID_NUM + 1];
> +	/* index == SID - 1 (no entry for SECSID_NULL) */
> +	struct sidtab_isid_entry isids[SECINITSID_NUM];
>   };
>   
>   int sidtab_init(struct sidtab *s);
> 

