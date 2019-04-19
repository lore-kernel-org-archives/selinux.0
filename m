Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39ECC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96420693
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HoeEUod0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfDSStw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:49:52 -0400
Received: from usfb19pa11.eemsg.mail.mil ([214.24.26.82]:48752 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfDSStu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Apr 2019 14:49:50 -0400
X-EEMSG-check-017: 132614783|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Apr 2019 15:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555687663; x=1587223663;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=6RYk6sxhbixm4TgQ89e7XGiAPaP48a2SMZPA9thzCJ4=;
  b=HoeEUod06z0PCiQJZ8X+FXr1LtfduRewb/s+8i/sTWIJEh9QwOjhBOxT
   syj7eAJ89Ztc0iISskZZbbDQnYlGEc+z1WjJXwuj71lZHgthFkm9gQbXX
   v8A+1CKQGbMyrK9BahhJr7nSj/jqJsS8sOXiIPWi4V01aGfYCQ2lcD7kt
   JxUdGPIK2oyoXfuJBGWjOVquMdcBMghek0YgTG9FHMm0DA9IRamiFkeaK
   v5FkHL9K/oZ+2Yw3zYfTuqZvK3wAwoEtmrbLlvTaZQloLS1c4h3ieTvrn
   d5r5+RSWawQZt8qo+f1hMHk23qH1ja9ErqPLdPiy+b3u+t2VGu+rzD8Fh
   w==;
X-IronPort-AV: E=Sophos;i="5.60,370,1549929600"; 
   d="scan'208";a="26530470"
IronPort-PHdr: =?us-ascii?q?9a23=3AEQDqQReNt4aQ5iF3bNvAURc8lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc24YhSN2/xhgRfzUJnB7Loc0qyK6vmmAjNLvsfJ8ChbNsAVD1?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN7s9xg?=
 =?us-ascii?q?HHr3ZKdOhbx2dlLk+Xkxrg+8u85pFu/zlMt/4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlinxlf7e/iAyz8Uim0uD8Wci00E?=
 =?us-ascii?q?pKripYidbArGwC1xvW6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaOcQaqbK5Aw9SyIoj7QqwDyy639?=
 =?us-ascii?q?gCmHkHLVZFdAqGj4jvJV7OPOj1Aeqwjlmjijtmx+3KMqf/DpjCMHTPiqrtca?=
 =?us-ascii?q?5460FGyQozyd5f54hTCrEEOP/zQVL+tMfDAx8lMw273+bnCNJn2oMYQmKAGL?=
 =?us-ascii?q?WVMKzVsV+W/u4vOfWDZJcJuDbhLPgo/+LhgmUimVADfaikxoAXZ2y4Hvt8Pk?=
 =?us-ascii?q?WZb37sjckbEWsTogUxVvbmh0GFUT5Wf3yyRb4z5iknCIK6CofOXpyij6aa3C?=
 =?us-ascii?q?ilHpxafHtGBUyMEXjyaoWEVfMMZzyIIsJ6kzwEU6ShRJEl1R20qAD6zL9nJP?=
 =?us-ascii?q?LO+iIErZLjyMR15+rLmBEw8Dx0CN6d03uMT2FvhW4IQSU53KVhrkx80FuD1r?=
 =?us-ascii?q?J4g/NAH9xJ+/xJShs6NYLbz+FiD9DyWwTBfsqGSVq/WdWpHy0+Ts8rw98Pf0?=
 =?us-ascii?q?Z8G8yujhXE3yW3Hr8Vk6KECYcq8qLTwXfxPdxxy3XY26k7iVkpXM9POXehhq?=
 =?us-ascii?q?5l+AjZH5TJnFmBl6a2aaQc2zbA9HydwmqKvUFYVhNwUKreUHABaUvZs8756l?=
 =?us-ascii?q?nBT7CwE7QnNBVOycqYJqtNcN3pggYOePC2E93FbnP5oGywDAuGwr6WJN7hcn?=
 =?us-ascii?q?4QzQ3GA0gNjg4X8GzDPgF4DSCk9SaWBzV1GEOpeEjs+PRwrH6hZk4y0wyOKU?=
 =?us-ascii?q?Zm0v79+BsSn+adUNsV17cJuWEmsTowVFK82c/GTsGNrBd7fblNJNY67EpD2E?=
 =?us-ascii?q?rHuAFneJ+tNaZvghgZaQsz91jj0xRxF5Voj8cntjUpwRB0JKbe10lOJB2C2p?=
 =?us-ascii?q?WlAaHaMmn/+liUbqfS3lzPmIKN9rwn9OUzq1KluhqgUEUl7SM0gJFuz3KA68?=
 =?us-ascii?q?CSX0IpWpXrXxNyrkMrqg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DJAACH6Llc/wHyM5BmGwEBAQEDAQEBBwMBAQGBZYFnK?=
 =?us-ascii?q?mhSMiiEDpN1AQEDBoEILYlIkH4rEQGEQAKGGSM4EwEDAQEBBAEBAQECAWwcD?=
 =?us-ascii?q?II6KQGCZgEBAQECASMVUQsYAgImAgJXBgEMBgIBAYJfPwGBdAUPpzaBL4VHh?=
 =?us-ascii?q?GeBCyeLShd4gQeBOIJrPoJhAoRrglcEimGHKE+BHJJdCYIKhg+MFQYbgmmSK?=
 =?us-ascii?q?IM7iEeWSCGBVisIAhgIIQ+DJwmCEReDTIpvIwMwgQYBAY9qAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Apr 2019 15:27:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3JFReGE015252;
        Fri, 19 Apr 2019 11:27:40 -0400
Subject: Re: [PATCH 00/90] LSM: Module stacking for all
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20190419004617.64627-1-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c9c3782-a168-c435-0caf-311c2d21d174@tycho.nsa.gov>
Date:   Fri, 19 Apr 2019 11:27:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/18/19 8:44 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the any security module to stack safely with any other.
> 
> A new process attribute identifies which security module
> information should be reported by SO_PEERSEC and the
> /proc/.../attr/current interface. This is provided by
> /proc/.../attr/display. Writing the name of the security
> module desired to this interface will set which LSM hooks
> will be called for this information. The first security
> module providing the hooks will be used by default.
> 
> The use of integer based security tokens (secids) is
> generally (but not completely) replaced by a structure
> lsm_export. The lsm_export structure can contain information
> for each of the security modules that export information
> outside the LSM layer.
> 
> The LSM interfaces that provide "secctx" text strings
> have been changed to use a structure "lsm_context"
> instead of a pointer/length pair. In some cases the
> interfaces used a "char *" pointer and in others a
> "void *". This was necessary to ensure that the correct
> release mechanism for the text is used. It also makes
> many of the interfaces cleaner.
> 
> Security modules that use Netlabel must agree on the
> labels to be used on outgoing packets. If the modules
> do not agree on the label option to be used the operation
> will fail.
> 
> Netfilter secmarks are restricted to a single security
> module. The first module using the facility will "own"
> the secmarks.

Is it expected that enabling all security modules with this change will 
yield permission denials on packet send/receive (e.g. sendmsg() fails 
with permission denied), even without any configuration of NetLabel or 
SECMARK?  That's what I see.

> 
> git://github.com/cschaufler/lsm-stacking.git#stack-5.1-v2-full
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   drivers/android/binder.c                |  25 +-
>   fs/kernfs/dir.c                         |   6 +-
>   fs/kernfs/inode.c                       |  31 +-
>   fs/kernfs/kernfs-internal.h             |   3 +-
>   fs/nfs/inode.c                          |  13 +-
>   fs/nfs/internal.h                       |   8 +-
>   fs/nfs/nfs4proc.c                       |  17 +-
>   fs/nfs/nfs4xdr.c                        |  16 +-
>   fs/nfsd/nfs4proc.c                      |   8 +-
>   fs/nfsd/nfs4xdr.c                       |  14 +-
>   fs/nfsd/vfs.c                           |   7 +-
>   fs/proc/base.c                          |   1 +
>   include/linux/cred.h                    |   3 +-
>   include/linux/lsm_hooks.h               | 119 +++---
>   include/linux/nfs4.h                    |   8 +-
>   include/linux/security.h                | 159 ++++++--
>   include/net/af_unix.h                   |   2 +-
>   include/net/netlabel.h                  |  18 +-
>   include/net/scm.h                       |  14 +-
>   kernel/audit.c                          |  43 +--
>   kernel/audit.h                          |   9 +-
>   kernel/auditfilter.c                    |   6 +-
>   kernel/auditsc.c                        |  77 ++--
>   kernel/cred.c                           |  15 +-
>   net/ipv4/cipso_ipv4.c                   |  13 +-
>   net/ipv4/ip_sockglue.c                  |  14 +-
>   net/netfilter/nf_conntrack_netlink.c    |  29 +-
>   net/netfilter/nf_conntrack_standalone.c |  16 +-
>   net/netfilter/nfnetlink_queue.c         |  35 +-
>   net/netfilter/nft_meta.c                |   8 +-
>   net/netfilter/xt_SECMARK.c              |   9 +-
>   net/netlabel/netlabel_kapi.c            | 125 ++++--
>   net/netlabel/netlabel_unlabeled.c       | 101 +++--
>   net/netlabel/netlabel_unlabeled.h       |   2 +-
>   net/netlabel/netlabel_user.c            |  13 +-
>   net/netlabel/netlabel_user.h            |   2 +-
>   net/unix/af_unix.c                      |   6 +-
>   security/apparmor/audit.c               |   4 +-
>   security/apparmor/include/audit.h       |   2 +-
>   security/apparmor/include/net.h         |   6 +-
>   security/apparmor/include/secid.h       |   9 +-
>   security/apparmor/lsm.c                 |  64 ++--
>   security/apparmor/secid.c               |  42 +-
>   security/integrity/ima/ima.h            |  14 +-
>   security/integrity/ima/ima_api.c        |   9 +-
>   security/integrity/ima/ima_appraise.c   |   6 +-
>   security/integrity/ima/ima_main.c       |  34 +-
>   security/integrity/ima/ima_policy.c     |  19 +-
>   security/security.c                     | 653 +++++++++++++++++++++++++++-----
>   security/selinux/hooks.c                | 310 +++++++--------
>   security/selinux/include/audit.h        |   5 +-
>   security/selinux/include/netlabel.h     |   7 +
>   security/selinux/include/objsec.h       |  43 ++-
>   security/selinux/netlabel.c             |  69 ++--
>   security/selinux/ss/services.c          |  18 +-
>   security/smack/smack.h                  |  34 ++
>   security/smack/smack_access.c           |  14 +-
>   security/smack/smack_lsm.c              | 388 ++++++++++---------
>   security/smack/smack_netfilter.c        |  48 ++-
>   security/smack/smackfs.c                |  23 +-
>   60 files changed, 1855 insertions(+), 961 deletions(-)
> 

