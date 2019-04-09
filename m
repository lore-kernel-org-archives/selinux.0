Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C04C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3122084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mPI8HVNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDITS4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:18:56 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:34859
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfDITS4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837534; bh=W9Bk1GHOf2dTaz/rUNvsw6t4KBSqP73iCvdQussNTCc=; h=From:To:Cc:Subject:Date:From:Subject; b=mPI8HVNxLp39B9wGZjKmvdPqdycSjhTODXHXDzDH0p2IIkaSUYwnAjnK6iDXe8K2XT0jr4MoesfyCzl3rctr7Kfb3qRT09unNRaKDW+pSn03nUODFGnWiS4D4SLQD6SMwBpQ8Tz+UGfFu8/24n2DBUgwwnjJgYETcCQuCZ6xWbBR8nR7dTB8C+6DS0lSTlkao2eQwk4i7E7AESd/pET4PdoXYZUe9Nvsfax+malMs8c4G5zGRWg3B//OZbd2P3+8cMi3tEUMNio+DaG9UzzJ26mYId3/fs4fi7dNxq4C70cumP4RTyW6kMm4n6M3+NrvQit7GpQTQYiQh7hMDJKYBg==
X-YMail-OSG: 2sC7NNwVM1k4sP9La2kgTNt9OCJD.h3850.KaH._I8OWkgofrZDbT.vidrwCOA4
 oE4hv8wLlCSC6bfRnpCAYbb7XKxCH3rla4L2RyIrNv28TKYhozvQIVJQV6IXDf_QiLvQFzW4V5tu
 kUB06SXJN_aNHXXXcYGb8GCAQfix1PScLsi.2__0QfSdFTq5_pjQ66BZzaGrC3yBeHyRdgsYApR5
 cebNoTDcUXzZxXN9syv57nLUvnRMDl87YHQcdBy75Vo4CH8X00r8nxCpfSvOEer3WG7hsKlWg6WX
 xHQdZUUk0i9zcKEgGWj5tksBCPrNmrrpjbi3haQzxFoi6aSzzgCxdWS4fhJGUgjhUIxhT9Z7Chly
 xMKs500Xs7fUJVVvb9k3Gr3U3kYdVOjL_hhQFc8roJy5i5Mob1KbhqWeCopFPKJGXW8sYyCBKV62
 ACYhMk7xVwuXU93HkMCUnyMfPVjIuqlYGWoE90P3YYDL9dHS1_SvpycX1qiEEJqp9Xm2GMeLI_PI
 9TbSoMBrhUEpi2o2KjckMNPCsJoxTaJMvD6ya1GNFy3TXEJOr5cuMN4ZxzkbRQtX27afUE0BqwZh
 M8beEC9etCQ58Ojr_4Qn1lx4YIv.O0YOB9Umk20ji_BL6GZBWeLu61UEsEWmfjyxNgJqszOrJ8Gl
 fy7HTlKHmY2shXYExQSv6lilaJudJL8xu4EU4V5dsDlRy3eIzDWVfUApcfpUikjo3QHdhvB2v554
 0_JOXATxDRTnSIMinc2j.EbX3cdAyKqbyUq89p7Y3A8n34hGk0RXQuy_n1QbFvPhPmOU4H4dS_tQ
 lmJOD2fTCJ6GhY.TSNouzq1KRdrWKNGcSNw6vSp4_RNwYMbdvRO_yl45rr_ApkY_R3pQEVPV59Vp
 NJUWZusEv4layIDw2tAsKN.o22EqzTC9A8AtPbKLRQuhglQc_ymMz5pWLLjEC7oxhR0bhNh2ps6U
 q57VOe_.Dfv2aLBwfb1oAKoIlUag01shnCbKm49DtElVLUpB5tNvR4shCqCeRsw6a67_H25KbUXm
 KXFU6X3is07emmD2Csi.e_UA4OX7MNMHJw95uNiuTwknHV8yNC1za.Cf_bZknlOlz9eD.H1ImhQM
 XM9VyjoJO7bAwfZmeRJ5_4wlulj_TJT0RPcsdBRLGUfIvj3x5pdwg2CTuL.YLLNIJGvUWAw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:18:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b77b874e22efcf04356cc7acbadd009c;
          Tue, 09 Apr 2019 19:18:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 00/59] LSM: Module stacking for AppArmor
