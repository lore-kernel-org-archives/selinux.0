Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C934BC4360F
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A4C2086A
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="m4K454S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfBVPlB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:41:01 -0500
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:17024 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBVPlA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 10:41:00 -0500
X-EEMSG-check-017: 388207712|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 15:40:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550850047; x=1582386047;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=BdvFTOE9Ef8FKaUyAUQeLKYjwqqiRL5h0hiwLJfTjoE=;
  b=m4K454S7kyclpgij+wAL8kAd18ieyvUx1fjVCfoL/DvjYbocwLGuUXoj
   esp/zQOc1iEXNH67tSXugdFwrAkVwC4kSzCvkHxH7EKtDxMSTQ4MQzxJQ
   ioNr8U0vlelt0sbNOtP0jlh+TI6ctCeFLvpwQm6p4AnmN7a5XxwMkNJNS
   cjk2Cg4xG8JW98JszS5+qsIhl5nwpmv3GwfOtqNsBdd81vlnkXiczhtkM
   UYVI8my8sgKhmd36DErmban84+B28xQP3mJmNHNpWoHO9wC2f1kJDZGPy
   SXzo+ng5Fa7A608edV4siWGVEqiGb7+wyvbDmtnwbd88tA0w1m0A5iYoB
   A==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544486400"; 
   d="scan'208";a="20795241"
IronPort-PHdr: =?us-ascii?q?9a23=3AKsv06BeCjib9DIj+m92QC3StlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YR2N2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
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
 =?us-ascii?q?9ig/xXDdZT/e9GUh8mNZ7AyOx3E8zyWgDac9eKVlmmWNOmDi81Tt4rxN8OeU?=
 =?us-ascii?q?l9Ec24jh/fxyqqH6MVl7uTCZMo6K3cxGb+JsZmxnbdyKYhj0MpQtZBNW2imK?=
 =?us-ascii?q?F/7RHfCJLTnEmDi6mqcqEc1jbX9Gif1WqOoF1YUAloXKXeQ38ffETWosri60?=
 =?us-ascii?q?PCVbCuDbAnMwtHycKYNqRKbdjph01cRPj/INTef36xm2CoCBaH3LODcoXqe2?=
 =?us-ascii?q?Yd3CjGDEgEkgYT/WuJNAgwASehvmTeAyF0GlLzYkPs9u9+pGm8Tk8uwAGAd1?=
 =?us-ascii?q?dh2Kat+h4JmfycTOse3rABuCcmsTV0Ble938nNBtqGvQVhebtTYdIn7FdAz2?=
 =?us-ascii?q?LZuBR3Poa8IKB6ml4ebwN3slvq1xV2DIVAjMcroGokzAppNK2Xzk1BeC2c3Z?=
 =?us-ascii?q?3rJL3XJXf9/Aq1Z67VxF7eytCW9bkL6PgirFXjpg6pHFI483p7y9lVz2ec5p?=
 =?us-ascii?q?LSAQUOXpLxSEE39wVip7HBeSQ9+YzU2mN2MaWusT/NxcgpBO07xRakZdtfN7?=
 =?us-ascii?q?mEFAChW/EdUu+oJPYnmRCMaQkCNetf9+ZgOMahbP2P06ODJutsnDu6y29A5d?=
 =?us-ascii?q?Y5mlmB8yt6V/7gwZkI2beb0xGBWjO6i02u9ojPkJ1ALRQVGXCygXz8DZNVTr?=
 =?us-ascii?q?V7YIJODGCpOcDxzdJ70c3DQXldoWW/CksG1cnhQh+ba1jwzEUEzkgMiWC2ki?=
 =?us-ascii?q?u/iTpvmncmqbTJj3+G+PjraBdSYj0Df2Jll1q5ZNHu190=3D?=
X-IPAS-Result: =?us-ascii?q?A2CTAACuF3Bc/wHyM5BlHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VkqgTcBMieEB5Q5AQEBAQEBBoEQJYk7kF44AYRAAoN+IjcGDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII6KQGCZwEFIwQRQRALDgoCAiYCAlcGAQwGAgEBgl89gWYNrAR8M4VEh?=
 =?us-ascii?q?GmBC4s9F3iBB4ERJwyCX4gLgjUiAooKggWEQEs7kgQJkloGGYFxkR6KToEQk?=
 =?us-ascii?q?wIigVYrCAIYCCEPgyeCKBcTjikhAzCBBQEBjwQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Feb 2019 15:40:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MFeakb008558;
        Fri, 22 Feb 2019 10:40:36 -0500
Subject: Re: [PATCH v7 3/7] selinux: try security xattr after genfs for kernfs
 filesystems
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190222145718.5740-1-omosnace@redhat.com>
 <20190222145718.5740-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9cf19efd-2853-210d-2094-cacd23090e12@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 10:40:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222145718.5740-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/22/19 9:57 AM, Ondrej Mosnacek wrote:
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c            | 157 +++++++++++++++-------------
>   security/selinux/include/security.h |   1 +
>   2 files changed, 85 insertions(+), 73 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 81e012c66d95..0f62757b6634 100644
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
> @@ -1392,6 +1394,67 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
>   	return rc;
>   }
>   
> +static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
> +				  u32 def_sid, u32 *sid)
> +{
> +#define INITCONTEXTLEN 255
> +	char *context;
> +	unsigned int len;
> +	int rc;
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
> +		*sid = def_sid;
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
> @@ -1400,9 +1463,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   	u32 task_sid, sid = 0;
>   	u16 sclass;
>   	struct dentry *dentry;
> -#define INITCONTEXTLEN 255
> -	char *context = NULL;
> -	unsigned len = 0;
>   	int rc = 0;
>   
>   	if (isec->initialized == LABEL_INITIALIZED)
> @@ -1470,72 +1530,11 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
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
> @@ -1586,9 +1585,21 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
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
> +			if ((sbsec->flags & SE_SBGENFS_XATTR) &&
> +			    (inode->i_opflags & IOP_XATTR)) {
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

