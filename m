Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3BC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB720716
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ih8exUNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLRS3M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:29:12 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:44220 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRS3M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 13:29:12 -0500
X-EEMSG-check-017: 61919212|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="61919212"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 18:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576693749; x=1608229749;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8LftuShrOsOL4SsPk5IqWnquwxAohCaXIarjLdWeDBM=;
  b=ih8exUNLlKeVcervJvN08DPE/A27k8ATTTVFOm1iRcfUhHIPkqLVbfPd
   94OqpKTo1nuPVH/jBZF+Hi6cBQiXm46jUzNBw4tLJWJYkhjif4bruY2fD
   99cBwiaBr0xoKNuY8eL/rU6P9udkqqZLrrx2RXF8s/icod2mC+M1IZrT7
   FH7yIxuxosopclO2cB3t6B9ZmALe+CXfgk6XFc3ajWsG0EJV0OA7spduV
   x+U+pYU5iT+ixHZidWJrFhGDU7PUbv1nbuQIxRm6F+iKvNWpNWIJQlsTD
   Tv0eMhsIrg0Pb65MpmwlcaybjhcCK/nYmc7FSfFP0iF2+HMzl79S6GiiE
   g==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31247326"
IronPort-PHdr: =?us-ascii?q?9a23=3AsrcGJByNxxx85ZzXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4RLvad9pjvdHbS+e9qxAeQG9mCsLQe07ud6vixEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm6sQHcusYLjYd+Lqs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IQoRa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Qgwr42mJ?=
 =?us-ascii?q?oTtl/DETHql0nskK+Xdlkr+uiv6+j9ZLXpuoScOJNuhgH7M6QuntSzAeU+Mg?=
 =?us-ascii?q?cQQ2iW4fmw2bLs8EHjQLhGk+c6nrfWvZzEP8gXu7a1AwpP3YYi7xa/AS2m0N?=
 =?us-ascii?q?MdnXQfN1JKZQmHgpP1O1DOPP/4DfC/j06qkDdw3f/KJLLhApLTLnTbirfuYa?=
 =?us-ascii?q?5961JAyAo01d1Q+4hbCqofL/PzQULxr8DXDh8jPAypzebnDMty1pkHVW2TGK?=
 =?us-ascii?q?CVKr/dsViN5ug3OemDeJcVuCrhK/gi//PhkWU2mUQDcqipx5cXc2y3HvR8LE?=
 =?us-ascii?q?WEb3rshskOEX0Rswo/SuzqlEONUTpJa3muWKI84ykxCJi6AofbWoCtnLuB0T?=
 =?us-ascii?q?+5Hp1TYWBGEEqMEXbzd4ifXfcDcieSLdFgkjAeUrihUYAh3wm0tADm07pnMv?=
 =?us-ascii?q?bU+ioAuJLn1dh14fDTlB4r+TxvEcuSz3yNT3t1nmMURz46xaV/oUtgxVee1a?=
 =?us-ascii?q?h3nedVFcJc5/xXSAc2L53cwPJgC9D0RA3Bes2FSFG8QtWpGTsxVM4+w8cSY0?=
 =?us-ascii?q?ZhHNWvlgvD0DSuA78UkbyLGZM1/7nC33j+Ocl90WzK1Ko/gFk8RMtAK2mmir?=
 =?us-ascii?q?R49wjJCI7Di1+ZmLqydaQAwC7N83+OzWmQs05GSw5/TaLFXXccZkbNsdv55l?=
 =?us-ascii?q?nCT7irCbQmLwtBzNSOKqxQat3mlV9GXuvsOMzCY2KtnGe9HRSIxrSMbIrsYW?=
 =?us-ascii?q?kd3iLdCEgenAAV5naJKw4+Czy9rG3ECjxuElTvY0Lw/uZkrHO3VFM7zwaPb0?=
 =?us-ascii?q?d5zbq65gYVheCAS/MUxr8EoDkuqzN7HFag3tLWDcOMpwl/c6VGZ9My/lNH2H?=
 =?us-ascii?q?nYtwBkOpygKL5iiUAEfwRspUzu1Ah3Cp9ansQwqnMl0hB+KaCA0FlZbTOXwY?=
 =?us-ascii?q?jwOqHLKmn15B2vc7TZ2kza0NuN4qcA8uk4q1H6sAGsEUoi9G9n3MdP33SA4Z?=
 =?us-ascii?q?XKCVlabZWkeU8s+gkynLraazQz447OnSlnOLK5oxfZ0NIgGeUhxwzldN4ZO6?=
 =?us-ascii?q?SBQku6GMQBCtnoM+cqkkWnah8eFOFU6KMwecihcr/O2qusJvxhhxqghGFK4c?=
 =?us-ascii?q?Z6yE3Ivy59TPPYmo0IyOyC3xeWEjL7gEqlv+jplo1eIzIfBGyyzW7jHoEVLr?=
 =?us-ascii?q?Z/eYcNFHeGPcK63JN9ioTrVnoe80SsVH0c38r8Qgafd1zw20Vr0E0TpXG20X?=
 =?us-ascii?q?+jwydcjyAirq3Z2jfHhevlakxUaSZwWGB+gAK0csCPhNcAUR3tNlJ4mQ=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DJAACRb/pd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfIF2gW0gEiqEBIkDhlkGgRIlgQGIaZFFCQEBAQEBAQEBATcBAYRAAoI9O?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjBBFBBQsLGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CUwUgrRV1fzOFT4NBgUGBDiiIJYQNeYEHgREnDAOCKDU+h?=
 =?us-ascii?q?1mCXgSNOIh1YUZ3lj6CP4JDiiWJJQYbmk4tjiGcXyKBWCsIAhgIIQ87gmxQG?=
 =?us-ascii?q?A2NHheOQSMDMI8tAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 18:28:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIISE7a085022;
        Wed, 18 Dec 2019 13:28:15 -0500
