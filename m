Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F551C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B62084F
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="omdHv+p7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbfCAOWn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:22:43 -0500
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:12897 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388464AbfCAOWn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 09:22:43 -0500
X-EEMSG-check-017: 193041597|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Mar 2019 14:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551450157; x=1582986157;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ew2Yx6k42mjdgnLb3Nj4Y0xyvy456V3x+Rsfk5WPSeU=;
  b=omdHv+p7vfab+roZ/wOmqtBNvTwg1cwqP4UWXRNLqFFwuMz6QzmEeF9l
   kOnZ8qyfsnaFEgMZqRL/XUygop0QnxfWMRZrRR44GlRcBnHyBWnAyQRUz
   N2FK/QRP2ovZteKkh7k825VeZRkDie7GVTMKjh95/wT8r65MtXCU8cjYT
   oGuB3NnS6Hd/pWeP2lRZxUKpLLX4Z9AL7T3PsgEEhecmdquCH/SOu2u0t
   ewJcGZuwKjyfFrGg8ZZ5LGv7e8vLRDpfEn66M4Gyfg3wLPM7yy218R1Bh
   8PgmiS71n+4TPe1idc2WGshz5cds5+3GnPrmV2woMs1WvLx1jTJdT1Zog
   w==;
X-IronPort-AV: E=Sophos;i="5.58,427,1544486400"; 
   d="scan'208";a="21032071"
IronPort-PHdr: =?us-ascii?q?9a23=3AoaF6OBFvuL16xTqvQTFKD51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pMSybnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VesCGaMpF5QsIkQ2xwtyY6y6EGuZ?=
 =?us-ascii?q?6mfCcR0pgo2xnfa/mBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9frXnpoOTN49zig3kNKQhhte/DvgiPg?=
 =?us-ascii?q?gLXmib/fyw1Lzl/ULnXLVHluA6n6bWvZzAJckXu7S1DxFa34o98RqzEi+q0N?=
 =?us-ascii?q?ECknkGKFJFdgiHj4/sO1zWO/D3EOy/jk+wkDZr2//GPrrhDo/LLnjYirjtZ7?=
 =?us-ascii?q?l960lCyAYr19BQ+4pUCq0dIPL0QkL+qMbXDgQnPA202OvnE8ly1oMEVmKSDK?=
 =?us-ascii?q?+ZNL3dsUWR6u0zOeaAfpMauDH4K/I9/f7hkWc5mUMBfamuxZYXanW4HvN8I0?=
 =?us-ascii?q?WDYHrsmcwMEWEQsQo7UuPqiUeOUTlJZ3a9R6g8/C00CJq6DYffQYCgmLiB3C?=
 =?us-ascii?q?a9Hp1LaWFKE0uMHmn0eIWZQfcMaT6SI894njwBUriuVpIh1RWwuwLh1bpnIf?=
 =?us-ascii?q?Tb+jcCuZLgytd1/evTmg829TBuCMSdyW6NRXlunmwUXz82wLx/oUtlx1eYz6?=
 =?us-ascii?q?d4h/1YFdpO5/JGSQo6K5HcwPJgC9zoWQLOYM2JSFC4TdWiGz0xScgxw9AWaU?=
 =?us-ascii?q?ZnB9qilgzD3zatA7INlLyEGoI78rnA0Hj2IMZ9yG3L27Uhj1k8RctPMGymhr?=
 =?us-ascii?q?N69wTJAI7JiUqZnb6wdasAxC7N6HuDzW2WsUFaVw5wUaPFUWodZkvRrdT2/E?=
 =?us-ascii?q?XCT6SwBrQhKQZO1dSNKq1Nat3vjFVJWO3sONDEb22tnGewAA6CxqmQY4ryZ2?=
 =?us-ascii?q?UdwCLdBVAckw8N+3aGOhU+Biano27HDzxhC0jvY0Xy/ul6s367T1Y4zwWNb0?=
 =?us-ascii?q?1/ybW54AUViuafS/MOxLILoj0tqzNqE1qn3dLWE8KKpxB9c6VEfdM9/FBH2H?=
 =?us-ascii?q?rBtwNnI5ygK7tvhkYEfARqu0PizhB3CoJHkcgwsnwm1hZ9KaWd0AAJSzTN9p?=
 =?us-ascii?q?nrN6yfEWLy9Q2hb6PMkgXV2c2b648U4/QxtlvnsRvsHUNk+HJihZ0d0X6b/I?=
 =?us-ascii?q?/LFyIUWJf8UwAw7Rc+77XbZDQtopjZ3mB2MLWl9zrF188tCcM7xRu6OdRSKq?=
 =?us-ascii?q?WJEEn1CcJeT9OjLO0shkiBcB0JJqZR+bQyMsfgcOGJi4CxO+M1py6rlWRK5s?=
 =?us-ascii?q?hG10uI8ydtArrT040t3+CT3gzBUSz1ylimrJakysh/eTgOEz/nmmDfD4lLa/?=
 =?us-ascii?q?g3JNxTBA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BCAAB+P3lc/wHyM5BbChwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YFaKmhRMieECIgajBsBAQEBAQEGgQgtiTyOZIF7KBABhEAChCEiNAkNAQMBA?=
 =?us-ascii?q?QECAQMCAWwcDII6KQGCZgEBAQECASMVQQULCxgCAiYCAlcGAQwGAgEBgl8/A?=
 =?us-ascii?q?YFoBQirPYEvhUSEa4ELi0AXeIEHgTiCa4MeAoE2gzWCVwKKDYZSSzuSFQmHQ?=
 =?us-ascii?q?4smBhmBdFiQVYpggRKSeziBVisIAhgIIQ+DJwmGAYpxIQMwgQUBAY88AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Mar 2019 14:22:35 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x21EMZVg001681;
        Fri, 1 Mar 2019 09:22:35 -0500
