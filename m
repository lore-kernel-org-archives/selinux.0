Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC25C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5795206C2
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hUerXfjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbfIPTQF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:16:05 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:63892 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTQF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 15:16:05 -0400
X-EEMSG-check-017: 28349278|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28349278"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 19:15:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568661332; x=1600197332;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7wd0yj5Ez0juicqKHYECS0TajeX9hkhN9llsYCrfitg=;
  b=hUerXfjLFZFP+Sg8FSYWOR5B81ie3u3Mb+8l5t3l43u5EhLlDT4v5sXl
   hN96kNhH3Yts9AF6EbhXQGJWlxtU90dclvklQ0+Hvel23L6chWXsotLrE
   QYUMeEW6qJXJ/5zkH2yjKk6sN9mWiSI0nNq1+9sXYl6ujJGv3yePjFoJS
   xp3Klmphi2OcYbI2ns47imXuU63Cg+FxQ1xomWKD+LIt2LQykJyju80J4
   Aue4XGjRPkO4uXxbdUs6jANbk33vbcFLxsyaPweXIYtcwKH6HHpUYDx7G
   8nMQjysnSeAKX5KF0+O1xzdSVWiBC/TF4lbVqCrSZhFnDQE1HDmMZZCcw
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32912381"
IronPort-PHdr: =?us-ascii?q?9a23=3AQ61xLBChwvAqwa/k7qLRUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/rs2wAkXT6L1XgUPTWs2DsrQY0rGQ6vurADdcqdbZ6TZeKcYKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZsJ6or1x?=
 =?us-ascii?q?fErHREd/lYyG5nOFmfmwrw6tqq8JNs7ihcpegt+9JcXan/Yq81UaFWADM6Pm?=
 =?us-ascii?q?4v+cblrwPDTQyB5nsdVmUZjB9FCBXb4R/5Q5n8rDL0uvJy1yeGM8L2S6s0WS?=
 =?us-ascii?q?m54KdwVBDokiYHOCUn/2zRl8d9kbhUoBOlpxx43o7UfISYP+dwc6/BYd8XQ3?=
 =?us-ascii?q?dKU91PXCJdHIyzc4oPD/IAPelGqYn9u0AOpga6CQW1Ge/j1iNEinrw0KI0ye?=
 =?us-ascii?q?QhFRzN0hImEdwArX/YqMz5OLkWXOywyqTD0DfNYO5M2Trl9YbGbB4hr/GPU7?=
 =?us-ascii?q?x+f8XexksgGB/KgFiLtYzoPSmY2vgRv2WV7edtU/+khW49qwF2pzii3toiip?=
 =?us-ascii?q?XXiYINylDL6yN5y5soK929UkF7ZdqkH4VQtiqHMIZ2Wd4tQ3pztSYmyrwJpZ?=
 =?us-ascii?q?67fC8QxJQh3B7QceaLc4eP4hL9TeucJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4ih3+M6symsy/Bv40Mg?=
 =?us-ascii?q?4SUGiA5euwzrjj/Uz9QLlSj/02lLfWsIzCKMgGqaO0DBVZ34Y+5xqlETur38?=
 =?us-ascii?q?oUkWMaIF5dfRKIlYnpO1XAIPDiCve/hkyhkCx2yPDdJbDhHpXMIWTDkLfmZ7?=
 =?us-ascii?q?p97VVcxxApwdBQ4JJUFKkNIOjvVU/pqNzYEhg5PhSozOn9E9VyyIMfVHmUAq?=
 =?us-ascii?q?CFMKPdq0KI5uwrI+aSfo8ZoSryJOI/6/Hyin85nEcXfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2FbnX2mdcOD2cLshAlTOP2iF2NSyNTZ3i2X60i/DE2E4OmDYHfRo+zhLyNxj?=
 =?us-ascii?q?u0HppTZmpeEFCDDW/od5mYW/cLcC+SIMphkjseVbi7So8hzgqjtAngxLpiMO?=
 =?us-ascii?q?XU+zcUtZX51Nh6/+fTjw099SRoD8SB1GGAV2V0nmIORz8r06FzuFd9xUmf3q?=
 =?us-ascii?q?hlmfxYFMBT5vNQXgc/Mp7T0vF6C9TsVQ/aYNeJR0ipQs+8DTEyUN0x2dkObF?=
 =?us-ascii?q?h5G9m4iRDDxSWqCacPl7OXHJw07r7c33/pKsZm1XnG0Kghj187QspALmCmmK?=
 =?us-ascii?q?F/+BbJB4LTkEWWibyqdaIC0y7J7muDynCOvE5AWg5qTarFRWwfZlfRrdnh5U?=
 =?us-ascii?q?PNUaGhCa87PQtGzs6CKbBHZcHpjVVcQ/fjPdXeY3+0m2uqAhaI3LyMZpLwe2?=
 =?us-ascii?q?oBxCXdFFQEkwcL8HaEMgg+BiGhr3jcDDxpFVLgeUXs8fJgp3O9VUI70xuFb0?=
 =?us-ascii?q?tm17qz+x4ameaTS/cJ0r0Yvychri1+HEyh0NLOF9qAuw1hcb1EYdwj5ldH2n?=
 =?us-ascii?q?/Ztw17PpC5LKBtmEQecwJpsEPqzBh3C5xMkcwtrHM00gV+M7mY30lCdzOFx5?=
 =?us-ascii?q?D/IKfbKm/s8xy1aa7WwknU0MyK9acX9PQ4t1LjsRmxFkU47nVn18JY02OG6Z?=
 =?us-ascii?q?XXCAoeSJfxUkEw9xhgub7WeDUy54TR1S4kDa7hmTbZ1sNhP+Alwwuue9pFeP?=
 =?us-ascii?q?ePHRT/AuUBDMinNeIulkLsZRtCN+dXoup8NMq9eurAw6WrNftumD+8pWVB/I?=
 =?us-ascii?q?15lEmL8m40SOvPxYwE2Nme1w6KVnH7lljl+sT2n51UICofFXelyDT1QYtWar?=
 =?us-ascii?q?B2cK4VBmq0Zc663NNzg9jqQXEcvEWuA1IAxd+BZxWfdRr+0BdW2EBRpmaoyg?=
 =?us-ascii?q?WiyDkhqC0ktqqS2mT1xu3mcBcWcjpQSHJKkUbnIY/yicsTGkevcV56x1Oe+U?=
 =?us-ascii?q?/myv0D9+xEJG7JTBINJnKnIg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C6BwA73n9d/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoE/A?=
 =?us-ascii?q?TIqhCGPVQEBAQEBAQaBESV+iHWRJwkBAQEBAQEBAQE0AQIBAYQ/AoJvIzgTA?=
 =?us-ascii?q?gwBAQEEAQEBAQEFAwEBbIU6gjopAYJmAQEBAQIBIwQRQRALGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz+BdwUPrUV/M4VMgzeBSYEMKIt4GHiBB4ERJwyCKgcuPoEXhjiCW?=
 =?us-ascii?q?ASVE16WeYIsgi6STAYbmRmOCZsTIYFYKwgCGAghDzuCbIJOF44+JAMwgQYBA?=
 =?us-ascii?q?Y9uAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 19:15:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GJFTvU016975;
        Mon, 16 Sep 2019 15:15:29 -0400