Subject: Re: [PATCH v12 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-24-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56b96440-a304-42b6-1515-1ad2659b2581@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 13:28:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-24-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> The getsockopt SO_PEERSEC provides the LSM based security
> information for a single module, but for reasons of backward
> compatibility cannot include the information for multiple
> modules. A new option SO_PEERCONTEXT is added to report the
> security "context" of multiple modules using a "compound" format
> 
>          lsm1\0value\0lsm2\0value\0
> 
> This is expected to be used by system services, including dbus-daemon.
> The exact format of a compound context has been the subject of
> considerable debate. This format was suggested by Simon McVittie,
> a dbus maintainer with a significant stake in the format being
> usable.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org

Requires ack by netdev and linux-api.  A couple of comments below.

> ---

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2bf82e1cf347..2ae10e7f81a7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -880,8 +880,8 @@
>    *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>    *	socket is associated with an ipsec SA.
>    *	@sock is the local socket.
> - *	@optval userspace memory where the security state is to be copied.
> - *	@optlen userspace int where the module should copy the actual length
> + *	@optval memory where the security state is to be copied.

This is misleading; it suggests that the caller is providing an 
allocated buffer into which the security module copies its data. Instead 
it is just a pointer to a pointer that is then set by the security 
module to a buffer the module allocates.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 536db4dbfcbb..b72bb90b1903 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -181,7 +181,7 @@ struct lsmblob {
>   #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>   #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
>   #define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
> -#define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
> +#define LSMBLOB_COMPOUND	-5	/* A compound "display" */

I'm puzzled by the removal of LSMBLOB_FIRST by this patch; it suggests 
it was never needed in the first place by the patch that introduced it. 
But more below.

> diff --git a/security/security.c b/security/security.c
> index d0b57a7c3b31..1afe245f3246 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -723,6 +723,42 @@ static void __init lsm_early_task(struct task_struct *task)
>   		panic("%s: Early task alloc failed.\n", __func__);
>   }
>   
> +/**
> + * append_ctx - append a lsm/context pair to a compound context
> + * @ctx: the existing compound context
> + * @ctxlen: size of the old context, including terminating nul byte
> + * @lsm: new lsm name, nul terminated
> + * @new: new context, possibly nul terminated
> + * @newlen: maximum size of @new
> + *
> + * replace @ctx with a new compound context, appending @newlsm and @new
> + * to @ctx. On exit the new data replaces the old, which is freed.
> + * @ctxlen is set to the new size, which includes a trailing nul byte.
> + *
> + * Returns 0 on success, -ENOMEM if no memory is available.
> + */
> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
> +		      int newlen)
> +{
> +	char *final;
> +	int llen;
> +
> +	llen = strlen(lsm) + 1;
> +	newlen = strnlen(new, newlen) + 1;
> +
> +	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
> +	if (final == NULL)
> +		return -ENOMEM;
> +	if (*ctxlen)
> +		memcpy(final, *ctx, *ctxlen);
> +	memcpy(final + *ctxlen, lsm, llen);
> +	memcpy(final + *ctxlen + llen, new, newlen);
> +	kfree(*ctx);
> +	*ctx = final;
> +	*ctxlen = *ctxlen + llen + newlen;
> +	return 0;
> +}

You should likely take some precautions against integer overflows in the 
above code?

> +
>   /*
>    * Hook list operation macros.
>    *
> @@ -2164,8 +2200,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> -		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> -		    *display != hp->lsmid->slot)
> +		if (lsm == NULL && display != NULL &&
> +		    *display != LSMBLOB_INVALID && *display != hp->lsmid->slot)
>   			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}

Is this a bug fix that should be folded into the earlier patch that 
introduced it?

> @@ -2196,7 +2232,7 @@ int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
>   	 */
>   	if (display == LSMBLOB_DISPLAY)
>   		display = lsm_task_display(current);
> -	else if (display == LSMBLOB_FIRST)
> +	else if (display == 0)
>   		display = LSMBLOB_INVALID;
>   	else if (display < 0) {
>   		WARN_ONCE(true,

Why is it necessary to re-map display 0 in this manner? Previously if 
display 0 was specified, it would require it to match the lsmid->slot 
value.  Won't it match anyway?

> @@ -2246,6 +2282,15 @@ void security_release_secctx(struct lsmcontext *cp)
>   	struct security_hook_list *hp;
>   	bool found = false;
>   
> +	if (cp->slot == LSMBLOB_INVALID)
> +		return;
> +
> +	if (cp->slot == LSMBLOB_COMPOUND) {
> +		kfree(cp->context);
> +		found = true;
> +		goto clear_out;
> +	}
> +

If you re-order your pr_warn() below with your memset() to address the 
earlier comment, you'll end up trying to print the freed memory.  Not a 
problem if you just drop the pr_warn() altogether.