Subject: Re: [PATCH 00/97] LSM: Complete module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190228221933.2551-1-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c334385a-89e8-169a-3e92-4b816145391d@tycho.nsa.gov>
Date:   Fri, 1 Mar 2019 09:17:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/28/19 5:17 PM, Casey Schaufler wrote:
> This is a preliminary version of the complete stacking
> implementation. The patches need to be cleaned up, and
> several are not strictly necessary. There is likely to
> be work required in the audit sub-system. It does address
> all the shared data, including CIPSO headers. It should
> handle CALIPSO once Smack supports it. I will be revising
> the set after 5.1.
> 
> Complete the transition from module based blob management
> to infrastructure based blob management. This includes
> the socket, superblock and key blobs.
> 
> Change the LSM infrastructure from exposing secids to
> exposing an opaque "lsm_export" structure that can contain
> information for multiple active security modules. Update
> all of the security modules to use information from the
> lsm_export structure. Update the LSM interfaces that expose
> secids for more than one module to use the export structure.
> Update all the users of these interfaces.
> 
> Change the LSM infrastructure from using a string/size pair
> for security "contexts" to a "lsm_context" structure that
> can represent information for multiple modules. This contains
> information that allows the "context" to be properly freed
> regardless of where it is allocated and where it is used.
> 
> Add an interface to identify which security module data
> should be presented with SO_PEERSEC. /proc/.../attr/display
> will set and report the name of the LSM for which the
> security_secid_to_secctx() will use to translate to text.
> If it is not explicitly set, the first security module that
> supplies secid (now lsm_export) interfaces will be used.
> To ensure consistency, a set of module hooks dealing with
> the secid/context processing is maintained with each process
> that explicitly sets it.
> 
> Before sending a network packet verify that all interested
> security modules agree on the labeling. Fail if the labeling
> cannot be reconciled. This requires a new Netlabel interface
> to compare proposed labels, and a change to the return values
> from the existing netlabel attribute setting functions.

Have you run any benchmarks to assess the performance impact of these 
changes?