Subject: Re: [PATCH v8 04/28] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190829232935.7099-1-casey@schaufler-ca.com>
 <20190829232935.7099-5-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a95a0c6a-1410-471a-8397-fdcc45a8c77e@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 15:15:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829232935.7099-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/19 7:29 PM, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.

I won't obstruct the patch on naming but I do have to wonder about the 
use of lsmblob here given that we use the term "security blobs" 
elsewhere to refer to what the ->security fields reference and this is 
not the same thing.  Not sure why it wasn't just lsmsecids or similar, 
but whatever.

> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.

Is it really desirable/necessary to duplicate the module name, once in 
the lsm_id and once in the lsm_info?  Again, not a blocker for me but 
seems unfortunate.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h  | 12 +++++--
>   include/linux/security.h   | 66 ++++++++++++++++++++++++++++++++++++++
>   security/apparmor/lsm.c    |  7 +++-
>   security/commoncap.c       |  7 +++-
>   security/loadpin/loadpin.c |  8 ++++-
>   security/safesetid/lsm.c   |  8 ++++-
>   security/security.c        | 31 ++++++++++++++----
>   security/selinux/hooks.c   |  8 ++++-
>   security/smack/smack_lsm.c |  7 +++-
>   security/tomoyo/tomoyo.c   |  8 ++++-
>   security/yama/yama_lsm.c   |  7 +++-
>   11 files changed, 152 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3fe39abccc8f..fe1fb7a69ee5 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2029,6 +2029,14 @@ struct security_hook_heads {
>   #endif /* CONFIG_BPF_SYSCALL */
>   } __randomize_layout;
>   
> +/*
> + * Information that identifies a security module.
> + */
> +struct lsm_id {
> +	const char	*lsm;	/* Name of the LSM */
> +	int		slot;	/* Slot in lsmblob if one is allocated */
> +};
> +
>   /*
>    * Security module hook list structure.
>    * For use with generic list macros for common operations.
> @@ -2037,7 +2045,7 @@ struct security_hook_list {
>   	struct hlist_node		list;
>   	struct hlist_head		*head;
>   	union security_list_options	hook;
> -	char				*lsm;
> +	struct lsm_id			*lsmid;
>   } __randomize_layout;
>   
>   /*
> @@ -2068,7 +2076,7 @@ extern struct security_hook_heads security_hook_heads;
>   extern char *lsm_names;
>   
>   extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +			       struct lsm_id *lsmid);
>   
>   #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>   #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..5bb8b9a6fa84 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,72 @@ enum lsm_event {
>   	LSM_POLICY_CHANGE,
>   };
>   
> +/*
> + * Data exported by the security modules
> + *
> + * Any LSM that provides secid or secctx based hooks must be included.
> + */
> +#define LSMBLOB_ENTRIES ( \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
> +
> +struct lsmblob {
> +	u32     secid[LSMBLOB_ENTRIES];
> +};
> +
> +#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
> +#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
> +#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.
> + * @blob: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		blob->secid[i] = secid;
> +}

