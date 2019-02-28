Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB136C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8622133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Fb6RErQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfB1WTs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:48 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:42975
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728223AbfB1WTr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392386; bh=r1y0GBXKkBbY5qhMGHClPoSe5dafkvFJUOvqdLXhntA=; h=From:To:Cc:Subject:Date:From:Subject; b=Fb6RErQIuQIQHZITxKQPkYwLq/mbEnJYhkCPdmxyOZfok8/fu5IzAVTwwTNs6dvUQi7G5sCYmzNJxmV5OigPtAimtsNdMfrVdzm4fLdz+NMGegl7IG8Lgbxe4BcQrcQ52fxjIhdmsbt/bRyb1x2B1cvKOxyTQtjtY2k0JWgRNSWPAKUu3dITDb7OYtoWclMkYH4Atq9hgjdAlCxj+MdGrRIPKOahCNiQAAm1VLow0326u20P0TJX6s63mVBU1g5a2y/TBcKPIr5vEQ+h5nz+YlDYu/KW7yO003kPo4i8nf/d/kBKAYnqyNDj9zWzLO+HIsP1ofWleQ8FL75qYDyDBA==
X-YMail-OSG: 2wayISUVM1kMGjayoKBIrSGR.c4TAWxTk8bF59mzJ765mJWCpg6UreeXfUkXCyx
 RgSF.2OUErJVnTgGfyEcMhBZV305hgFnRO3Ot.kZ0iz7Q_mC8Byu.y67EpHO4ZyPAaScoEmLp43u
 gfHWXvEEjwVVU7RS0jxJ67wAqUw75mDgqrkauEbVhQqXGeEPUVuiztl4tVGaRRL7htbiIn_k.Q8r
 vuESEvvQOFwrkonXTyibfFtcba.KjMwJTLyoli_0MsJaggS5S_gAZ_WcRCn6KtYx2spcwypy1NLB
 S.Y_0iqKBLD15XlZXiNsNHjZjPP863ZiQkl6.i5kwtfuUoHYwCJfliPtBHuIKCkXdc0kjW0U4mlr
 ZBuU357s9hRTx4Je.6McXfgHjZbH0M6jpsMZzpQokNrBV6TFJub6imwtdHlaoS_pZvzrY1MLQ7LM
 xTREH2EXrqgmPWYB6w7_9XjbCLKwvVTgnncwbJyCXKI8TfoHvDlsv0Qh6ScsFAdMBbZlLtcIUh4R
 rtaCXvCCfJfJ0H5Q6ykYX5GRg6fgji6LjohPKAF_t27dhI1wGgheMK4634XI8kBj8NEn83hKgoZ4
 mhW8_I4mMAAzO4A.gQqVDk.anme4eI_gY0k.ETEFEdehMAN57qu3es6NJmK9B2HgYS_QAxPWGzMZ
 yk9VMHQmmP6i9AMN_NSEACSg_fdhFoAiFYrBpL5jsW47g3iAB5RGWKjOHBietJ7G17IXP8Nl5vQo
 gRT8RDVgjo5DVUxXxx3G8xImHEyD9Q_pev6OPG1wx21azwhkkuFQnUHXXV9T2ied9u7.qjiSg5XH
 LXjV_vw2TteOy1B1pfSvBaFZmzYpl0YvrchDd8foGjHl0vlqh6pvoyCL0IhpknLYi3dt1nWNqUVr
 BXlCAWXF6OuCIVbPke8xYYkn6oUEoLJZSOwH_q1Uq2ItQeZOP7WxUj2UDAfqNLuCmB6wXDI02QM4
 BIRpcKRQ.4dH43m1RWJY1zA0FgBvBlRZGQ0ij3Kh416UmuoPULxsK.LJ43joi_fYI0sa.E6I6YSZ
 X2LwEGhcTn_PiuY0fzXsjR49pTN6kmrG55XqhnCpJvUjyFgOwJmVuOoyFi96vhTw9r46zfe.vIx9
 _YaCZxWXvQlUD4jeirrYk7ch0Urn.L83tegw2zlFHJFBkd.8UIZNifDL2VjTR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 00/97] LSM: Complete module stacking
Date:   Thu, 28 Feb 2019 14:17:56 -0800
Message-Id: <20190228221933.2551-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a preliminary version of the complete stacking
implementation. The patches need to be cleaned up, and
several are not strictly necessary. There is likely to
be work required in the audit sub-system. It does address
all the shared data, including CIPSO headers. It should
handle CALIPSO once Smack supports it. I will be revising
the set after 5.1.

Complete the transition from module based blob management
to infrastructure based blob management. This includes
the socket, superblock and key blobs.

Change the LSM infrastructure from exposing secids to
exposing an opaque "lsm_export" structure that can contain
information for multiple active security modules. Update
all of the security modules to use information from the
lsm_export structure. Update the LSM interfaces that expose
secids for more than one module to use the export structure.
Update all the users of these interfaces.

Change the LSM infrastructure from using a string/size pair
for security "contexts" to a "lsm_context" structure that
can represent information for multiple modules. This contains
information that allows the "context" to be properly freed
regardless of where it is allocated and where it is used.