> 
> git://github.com/cschaufler/lsm-stacking.git#5.0-rc3-plus-a
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/kernfs/dir.c                                    |   6 +-
>   fs/kernfs/inode.c                                  |  31 +-
>   fs/kernfs/kernfs-internal.h                        |   4 +-
>   fs/nfs/inode.c                                     |  13 +-
>   fs/nfs/internal.h                                  |   8 +-
>   fs/nfs/nfs4proc.c                                  |  17 +-
>   fs/nfs/nfs4xdr.c                                   |  16 +-
>   fs/nfsd/nfs4proc.c                                 |   8 +-
>   fs/nfsd/nfs4xdr.c                                  |  14 +-
>   fs/nfsd/vfs.c                                      |   7 +-
>   fs/proc/base.c                                     |   1 +
>   include/linux/cred.h                               |   3 +-
>   include/linux/lsm_hooks.h                          | 122 ++--
>   include/linux/nfs4.h                               |   8 +-
>   include/linux/security.h                           | 165 +++--
>   include/net/netlabel.h                             |  18 +-
>   include/net/route.h                                |  55 +-
>   include/net/scm.h                                  |  14 +-
>   include/net/sock.h                                 |  14 +-
>   include/uapi/linux/netfilter/xt_CONNMARK.h         |  45 +-
>   include/uapi/linux/netfilter/xt_DSCP.h             |  27 +-
>   include/uapi/linux/netfilter/xt_MARK.h             |  17 +-
>   include/uapi/linux/netfilter/xt_RATEEST.h          |  38 +-
>   include/uapi/linux/netfilter/xt_TCPMSS.h           |  13 +-
>   include/uapi/linux/netfilter_ipv4/ipt_ECN.h        |  40 +-
>   include/uapi/linux/netfilter_ipv4/ipt_TTL.h        |  14 +-
>   include/uapi/linux/netfilter_ipv6/ip6t_HL.h        |  14 +-
>   kernel/audit.c                                     |  60 +-
>   kernel/audit.h                                     |   9 +-
>   kernel/auditfilter.c                               |   6 +-
>   kernel/auditsc.c                                   |  61 +-
>   kernel/cred.c                                      |  15 +-
>   net/ipv4/cipso_ipv4.c                              |  13 +-
>   net/ipv4/ip_sockglue.c                             |  14 +-
>   net/ipv4/route.c                                   |  61 ++
>   net/netfilter/nf_conntrack_netlink.c               |  27 +-
>   net/netfilter/nf_conntrack_standalone.c            |  16 +-
>   net/netfilter/nfnetlink_queue.c                    |  35 +-
>   net/netfilter/nft_meta.c                           |   8 +-
>   net/netfilter/xt_DSCP.c                            | 149 ++---
>   net/netfilter/xt_HL.c                              | 164 ++---
>   net/netfilter/xt_RATEEST.c                         | 278 +++------
>   net/netfilter/xt_SECMARK.c                         |   9 +-
>   net/netfilter/xt_TCPMSS.c                          | 378 +++---------
>   net/netlabel/netlabel_kapi.c                       | 125 +++-
>   net/netlabel/netlabel_unlabeled.c                  |  99 ++-
>   net/netlabel/netlabel_unlabeled.h                  |   2 +-
>   net/netlabel/netlabel_user.c                       |  13 +-
>   net/netlabel/netlabel_user.h                       |   2 +-
>   net/socket.c                                       |  17 +
>   net/unix/af_unix.c                                 |  11 +-
>   security/apparmor/audit.c                          |   4 +-
>   security/apparmor/include/audit.h                  |   2 +-
>   security/apparmor/include/net.h                    |   6 +-
>   security/apparmor/include/secid.h                  |   9 +-
>   security/apparmor/lsm.c                            |  64 +-
>   security/apparmor/secid.c                          |  42 +-
>   security/integrity/ima/ima.h                       |  14 +-
>   security/integrity/ima/ima_api.c                   |   9 +-
>   security/integrity/ima/ima_appraise.c              |   6 +-
>   security/integrity/ima/ima_main.c                  |  34 +-
>   security/integrity/ima/ima_policy.c                |  19 +-
>   security/security.c                                | 682 ++++++++++++++++++---
>   security/selinux/hooks.c                           | 308 +++++-----
>   security/selinux/include/audit.h                   |   6 +-
>   security/selinux/include/netlabel.h                |   7 +
>   security/selinux/include/objsec.h                  |  43 +-
>   security/selinux/netlabel.c                        |  69 ++-
>   security/selinux/ss/services.c                     |  19 +-
>   security/smack/smack.h                             |  34 +
>   security/smack/smack_access.c                      |  14 +-
>   security/smack/smack_lsm.c                         | 389 ++++++------
>   security/smack/smack_netfilter.c                   |  48 +-
>   security/smack/smackfs.c                           |  23 +-
>   .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |  12 +-
>   75 files changed, 2369 insertions(+), 1798 deletions(-)
> 

