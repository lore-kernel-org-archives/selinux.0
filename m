Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6594CA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCA12087E
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HKQf8eoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfJ3P3h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:29:37 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:61144 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfJ3P3g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 11:29:36 -0400
X-EEMSG-check-017: 43344709|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="scan'208";a="43344709"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Oct 2019 15:29:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572449375; x=1603985375;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=g987TzcHMGHFIDtOduhJsVCYEd3ZBOh4KlEkW6lHYb4=;
  b=HKQf8eoCN6moRDx2hRJrJqbGZqXSy7sfCbS6KrILGFUF1nMKjpaycrR0
   SnxkOgRNNa1kyhBCg+ly4zmAvb1AXsvdQ8ZdTwwBbSMuh7jhSlUIxjbw7
   nIZTS+HWfN4dGzExNn3BHF+fYFH6k+pLp0rFU/NA3rN2Xw/uDdfI4Uo1v
   d+M8e7LkADqRbMpeJbWvZ4ZeupNkqgwSIpla6COP4iBwWrcgSpIVqtpSl
   dYwCaAjm3cF46FnmBvxIpmQrm6oNVoGvyvRPZybI6q18lQFf3/2cwaQCq
   nCeB4s7exV496JuaZUBBpc5hIEiYrm5CWtHNN0Lq24xa69Bvfe9eic5WA
   g==;
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="scan'208";a="29562359"
IronPort-PHdr: =?us-ascii?q?9a23=3AlQL4Nhf7/Nfj41cXP19xSOc4lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS6bR7h7PlgxGXEQZ/co6odzbaP6Oa5ATdLvsjJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusUKj4ZuJaQ8xx?=
 =?us-ascii?q?rUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU2/nvXishth6xFphyvqQF0z4rNbIyVMPdye6XQds4YS2?=
 =?us-ascii?q?VcRMZcTzFPDJ2yb4UPDOQPM+hXoIb/qFQSohWzHhWsCeH1xzNUmnP706833u?=
 =?us-ascii?q?I8Gg/GxgwgGNcOvWzJotXpKqgSSeC1w7fOzT7ecv1W3C3y6IzMch8/ofCHQL?=
 =?us-ascii?q?V9cdHMxkk0DA7FklWRppDlPzOSzOgNtXOb4PB6WeKgjG4ntRh8rz6yzckvko?=
 =?us-ascii?q?nEnp8Zx1/L+CljwIs5OMe0RFB0bNK6CpdcqieXPJZsTMw4WWFnoiM6x6UDuZ?=
 =?us-ascii?q?68YScF1owqxwXaa/yba4iI5Q/jVPqJLTd4mn1lfLW/ig6u8Ue60O38V9S00E?=
 =?us-ascii?q?1QoipZktjDqnAN1xvJ5siBVvR95Vuu1SyK1wDS7uFIOUE0lazFJJ492rM8i5?=
 =?us-ascii?q?UevEvZEiL2hUn6lrGae0o69uSy9ujrerDmqYWdN49whAH+KKMumsmnDOQjLw?=
 =?us-ascii?q?cORHOW+fi81bL//U35R69GjvstkqbDqpzaKsMbprChDw9Pzokj8wq/Dyuh0N?=
 =?us-ascii?q?kAhnkIMlZFeBOBj4j0NFDDO+74DfihjFS2ijtrxO7JPqfnAprTKnjPirDhfa?=
 =?us-ascii?q?xy60RE0go80chf545ICrEGOP/zQlX+tMHcDhIiKwy72fvnCNFk2oMbXmKPBb?=
 =?us-ascii?q?WZP73IvVCU4eIvJrrEWIhAozv5Kv4499bwgnIj31wQZ6+k2d0Qcn/rMO5hJh?=
 =?us-ascii?q?CifXf0gtoHWVwPtw46Qf2i3EaOShZPdn2yWOQ6/Th9B4W4W9SQDruxiaCMiX?=
 =?us-ascii?q?/oVqZdYXpLXxXRQHo=3D?=
