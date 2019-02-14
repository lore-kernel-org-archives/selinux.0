Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B5C43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE52147C
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 20:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PohP/MJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503233AbfBNUtz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:49:55 -0500
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:27057 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503229AbfBNUtx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 15:49:53 -0500
X-EEMSG-check-017: 678037213|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="678037213"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 20:49:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550177367; x=1581713367;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8rYFd9vAFV+XF5bqdOP/dJL0FaQzrF94Ohvnq4J/h2M=;
  b=PohP/MJuqBhKoWWQjZEZt3TZ5saG3jrrl7FPRjydlmSMXJwExM/oXHXW
   uMjWUzXCbNaLrxp4I4B3PTImsYBVsc14VCo7q8hH60Pk52/YaZgVtx6kl
   uKZe1RUnSiNTO9uUcfiTZkfdDl0dTDcGaIKp08lxOWmo/EAI993VRKojG
   XYxxgHeP7RfjRieOyB30cJIDT6KHZfr2bQ6DW0mb337z2Skd8tgZQlls0
   Uw6IT2YCUGizXhgXoeHLaLOGSr0ElQZpb5xK/Cv//MyXJvXKfy2BOEfKn
   vqBP0J2Xq2ssC57C/t0DVD0EPmcKKkSe3/qoRplWFxEPEHH/+v1lvUTAG
   w==;
X-IronPort-AV: E=Sophos;i="5.58,370,1544486400"; 
   d="scan'208";a="23954779"
IronPort-PHdr: =?us-ascii?q?9a23=3AaMtYihxdmMutBsLXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ukQK/ad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym1OskDJsx/DdOL3uGInCIWbYnbf7Y7?=
 =?us-ascii?q?ly9k5cxxAvzdxF+51UDbQBKurpWkDtrNzYEgM5Mwuszub8Ftp90oIeWWSSAq?=
 =?us-ascii?q?6WK67Sr1CI6fw1I+WWZ48apiz9K/476P7ql3M5nkUdfaax15sNdH+4BuhmI1?=
 =?us-ascii?q?meYXf0mtcOC3oKvg4lQezyklKCTDpTa2+3X6I74TE7EpypAZ3fSYCqhbyLxD?=
 =?us-ascii?q?27EYFOZmBaFlCMFm/ld4GFW/cKdSKTLdZtkicaWre9Vo8hzxCutBP6yrZ+K+?=
 =?us-ascii?q?rU/TAXtY/n1Ndr/ODTix4y+iJuD8iH0GGCUXt0nmUWSD8yxqx/plZ9ylib26?=
 =?us-ascii?q?hin/NYDcBT5+9OUgoiKZHT1fd6BM7yWw/aZdeGVFamTc+7ATE/StI+3cUOb1?=
 =?us-ascii?q?9hFNq4lBzMwy2qA7oNnbyRGJM06r7c32T2J8tlxHbGzrcuj1YlQstPLmCmgq?=
 =?us-ascii?q?9/9w7OB4/GnUWZkLuqdaIB0yHX6GeDzG2OvEdCXA53S6XFUmgVZlHKotTh+k?=
 =?us-ascii?q?PCU7iuBKw7MgtD0sOCKbVFasfvjVpYQPfvItPeY3i+m22oHxaH2quMbJb2e2?=
 =?us-ascii?q?UaxCjdDEkEkwYO/XeJLAQ+CDyhrH/AAzxwC13vZ1jh8fdxqHylVE841QKKYF?=
 =?us-ascii?q?N717qz5BEVgeaQS/QJ3rILoC0hsSl7HE6h39LKDNqNvxZufKpGYdM6/VdHzX?=
 =?us-ascii?q?nZuhdjPpyvMa9inEQScwdpsEP00RV4FIFAndItrHMwwwohYZ6fhXRHeymV39?=
 =?us-ascii?q?jVPabRI2L//1j7bKvRwVfX29u+4KoD6P0k7V7kuVftXlEv93Rhzsl9zXSR/N?=
 =?us-ascii?q?PJARAUXJa3VVw4s1BCrqzeKgw64JnZnSl0OLSwmifLxtZsAewi0BvmdNBaZv?=
 =?us-ascii?q?CqDgj3RvYGCtCuJepioF2gahYJLagG76IvF9+3fPuBnqiwNaBvmyzw3jcP25?=
 =?us-ascii?q?x0zk/Zr3k0ceXPxZtQhqjChgY=3D?=
