Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E3DC65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24222086D
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fCNbNpu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24222086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeLMQZW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:25:22 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:51316 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeLMQZW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 11:25:22 -0500
X-EEMSG-check-008: 624051978|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,349,1539648000"; 
   d="scan'208";a="624051978"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2018 16:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1544718319; x=1576254319;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=baJhaW4KxfwDrLOuRl022SU8pwbPYn+VZkz9wLs7Pq4=;
  b=fCNbNpu8d5BMnK8h9pqNMvmFb4GTHr3mZuNALkJu+rAuLpoMYALzsrZn
   kPdP3Gkw9hjKXZOFrgkMj+EoUFifP1bprwqQUESuBcC/F+hZqceJMWAxN
   0UsWlYJytrMfS32txsX45KXHd2HcdUJdQnLJKQFc5YPW/lBn1ESWQA+P3
   Op8Ws0hbTfWp5MwYyMKpSCeCa0GhqzhfkMhVh2GMmwBvRhD7HHKl9YWNa
   9M+tNXUoWbzy1QFGxpXPl6qK/BkwSVZ2BjEcHCx/2DMRaIvKmM19P0s9R
   WUxiQJemDKv64d1jQSBU1F9QWaC579Wf9QbJkjsqKp/mmiO+nAlFO4+9i
   A==;
X-IronPort-AV: E=Sophos;i="5.56,349,1539648000"; 
   d="scan'208";a="21643470"
IronPort-PHdr: =?us-ascii?q?9a23=3AzrrbExQbt4v/nKhGf1wkp3mTkNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZhaCt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eOb3hB5LNLmPFkLj7Yb?=
 =?us-ascii?q?ly9VVRyBAtwt9C55JbEK0BLOjvVU/2sdzSFgU5PBCsw+b7FNV90ZsTWXmRDa?=
 =?us-ascii?q?+dMaPSt0KI5+00LumSa48apiz9J+Im5/Hwl385n0ESfa2z0ZsQcnC4EexsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxImTOPwlV2CVSVeZ26oUKIh4jE3EYemDYDERoC3nrONxj?=
 =?us-ascii?q?u0HppTZmpeEFCDDW/od5mYW/cLcC+dPsBhkiYDVbi8U48hzgqjtBH1y7V5NO?=
 =?us-ascii?q?rY4C4Yuoz51Nhz+eLTkQs+9TtuD8SSy2uNVX17nnsURz8q26ByuVB9ylWY3K?=
 =?us-ascii?q?h7nfNYD9pT6O1NUgsgMp7c1eN6AcjoWg3dZteJVEqmQtK+DDE1T9IwwsEBY0?=
 =?us-ascii?q?hnFNWklR3D3zeqDKUblrOVBZw46L7T33/0J8xl0XbJyLEhj0U6QstILWCmhr?=
 =?us-ascii?q?Rw9w7VB4HXiEWUjLqldaEE3C/C6GiDzWWOsFtfUA5qXqWWFUwYM2zQoc705A?=
 =?us-ascii?q?vnSKSoAL8qMUMVzsuFMa1DYdDBl1hKRP7/ft/ZZjT103y9AReO26OkcoXnYS?=
 =?us-ascii?q?Me0T/bBUxClBocuT6+PBU6TgKmpHjTRGh2HE/rS1vl7O07rXS8VEJyxAaPOQ?=
 =?us-ascii?q?kp3LWv/QMNntSCRP4JmLEJoiEsr3NzBln5l+7bCceG7ypse+0IfdEV41pd02?=
 =?us-ascii?q?/d8QtnMcrzAbplgwslbwlvv07ony5yA4FEnNli+Ggm1yJuOKmY1xVHbDre0p?=
 =?us-ascii?q?fubO6EYlLu9QyiPvaFkmrV18ybr+JWsqw1?=
X-IPAS-Result: =?us-ascii?q?A2BvAQA9hxJc/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YFoJ4N8lHkFBoEICCWJIZAtOAGEQAKDAyI4EgEDAQEBAQEBAgFsKII2JAGCY?=
 =?us-ascii?q?gEFIwQRQRALDgoCAiYCAlcGAQwGAgEBgl4/gXQNpyd8M4VAhHSBC4sxF3iBB?=
 =?us-ascii?q?4ERJwyCX4gFglcCkA43kEoJkVMGGJFKiS6ReCGBVisIAhgIIQ+DJ4InF447I?=
 =?us-ascii?q?QMwgQUBAYxIAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Dec 2018 16:25:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBDGPDtb026698;
        Thu, 13 Dec 2018 11:25:17 -0500
Subject: Re: [RFC PATCH 3/3] selinux: do not override context on context
 mounts
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
References: <20181213141739.8534-1-omosnace@redhat.com>
 <20181213141739.8534-4-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a779b0e5-79d5-8a10-8372-488de5f8345f@tycho.nsa.gov>
Date:   Thu, 13 Dec 2018 11:27:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181213141739.8534-4-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/18 9:17 AM, Ondrej Mosnacek wrote:
> Ignore all selinux_inode_notifysecctx() calls on mounts with the
> SECURITY_FS_USE_MNTPOINT behavior.
> 
> This fixes behavior of kernfs-based filesystems when mounted with the
> 'context=' option. Before this patch, if a node's context had been
> explicitly set to a non-default value and later the filesystem has been
> remounted with the 'context=' option, then this node would show up as
> having a different context.
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
> ---
>   security/selinux/hooks.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d6d29ec54eab..0ca5ed30afe1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6620,6 +6620,13 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>    */
>   static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>   {
> +	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> +
> +	/* Do not change context in SECURITY_FS_USE_MNTPOINT case */
> +	if ((sbsec->flags & SE_SBINITIALIZED) &&
> +	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT))
> +		return 0;
> +
>   	return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
>   }

Wondering if we ought to take this into selinux_inode_setsecurity() and 
return -EOPNOTSUPP in that case.  We already return -EOPNOTSUPP from 
selinux_inode_setxattr() if (!(sbsec->flags & SBLABEL_MNT)) and that 
should precede other calls to selinux_inode_setsecurity() IIRC.  Should 
we just be checking SBLABEL_MNT here instead?  And do we need to 
separately check SE_SBINITIALIZED?
