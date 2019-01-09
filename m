Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B7C43444
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0336E206BA
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gmVMkzb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfAIPmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:42:33 -0500
Received: from upbd19pa10.eemsg.mail.mil ([214.24.27.85]:61711 "EHLO
        upbd19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbfAIPmd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 10:42:33 -0500
X-EEMSG-check-017: 191536736|UPBD19PA10_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2019 15:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547048544; x=1578584544;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xXxmzFrkN9/s1GkteulX3jJFDtA9uegsQcgYS7QfvZ8=;
  b=gmVMkzb59cmY26UXB0oAuF0jYaK2BBBGMh05O4EVjwW57VLD67F/baf1
   xZBWBrj1IONdMZCbcmX3cySM7O/G6aBnrjcipatmzn66BV4cZ0E0ab0di
   76ylyg3/SoW2MIY59NeBKI/+r/w87EaOUHfKOcqTT/WoASSK9nyuXXh7z
   NVZ4XimFVWoZCOYduBIaDPD7NgyPVr81ed/lxZhY9PL9praVpE+A4Pe/a
   4+5mTFXjcbvgvKYh24lTkjFVaTM2/CPuAfX4Y/z2koP2zlwy83L4ftNpb
   KjcMYvPLz5ZKvDXSdH6Yc03PLbtpf2dMUu6VHQ8FTlot7tDdkucHD+04t
   w==;
X-IronPort-AV: E=Sophos;i="5.56,458,1539648000"; 
   d="scan'208";a="22474113"
IronPort-PHdr: =?us-ascii?q?9a23=3A7jtzkhb+jETCGJE+g/QIMVD/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps+5bR7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNIPpUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBeuSaaN45sTcMjRWFloCk6yrwauZ?=
 =?us-ascii?q?67YSgF044ryALYa/yCdYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreKnmp5+AOI90jQHyKKIuldCkAeskKA?=
 =?us-ascii?q?QOWmmb+eCk2L3i+032XqlKg+UrnqTWv53WP8QWqrOjDwNL3Ysv9QyzAyq+3N?=
 =?us-ascii?q?Qdh3YHLVZFeBydj4juPlHDOOv4Auqkg1m3jDdqx+zJPr3mApnXKHjDi63uca?=
 =?us-ascii?q?xy605b1go/1cpf6I5MCrEdPPLzXVf8tNvdDh8+KAy0xfzoB8lj2Y4FQ2KAHL?=
 =?us-ascii?q?KWMKPIvl+U/O4gP+6MZIoNsjbnN/cl/+LujWM+mVIFZqmmw58XaHG+HvR7LE?=
 =?us-ascii?q?SUemTsgtgfHmcQpAY+T/LliEeEUTFNY3a+RaU85is0CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBWfnpJCk2IEXrzb4WLQeoMaCaLLs9klTwEUqKhRJE72R6ysw/6zqJtLv?=
 =?us-ascii?q?DI9S0AqZLjyN916vXXlREz8zx0Esuc33iWT25qgmwIWiU23KFjoU1901uD1K?=
 =?us-ascii?q?94jOFFFdxX+fxESRk6NZHCwOxgEdzyWRzOfs2PSFm4RtWqGzYxTsg+w9UWeU?=
 =?us-ascii?q?ZyB82ijgzf3yqtG7IVmKaLC4I78qLf33j8PMJ9y3fA1Kk8gFgmTMxPNXCghq?=
 =?us-ascii?q?Fi7QfTG4/Jk0Kfl6qwcqQcxiHN/n+ZzWWSpEFYTBJwUaLdUHADZEvbttf56V?=
 =?us-ascii?q?3YT7+oF7snNhFNycmYKqtFctfpl0lJRO//ONTCZGK8g2OwBReOxrORY4vmYm?=
 =?us-ascii?q?sd3D7AB0cajQAc43KGOBMgBieuvW3eFiZiFVHxbEP29+lxtne7QlUzzwGQYE?=
 =?us-ascii?q?1rz6C19QINhfyAV/MT2aoJtzsuqzVuG1a9wsrWC8Gbqgp/c6VTf8k97E1E1W?=
 =?us-ascii?q?3HrQx9OIKvL6R4il4ZaQR3sBCm6xIiLYNMi8Uo5FYt1wx7Iq+bmAdGcjSD25?=
 =?us-ascii?q?n7N5XNJ2Xy9QzpYKnTjBWWy9uS+6ES+NwmpFj5+gKkDEwv9zNgydYRm0OV+5?=
 =?us-ascii?q?GCKQ0VS5+5Bl4+6hxSv7jHZmw44ITO2DtnNqzi4RHY3Nd8P/co0hateZ9kNa?=
 =?us-ascii?q?qAEALjW5kBC9OGNP0hm1/vaAkNeu9V6vhnbIuda/Ka1fvzb65blzW8gDECud?=
 =?us-ascii?q?kl3w=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2APAABlFTZc/wHyM5BjGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFaKWaBAieEAIgajDYBAQEBAQEGgQgIJYksjkaBezAIAYRAAoIfIjQJD?=
 =?us-ascii?q?QEDAQEBAQEBAgFsHAyCOikBgmcBBSMEEUEQCw4KAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?wGBdA0Pqw98M4VBhHWBC4s0F3iBB4ERJwyCMS6DHgKEaoJXAo9wSTeQfAmHG?=
 =?us-ascii?q?YpeBhiRd4lshQqDNoltOIFWKwgCGAghD4MnCYIdAReDS4RRhiAhAzCBBQEBi?=
 =?us-ascii?q?U8BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 09 Jan 2019 15:42:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x09FgK60023578;
        Wed, 9 Jan 2019 10:42:21 -0500
Subject: Re: [PATCH 3/3] kernfs: Initialize security of newly created nodes
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190109091028.24485-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ea48be7a-1319-36ca-adfb-89c00f822a4b@tycho.nsa.gov>
Date:   Wed, 9 Jan 2019 10:44:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109091028.24485-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/19 4:10 AM, Ondrej Mosnacek wrote:
> Use the new security_object_init_security() hook to allow LSMs to
> possibly assign a non-default security context to newly created nodes
> based on the context of their parent node.
> 
> This fixes an issue with cgroupfs under SELinux, where newly created
> cgroup subdirectories would not inherit its parent's context if it had
> been set explicitly to a non-default value (other than the genfs context
> specified by the policy). This can be reproduced as follows:
> 
>      # mkdir /sys/fs/cgroup/unified/test
>      # chcon -R system_u:object_r:cgroup_t:s0:c123 /sys/fs/cgroup/unified/test
>      # ls -lZ /sys/fs/cgroup/unified
>      total 0
>      -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.controllers
>      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.max.depth
>      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.max.descendants
>      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.procs
>      -r--r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.stat
>      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.subtree_control
>      -rw-r--r--.  1 root root system_u:object_r:cgroup_t:s0      0 Jan  8 05:00 cgroup.threads
>      drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:54 init.scope
>      drwxr-xr-x. 25 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:54 system.slice
>      drwxr-xr-x.  2 root root system_u:object_r:cgroup_t:s0:c123 0 Jan  8 04:59 test
>      drwxr-xr-x.  3 root root system_u:object_r:cgroup_t:s0      0 Jan  8 04:55 user.slice
>      # mkdir /sys/fs/cgroup/unified/test/subdir
> 
> Actual result:
> 
>      # ls -ldZ /sys/fs/cgroup/unified/test/subdir
>      drwxr-xr-x. 2 root root system_u:object_r:cgroup_t:s0 0 Jan  8 05:10 /sys/fs/cgroup/unified/test/subdir
> 
> Expected result:
> 
>      # ls -ldZ /sys/fs/cgroup/unified/test/subdir
>      drwxr-xr-x. 2 root root unconfined_u:object_r:cgroup_t:s0:c123 0 Jan  8 05:10 /sys/fs/cgroup/unified/test/subdir
> 
> Link: https://github.com/SELinuxProject/selinux-kernel/issues/39
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
>   fs/kernfs/inode.c           |  9 +++----
>   fs/kernfs/kernfs-internal.h |  4 +++
>   3 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 4ca0b5c18192..8a678a934f65 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -15,6 +15,7 @@
>   #include <linux/slab.h>
>   #include <linux/security.h>
>   #include <linux/hash.h>
> +#include <linux/stringhash.h>
>   
>   #include "kernfs-internal.h"
>   
> @@ -617,7 +618,43 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
>   	return NULL;
>   }
>   
> -static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> +static int kernfs_node_init_security(struct kernfs_node *parent,
> +				     struct kernfs_node *kn, umode_t mode)
> +{
> +	struct kernfs_iattrs *attrs;
> +	struct qstr q;
> +	void *ctx;
> +	u32 ctxlen;
> +	int ret;
> +
> +	/* If parent has no explicit context set, leave child unset as well */
> +	if (!parent->iattr)
> +		return 0;
> +	if (!parent->iattr->ia_secdata || !parent->iattr->ia_secdata_len)
> +		return 0;
> +
> +	q.name = kn->name;
> +	q.hash_len = hashlen_string(parent, kn->name);
> +
> +	ret = security_object_init_security(parent->iattr->ia_secdata,
> +					    parent->iattr->ia_secdata_len,
> +					    &q, (u16)mode, &ctx, &ctxlen);
> +	if (ret)
> +		return ret;
> +
> +	attrs = kernfs_iattrs(kn);
> +	if (!attrs) {
> +		security_release_secctx(ctx, ctxlen);
> +		return -ENOMEM;
> +	}
> +
> +	kernfs_node_setsecdata(attrs, &ctx, &ctxlen);
> +	/* The inode is fresh, so the returned ctx is always NULL. */
> +	return 0;
> +}
> +
> +static struct kernfs_node *__kernfs_new_node(struct kernfs_node *parent,
> +					     struct kernfs_root *root,
>   					     const char *name, umode_t mode,
>   					     kuid_t uid, kgid_t gid,
>   					     unsigned flags)
> @@ -674,6 +711,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>   			goto err_out3;
>   	}
>   
> +	if (parent) {
> +		ret = kernfs_node_init_security(parent, kn, mode);
> +		if (ret)
> +			goto err_out3;
> +	}
> +
>   	return kn;
>   
>    err_out3:
> @@ -692,7 +735,7 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
>   {
>   	struct kernfs_node *kn;
>   
> -	kn = __kernfs_new_node(kernfs_root(parent),
> +	kn = __kernfs_new_node(parent, kernfs_root(parent),
>   			       name, mode, uid, gid, flags);
>   	if (kn) {
>   		kernfs_get(parent);
> @@ -962,7 +1005,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
>   	INIT_LIST_HEAD(&root->supers);
>   	root->next_generation = 1;
>   
> -	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
> +	kn = __kernfs_new_node(NULL, root, "", S_IFDIR | S_IRUGO | S_IXUGO,
>   			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
>   			       KERNFS_DIR);
>   	if (!kn) {
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 80cebcd94c90..e6db8d23437b 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -31,7 +31,7 @@ static const struct inode_operations kernfs_iops = {
>   	.listxattr	= kernfs_iop_listxattr,
>   };
>   
> -static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
> +struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
>   {
>   	static DEFINE_MUTEX(iattr_mutex);
>   	struct kernfs_iattrs *ret;
> @@ -135,8 +135,8 @@ out:
>   	return error;
>   }
>   
> -static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> -				  u32 *secdata_len)
> +void kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> +			    u32 *secdata_len)
>   {
>   	void *old_secdata;
>   	size_t old_secdata_len;
> @@ -149,7 +149,6 @@ static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
>   
>   	*secdata = old_secdata;
>   	*secdata_len = old_secdata_len;
> -	return 0;
>   }
>   
>   ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
> @@ -365,7 +364,7 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
>   		return error;
>   
>   	mutex_lock(&kernfs_mutex);
> -	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
> +	kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
>   	mutex_unlock(&kernfs_mutex);
>   
>   	if (secdata)
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 3d83b114bb08..f6fb2df24c30 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -92,6 +92,10 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
>   ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
>   int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
>   
> +struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn);
> +void kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> +			    u32 *secdata_len);
> +
>   /*
>    * dir.c
>    */
> 

