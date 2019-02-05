Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35287C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA242080A
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 14:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="I4DTOW2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBEOXw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:23:52 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:12754 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfBEOXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 09:23:51 -0500
X-EEMSG-check-017: 231300316|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2019 14:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549376626; x=1580912626;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+lhsJ+Xg7/IyRWoYG8BV2njHemVTv1Ii4wjNcswQwfQ=;
  b=I4DTOW2QqeBMrKxQ8OWU47bYnKCctnHzWrJsGqFFv1WIvqm5SeLjppeD
   j871IqEx2BNDPMWWigyybv9jPkovSheMyP0IYLWOZulY/uGYPN7M7SVxX
   worhjNKMLh7t5rEoPUMdWthn5mnAlY5v792NKWlyMlt6x0XDGco8dujz0
   9qn9d6bOlaZcDpKmu23V6OcS5QQMiUAmBtnngVpO2oqQmyPtn6GRAcIZJ
   i7Lt+Uq2ZIbd99ICRgAVxngAAAUQ6rJYSfMCsDsNOADyR7WSmpVTUq61R
   SThma5t/E3vfoli0rYLaISnkPXg8ZnGMZa5s5p/wkIxH8tDGhDeH/uIVP
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539648000"; 
   d="scan'208";a="23507917"
IronPort-PHdr: =?us-ascii?q?9a23=3AMXUGpxfULXTdz/or94/6y5xxlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc25YhWN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
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
 =?us-ascii?q?9ig/xXDdZT/e9GUh8mNZ7AyOx3E8z9VRjaftiXSFerWc6mDi0xTt0r3t8ObU?=
 =?us-ascii?q?J9FMu4jhzawyWlGaUZmKCMBJwx6qjcxWT+J95hy3ba06ksl1YmQtFROm2pha?=
 =?us-ascii?q?5/9xPeB4rIk0Wfiqareqoc3CnQ9GeF0GWBpl1YUA93UaXDR3wfYVHWrdvh7E?=
 =?us-ascii?q?PYU7CuEagnMhdGycOaNqtKaMbkjVZYS/f5PtTRfWaxl323BRaSybOGdJDqdH?=
 =?us-ascii?q?kF3CXBFEgElBge/XKHNQg4GyegrHvSDDJ1FV3yfUzs7/dxqHegQ08qwAGFcV?=
 =?us-ascii?q?dh26C2+hELn/ycTe0c3rYetCcmsTV0E06338jKBNqYuwphYKJcbMsh71dIz2?=
 =?us-ascii?q?LZsBF9PoS7L615mF4efBp4v1n02xV0FIpAi84qo20uzAZoLqKYylxBJHuk2s?=
 =?us-ascii?q?XXPLHNJ2u62Re0bafd11KWhNGT/bwJ4f81g0/usAGgCgwp9HAxl5FO3n+d4I?=
 =?us-ascii?q?jaJBQdXIi3UUst8RV+4bbAbW1134rJ0TVJNq6uv3eWw9s0AMM9wwukOtJYN7?=
 =?us-ascii?q?mJUgT1FptJKdKpLbkRh1Wxbh8CdNtX/aowMtLuI+CKw4a3Le1gm3Sglm0B74?=
 =?us-ascii?q?djhBHfvxFgQ/LFis5Wi8qT2RGKAnKl1g+s?=
X-IPAS-Result: =?us-ascii?q?A2BJAACtm1lc/wHyM5BlGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKYE4MieEA5QPTAEBAQEBAQaBCAgliTWOb4FnOAGEQAKDEiI3Bg0BA?=
 =?us-ascii?q?wEBAQEBAQIBbCiCOikBgmcBBSMEEUEQCw4KAgImAgJXBgEMBgIBAYJfP4F1D?=
 =?us-ascii?q?atYfDOFRIRxgQuLNhd4gQeBEScMgl+EaYMhgjUiAol9hjVLOpFHCZI5BhmBb?=
 =?us-ascii?q?JBbiiqBDJIzIoFWKwgCGAghD4MngigXE44pIQMwgQUBAY1zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2019 14:23:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x15ENdO7006404;
        Tue, 5 Feb 2019 09:23:39 -0500
Subject: Re: [PATCH v5 1/5] selinux: try security xattr after genfs for kernfs
 filesystems
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190205110638.30782-1-omosnace@redhat.com>
 <20190205110638.30782-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6e92a790-5e69-1462-d9e3-79fe48b67793@tycho.nsa.gov>
Date:   Tue, 5 Feb 2019 09:23:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205110638.30782-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/19 6:06 AM, Ondrej Mosnacek wrote:
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
>   security/selinux/hooks.c            | 159 +++++++++++++++-------------
>   security/selinux/include/security.h |   1 +
>   2 files changed, 88 insertions(+), 72 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 81e012c66d95..758a99d1086e 100644
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
> +	int rc;
> +
> +	*sid = def_sid;
> +
> +	if (!(inode->i_opflags & IOP_XATTR))
> +		return 0;
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
> @@ -1401,8 +1468,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   	u16 sclass;
>   	struct dentry *dentry;
>   #define INITCONTEXTLEN 255

This definition can also be removed, having been moved up above.

> -	char *context = NULL;
> -	unsigned len = 0;
>   	int rc = 0;
>   
>   	if (isec->initialized == LABEL_INITIALIZED)
> @@ -1470,72 +1535,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
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
> @@ -1586,9 +1590,20 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
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

