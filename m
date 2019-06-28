Return-Path: <SRS0=x6Ba=U3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7776C4321A
	for <selinux@archiver.kernel.org>; Fri, 28 Jun 2019 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660662064A
	for <selinux@archiver.kernel.org>; Fri, 28 Jun 2019 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="iVxwImiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfF1OqQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:46:16 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:49303 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OqP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jun 2019 10:46:15 -0400
X-EEMSG-check-017: 691126319|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,428,1557187200"; 
   d="scan'208";a="691126319"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jun 2019 14:46:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1561733163; x=1593269163;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rhXeg8dKQd0MDs7MS3rNsR+paa9zDxblmL26x2NuT9I=;
  b=iVxwImiW2Ni3mlRTZMVOV3Tz/Uev0bNYRiQpJK02be2pgneZMQZmd/Co
   ckO2ygJR3fzcO7S+7wNvedEqIJcPe+9aE4YTUXVin13d3JVcdd/mvvqfI
   0+VNIU/HeGSHTm6gum42VfLtdz/OaQRIT2zn1w+uO9hGCjBngkFHPOT9i
   b9/AZMyBDD/ON0GCWFRfxJKa+DFJYXmV93CwcgtQjUG3xPrJ8G5CDRCIF
   Ns40GH60ZkQqBw3GjmxSdRGxNjTkhSSo57aPvSKIm6WYqOkqNw1CntraT
   NkM4M8YSjzkhrer01r6XAo2fFfVP90SZz3Q1hoLe6lZqdCdnpwWd3jFH1
   A==;
X-IronPort-AV: E=Sophos;i="5.63,428,1557187200"; 
   d="scan'208";a="29554556"
IronPort-PHdr: =?us-ascii?q?9a23=3APsfvXxF6DASQu8PJNKg/+51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8SybnLW6fgltlLVR4KTs6sC17OM9fq4EjxZqdbZ6TZeKcUKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZ8Jqor1B?=
 =?us-ascii?q?fFvnREdudLyWh1IV6fgwvw6t2/8ZJ+7ihcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdv4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0PBCuzOb8Ftp81pgTWXmTDa?=
 =?us-ascii?q?+ZKqzSrFGI5uYxLOmWfYMapCzyJ+I56P7piH8zgUUdcrWx3ZsLdHC4GexrLF?=
 =?us-ascii?q?mDbnr3nNgAEX0GvhEiQ+zqklKCTDBTZ3KsUKIm/Tw7CYSmDZvdSYCpmrCOwC?=
 =?us-ascii?q?C7HphObGBcFl+MCWvod5mDW/oUaiKSJ8hhkiYeVbigUI8szheuuxX/y7V5L+?=
 =?us-ascii?q?rY4CoYtYjs1NJt/e3ciQky9SBoD8Say2yNS2B0nmUVRz45xax/ulJyxUue0a?=
 =?us-ascii?q?higvxYCdxS6+pMUgc9KJHc0uh6BM7pVwLfcdeGVkymTs+lAT4vVNIxxcEBY0?=
 =?us-ascii?q?JnF9WllBDD0DKgA6UJmLyTGJw07qXc0mDqJ8ljz3bG1a8hj0QpQ8ZUK22mib?=
 =?us-ascii?q?Bw9xLJC47KjUqZjaCqeroY3CLX82eD12WOtllCUAFsSaXFQWwfZkzOoNT6+E?=
 =?us-ascii?q?zNUaSuBqggMgtGys6PMbdFat3zjVVBQffjOcneY2erl2e3HxaIyauGbJD2dG?=
 =?us-ascii?q?UFwCXdFE8EnhgR/XaBNQg+AD2to2DZDDxuD13vZVjs/vd4qH6gUkA71QeKb0?=
 =?us-ascii?q?pn17q05hEan/icR+kP0bIDvScrsy90E0ql39LKF9qAoBJsfL1CbtM771dHyG?=
 =?us-ascii?q?PZtwpkMpyjMa9inFgefBpzv0711hV7E4FAkc80rHw01gZyMriX0FBcdzOCx5?=
 =?us-ascii?q?/8ILvXJXfo8BCtc67cwkve38qO+qcT9PQ4rE3uvBmzGUo/93VqyMFV3GGB5p?=
 =?us-ascii?q?XOFQYSVJXxUkEt9xdkvb3Vfi4954aHnUFrZIK9qTLTk+kiBOI4xBKtZZ8LO6?=
 =?us-ascii?q?qfGR7aCMYaDtWgLOEw3lOgKBkDObYWvKU9JM63MeCN2Ke2MuJthhqni3hK5M?=
 =?us-ascii?q?Z21UfIvyh5TfTS3o0txfid0wrBUC3zyB+ls8bqicVfaDoPBGuj2G3hA4JMYq?=
 =?us-ascii?q?BaY4kGEyGtLtexy9E4gITiHzZD+VqiAU4W8NGmdADUbFHn2wBUk0MNri+Jgy?=
 =?us-ascii?q?y9mgdonikpo6zX5ynHx+DvZVJTIWJQbHVzhlfrZ46vhpYVW1b+PFthrwes+U?=
 =?us-ascii?q?uvn/sTn694NWSGBB4TLiU=3D?=
