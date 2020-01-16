Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD0C33CB3
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5AA246AE
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="K3gAfAuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgAPRNA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:13:00 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:3183 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390592AbgAPRNA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 12:13:00 -0500
X-EEMSG-check-017: 46620989|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,327,1574121600"; 
   d="scan'208";a="46620989"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 17:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579194771; x=1610730771;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=aN3b1yc7IcUor/W1awAwrOH/zjuZ5V+8WI1Ru+jBeFM=;
  b=K3gAfAuI7S/oeKF7bKLlsvyDyuYorzrrZZSmLclwni0+J6MDMZGnXBr6
   nxfFWDWJRxfOt5vlE3usadfr2yWc35PT1coOjL+5g6U7iWDQFB90FeVsY
   FbfykLqNPhz0ezyug449gIw6vJsEz1jpWu2CR30EsDU4fVLM2kllX1gzn
   yiHvNBUm4cmYf5Qg9CeOoMHzACIiyqJSa/arln4oJQOSbZ5rfxKPi6ULL
   sNYGfCx8zm7ZSgrB+Sj6JETMGGmIJAZcKp6oOeX+CtKi5e8qsKqtPQ8BE
   tLv7A0ALh6D/ENy+hJf4vB3NNdBY/6+dqwmd5xhqTsvP5QruccnhdT0E7
   A==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="32037880"
IronPort-PHdr: =?us-ascii?q?9a23=3A5LEzxh3OXh5l4DCzsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKPrxwZ3uMQTl6Ol3ixeRBMOHsq4C07ed4vmoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZF+JqsxxR?=
 =?us-ascii?q?fEpmZEcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
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
X-IPAS-Result: =?us-ascii?q?A2CuBADUlyBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCJjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCw4KAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJaxKfzOFSoNWgT6BDiiMNnmBB4ERJw+CXT6HWYJeBI1aiVZGl1aCQ4JJk?=
 =?us-ascii?q?2EGG5pwLY4vnRUigVgrCAIYCCEPO4JsUBgNiA0XjkEjAzCNbAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Jan 2020 17:12:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GHC7rY037697;
        Thu, 16 Jan 2020 12:12:09 -0500