This seems nonsensical for any value other than 0.  Otherwise, we should 
only set it for the module that produced the secid originally?  And if 
setting them all to zero, you could just do a memset.

> +
> +/**
> + * lsmblob_is_set - report if there is an value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a secid set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (blob->secid[i] != 0)
> +			return true;
> +	return false;

memcmp against the all-zeroes lsmblob?

> +}
> +
> +/**
> + * lsmblob_equal - report if the two lsmblob's are equal
> + * @bloba: Pointer to one LSM data
> + * @blobb: Pointer to the other LSM data
> + *
> + * Returns true if all entries in the two are equal, false otherwise
> + */
> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (bloba->secid[i] != blobb->secid[i])
> +			return false;
> +	return true;

memcmp of the two blobs?

> +}
> +
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>   		       int cap, unsigned int opts);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2716e7731279..ec2e39aa9a84 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1138,6 +1138,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>   	.lbs_sock = sizeof(struct aa_sk_ctx),
>   };
>   
> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
> +	.lsm  = "apparmor",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>   static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>   	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
> @@ -1679,7 +1684,7 @@ static int __init apparmor_init(void)
>   		goto buffers_out;
>   	}
>   	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				&apparmor_lsmid);
>   
>   	/* Report that AppArmor successfully initialized */
>   	apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index afd9679ca866..973e6c7009d0 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1344,6 +1344,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>   
>   #ifdef CONFIG_SECURITY
>   
> +static struct lsm_id capability_lsmid __lsm_ro_after_init = {
> +	.lsm  = "capability",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(capable, cap_capable),
>   	LSM_HOOK_INIT(settime, cap_settime),
> @@ -1368,7 +1373,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>   static int __init capability_init(void)
>   {
>   	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> -				"capability");
> +			   &capability_lsmid);
>   	return 0;
>   }
>   
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 055fb0a64169..7b23fdf24e27 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -181,6 +181,11 @@ static int loadpin_load_data(enum kernel_load_data_id id)
>   	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>   }
>   
> +static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
> +	.lsm  = "loadpin",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>   	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> @@ -191,7 +196,8 @@ static int __init loadpin_init(void)
>   {
>   	pr_info("ready to pin (currently %senforcing)\n",
>   		enforce ? "" : "not ");
> -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> +	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
> +			   &loadpin_lsmid);
>   	return 0;
>   }
>   
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..4a96cd8c0d15 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -255,6 +255,11 @@ void flush_safesetid_whitelist_entries(void)
>   	}
>   }
>   
> +static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
> +	.lsm  = "safesetid",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list safesetid_security_hooks[] = {
>   	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>   	LSM_HOOK_INIT(capable, safesetid_security_capable)
> @@ -263,7 +268,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
>   static int __init safesetid_security_init(void)
>   {
>   	security_add_hooks(safesetid_security_hooks,
> -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> +			   ARRAY_SIZE(safesetid_security_hooks),
> +			   &safesetid_lsmid);
>   
>   	/* Report that SafeSetID successfully initialized */
>   	safesetid_initialized = 1;
> diff --git a/security/security.c b/security/security.c
> index 7cfedb90210a..27e2db3d6b04 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -317,6 +317,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("lsmblob size         = %lu\n", sizeof(struct lsmblob));
>   
>   	/*
>   	 * Create any kmem_caches needed for blobs
> @@ -399,7 +400,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
>   	return !strcmp(last, lsm);
>   }
>   
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>   {
>   	char *cp;
>   
> @@ -420,24 +421,40 @@ static int lsm_append(char *new, char **result)
>   	return 0;
>   }
>   
> +/*
> + * Current index to use while initializing the lsmblob secid list.
> + */
> +static int lsm_slot __initdata;
> +
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
>    * @hooks: the hooks to add
>    * @count: the number of hooks to add
> - * @lsm: the name of the security module
> + * @lsmid: the identification information for the security module
>    *
>    * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>    */
>   void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +			       struct lsm_id *lsmid)
>   {
>   	int i;
>   
> +	if (lsmid->slot == LSMBLOB_NEEDED) {
> +		if (lsm_slot >= LSMBLOB_ENTRIES)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsmid->slot = lsm_slot++;
> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
> +			   lsmid->slot);
> +	}
> +
>   	for (i = 0; i < count; i++) {
> -		hooks[i].lsm = lsm;
> +		hooks[i].lsmid = lsmid;
>   		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>   	}
> -	if (lsm_append(lsm, &lsm_names) < 0)
> +
> +	if (lsm_append(lsmid->lsm, &lsm_names) < 0)
>   		panic("%s - Cannot get early memory.\n", __func__);
>   }
>   
> @@ -1917,7 +1934,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   	struct security_hook_list *hp;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
>   		return hp->hook.getprocattr(p, name, value);
>   	}
> @@ -1930,7 +1947,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   	struct security_hook_list *hp;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c83ec2652eda..74c491980ed2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6622,6 +6622,11 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   };
>   
> +static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
> +	.lsm  = "selinux",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>   static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>   	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -6877,7 +6882,8 @@ static __init int selinux_init(void)
>   
>   	hashtab_cache_init();
>   
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
> +			   &selinux_lsmid);
>   
>   	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>   		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e9560b078efe..7a0ead4da479 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4553,6 +4553,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>   	.lbs_superblock = sizeof(struct superblock_smack),
>   };
>   
> +static struct lsm_id smack_lsmid __lsm_ro_after_init = {
> +	.lsm  = "smack",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>   static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>   	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
> @@ -4743,7 +4748,7 @@ static __init int smack_init(void)
>   	/*
>   	 * Register with LSM
>   	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
>   	smack_enabled = 1;
>   
>   	pr_info("Smack:  Initializing.\n");
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92ec941a..f1968e80f06d 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -529,6 +529,11 @@ static void tomoyo_task_free(struct task_struct *task)
>   	}
>   }
>   
> +static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
> +	.lsm  = "tomoyo",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   /*
>    * tomoyo_security_ops is a "struct security_operations" which is used for
>    * registering TOMOYO.
> @@ -581,7 +586,8 @@ static int __init tomoyo_init(void)
>   	struct tomoyo_task *s = tomoyo_task(current);
>   
>   	/* register ourselves with the security framework */
> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
> +	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
> +			   &tomoyo_lsmid);
>   	pr_info("TOMOYO Linux initialized\n");
>   	s->domain_info = &tomoyo_kernel_domain;
>   	atomic_inc(&tomoyo_kernel_domain.users);
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index efac68556b45..0529ecc86954 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -425,6 +425,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>   	return rc;
>   }
>   
> +static struct lsm_id yama_lsmid __lsm_ro_after_init = {
> +	.lsm  = "yama",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>   	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
> @@ -482,7 +487,7 @@ static inline void yama_init_sysctl(void) { }
>   static int __init yama_init(void)
>   {
>   	pr_info("Yama: becoming mindful.\n");
> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
> +	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
>   	yama_init_sysctl();
>   	return 0;
>   }
> 