X-IPAS-Result: =?us-ascii?q?A2CbDwAAJxZd/wHyM5BlHQEBBQEHBQGBZ4FtKoE7ATIoh?=
 =?us-ascii?q?ByTQAEBAQEBAQaBCQgliVmJC4gJCQEBAQEBAQEBATQBAgEBhEACgwAjOBMBA?=
 =?us-ascii?q?wEBAQQBAQEBBAEBbIpDgjopAYJmAQEBAQIBIwQRQRALGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+BdwUPpz9/M4VHgzSBRoEMKItfF3iBB4ERJwyCXz6HToJYBJN7WpVXC?=
 =?us-ascii?q?YIYgh+GOYsbBgIZgiuLJooSjS2ZMCGBWCsIAhgIIQ87gmyCTReOPSMDMIEGA?=
 =?us-ascii?q?QGPPwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jun 2019 14:46:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5SEjtw7018885;
        Fri, 28 Jun 2019 10:45:55 -0400
Subject: Re: [PATCH v4 15/23] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-16-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <89561452-86f9-fd9a-1390-0cd4bde1fd62@tycho.nsa.gov>
Date:   Fri, 28 Jun 2019 10:45:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626192234.11725-16-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/19 3:22 PM, Casey Schaufler wrote:
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.
> The name of an active LSM that supplies hooks for human readable
> data may be written to "display" to set the value. The name of
> the LSM currently in use can be read from "display".
> At this point there can only be one LSM capable of display
> active.

IIUC, presently, at the end of the entire series,

1) Any process can change its display attribute to any enabled security 
module, and no security module can veto that change.

2) The display attribute is inherited across fork and exec, even execs 
that change credentials, and again no security module has control over 
the inheritance of this attribute.

3) Setting the display attribute affects more than just the contexts 
read or written by the process itself:
- Contexts reported in audit logs,
- Contexts passed across binder (generated in sender context, delivered 
to receiver),
- Contexts passed to NFS servers for new files,
- Contexts returned by NFS servers for existing files,
- Netlink-related contexts (?possibly generated in sender context rather 
than receiver context?),
- This list may not be complete.

4) A security_secid_to_secctx() in one process' context (e.g. sender) or 
with one display value followed later by a security_secctx_to_secid() 
call in a different process' context (e.g. receiver) or with a different 
display value may ask a different security module to perform the reverse 
translation of the context than the forward translation.