X-IPAS-Result: =?us-ascii?q?A2BmAABY02Vc/wHyM5BkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VkpgWonhAaUCk0BAQEBAQaBCAgliTiOW4F7OAGEQAKDYyI1CA0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCOikBgmcBBSMEEUEQCw4KAgImAgJXBgEMBgIBAYJfPYFmDasmfDOFR?=
 =?us-ascii?q?IRxgQuLORd4gQeBEScMgl+ICoI1IgKKBYY7SzuRaAmSTgYZgW6RBYo6gQ+SU?=
 =?us-ascii?q?AE2gVYrCAIYCCEPgyeCKBcTjikhAzCBBQEBj1UBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2019 20:49:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1EKnP2h025506;
        Thu, 14 Feb 2019 15:49:25 -0500
Subject: Re: [PATCH v6 1/5] selinux: try security xattr after genfs for kernfs
 filesystems
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8569202a-1a46-2a4d-3943-01b9bc918524@tycho.nsa.gov>
Date:   Thu, 14 Feb 2019 15:49:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214095015.16032-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/19 4:50 AM, Ondrej Mosnacek wrote:
> Since kernfs supports the security xattr handlers, we can simply use
> these to determine the inode's context, dropping the need to update it
> from kernfs explicitly using a security_inode_notifysecctx() call.
> 
> We achieve this by setting a new sbsec flag SE_SBGENFS_XATTR to all
> mounts that are known to use kernfs under the hood and then fetching the
> xattrs after determining the fallback genfs sid in
> inode_doinit_with_dentry() when this flag is set.
> 
> This will allow implementing full security xattr support in kernfs and
> removing the ...notifysecctx() call in a subsequent patch.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/hooks.c            | 160 +++++++++++++++-------------
>   security/selinux/include/security.h |   1 +
>   2 files changed, 88 insertions(+), 73 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 81e012c66d95..7dea5b1a89a3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -793,11 +793,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   
>   	if (!strcmp(sb->s_type->name, "debugfs") ||
>   	    !strcmp(sb->s_type->name, "tracefs") ||
> -	    !strcmp(sb->s_type->name, "sysfs") ||
> -	    !strcmp(sb->s_type->name, "pstore") ||
> +	    !strcmp(sb->s_type->name, "pstore"))
> +		sbsec->flags |= SE_SBGENFS;
> +
> +	if (!strcmp(sb->s_type->name, "sysfs") ||
>   	    !strcmp(sb->s_type->name, "cgroup") ||
>   	    !strcmp(sb->s_type->name, "cgroup2"))
> -		sbsec->flags |= SE_SBGENFS;
> +		sbsec->flags |= SE_SBGENFS | SE_SBGENFS_XATTR;
>   
>   	if (!sbsec->behavior) {
>   		/*
> @@ -1392,6 +1394,71 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
>   	return rc;
>   }
>   
> +static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
> +				  u32 def_sid, u32 *sid)
> +{
> +#define INITCONTEXTLEN 255
> +	char *context = NULL;
> +	unsigned int len = 0;

No need to initialize here since no uses or gotos prior to first assignment?

> +	int rc;
> +
> +	*sid = def_sid;
> +
> +	if (!(inode->i_opflags & IOP_XATTR))
> +		return 0;

Is this a change in behavior from before the patch?  Would we have 
previously called __vfs_getxattr -> xattr_resolve_name and returned 
either -EIO (is_bad_inode) or -EOPNOTSUPP to the caller?  Perhaps it is 
fine to return 0 with the default SID here, but wanted to check.

> +
> +	len = INITCONTEXTLEN;
> +	context = kmalloc(len + 1, GFP_NOFS);
> +	if (!context)
> +		return -ENOMEM;
> +
> +	context[len] = '\0';
> +	rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> +	if (rc == -ERANGE) {
> +		kfree(context);
> +
> +		/* Need a larger buffer.  Query for the right size. */
> +		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
> +		if (rc < 0)
> +			return rc;
> +
> +		len = rc;
> +		context = kmalloc(len + 1, GFP_NOFS);
> +		if (!context)
> +			return -ENOMEM;
> +
> +		context[len] = '\0';
> +		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
> +				    context, len);
> +	}
> +	if (rc < 0) {
> +		kfree(context);
> +		if (rc != -ENODATA) {
> +			pr_warn("SELinux: %s:  getxattr returned %d for dev=%s ino=%ld\n",
> +				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
> +			return rc;
> +		}
> +		return 0;
> +	}
> +
> +	rc = security_context_to_sid_default(&selinux_state, context, rc, sid,
> +					     def_sid, GFP_NOFS);
> +	if (rc) {
> +		char *dev = inode->i_sb->s_id;
> +		unsigned long ino = inode->i_ino;
> +
> +		if (rc == -EINVAL) {
> +			pr_notice_ratelimited("SELinux: inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> +					      ino, dev, context);
> +		} else {
> +			pr_warn("SELinux: %s:  context_to_sid(%s) returned %d for dev=%s ino=%ld\n",
> +				__func__, context, -rc, dev, ino);
> +		}
> +	}
> +	kfree(context);
> +	return 0;
> +}
> +
>   /* The inode's security attributes must be initialized before first use. */
>   static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
>   {
> @@ -1400,9 +1467,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   	u32 task_sid, sid = 0;
>   	u16 sclass;
>   	struct dentry *dentry;
> -#define INITCONTEXTLEN 255
> -	char *context = NULL;
> -	unsigned len = 0;
>   	int rc = 0;
>   
>   	if (isec->initialized == LABEL_INITIALIZED)
> @@ -1470,72 +1534,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   			goto out;
>   		}
>   
> -		len = INITCONTEXTLEN;
> -		context = kmalloc(len+1, GFP_NOFS);
> -		if (!context) {
> -			rc = -ENOMEM;
> -			dput(dentry);
> -			goto out;
> -		}
> -		context[len] = '\0';
> -		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> -		if (rc == -ERANGE) {
> -			kfree(context);
> -
> -			/* Need a larger buffer.  Query for the right size. */
> -			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
> -			if (rc < 0) {
> -				dput(dentry);
> -				goto out;
> -			}
> -			len = rc;
> -			context = kmalloc(len+1, GFP_NOFS);
> -			if (!context) {
> -				rc = -ENOMEM;
> -				dput(dentry);
> -				goto out;
> -			}
> -			context[len] = '\0';
> -			rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> -		}
> +		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
> +					    &sid);
>   		dput(dentry);
> -		if (rc < 0) {
> -			if (rc != -ENODATA) {
> -				pr_warn("SELinux: %s:  getxattr returned "
> -				       "%d for dev=%s ino=%ld\n", __func__,
> -				       -rc, inode->i_sb->s_id, inode->i_ino);
> -				kfree(context);
> -				goto out;
> -			}
> -			/* Map ENODATA to the default file SID */
> -			sid = sbsec->def_sid;
> -			rc = 0;
> -		} else {
> -			rc = security_context_to_sid_default(&selinux_state,
> -							     context, rc, &sid,
> -							     sbsec->def_sid,
> -							     GFP_NOFS);
> -			if (rc) {
> -				char *dev = inode->i_sb->s_id;
> -				unsigned long ino = inode->i_ino;
> -
> -				if (rc == -EINVAL) {
> -					if (printk_ratelimit())
> -						pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> -							"context=%s.  This indicates you may need to relabel the inode or the "
> -							"filesystem in question.\n", ino, dev, context);
> -				} else {
> -					pr_warn("SELinux: %s:  context_to_sid(%s) "
> -					       "returned %d for dev=%s ino=%ld\n",
> -					       __func__, context, -rc, dev, ino);
> -				}
> -				kfree(context);
> -				/* Leave with the unlabeled SID */
> -				rc = 0;
> -				break;
> -			}
> -		}
> -		kfree(context);
> +		if (rc)
> +			goto out;
>   		break;
>   	case SECURITY_FS_USE_TASK:
>   		sid = task_sid;
> @@ -1586,9 +1589,20 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   				goto out;
>   			rc = selinux_genfs_get_sid(dentry, sclass,
>   						   sbsec->flags, &sid);
> -			dput(dentry);
> -			if (rc)
> +			if (rc) {
> +				dput(dentry);
>   				goto out;
> +			}
> +
> +			if (sbsec->flags & SE_SBGENFS_XATTR) {
> +				rc = inode_doinit_use_xattr(inode, dentry,
> +							    sid, &sid);
> +				if (rc) {
> +					dput(dentry);
> +					goto out;
> +				}
> +			}
> +			dput(dentry);
>   		}
>   		break;
>   	}
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f68fb25b5702..6e5928f951da 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -58,6 +58,7 @@
>   #define SE_SBINITIALIZED	0x0100
>   #define SE_SBPROC		0x0200
>   #define SE_SBGENFS		0x0400
> +#define SE_SBGENFS_XATTR	0x0800
>   
>   #define CONTEXT_STR	"context="
>   #define FSCONTEXT_STR	"fscontext="
> 

