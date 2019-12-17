Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5EBC2D0BF
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F342176D
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CbyBz70c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfLQSCl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:02:41 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:6279 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfLQSCk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 13:02:40 -0500
X-EEMSG-check-017: 62628034|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="62628034"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 18:02:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576605757; x=1608141757;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/5Sus09UcwL+JBv3G7XgeZYPeopZt7dtXkIX6VEt4UI=;
  b=CbyBz70cSZIceLcRWre+wVYIG7RJpizIy+tfR39KXOpOVFdmesVTBQR/
   0tLF+bM2WN301mjFRpD56TXw7NKchTiujiJ+QEmKU39u9fBADJ8cvMf4F
   w3B0QUgWOieMvhRp2b3xfjrSJuRK8NHVyxbepJkpfmFmSS2Vr/WpwEFrf
   ALgaCL366Ia/37Te+Vdz6LMmfo3h945hznmkm+ueUa24LqL6I8VwQA2qa
   lNYHeQdZuWnR5BTbxfqMicaTGVM6L2SlcFk17USC6bFcpazr7IGCGtGFK
   sFO/ykR+4mbWFUKP6d3aqGlpbsVMH25unl8LHab+YnRIhPjtkEtAKXFsz
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31198388"
IronPort-PHdr: =?us-ascii?q?9a23=3AVkD4IhG3FeJdqj8LsEaapZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8u+bnLW6fgltlLVR4KTs6sC17ON9fq4BidZuc3JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusUKg4ZuJbs9xg?=
 =?us-ascii?q?fHr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHBegCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jJ?=
 =?us-ascii?q?sTsULNHi/xg0X5krOZel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB74dOv3zQVH+tdzDAx8iLwO0w/zoCMhz1oMaR22PGL?=
 =?us-ascii?q?aVP7/IvlOS+u0vJOyMbpcPuDnhM/gl++LujXghlFABZ6apxoUYaXCiEvR9P0?=
 =?us-ascii?q?qZYWDjgsoPEWcOoAU+VvfniFyEUT5PeXmyW7gw6S08CIKjFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfmJGClWLEXfybYWEWuwMZTmUIsB7lzwLS7mhR5Um1RG0uw/w06BnIf?=
 =?us-ascii?q?bM+i0EqZLj08B45+nSlRE06Dx1AN2R03qTQG5og2MIXT423Lx/oEBkz1eD1r?=
 =?us-ascii?q?V3g+FcFdNN/P5JTAg6OoDGz+BgCND9RBjBftGXR1aiWNmmBisxTt0pyd8Uf0?=
 =?us-ascii?q?l9A8mijgzE3yeyGL8aibiLBJ0y8qLB0Hn8PNh9y3nY26k7lVUmQdVANXeghq?=
 =?us-ascii?q?Fh8wjfHYnJk1+Wl6yyb6QTwDbN9HufzWqJpExYUxB/XrveXX8DYUvWqtf561?=
 =?us-ascii?q?jeQL+uE7QnNQ5Byc+fKqtPcNHpik9GRPj7MtTEf22xg3uwBQqPxr6UborqfG?=
 =?us-ascii?q?Ud3CPHBEgGlAAT/WyJNQ4lBii/pWLTFyBhGkjpY0Pr9+l+qW+0QVUwzw2Qc0?=
 =?us-ascii?q?Jh0L+18AYPhfOAU/MTwq4EuCA5pjVsAlm92d3WC8eBpwpnZalcYs0y4E1B1W?=
 =?us-ascii?q?3HswxwJZ2gI7lmhl4ZbQR4oVni1w5tBYVDjMgqtmklwBB0Ka2Gyl9BdSuY14?=
 =?us-ascii?q?jqOrLLMmny4Ayva6nO11HGytmW56MP5e8gq1r5oQGpElMu83Bg09lSyXuT+I?=
 =?us-ascii?q?/GAxYVUZL0AQ4L8E1RrqrXc2EG7IPdyHNoPLP85jTLwN84LPAuyh+9cdNSKu?=
 =?us-ascii?q?aPHUn5FMhMQ4ClIfcnih6yZRINIe5W+bQcPsW6ev/A06mueK5imTW8l2VcyI?=
 =?us-ascii?q?Z010+NsS1mRaqA25cD3uHdxQaMSi39kEbkt8f7hIRJTS8dE3D5yiX+AoNVIK?=
 =?us-ascii?q?pocsJDEmqqIsuq1v1giJP3HX1V7liuAxUBwsD6VwCVagnGwQBI1UkR6UeikC?=
 =?us-ascii?q?+8wi08xyoltYKDzSfOxKLkbxNBNWlVEjoxxWzwKJS52ohJFHOjaBIkwV78vx?=
 =?us-ascii?q?f3?=
X-IPAS-Result: =?us-ascii?q?A2AXAAADF/ld/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBbAQBAQELAYFzgW0gEiqEBIkDhngGgTeJaooihSiBewkBAQEBAQEBAQE3A?=
 =?us-ascii?q?QGEQAKCPDYHDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz+CUyWuN38zhU+DQIFIgQ4oAYwxeYEHgTgPgl0+h1mCX?=
 =?us-ascii?q?gSXDEaXM4I+gkKTSAYbmkktjiCcTgMvgVgrCAIYCCEPO4JsUBEUjR4XjkEjA?=
 =?us-ascii?q?zCRfQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 18:02:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHI2IxT161091;
        Tue, 17 Dec 2019 13:02:18 -0500
Subject: Re: [PATCH v12 08/25] LSM: Use lsmblob in security_ipc_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-9-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7d4e26b4-e86c-271e-ca20-4bc7ffcd227d@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 13:02:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-9-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> There may be more than one LSM that provides IPC data
> for auditing. Change security_ipc_getsecid() to fill in
> a lsmblob structure instead of the u32 secid. The
> audit data structure containing the secid will be updated
> later, so there is a bit of scaffolding here.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/security.h |  7 ++++---
>   kernel/auditsc.c         |  5 ++++-
>   security/security.c      | 12 +++++++++---
>   3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 26b8cee65c64..61a80afbbdba 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -466,7 +466,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>   			unsigned long arg4, unsigned long arg5);
>   void security_task_to_inode(struct task_struct *p, struct inode *inode);
>   int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
>   int security_msg_msg_alloc(struct msg_msg *msg);
>   void security_msg_msg_free(struct msg_msg *msg);
>   int security_msg_queue_alloc(struct kern_ipc_perm *msq);
> @@ -1174,9 +1174,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>   	return 0;
>   }
>   
> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
> +					 struct lsmblob *blob)
>   {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>   }
>   
>   static inline int security_msg_msg_alloc(struct msg_msg *msg)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 04803c3099b2..ce8bf2d8f8d2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2285,11 +2285,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>   void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>   {
>   	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>   	context->ipc.uid = ipcp->uid;
>   	context->ipc.gid = ipcp->gid;
>   	context->ipc.mode = ipcp->mode;
>   	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> +	security_ipc_getsecid(ipcp, &blob);
> +	/* scaffolding on the [0] - change "osid" to a lsmblob */
> +	context->ipc.osid = blob.secid[0];
>   	context->type = AUDIT_IPC;
>   }
>   
> diff --git a/security/security.c b/security/security.c
> index 61571f5c7c5f..0d87a2349552 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1783,10 +1783,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>   	return call_int_hook(ipc_permission, 0, ipcp, flag);
>   }
>   
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
>   {
> -	*secid = 0;
> -	call_void_hook(ipc_getsecid, ipcp, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
> +	}
>   }
>   
>   int security_msg_msg_alloc(struct msg_msg *msg)
> 

