Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC82C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9A82070B
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Qt34vwzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfAIOiW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:38:22 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:41059 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbfAIOiW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 09:38:22 -0500
X-EEMSG-check-017: 180939164|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2019 14:38:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547044696; x=1578580696;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oQ6Vwtdz2+GonlnHnG4d6WkJgHa0ZqYYMrsayRcQEh8=;
  b=Qt34vwzTJPISZb+6KZOSbvHHMfQ0fMmOpeVx16GiMPKQYCeWcoxQfnzI
   KcahA4//yemb1uSWGLyquZlq4/+meK+yQ/L+sHmeBJ2YXPJkYdcvrSWjp
   1MPnD+C6ymBOol+xu0DhIcwYDpne/M3mrRFG6jDeqQAZ758jJjpxeWAU6
   lBhApt62UoHMPtENro0k0cqc2MQpNBdk3jEjSAl52HeC5Fj0WNgcGgkiQ
   aZt833rfezJs7d5zJDjVtetF4Jfa8eFdgi1cAz8lGqrwnEUWW/p1hyzfC
   LKxffiu9cSv8kQa57/+t11cj+LxTkpQqtNMG8ffM0aoZBMxIwpYmS95p3
   A==;
X-IronPort-AV: E=Sophos;i="5.56,457,1539648000"; 
   d="scan'208";a="19357637"
IronPort-PHdr: =?us-ascii?q?9a23=3ARrXZEhfUBftmUS7lrakjuSfmlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc25ZBWN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGmHH206053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujBPr3kBZXNNX7Dn639cr?=
 =?us-ascii?q?lj8ENc0hQ8ws1f551OFrENOu78Wkj0tNbAFB82LxS0w/r7CNV6zo4eQnyAAq?=
 =?us-ascii?q?uYMKPUrF+J6fkiI/eDZIALojbxMfsl6OD0jX8/h1AdebOl3ZwNaHC3Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHphI+Q/b3iF2GSjNTf2y9X7845j0iDYKmCoDDRpqzj7CbwC?=
 =?us-ascii?q?i7GZhWbHhcCl+QCXfoa5mEW/AUZSKWI89hlCEEVLe4R486yx6hqBL6y6BmLu?=
 =?us-ascii?q?rI+iwUrJfj1N9o6O3OkRE96yd5D9qS026TVWF4hGAISCEs3KB5v0N9zk2P0a?=
 =?us-ascii?q?9ig/xXDdZT/e9GUh8mNZ7AyOx3E9/yWhjfcdeGS1amQs6rATUwTtI33t8PbE?=
 =?us-ascii?q?h9G9K/jhDFwiWlGaMVl72MBJwy6K7c2GLxJ8llwXbcyKYhl0UmQtdINWC+mq?=
 =?us-ascii?q?5/9RPeB43XnEWDkaala6Ac0DTK9GeZwmqEpFtYXxJoUaXZQXAfYVPbrdD45k?=
 =?us-ascii?q?PEUr+vBq0rMgVaycGfNKRKdMPmjVFdSff9N9TRfXixl32zBRmW3LOMapTle2?=
 =?us-ascii?q?EH0CXaEkgEnBgZ/WyaOggmGiehv2XeASRyGlLgeUPs9vR+qGugTkIv0QGKYF?=
 =?us-ascii?q?Nu16Cv9h4Wm/OcUfUT0awAuCs7rDV0Blm9jJrqDI+noQZ7cacURNQm5l5M2G?=
 =?us-ascii?q?GR4wt4OYemJqtvrkQTfwR+owXl0BAhTs1bnMwrqm465BR9JLje015bcT6cm5?=
 =?us-ascii?q?fqNfmfEmDv+FiKbKnM1xmKyN+L/o8X4ek87lDkuxukUEEl9iM0/cNS1i6n+p?=
 =?us-ascii?q?jSDAcUGan0W0Iz+gky86rWeQEh9ojU0jtqKqDyvTjcjYF6TNA5wwqtKo8MeJ?=
 =?us-ascii?q?iPExX/RohDXZCj?=
X-IPAS-Result: =?us-ascii?q?A2BuAACsBjZc/wHyM5BjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYFoJ4QAlARMAQEBAQEBBoEILYksiUOGfjgBhEACgh8iNwYNAQMBA?=
 =?us-ascii?q?QEBAQECAWwogjopAYJnAQUjBBFBEAsOCgICJgICVwYBDAYCAQGCXz+BdQ2qe?=
 =?us-ascii?q?XwzhUGEdoELizQXeIEHgTiCa4gKglcCj3BJN5B8CZF3BhiRdy2JP5JDIoFWK?=
 =?us-ascii?q?wgCGAghD4MngicXjjwhAzCBBQEBii0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2019 14:38:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x09EcE9V003707;
        Wed, 9 Jan 2019 09:38:14 -0500
Subject: Re: [PATCH 2/3] selinux: Implement the object_init_security hook
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190109091028.24485-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f14d46d2-26f3-2c62-963d-7736a82a78b4@tycho.nsa.gov>
Date:   Wed, 9 Jan 2019 09:40:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109091028.24485-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/19 4:10 AM, Ondrej Mosnacek wrote:
> The hook applies the same logic as selinux_determine_inode_label(), with
> the exception of the super_block handling, which will be enforced on the
> actual inodes by other hooks.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 41 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce012d9ec51..29c038513504 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3526,6 +3526,45 @@ static int selinux_inode_copy_up_xattr(const char *name)
>   	return -EOPNOTSUPP;
>   }
>   
> +/* file-like object operations */
> +
> +/* Used e.g. for kernfs_node for newly created nodes */
> +static int selinux_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> +					const struct qstr *qstr, u16 mode,
> +					void **ctx, u32 *ctxlen)
> +{
> +	const struct task_security_struct *tsec = current_security();
> +	u32 parent_sid, newsid, clen;
> +	int rc;
> +	char *context;
> +
> +	rc = security_context_to_sid(&selinux_state, parent_ctx, parent_ctxlen,
> +				     &parent_sid, GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	if (tsec->create_sid) {
> +		newsid = tsec->create_sid;
> +	} else {
> +		u16 secclass = inode_mode_to_security_class(mode);
> +
> +		rc = security_transition_sid(&selinux_state, tsec->sid,
> +					     parent_sid, secclass, qstr,
> +					     &newsid);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = security_sid_to_context_force(&selinux_state, newsid,
> +					   &context, &clen);
> +	if (rc)
> +		return rc;
> +
> +	*ctx = context;
> +	*ctxlen = clen;
> +	return 0;
> +}
> +
>   /* file security operations */
>   
>   static int selinux_revalidate_file_permission(struct file *file, int mask)
> @@ -6965,6 +7004,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
>   	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
>   
> +	LSM_HOOK_INIT(object_init_security, selinux_object_init_security),
> +
>   	LSM_HOOK_INIT(file_permission, selinux_file_permission),
>   	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
>   	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
> 

