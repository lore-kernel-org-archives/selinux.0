Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52424C33CB3
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF5220730
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GK/EI7HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbgAPRQg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:16:36 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:52204 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbgAPRQa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 12:16:30 -0500
X-EEMSG-check-017: 46542469|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="46542469"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 17:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579194986; x=1610730986;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ByCV7QZAM0fuOYWaioB5pRTlkl1P9UW3wothFD7s1XU=;
  b=GK/EI7HYBaCnRoXPngIs/Wvios5Gat8Pbz8D/zjNjzYu9CUDZIm/sXRN
   9YwXCWhI89mtrMlSkyP3s6zrtkq9yoku6hnOrMamSpI4l/LjLjl/6y3Y3
   VPlpYwBbBA4eAtOsv63x5ic3A4yF7BqdPDNSZ7CmZZctsCfICrPlrpN8J
   I/KW+Kt7/8eJHMsm4T1OhWDqVqKj3gujX7WdQgXPcVTH1O63lZN9JXfts
   3m3GTnQXoyLfX4veywMCa2YVr1/LbY/UH0Rc38/jOV2CpZYdvrugT0DTW
   PNEcxLjZWp690DuXYlwpAoow2fPuHgJKP1XXZlXkCu146cq0RiVxKcrrT
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="37886890"
IronPort-PHdr: =?us-ascii?q?9a23=3AK83nTx2+pjxuUDp/smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKPrxwZ3uMQTl6Ol3ixeRBMOHsq4C07ed4vqoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF+JqsxxR?=
 =?us-ascii?q?fEpmVEcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XvnnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8p5+cMYF0igblMqswhsOzG/g4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj8lHiQLpWlPE2l6jZsJTCKcQaoK62HRNV354+5xuwADqqyt?=
 =?us-ascii?q?QVkWQdIF5bdx+LkZLlN0zWLPD9F/i/glCskDlxx/DBO73sGo7NIWXYkLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTWWWKAq?=
 =?us-ascii?q?+eK6PSt0WH6f4xLOSXfo8apivyK/g/6P7yl3M2hVgdfayx15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mdcOD2MKvgs4TOz3h1yPSiBTZ3msUKIm/D07C5ypDZ3FRo+zhLyNxi?=
 =?us-ascii?q?C7HodZZmpeEFCDDW/od5mYW/cLcC+SOtVukiEAVbW6U48uzwyutAvjx7piKe?=
 =?us-ascii?q?rU/TcYuoz52Ndp4O3TkEJ6yTshKMKRyWyPB0RzhWUBTDI1lPR4pEtmzF6I3I?=
 =?us-ascii?q?BijvBYHMAV7PRMBENyLpPYzupnG/jsVQ/bONSEUlCrRpOhGz51Buo43ttGRk?=
 =?us-ascii?q?F6Adjq2gjKwi6CG7YIk/mOA5su/+TX2H2ndOhnzHOT77Usl1krRIN0MGSigq?=
 =?us-ascii?q?Nuv1zIC5Xhj1SSl6Hsc78VmiHK6jHQniK1oEhEXVsoAu3+VncFax6T9I+o6w?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DSBADXmCBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoESJYlukUkJAQEBAQEBAQEBNwEBhEACgiY4EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRUQsOCgICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CVyWsTX8zhUqDV4E+gQ4ojDZ5gQeBEScMA4JdPodZgl4EjVqJVkaXVoJDg?=
 =?us-ascii?q?kmTYQYbmnAtji+dFSKBWCsIAhgIIQ87gmxQGA2IDReOQSMDMI1sAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2020 17:16:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GHFg2O037734;
        Thu, 16 Jan 2020 12:15:42 -0500