X-IPAS-Result: =?us-ascii?q?A2B5AAA0q7ld/wHyM5BkHAEBAQEBBwEBEQEEBAEBgWoGA?=
 =?us-ascii?q?QELAYFzLIFBMiqEKJBzJYljjzaBewkBAQEBAQEBAQE0AQIBAYRAAoNmJDUID?=
 =?us-ascii?q?gIMAQEBBAEBAQEBBQMBAWyFQ4I7KYJuAQUjFTwFEAsYAgImAgJXEwYCAQGCX?=
 =?us-ascii?q?z+CUyWzQYEyhU6DQIFIgQ4oAYwQGHiBB4ERJwyCXz6HVYJeBI05iQGBNJYAg?=
 =?us-ascii?q?i6CM5J4BhuZXqoKAjWBWCsIAhgIIQ+DJ1AQFIMSFxWOKiUDMIEFAQGNZQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Oct 2019 15:29:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9UFTXF0018378;
        Wed, 30 Oct 2019 11:29:33 -0400
Subject: Re: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and
 confidentiality
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20191030131633.9356-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <365ca063-6efd-8051-8d4b-5c8aef0d2e12@tycho.nsa.gov>
Date:   Wed, 30 Oct 2019 11:29:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030131633.9356-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/30/19 9:16 AM, Stephen Smalley wrote:
> Add SELinux access control hooks for lockdown integrity and
> confidentiality. This effectively mimics the current implementation of
> lockdown (caveat noted below). If lockdown is enabled alongside SELinux,
> then the lockdown access control will take precedence over the SELinux
> lockdown implementation.
> 
> Note that this SELinux implementation allows the integrity and
> confidentiality reasons to be controlled independently from one another.
> Thus, in an SELinux policy, one could allow integrity operations while
> blocking confidentiality operations.

NB This is intended to be the first of a series that will ultimately 
lead to finer-grained controls than just integrity and confidentiality, 
but wanted to get some feedback on it at this stage.  Also anticipate 
greater controversy over exposing finer granularity since the lockdown 
reasons are free to change at any time, so this would be the baseline 
fallback position if finer grained controls are rejected.

> 
> (original patch authored by an intern who wishes to remain anonymous;
> I am signing off on his behalf)
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   security/selinux/hooks.c            | 22 ++++++++++++++++++++++
>   security/selinux/include/classmap.h |  2 ++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 36e531b91df2..6722c6b4ae74 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -91,6 +91,7 @@
>   #include <uapi/linux/mount.h>
>   #include <linux/fsnotify.h>
>   #include <linux/fanotify.h>
> +#include <linux/security.h>
>   
>   #include "avc.h"
>   #include "objsec.h"
> @@ -6799,6 +6800,25 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>   }
>   #endif
>   
> +static int selinux_lockdown(enum lockdown_reason what)
> +{
> +	u32 sid = current_sid();
> +
> +	if (what <= LOCKDOWN_INTEGRITY_MAX)
> +		return avc_has_perm(&selinux_state,
> +				sid, sid,
> +				SECCLASS_LOCKDOWN, LOCKDOWN__INTEGRITY, NULL);
> +	else if (what <= LOCKDOWN_CONFIDENTIALITY_MAX)
> +		return avc_has_perm(&selinux_state,
> +				sid, sid,
> +				SECCLASS_LOCKDOWN, LOCKDOWN__CONFIDENTIALITY,
> +				NULL);
> +
> +	/* invalid reason */
> +	pr_warn("SELinux: invalid lockdown reason\n");
> +	return -EPERM;
> +}
> +
>   struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>   	.lbs_cred = sizeof(struct task_security_struct),
>   	.lbs_file = sizeof(struct file_security_struct),
> @@ -7042,6 +7062,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>   	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>   #endif
> +
> +	LSM_HOOK_INIT(locked_down, selinux_lockdown),
>   };
>   
>   static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 32e9b03be3dd..594c32febcd8 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
>   	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
>   	{ "xdp_socket",
>   	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "lockdown",
> +	  { "integrity", "confidentiality", NULL } },
>   	{ NULL }
>     };
>   
> 