Date:   Tue,  9 Apr 2019 12:17:49 -0700
Message-Id: <20190409191848.1380-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with
"exclusive" security modules, those being SELinux and
Smack. 

Performance: Using a kernel compile benchmark indicates
a performance impact of 0.15% for a Fedora 29 system
with SELinux. Adding AppArmor has an additional 0.20%
impact. Fedora does not include an AppArmor profile.

A new process attribute identifies which security module
information should be reported by SO_PEERSEC and the
/proc/.../attr/current interface. This is provided by
/proc/.../attr/display. Writing the name of the security
module desired to this interface will set which LSM hooks
will be called for this information. The first security
module providing the hooks will be used by default.

The use of integer based security tokens (secids) is
generally (but not completely) replaced by a structure
lsm_export. The lsm_export structure can contain information
for each of the security modules that export information
outside the LSM layer.

The LSM interfaces that provide "secctx" text strings
have been changed to use a structure "lsm_context"
instead of a pointer/length pair. In some cases the
interfaces used a "char *" pointer and in others a
"void *". This was necessary to ensure that the correct
release mechanism for the text is used. It also makes
many of the interfaces cleaner.

The security module stacking issues around netlabel
not addressed here as they are beyond what is required 
to stack AppArmor with either SELinux or Smack.

git://github.com/cschaufler/lsm-stacking.git#stack-5.1-rc2-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  25 ++-
 fs/kernfs/dir.c                         |   6 +-
 fs/kernfs/inode.c                       |  31 ++-
 fs/kernfs/kernfs-internal.h             |   3 +-
 fs/nfs/inode.c                          |  13 +-
 fs/nfs/internal.h                       |   8 +-
 fs/nfs/nfs4proc.c                       |  17 +-
 fs/nfs/nfs4xdr.c                        |  16 +-
 fs/nfsd/nfs4proc.c                      |   8 +-
 fs/nfsd/nfs4xdr.c                       |  14 +-
 fs/nfsd/vfs.c                           |   7 +-
 fs/proc/base.c                          |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  93 ++++----
 include/linux/nfs4.h                    |   8 +-
 include/linux/security.h                | 137 ++++++++----
 include/net/netlabel.h                  |  10 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  43 ++--
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   6 +-
 kernel/auditsc.c                        |  77 ++++---
 kernel/cred.c                           |  15 +-
 net/ipv4/cipso_ipv4.c                   |  13 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  29 ++-
 net/netfilter/nf_conntrack_standalone.c |  16 +-
 net/netfilter/nfnetlink_queue.c         |  38 ++--
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |  14 +-
 net/netlabel/netlabel_kapi.c            |   5 +-
 net/netlabel/netlabel_unlabeled.c       | 101 +++++----
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   2 +-
 net/unix/af_unix.c                      |  11 +-
 security/apparmor/audit.c               |   4 +-
 security/apparmor/include/audit.h       |   2 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/include/secid.h       |   9 +-
 security/apparmor/lsm.c                 |  64 ++----
 security/apparmor/secid.c               |  42 ++--
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  34 +--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/security.c                     | 366 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                | 259 +++++++++++-----------
 security/selinux/include/audit.h        |   5 +-
 security/selinux/include/objsec.h       |  42 +++-
 security/selinux/netlabel.c             |  25 +--
 security/selinux/ss/services.c          |  18 +-
 security/smack/smack.h                  |  18 ++
 security/smack/smack_lsm.c              | 238 +++++++++++----------
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  12 +-
 57 files changed, 1252 insertions(+), 781 deletions(-)