Subject: Re: [PATCH 5/6] selinux: convert cond_expr to array
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-6-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <16478d80-ca30-8613-2152-239abac88d0c@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 12:17:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-6-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/conditional.c | 62 ++++++++++++-------------------
>   security/selinux/ss/conditional.h | 14 ++++---
>   2 files changed, 33 insertions(+), 43 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index b847fd2a6a51..8f9f2f3c86a0 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -23,18 +23,19 @@
>    */
>   static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
>   {
> -
> -	struct cond_expr *cur;
> +	u32 i;
>   	int s[COND_EXPR_MAXDEPTH];
>   	int sp = -1;
>   
> -	for (cur = expr; cur; cur = cur->next) {
> -		switch (cur->expr_type) {
> +	for (i = 0; i < expr->len; i++) {
> +		struct cond_expr_node *node = &expr->nodes[i];
> +
> +		switch (node->expr_type) {
>   		case COND_BOOL:
>   			if (sp == (COND_EXPR_MAXDEPTH - 1))
>   				return -1;
>   			sp++;
> -			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
> +			s[sp] = p->bool_val_to_struct[node->bool - 1]->state;
>   			break;
>   		case COND_NOT:
>   			if (sp < 0)
> @@ -91,7 +92,7 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   	int new_state;
>   	u32 i;
>   
> -	new_state = cond_evaluate_expr(p, node->expr);
> +	new_state = cond_evaluate_expr(p, &node->expr);
>   	if (new_state != node->cur_state) {
>   		node->cur_state = new_state;
>   		if (new_state == -1)
> @@ -133,12 +134,7 @@ int cond_policydb_init(struct policydb *p)
>   
>   static void cond_node_destroy(struct cond_node *node)
>   {
> -	struct cond_expr *cur_expr, *next_expr;
> -
> -	for (cur_expr = node->expr; cur_expr; cur_expr = next_expr) {
> -		next_expr = cur_expr->next;
> -		kfree(cur_expr);
> -	}
> +	kfree(node->expr.nodes);
>   	/* the avtab_ptr_t nodes are destroyed by the avtab */
>   	kfree(node->true_list.nodes);
>   	kfree(node->false_list.nodes);
> @@ -354,7 +350,7 @@ static int cond_read_av_list(struct policydb *p, void *fp,
>   	return 0;
>   }
>   
> -static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
> +static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
>   {
>   	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
>   		pr_err("SELinux: conditional expressions uses unknown operator.\n");
> @@ -371,43 +367,37 @@ static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
>   static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>   {
>   	__le32 buf[2];
> -	u32 len, i;
> +	u32 i, len;
>   	int rc;
> -	struct cond_expr *expr = NULL, *last = NULL;
>   
>   	rc = next_entry(buf, fp, sizeof(u32) * 2);
>   	if (rc)
> -		goto err;
> +		return rc;
>   
>   	node->cur_state = le32_to_cpu(buf[0]);
>   
>   	/* expr */
>   	len = le32_to_cpu(buf[1]);
> +	node->expr.nodes = kcalloc(len, sizeof(*node->expr.nodes), GFP_KERNEL);
> +	if (!node->expr.nodes)
> +		return -ENOMEM;
> +
> +	node->expr.len = len;
>   
>   	for (i = 0; i < len; i++) {
> +		struct cond_expr_node *expr = &node->expr.nodes[i];
> +
>   		rc = next_entry(buf, fp, sizeof(u32) * 2);
>   		if (rc)
>   			goto err;
>   
> -		rc = -ENOMEM;
> -		expr = kzalloc(sizeof(*expr), GFP_KERNEL);
> -		if (!expr)
> -			goto err;
> -
>   		expr->expr_type = le32_to_cpu(buf[0]);
>   		expr->bool = le32_to_cpu(buf[1]);
>   
> -		if (!expr_isvalid(p, expr)) {
> +		if (!expr_node_isvalid(p, expr)) {
>   			rc = -EINVAL;
> -			kfree(expr);
>   			goto err;
>   		}
> -
> -		if (i == 0)
> -			node->expr = expr;
> -		else
> -			last->next = expr;
> -		last = expr;
>   	}
>   
>   	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
> @@ -512,27 +502,23 @@ static int cond_write_av_list(struct policydb *p,
>   static int cond_write_node(struct policydb *p, struct cond_node *node,
>   		    struct policy_file *fp)
>   {
> -	struct cond_expr *cur_expr;
>   	__le32 buf[2];
>   	int rc;
> -	u32 len = 0;
> +	u32 i;
>   
>   	buf[0] = cpu_to_le32(node->cur_state);
>   	rc = put_entry(buf, sizeof(u32), 1, fp);
>   	if (rc)
>   		return rc;
>   
> -	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next)
> -		len++;
> -
> -	buf[0] = cpu_to_le32(len);
> +	buf[0] = cpu_to_le32(node->expr.len);
>   	rc = put_entry(buf, sizeof(u32), 1, fp);
>   	if (rc)
>   		return rc;
>   
> -	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
> -		buf[0] = cpu_to_le32(cur_expr->expr_type);
> -		buf[1] = cpu_to_le32(cur_expr->bool);
> +	for (i = 0; i < node->expr.len; i++) {
> +		buf[0] = cpu_to_le32(node->expr.nodes[i].expr_type);
> +		buf[1] = cpu_to_le32(node->expr.nodes[i].bool);
>   		rc = put_entry(buf, sizeof(u32), 2, fp);
>   		if (rc)
>   			return rc;
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index 5f97f678440e..4677c6ff7450 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -19,7 +19,7 @@
>    * A conditional expression is a list of operators and operands
>    * in reverse polish notation.
>    */
> -struct cond_expr {
> +struct cond_expr_node {
>   #define COND_BOOL	1 /* plain bool */
>   #define COND_NOT	2 /* !bool */
>   #define COND_OR		3 /* bool || bool */
> @@ -28,9 +28,13 @@ struct cond_expr {
>   #define COND_EQ		6 /* bool == bool */
>   #define COND_NEQ	7 /* bool != bool */
>   #define COND_LAST	COND_NEQ
> -	__u32 expr_type;
> -	__u32 bool;
> -	struct cond_expr *next;
> +	u32 expr_type;
> +	u32 bool;
> +};
> +
> +struct cond_expr {
> +	struct cond_expr_node *nodes;
> +	u32 len;
>   };
>   
>   /*
> @@ -52,7 +56,7 @@ struct cond_av_list {
>    */
>   struct cond_node {
>   	int cur_state;
> -	struct cond_expr *expr;
> +	struct cond_expr expr;
>   	struct cond_av_list true_list;
>   	struct cond_av_list false_list;
>   };
> 

