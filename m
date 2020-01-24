Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A79C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA2E206F0
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gG2GNLOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAXOld (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:41:33 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:28298 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAXOld (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 09:41:33 -0500
X-EEMSG-check-017: 49511558|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="49511558"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 14:41:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579876889; x=1611412889;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=piZbQhdQ5aTDP6CNU2xc0gnzpS5En0G31QtAG2FZ6QU=;
  b=gG2GNLOwQQRDk2WKpyFrLqVxVjkvdyIF+dq+dF0xSs8jFXO3jBAFw0CU
   TnAgUugPGnbyq6EVB2upZLkQC1r40zKfptWI0IJOxAyX3Pak/rrr4v/I5
   ok0l5spFkJVTbKqpjigZWtvFkUydv8u34u9siXry+R1ETCSxiMVo7C7IB
   ApFKBFOouiyy/mF/CfApPb5bl0pWglFfRBrjz1+6QAngXxVVM0kbcyteR
   dd/YmoK79Muw72KvlS/nSmM+RqsBlKdmQ/OvCzkjOGsfQf4vlo+c9ePO4
   +6M3wpdrTx0pQ3uSIbrWB27tD6eKy+r4XGw1eXEOTsESgk99M5BkQVGzJ
   w==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="38206005"
IronPort-PHdr: =?us-ascii?q?9a23=3AGX+VOhHg+at91hvoL+8s4J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76osy+bnLW6fgltlLVR4KTs6sC17OK9fq8EjJdqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6or1B?=
 =?us-ascii?q?fErXREduVWyGh1IV6fgwvw6t2/8ZJ+/Slcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtcv5OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLY50igfwMqQpgcywH/g3Ph?=
 =?us-ascii?q?ISX2mb5eu81Lrj8Vf/QLpWlf05jrPVsJXbJcQfvqK5AglV3Zg/6xunEjur39?=
 =?us-ascii?q?sVkWMHIV5YYh6LkYfkN0/ULPzlFfu/hk6jkDZvx/DIJL3hBZDNI2DYkLj8Zr?=
 =?us-ascii?q?Zw8FJcyQovwtBf4JJYELcBIOnpVUPru9zYCQE5PxSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?CFKqzSqkGH5+I0LumXeIAVuCzyK+Ur5/7qk3A5g0YRcrWz0pcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQeP2klKCSiBcZnaoU6In+j47CJipDZrNRoCpnrOBxj?=
 =?us-ascii?q?y2HpxQZmBaFF+MFW3keJmDW/cJcCiSONNukiQYVbi9TI8szROutAr9y7p9NO?=
 =?us-ascii?q?rU+zYYuInl1Ndv4u3cixAy+SZzD8SH3GGHV3t0kX8QRz8qwKB/plRwylOC0a?=
 =?us-ascii?q?h+nvxZGsVf5+hXXQgmKJ7c1e16C8zyWw7Ye9eJT0upQsiiAT4vVd8x3dAObF?=
 =?us-ascii?q?hnG9m4jRDMwTCqA7kLmLyPHpA09bjc33fpLcZn13nGzLUhj0UhQsZXLm2pmK?=
 =?us-ascii?q?p/9wnVB47UnESUjLiqdasC0y7X7muDznSBvFteUAFuVaXJR3cfZlHZrd7h/E?=
 =?us-ascii?q?PNU6euCag7MgtG0cOCKbVFZcPyjVpaQ/fjP9febnmtlGewHxaIwbaMbIv3e2?=
 =?us-ascii?q?UYxindD1IEkw8L93acKQc+Hjuho37ZDDF2F1LvZEPs8e9kpHO5SU80zxuFb0?=
 =?us-ascii?q?t617Wr/B4YnuCTROkV3rIDvichqil7E0y5397MF9WAoA9hdr1GYdwh+FdHyX?=
 =?us-ascii?q?7ZtwtlM5y4Ma9igFEecxl2v0Pozhl3CZtPkdIsrHw0yAp/MqOY3EpFdzOfw5?=
 =?us-ascii?q?D/JKfbKnLo8xCsdq7WwEvR3MyQ+qgR8vg4qU3jthmzFkU+63Vnz8VV03yE65?=
 =?us-ascii?q?XSFgUSTJbxX10v9xdgurHaZjAx54bT1X1rK6m7rCXO1M4uBOsgmV6ceIJ0Ob?=
 =?us-ascii?q?iJBUfJGM0TGsaqJfZiz1OgdR8VFPtZ9KcpMcerbb6N0eigO+M22HqthH9K8c?=
 =?us-ascii?q?Zm2UKF6iR4R/Tg3pAZzvXe1QyCE3/+iVC7qMHssYZNYDwTWG2lxmysAI9Xe7?=
 =?us-ascii?q?03ZosAFH2vP9zyw9Jymprgc2BX+UTlBF4c3sKtPx2IYBi1xgBU1EIKsVS5li?=
 =?us-ascii?q?aiiT95iTckquyYxiOd7f7lcU88JmNTRGRkxWzpKIywgsFSCFOkdCA1hRCl4g?=
 =?us-ascii?q?D83KEdq6NheTqACXxUdjT7ejkxGpC7saCPNosWssIl?=
X-IPAS-Result: =?us-ascii?q?A2BrAgCYASte/wHyM5BdCBwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BbSASKoQSiQOGeQaBN4EBiG6RSQkBAQEBAQEBAQE3AQGEQAKCRjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFBEAsYAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJaxwfzOFSoM7gT6BDiqIJIQNeYEHgREnD4IoNT6EJCWDEIJeBI1SiQFhR?=
 =?us-ascii?q?nqWZIJDgkyTZQYbmnyOYJ0eIoFYKwgCGAghDzuCbFAYDYgNF45BIwMwjVYBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 14:41:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OEehw8248164;
        Fri, 24 Jan 2020 09:40:45 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 09:42:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200124002306.3552-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:23 PM, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:'
>          lsm1\0value\0lsm2\0value\0...
> This entry is not writable.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-api@vger.kernel.org

As previously discussed, there are issues with AppArmor's implementation 
of getprocattr() particularly around the trailing newline that 
dbus-daemon and perhaps others would like to see go away in any new 
interface.  Hence, I don't think we should implement this new API using 
the existing getprocattr() hook lest it also be locked into the current 
behavior forever.

> ---
>   Documentation/security/lsm.rst | 14 ++++++++
>   fs/proc/base.c                 |  1 +
>   security/security.c            | 63 ++++++++++++++++++++++++++++++++++
>   3 files changed, 78 insertions(+)
> 
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index aadf47c808c0..a4979060f5d3 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -199,3 +199,17 @@ capability-related fields:
>   -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
>   
>   -  ``fs/proc/array.c``::c:func:`task_cap()`
> +
> +LSM External Interfaces
> +=======================
> +
> +The LSM infrastructure does not generally provide external interfaces.
> +The individual security modules provide what external interfaces they
> +require. The infrastructure does provide an interface for the special
> +case where multiple security modules provide a process context. This
> +is provided in compound context format.
> +
> +-  `lsm1\0value\0lsm2\0value\0`
> +
> +The special file ``/proc/pid/attr/context`` provides the security
> +context of the identified process.
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 950c200cb9ad..d13c2cf50e4b 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "keycreate",		0666),
>   	ATTR(NULL, "sockcreate",	0666),
>   	ATTR(NULL, "display",		0666),
> +	ATTR(NULL, "context",		0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/security/security.c b/security/security.c
> index 6a77c8b2ffbc..fdd0c85df89e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -722,6 +722,42 @@ static void __init lsm_early_task(struct task_struct *task)
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
> +
>   /*
>    * Hook list operation macros.
>    *
> @@ -2041,6 +2077,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   				char **value)
>   {
>   	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	int rc = 0;
> +	int finallen = 0;
>   	int display = lsm_task_display(current);
>   	int slot = 0;
>   
> @@ -2068,6 +2108,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   		return -ENOMEM;
>   	}
>   
> +	if (!strcmp(name, "context")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +				     list) {
> +			rc = hp->hook.getprocattr(p, "current", &cp);
> +			if (rc == -EINVAL || rc == -ENOPROTOOPT)
> +				continue;
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
> +					cp, rc);
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +		}
> +		if (final == NULL)
> +			return -EINVAL;
> +		*value = final;
> +		return finallen;
> +	}
> +
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> 

