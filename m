Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F9C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2277A2146E
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="KEwqhjMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRPxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:53:22 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:19846 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfLRPxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 10:53:22 -0500
X-EEMSG-check-017: 58700293|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="58700293"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 15:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576684397; x=1608220397;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wlz4pWEgfe6Y/s+Q8/Z0N0Rzbns+hZUM52awO+FzXMA=;
  b=KEwqhjMdlGbSX7zUfOTka5FZDJ/+FMzRY5QvWUtXjSZqlQQDx/OV5Ygg
   tpljSyyYHlj7y0f0JAE7DqVOv2Zn01B8K8cGUsu18amYa6VPt91FIwcdK
   UjylTJsT4jZ4vhjsmhdxfH1PS20YH+2+M0r4VFHIIV/FKoNYF7DegTO08
   HzBQz9XdSYtCzY2B46e8BXxNK1ruEkTr4emSIsZCf9qawL5V9DUheXhba
   LagupccxRbXfOzFWH17oR5si3BTXghqOqX0pdTfD/lyK4+5YK37CKW/9S
   D7SxssU8pBpjOsWwAx1ivj4MDBZSRc77XoZKB9eyQn1yjghtk8SYcfO7F
   w==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36909962"
IronPort-PHdr: =?us-ascii?q?9a23=3Aw9SvkhFzQ+rtmJqcVY1R851GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8u7bnLW6fgltlLVR4KTs6sC17ON9fq4CCdfvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdutUSjIdtKKs8yA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRegAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/45bBasaIP3tWk78r8fYAQM5MwOu3ubnBtF92Z0EWW6WHq?=
 =?us-ascii?q?CWKrnevkOP5uIqO+OMfpMauC7hK/g54P7jlWM2lkUGfaa33Zobcmu4EehmI0?=
 =?us-ascii?q?qDfHrsjNMBHnkQvgclTezqjkGCXiBXZ3qoQ6084TQ7Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE51UY2BGDUqMEW3pd4WfQPoMbjidIsp/nTwFT7ShTJUh1R62vg/g17VnNv?=
 =?us-ascii?q?bU+jEftZ/70Nh15uvTlQw99DBtFMSSzX2CT3xunmMJWz833LlzoUl6yliezK?=
 =?us-ascii?q?h4h+JXGMdN5/NGTAg6L4TQz+9kBNDoXALOYNOJREyhQtW8DjE7VsgxzMMWY0?=
 =?us-ascii?q?ZhB9WiiQjO3zG0DL8RlryLAoE0863H0njvKMZy1WzG2LMij1Y4WMtPM3Ophq?=
 =?us-ascii?q?pl+wjUHY7JnF2Tl7y2eqQEwC7N6GCDwHKNvE5GTgFwSrnKXXcYZkvVttn2+k?=
 =?us-ascii?q?PCT6WpCbQiMwtB1MuCJrFNat3zglVMXO3jN8jGY2Kth2ewAg6FxrGLbIrqfW?=
 =?us-ascii?q?URxifdCE8Ekw8J+3aGLhYxBiG6rm3CFjNuE1XvY0Xt8eZisny7SlU4wB2Nb0?=
 =?us-ascii?q?1kz7C14AIaheSAS/MP2bIJoD8hpCtyHFaywtLWCtyAqxNifKpCe9M95klI1W?=
 =?us-ascii?q?bCugx8J5CgK6dihkAAfAhtpEPhzRZ3Cphakccwtn8qyhR9Jbia0FNZbzmYx4?=
 =?us-ascii?q?z/OqXLKmnu+xCic7bW1UvD0NaS4aoP8O43q0jnvA2wE0oi9HJn08NL3HeG+p?=
 =?us-ascii?q?rKCw8SAtrNVRMc/gN3tvnhaSk0+o3Q2GckZaK9qTLT88kiBOI4xBKtZZJUOe?=
 =?us-ascii?q?WPEwqkV4URDtOjOaoxkFigcxwAMfp69agoMsfgfPyDnOapOeF6hjO9pWJO5Y?=
 =?us-ascii?q?18lEWW+G40Tu/OwoZA2PyTwxGGSya5iVCtr8T6sZ5LaCtUHWelzyXgQolLae?=
 =?us-ascii?q?k6ZosPCGGzM+WpydhkwZ3gQXhV8BikHVxV9tWufE+pc1Hl3QBWnX8SqHijlD?=
 =?us-ascii?q?rwmyd4iBk1v6Gf22rI2O2kex0ZbD0YDFJ+hEvhdNDnx+sRW1KlOk1wzkqo?=
X-IPAS-Result: =?us-ascii?q?A2DvAACqSvpd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gWgFIBIqhASJA4ZVAQEBAQEGgRIliWqPXoFnCQEBAQEBAQEBATcBA?=
 =?us-ascii?q?YRAAoI9OBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjBBFBBQsLG?=
 =?us-ascii?q?AICJgICVwYBDAYCAQGCXz+CUwUgrQ51fzOFT4MzgUGBDiiMMnmBB4ERJwwDg?=
 =?us-ascii?q?i8uPoQxgyiCXgSNHolwRpc1gj+CQ5NKBhuaTo5OnF8igVgrCAIYCCEPO4JsU?=
 =?us-ascii?q?BgNjR4XjkEjAzCPIAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 15:53:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIFqjoj008951;
        Wed, 18 Dec 2019 10:52:47 -0500