Subject: Re: [PATCH 4/6] selinux: convert cond_av_list to array
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-5-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b1b0d8e8-adae-9ff4-edc7-4ae7be561658@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 12:13:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-5-omosnace@redhat.com>
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
>   security/selinux/ss/conditional.c | 125 ++++++++++++------------------
>   security/selinux/ss/conditional.h |   8 +-
>   2 files changed, 53 insertions(+), 80 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index c8a02c9b23ee..b847fd2a6a51 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -87,8 +87,9 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
>    */
>   void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   {
> +	struct avtab_node *avnode;
>   	int new_state;
> -	struct cond_av_list *cur;
> +	u32 i;
>   
>   	new_state = cond_evaluate_expr(p, node->expr);
>   	if (new_state != node->cur_state) {
> @@ -96,19 +97,21 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   		if (new_state == -1)
>   			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
>   		/* turn the rules on or off */
> -		for (cur = node->true_list; cur; cur = cur->next) {
> +		for (i = 0; i < node->true_list.len; i++) {
> +			avnode = node->true_list.nodes[i];
>   			if (new_state <= 0)
> -				cur->node->key.specified &= ~AVTAB_ENABLED;
> +				avnode->key.specified &= ~AVTAB_ENABLED;
>   			else
> -				cur->node->key.specified |= AVTAB_ENABLED;
> +				avnode->key.specified |= AVTAB_ENABLED;
>   		}
>   
> -		for (cur = node->false_list; cur; cur = cur->next) {
> +		for (i = 0; i < node->false_list.len; i++) {
> +			avnode = node->false_list.nodes[i];
>   			/* -1 or 1 */
>   			if (new_state)
> -				cur->node->key.specified &= ~AVTAB_ENABLED;
> +				avnode->key.specified &= ~AVTAB_ENABLED;
>   			else
> -				cur->node->key.specified |= AVTAB_ENABLED;
> +				avnode->key.specified |= AVTAB_ENABLED;
>   		}
>   	}
>   }
> @@ -128,16 +131,6 @@ int cond_policydb_init(struct policydb *p)
>   	return 0;
>   }
>   
> -static void cond_av_list_destroy(struct cond_av_list *list)
> -{
> -	struct cond_av_list *cur, *next;
> -	for (cur = list; cur; cur = next) {
> -		next = cur->next;
> -		/* the avtab_ptr_t node is destroy by the avtab */
> -		kfree(cur);
> -	}
> -}
> -
>   static void cond_node_destroy(struct cond_node *node)
>   {
>   	struct cond_expr *cur_expr, *next_expr;
> @@ -146,8 +139,9 @@ static void cond_node_destroy(struct cond_node *node)
>   		next_expr = cur_expr->next;
>   		kfree(cur_expr);
>   	}
> -	cond_av_list_destroy(node->true_list);
> -	cond_av_list_destroy(node->false_list);
> +	/* the avtab_ptr_t nodes are destroyed by the avtab */
> +	kfree(node->true_list.nodes);
> +	kfree(node->false_list.nodes);
>   }
>   
>   static void cond_list_destroy(struct policydb *p)
> @@ -255,19 +249,17 @@ err:
>   
>   struct cond_insertf_data {
>   	struct policydb *p;
> +	struct avtab_node **dst;
>   	struct cond_av_list *other;
> -	struct cond_av_list *head;
> -	struct cond_av_list *tail;
>   };
>   
>   static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
>   {
>   	struct cond_insertf_data *data = ptr;
>   	struct policydb *p = data->p;
> -	struct cond_av_list *other = data->other, *list, *cur;
>   	struct avtab_node *node_ptr;
> -	u8 found;
> -	int rc = -EINVAL;
> +	u32 i;
> +	bool found;
>   
>   	/*
>   	 * For type rules we have to make certain there aren't any
> @@ -277,7 +269,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>   	if (k->specified & AVTAB_TYPE) {
>   		if (avtab_search(&p->te_avtab, k)) {
>   			pr_err("SELinux: type rule already exists outside of a conditional.\n");
> -			goto err;
> +			return -EINVAL;
>   		}
>   		/*
>   		 * If we are reading the false list other will be a pointer to
> @@ -287,29 +279,29 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>   		 * If we are reading the true list (other == NULL) there shouldn't
>   		 * be any other entries.
>   		 */
> -		if (other) {
> +		if (data->other) {
>   			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
>   			if (node_ptr) {
>   				if (avtab_search_node_next(node_ptr, k->specified)) {
>   					pr_err("SELinux: too many conflicting type rules.\n");
> -					goto err;
> +					return -EINVAL;
>   				}
> -				found = 0;
> -				for (cur = other; cur; cur = cur->next) {
> -					if (cur->node == node_ptr) {
> -						found = 1;
> +				found = false;
> +				for (i = 0; i < data->other->len; i++) {
> +					if (data->other->nodes[i] == node_ptr) {
> +						found = true;
>   						break;
>   					}
>   				}
>   				if (!found) {
>   					pr_err("SELinux: conflicting type rules.\n");
> -					goto err;
> +					return -EINVAL;
>   				}
>   			}
>   		} else {
>   			if (avtab_search(&p->te_cond_avtab, k)) {
>   				pr_err("SELinux: conflicting type rules when adding type rule for true.\n");
> -				goto err;
> +				return -EINVAL;
>   			}
>   		}
>   	}
> @@ -317,39 +309,22 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>   	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
>   	if (!node_ptr) {
>   		pr_err("SELinux: could not insert rule.\n");
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> -
> -	list = kzalloc(sizeof(*list), GFP_KERNEL);
> -	if (!list) {
> -		rc = -ENOMEM;
> -		goto err;
> +		return -ENOMEM;
>   	}
>   
> -	list->node = node_ptr;
> -	if (!data->head)
> -		data->head = list;
> -	else
> -		data->tail->next = list;
> -	data->tail = list;
> +	*data->dst = node_ptr;
>   	return 0;
> -
> -err:
> -	cond_av_list_destroy(data->head);
> -	data->head = NULL;
> -	return rc;
>   }
>   
> -static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
> +static int cond_read_av_list(struct policydb *p, void *fp,
> +			     struct cond_av_list *list,
> +			     struct cond_av_list *other)
>   {
> -	int i, rc;
> +	int rc;
>   	__le32 buf[1];
> -	u32 len;
> +	u32 i, len;
>   	struct cond_insertf_data data;
>   
> -	*ret_list = NULL;
> -
>   	rc = next_entry(buf, fp, sizeof(u32));
>   	if (rc)
>   		return rc;
> @@ -358,18 +333,24 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
>   	if (len == 0)
>   		return 0;
>   
> +	list->nodes = kcalloc(len, sizeof(*list->nodes), GFP_KERNEL);
> +	if (!list->nodes)
> +		return -ENOMEM;
> +
>   	data.p = p;
>   	data.other = other;
> -	data.head = NULL;
> -	data.tail = NULL;
>   	for (i = 0; i < len; i++) {
> +		data.dst = &list->nodes[i];
>   		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
>   				     &data);
> -		if (rc)
> +		if (rc) {
> +			kfree(list->nodes);
> +			list->nodes = NULL;
>   			return rc;
> +		}
>   	}
>   
> -	*ret_list = data.head;
> +	list->len = len;
>   	return 0;
>   }
>   
> @@ -432,7 +413,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>   	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
>   	if (rc)
>   		goto err;
> -	rc = cond_read_av_list(p, fp, &node->false_list, node->true_list);
> +	rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
>   	if (rc)
>   		goto err;
>   	return 0;
> @@ -511,24 +492,16 @@ static int cond_write_av_list(struct policydb *p,
>   			      struct cond_av_list *list, struct policy_file *fp)
>   {
>   	__le32 buf[1];
> -	struct cond_av_list *cur_list;
> -	u32 len;
> +	u32 i;
>   	int rc;
>   
> -	len = 0;
> -	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next)
> -		len++;
> -
> -	buf[0] = cpu_to_le32(len);
> +	buf[0] = cpu_to_le32(list->len);
>   	rc = put_entry(buf, sizeof(u32), 1, fp);
>   	if (rc)
>   		return rc;
>   
> -	if (len == 0)
> -		return 0;
> -
> -	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
> -		rc = avtab_write_item(p, cur_list->node, fp);
> +	for (i = 0; i < list->len; i++) {
> +		rc = avtab_write_item(p, list->nodes[i], fp);
>   		if (rc)
>   			return rc;
>   	}
> @@ -565,10 +538,10 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
>   			return rc;
>   	}
>   
> -	rc = cond_write_av_list(p, node->true_list, fp);
> +	rc = cond_write_av_list(p, &node->true_list, fp);
>   	if (rc)
>   		return rc;
> -	rc = cond_write_av_list(p, node->false_list, fp);
> +	rc = cond_write_av_list(p, &node->false_list, fp);
>   	if (rc)
>   		return rc;
>   
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index e474bdd3a0ed..5f97f678440e 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -39,8 +39,8 @@ struct cond_expr {
>    * struct is for that list.
>    */
>   struct cond_av_list {
> -	struct avtab_node *node;
> -	struct cond_av_list *next;
> +	struct avtab_node **nodes;
> +	u32 len;
>   };
>   
>   /*
> @@ -53,8 +53,8 @@ struct cond_av_list {
>   struct cond_node {
>   	int cur_state;
>   	struct cond_expr *expr;
> -	struct cond_av_list *true_list;
> -	struct cond_av_list *false_list;
> +	struct cond_av_list true_list;
> +	struct cond_av_list false_list;
>   };
>   
>   int cond_policydb_init(struct policydb *p);
> 