Is that correct?  If so, it seems problematic.
	
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/proc/base.c      |   1 +
>   security/security.c | 129 ++++++++++++++++++++++++++++++++++++++------
>   2 files changed, 113 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..7bf70e041315 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "fscreate",		0666),
>   	ATTR(NULL, "keycreate",		0666),
>   	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/security/security.c b/security/security.c
> index 3180a6f30625..82e29c477fa4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
>   static struct kmem_cache *lsm_inode_cache;
>   
>   char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(int),	/* slot number for the "display" LSM */
> +};
>   
>   /* Boot-time LSM user choice */
>   static __initdata const char *chosen_lsm_order;
> @@ -423,8 +425,10 @@ static int lsm_append(const char *new, char **result)
>   
>   /*
>    * Current index to use while initializing the lsmblob secid list.
> + * Pointers to the LSM id structures for local use.
>    */
>   static int lsm_slot;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>   
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -444,6 +448,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	if (lsmid->slot == LSMBLOB_NEEDED) {
>   		if (lsm_slot >= LSMBLOB_ENTRIES)
>   			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>   		lsmid->slot = lsm_slot++;
>   		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>   			   lsmid->slot);
> @@ -564,6 +569,8 @@ int lsm_inode_alloc(struct inode *inode)
>    */
>   static int lsm_task_alloc(struct task_struct *task)
>   {
> +	int *display;
> +
>   	if (blob_sizes.lbs_task == 0) {
>   		task->security = NULL;
>   		return 0;
> @@ -572,6 +579,15 @@ static int lsm_task_alloc(struct task_struct *task)
>   	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>   	if (task->security == NULL)
>   		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "display" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	display = task->security;
> +	*display = LSMBLOB_INVALID;
> +
>   	return 0;
>   }
>   
> @@ -1563,14 +1579,24 @@ int security_file_open(struct file *file)
>   
>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>   {
> +	int *odisplay = current->security;
> +	int *ndisplay;
>   	int rc = lsm_task_alloc(task);
>   
> -	if (rc)
> +	if (unlikely(rc))
>   		return rc;
> +
>   	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>   		security_task_free(task);
> -	return rc;
> +		return rc;
> +	}
> +
> +	ndisplay = task->security;
> +	if (ndisplay && odisplay)
> +		*ndisplay = *odisplay;
> +
> +	return 0;
>   }
>   
>   void security_task_free(struct task_struct *task)
> @@ -1967,10 +1993,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   				char **value)
>   {
>   	struct security_hook_list *hp;
> +	int *display = current->security;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +		if (*display != LSMBLOB_INVALID)
> +			slot = *display;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>   		return hp->hook.getprocattr(p, name, value);
>   	}
>   	return -EINVAL;
> @@ -1980,10 +2025,46 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   			 size_t size)
>   {
>   	struct security_hook_list *hp;
> +	char *term;
> +	char *cp;
> +	int *display = current->security;
> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0 || size == 0)
> +			return -EINVAL;
> +		cp = kzalloc(size + 1, GFP_KERNEL);
> +		if (cp == NULL)
> +			return -ENOMEM;
> +		memcpy(cp, value, size);
> +
> +		term = strchr(cp, ' ');
> +		if (term == NULL)
> +			term = strchr(cp, '\n');
> +		if (term != NULL)
> +			*term = '\0';
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
> +				*display = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(cp);
> +		return rc;
> +	}
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}
>   	return -EINVAL;
> @@ -2003,15 +2084,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>   int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>   {
>   	struct security_hook_list *hp;
> -	int rc;
> +	int *display = current->security;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> +		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>   	}
>   	return 0;
>   }
> @@ -2021,16 +2102,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>   			     struct lsmblob *blob)
>   {
>   	struct security_hook_list *hp;
> -	int rc;
> +	int *display = current->security;
>   
>   	lsmblob_init(blob, 0);
>   	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>   	}
>   	return 0;
>   }
> @@ -2038,7 +2118,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>   
>   void security_release_secctx(char *secdata, u32 seclen)
>   {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (*display == LSMBLOB_INVALID ||
> +		    *display == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>   }
>   EXPORT_SYMBOL(security_release_secctx);
>   
> @@ -2163,8 +2251,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>   				      int __user *optlen, unsigned len)
>   {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	int *display = current->security;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> +			     list)
> +		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
> +			return hp->hook.socket_getpeersec_stream(sock, optval,
> +								 optlen, len);
> +	return -ENOPROTOOPT;
>   }
>   
>   int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> 

