Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7104EC43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC2421906
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ketTFhPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbeLUUpj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:45:39 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:22393 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbeLUUpj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:45:39 -0500
X-EEMSG-check-017: 669950505|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,382,1539648000"; 
   d="scan'208";a="669950505"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Dec 2018 20:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1545425117; x=1576961117;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Ej6+fxgq5SxPx79K6H7Drgxaik6417fvuBYCe1PlnX8=;
  b=ketTFhPbwTPjdoUo1vEInIUvyUGDsZPVZEunLc2jyJ1NEXi7oPatF7NA
   UO9WQ0uqk0oeD4LNf36oN2LORTcveiRwkmR0kOXbSHX1qYvQdBmyf1HbJ
   RfoPorz76lXasrWkZMn9088U+fK4QsqzLaa+0Iqzxg00ODvCKxYBWAKJI
   rwPlwfmQ3HZmZmRVrPI3mBsCRBloDLUuw1JaXCctzIqvJ9ViXfgwTLnFZ
   yomr+BZZUqhnqbVsH0ZKPVtxTY+X9H/H+5dVk8Jq8RdE4YNDCL1p6HN6l
   4cJqMyx2kexqo7gXYEz5CufHfgDPbpn6Fvu3qfIYV+1zEg+yQ8YSM6T/h
   w==;
X-IronPort-AV: E=Sophos;i="5.56,382,1539648000"; 
   d="scan'208";a="18985908"
IronPort-PHdr: =?us-ascii?q?9a23=3ASVSH0B1DfvNaAI/fsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMQL/ad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
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
 =?us-ascii?q?meYXf0mtcOC3oKvg4lQezyklKCTDpTa2+3X6I74TE7EpypAZ3fSYCqhbzSlB?=
 =?us-ascii?q?u8S7pQanpLCBipFmzufo6JWL9YbyeVOclomTEsT7WtS4Y9kxqpsVm+g6FqKu?=
 =?us-ascii?q?vS5z0wq53uzp526vfVmBV08iZ7S4yl2nyJB0RzmXkFD2su1b17iVR011PG1K?=
 =?us-ascii?q?9/mfEeHttWsaBnSAA/YKXAwvR6Bta6YQfIetOEWR7yWdm9KS0gRdI2hdkVag?=
 =?us-ascii?q?ByHMv03UOL5DajH7JAz+/DP5cz6K+JmiGrf8s=3D?=
X-IPAS-Result: =?us-ascii?q?A2AkAAA3UB1c/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGBWimBaCeDfZRhAQEBAQEBBoEILYkkkDY4AYRAAoJuIjcGDQEDA?=
 =?us-ascii?q?QEBAQEBAgFsKII6KQGCZwEFIwQRUQsOCgICJgICVwYBDAYCAQGCXz+BdQ2mH?=
 =?us-ascii?q?3wzhUCEbYELizQXeIEHgTiCa4RKgz+CVwKPYEk3kGUJkWMGGJFfiVOSJSKBV?=
 =?us-ascii?q?isIAhgIIQ+DJ4InF447IQMwgQUBAYthgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 21 Dec 2018 20:45:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBLKjGtX004193;
        Fri, 21 Dec 2018 15:45:16 -0500
Subject: Re: [PATCH v2 2/2] selinux: do not override context on context mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20181221201853.24015-1-omosnace@redhat.com>
 <20181221201853.24015-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b9fbfb5c-fc8f-fe02-13b1-998a00b1a7f5@tycho.nsa.gov>
Date:   Fri, 21 Dec 2018 15:47:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221201853.24015-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/21/18 3:18 PM, Ondrej Mosnacek wrote:
> Ignore all selinux_inode_notifysecctx() calls on mounts with SBLABEL_MNT
> flag unset. This is achived by returning -EOPNOTSUPP for this case in
> selinux_inode_setsecurtity() (because that function should not be called
> in such case anyway) and translating this error to 0 in
> selinux_inode_notifysecctx().
> 
> This fixes behavior of kernfs-based filesystems when mounted with the
> 'context=' option. Before this patch, if a node's context had been
> explicitly set to a non-default value and later the filesystem has been
> remounted with the 'context=' option, then this node would show up as
> having the manually-set context and not the mount-specified one.
> 
> Steps to reproduce:
>      # mount -t cgroup2 cgroup2 /sys/fs/cgroup/unified
>      # chcon unconfined_u:object_r:user_home_t:s0 /sys/fs/cgroup/unified/cgroup.stat
>      # ls -lZ /sys/fs/cgroup/unified
>      total 0
>      -r--r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.controllers
>      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.depth
>      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.max.descendants
>      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.procs
>      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
>      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.subtree_control
>      -rw-r--r--. 1 root root system_u:object_r:cgroup_t:s0        0 Dec 13 10:41 cgroup.threads
>      # umount /sys/fs/cgroup/unified
>      # mount -o context=system_u:object_r:tmpfs_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> 
> Result before:
>      # ls -lZ /sys/fs/cgroup/unified
>      total 0
>      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.controllers
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.depth
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.max.descendants
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.procs
>      -r--r--r--. 1 root root unconfined_u:object_r:user_home_t:s0 0 Dec 13 10:41 cgroup.stat
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.subtree_control
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0         0 Dec 13 10:41 cgroup.threads
> 
> Result after:
>      # ls -lZ /sys/fs/cgroup/unified
>      total 0
>      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.controllers
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.depth
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.max.descendants
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.procs
>      -r--r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.stat
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.subtree_control
>      -rw-r--r--. 1 root root system_u:object_r:tmpfs_t:s0 0 Dec 13 10:41 cgroup.threads
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

The patch looks good to me but I am a little puzzled by the cgroup2 
behavior here.  I would have expected that unmounting would have killed 
the superblock and thus discarded the previously set label.  I guess 
something else is keeping it alive?

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b4759bebeddc..fcf4af1e5157 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3477,12 +3477,16 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>   				     const void *value, size_t size, int flags)
>   {
>   	struct inode_security_struct *isec = inode_security_novalidate(inode);
> +	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
>   	u32 newsid;
>   	int rc;
>   
>   	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>   		return -EOPNOTSUPP;
>   
> +	if (!(sbsec->flags & SBLABEL_MNT))
> +		return -EOPNOTSUPP;
> +
>   	if (!value || !size)
>   		return -EACCES;
>   
> @@ -6625,7 +6629,10 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>    */
>   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>   {
> -	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> +	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
> +					   ctx, ctxlen, 0);
> +	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
> +	return rc == -EOPNOTSUPP ? 0 : rc;
>   }
>   
>   /*
> 