Add an interface to identify which security module data
should be presented with SO_PEERSEC. /proc/.../attr/display
will set and report the name of the LSM for which the
security_secid_to_secctx() will use to translate to text.
If it is not explicitly set, the first security module that
supplies secid (now lsm_export) interfaces will be used.
To ensure consistency, a set of module hooks dealing with
the secid/context processing is maintained with each process
that explicitly sets it.

Before sending a network packet verify that all interested
security modules agree on the labeling. Fail if the labeling
cannot be reconciled. This requires a new Netlabel interface
to compare proposed labels, and a change to the return values
from the existing netlabel attribute setting functions.

git://github.com/cschaufler/lsm-stacking.git#5.0-rc3-plus-a

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/dir.c                                    |   6 +-
 fs/kernfs/inode.c                                  |  31 +-
 fs/kernfs/kernfs-internal.h                        |   4 +-
 fs/nfs/inode.c                                     |  13 +-
 fs/nfs/internal.h                                  |   8 +-
 fs/nfs/nfs4proc.c                                  |  17 +-
 fs/nfs/nfs4xdr.c                                   |  16 +-
 fs/nfsd/nfs4proc.c                                 |   8 +-
 fs/nfsd/nfs4xdr.c                                  |  14 +-
 fs/nfsd/vfs.c                                      |   7 +-
 fs/proc/base.c                                     |   1 +
 include/linux/cred.h                               |   3 +-
 include/linux/lsm_hooks.h                          | 122 ++--
 include/linux/nfs4.h                               |   8 +-
 include/linux/security.h                           | 165 +++--
 include/net/netlabel.h                             |  18 +-
 include/net/route.h                                |  55 +-
 include/net/scm.h                                  |  14 +-
 include/net/sock.h                                 |  14 +-
 include/uapi/linux/netfilter/xt_CONNMARK.h         |  45 +-
 include/uapi/linux/netfilter/xt_DSCP.h             |  27 +-
 include/uapi/linux/netfilter/xt_MARK.h             |  17 +-
 include/uapi/linux/netfilter/xt_RATEEST.h          |  38 +-
 include/uapi/linux/netfilter/xt_TCPMSS.h           |  13 +-
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h        |  40 +-
 include/uapi/linux/netfilter_ipv4/ipt_TTL.h        |  14 +-
 include/uapi/linux/netfilter_ipv6/ip6t_HL.h        |  14 +-
 kernel/audit.c                                     |  60 +-
 kernel/audit.h                                     |   9 +-
 kernel/auditfilter.c                               |   6 +-
 kernel/auditsc.c                                   |  61 +-
 kernel/cred.c                                      |  15 +-
 net/ipv4/cipso_ipv4.c                              |  13 +-
 net/ipv4/ip_sockglue.c                             |  14 +-
 net/ipv4/route.c                                   |  61 ++
 net/netfilter/nf_conntrack_netlink.c               |  27 +-
 net/netfilter/nf_conntrack_standalone.c            |  16 +-
 net/netfilter/nfnetlink_queue.c                    |  35 +-
 net/netfilter/nft_meta.c                           |   8 +-
 net/netfilter/xt_DSCP.c                            | 149 ++---
 net/netfilter/xt_HL.c                              | 164 ++---
 net/netfilter/xt_RATEEST.c                         | 278 +++------
 net/netfilter/xt_SECMARK.c                         |   9 +-
 net/netfilter/xt_TCPMSS.c                          | 378 +++---------
 net/netlabel/netlabel_kapi.c                       | 125 +++-
 net/netlabel/netlabel_unlabeled.c                  |  99 ++-
 net/netlabel/netlabel_unlabeled.h                  |   2 +-
 net/netlabel/netlabel_user.c                       |  13 +-
 net/netlabel/netlabel_user.h                       |   2 +-
 net/socket.c                                       |  17 +
 net/unix/af_unix.c                                 |  11 +-
 security/apparmor/audit.c                          |   4 +-
 security/apparmor/include/audit.h                  |   2 +-
 security/apparmor/include/net.h                    |   6 +-
 security/apparmor/include/secid.h                  |   9 +-
 security/apparmor/lsm.c                            |  64 +-
 security/apparmor/secid.c                          |  42 +-
 security/integrity/ima/ima.h                       |  14 +-
 security/integrity/ima/ima_api.c                   |   9 +-
 security/integrity/ima/ima_appraise.c              |   6 +-
 security/integrity/ima/ima_main.c                  |  34 +-
 security/integrity/ima/ima_policy.c                |  19 +-
 security/security.c                                | 682 ++++++++++++++++++---
 security/selinux/hooks.c                           | 308 +++++-----
 security/selinux/include/audit.h                   |   6 +-
 security/selinux/include/netlabel.h                |   7 +
 security/selinux/include/objsec.h                  |  43 +-
 security/selinux/netlabel.c                        |  69 ++-
 security/selinux/ss/services.c                     |  19 +-
 security/smack/smack.h                             |  34 +
 security/smack/smack_access.c                      |  14 +-
 security/smack/smack_lsm.c                         | 389 ++++++------
 security/smack/smack_netfilter.c                   |  48 +-
 security/smack/smackfs.c                           |  23 +-
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |  12 +-
 75 files changed, 2369 insertions(+), 1798 deletions(-)