Subject: Re: [PATCH v12 14/25] LSM: Ensure the correct LSM context releaser
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-15-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <24dedc1d-0668-1951-ca79-f8c8f52a34f5@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 10:53:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-15-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Add a new lsmcontext data structure to hold all the information
> about a "security context", including the string, its size and
> which LSM allocated the string. The allocation information is
> necessary because LSMs have different policies regarding the
> lifecycle of these strings. SELinux allocates and destroys
> them on each use, whereas Smack provides a pointer to an entry
> in a list that never goes away.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>   drivers/android/binder.c                | 10 +++++--
>   fs/ceph/xattr.c                         |  6 +++-
>   fs/nfs/nfs4proc.c                       |  8 +++--
>   fs/nfsd/nfs4xdr.c                       |  7 +++--
>   include/linux/security.h                | 39 +++++++++++++++++++++++--
>   include/net/scm.h                       |  5 +++-
>   kernel/audit.c                          | 14 ++++++---
>   kernel/auditsc.c                        | 12 ++++++--
>   net/ipv4/ip_sockglue.c                  |  4 ++-
>   net/netfilter/nf_conntrack_netlink.c    |  4 ++-
>   net/netfilter/nf_conntrack_standalone.c |  4 ++-
>   net/netfilter/nfnetlink_queue.c         | 13 ++++++---
>   net/netlabel/netlabel_unlabeled.c       | 19 +++++++++---
>   net/netlabel/netlabel_user.c            |  4 ++-
>   security/security.c                     | 18 ++++++++----
>   security/smack/smack_lsm.c              | 14 ++++++---
>   16 files changed, 141 insertions(+), 40 deletions(-)
> 

> diff --git a/include/linux/security.h b/include/linux/security.h
> index d12b5e828b8d..597d9802b89b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -128,6 +128,41 @@ enum lockdown_reason {
>   	LOCKDOWN_CONFIDENTIALITY_MAX,
>   };
>   
> +/*
> + * A "security context" is the text representation of
> + * the information used by LSMs.
> + * This structure contains the string, its length, and which LSM
> + * it is useful for.
> + */
> +struct lsmcontext {
> +	char	*context;	/* Provided by the module */
> +	u32	len;
> +	int	slot;		/* Identifies the module */
> +};
> +
> +/**
> + * lsmcontext_init - initialize an lsmcontext structure.
> + * @cp: Pointer to the context to initialize
> + * @context: Initial context, or NULL
> + * @size: Size of context, or 0
> + * @slot: Which LSM provided the context
> + *
> + * Fill in the lsmcontext from the provided information.
> + * This is a scaffolding function that will be removed when
> + * lsmcontext integration is complete.
> + */
> +static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
> +				   u32 size, int slot)
> +{
> +	cp->slot = slot;
> +	cp->context = context;
> +
> +	if (context == NULL || size == 0)
> +		cp->len = 0;
> +	else
> +		cp->len = strlen(context);
> +}

Why do you recompute the length instead of just storing size? Aside from 
being less efficient, it may also be incorrect; SELinux-generated 
contexts include the terminating NUL byte.
> diff --git a/security/security.c b/security/security.c
> index aaac748e4d83..6310ca7e84ed 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2144,17 +2144,23 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>   }
>   EXPORT_SYMBOL(security_secctx_to_secid);
>   
> -void security_release_secctx(char *secdata, u32 seclen)
> +void security_release_secctx(struct lsmcontext *cp)
>   {
>   	struct security_hook_list *hp;
> -	int *display = current->security;
> +	bool found = false;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> -		if (display == NULL || *display == LSMBLOB_INVALID ||
> -		    *display == hp->lsmid->slot) {
> -			hp->hook.release_secctx(secdata, seclen);
> -			return;
> +		if (cp->slot == hp->lsmid->slot) {
> +			hp->hook.release_secctx(cp->context, cp->len);
> +			found = true;
> +			break;
>   		}
> +
> +	memset(cp, 0, sizeof(*cp));
> +
> +	if (!found)
> +		pr_warn("%s context \"%s\" from slot %d not released\n",
> +			__func__, cp->context, cp->slot);

Not sure we need this warning but regardless, you cleared cp before the 
pr_warn() so the output won't be very useful.

>   }
>   EXPORT_SYMBOL(security_release_secctx);
>   
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 9737ead06b39..8e960f82bf3f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4482,11 +4482,16 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>   	return 0;
>   }
>   
> -/*
> - * There used to be a smack_release_secctx hook
> - * that did nothing back when hooks were in a vector.
> - * Now that there's a list such a hook adds cost.
> +/**
> + * smack_release_secctx - do everything necessary to free a context
> + * @secdata: Unused
> + * @seclen: Unused
> + *
> + * Do nothing but hold a slot in the hooks list.
>    */
> +static void smack_release_secctx(char *secdata, u32 seclen)
> +{
> +}
>   
>   static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>   {
> @@ -4729,6 +4734,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
>   	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
>   	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
> +	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
>   	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
>   	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
>   	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
> 

Is this just to avoid the warning above?  If so, I'd just get rid of the 
warning instead.
