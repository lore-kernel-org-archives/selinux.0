Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3358C282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6936721736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tvaeC1Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDSAqb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:31 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:46785
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbfDSAqa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634789; bh=P1lu4maWQlkpHnXQcklWWaeWgN84+BDY7qm6GlIVNrA=; h=From:To:Cc:Subject:Date:From:Subject; b=tvaeC1QxMhSSO/4k6UHe+ZtRIll3mXX6dGyf9+if99i4xv5faBeT37JAAdBDau5ZxazL1A5TMapTXlHrLfYUfMBXIYfH/1re6hToHIKd9fCWPK88CIQ9Mz1XE32hg8UOzDEDUA/7gh5zfh3w803TgGpfYdC9czEYNj4LBdU59GzhZ43sA/jo3XnA/FfyNT6MDEmlsAe/x0dwXIirLihE91TW0TQS6w6n4gIF47M9LJelbg0JMV74N6A2y4d2vM4S23reJKu5KQSUNXAPdNluyXtXDdJqle6Kg8Lvax3la7yeNSlJ+DcSrvw/t51p035z/1jC2tngD+gKOE2F0csx2w==
X-YMail-OSG: upEWsQkVM1nQ_n0ZMDNs_HsZQIJbpd_JE06HoU2p8KWOT1q3wm2OFmPd1xTHY13
 kdZiabxoFPly_bO4T9.mHVI33nou.SRy3wLgwmznmfB1xcMnQTCdApTDTkVXT9LEiTy.Z3LOM3Fg
 6Oe584fxnsfLhj4V0L_FGZI5bBQLvyILruqSRfvGdn1Iz5839chZNqpMRLjFYV3rMmfucphUFjfc
 RKJ5KwWCaj90tLYHPWxkBXlvCZfA.URsKNZ.uNysdTn_VWX1oj3h13v9dlUF2vnKv8XV2gKNs7T0
 z01qC5m.cbhwZwymH6MATSGwWSy0fp8ApdKWvW8V7bT9HttK8JbABw42RUglvgV.OJqL4P0yv8y9
 p4qfvY7ErdQer2fKK9J7tjfxiEo2BUr7zUGT0H_JmnDNwDGF9UO1Z1q1jYRHEuetIeb7Z0rKTSyX
 1Ta2Xq69jGF9N1DOp2i1._gjCwGQYlflVnYMVB4moJ4RCyxo1MFKqj0zrcNVldY.tGeTC.b_Y9YN
 si5SoP4EydNy6zMTOMFGZZ6M0kzCTGxjqKysPXhvnzIwplfmYoXo7mgF5aZhPl4jjhwIS0SOloaW
 FmOKXMSiqHfzUFQFrkiB_HUYTDzDaySt3xmtt.wevsihd8.hr9eP3.VHYmaS.RUO9c_y5IuHDX_S
 5ymoADjPKxGy5pSbWa81lEMWESbYjK9iEw2xAhCb0hgmMCtvHCIuXjCjUoy24tByfSnsu_yKGQJt
 UGUdtBfrFWlmbfzqlG_TUlHuN4TQgNDMkqbK.hbaaqp8ztiPPv.iZimaOpxkt7BwRhloqEV5jup3
 fcDN62OOinHMh6UY0uxFyJgb96dy1t7hvUgYkopZfNnhX09bxT9v.XQ3PT3Inp4AMu2zNZF4q2yu
 WFGkVI80XFlZ5cjuqxtu9fTLdT6iAYw_S9XEl9duUaFk9_9x_.g0Xb_NRriJZD.uMm9wClikctIs
 lQPq6_CI3zDZp6popCDp7CN_bLUDT3J9mq6IgeGvCOyOEblPJyU0_H5LKicV9OUZ4IXpBCFnopO6
 YZ0cbHTbsuweB9xRacpl6wwMtyz2QWWSwSNVLagDVkzxNZJ040.XzcyIF.9FlzmeMgB.h75D7c9b
 YxYVS18dlilKQQFov9Yi28LnnK.qhy_KWffA_.lyxwkyl_VAEBwuqoTph54ifkt2rxMt9VnweoFL
 q9hk43NKQCVvxZ1RbHCNeQQ6M
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cf1bd369acc816a9d15b1740f4265439;
          Fri, 19 Apr 2019 00:46:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 00/90] LSM: Module stacking for all
Date:   Thu, 18 Apr 2019 17:44:47 -0700
Message-Id: <20190419004617.64627-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the any security module to stack safely with any other.

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

Security modules that use Netlabel must agree on the
labels to be used on outgoing packets. If the modules
do not agree on the label option to be used the operation
will fail.

Netfilter secmarks are restricted to a single security
module. The first module using the facility will "own"
the secmarks.

git://github.com/cschaufler/lsm-stacking.git#stack-5.1-v2-full

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  25 +-
 fs/kernfs/dir.c                         |   6 +-
 fs/kernfs/inode.c                       |  31 +-
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
 include/linux/lsm_hooks.h               | 119 +++---
 include/linux/nfs4.h                    |   8 +-
 include/linux/security.h                | 159 ++++++--
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |  18 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  43 +--
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   6 +-
 kernel/auditsc.c                        |  77 ++--
 kernel/cred.c                           |  15 +-
 net/ipv4/cipso_ipv4.c                   |  13 +-
 net/ipv4/ip_sockglue.c                  |  14 +-
 net/netfilter/nf_conntrack_netlink.c    |  29 +-
 net/netfilter/nf_conntrack_standalone.c |  16 +-
 net/netfilter/nfnetlink_queue.c         |  35 +-
 net/netfilter/nft_meta.c                |   8 +-
 net/netfilter/xt_SECMARK.c              |   9 +-
 net/netlabel/netlabel_kapi.c            | 125 ++++--
 net/netlabel/netlabel_unlabeled.c       | 101 +++--
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   2 +-
 net/unix/af_unix.c                      |   6 +-
 security/apparmor/audit.c               |   4 +-
 security/apparmor/include/audit.h       |   2 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/include/secid.h       |   9 +-
 security/apparmor/lsm.c                 |  64 ++--
 security/apparmor/secid.c               |  42 +-
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  34 +-
 security/integrity/ima/ima_policy.c     |  19 +-
 security/security.c                     | 653 +++++++++++++++++++++++++++-----
 security/selinux/hooks.c                | 310 +++++++--------
 security/selinux/include/audit.h        |   5 +-
 security/selinux/include/netlabel.h     |   7 +
 security/selinux/include/objsec.h       |  43 ++-
 security/selinux/netlabel.c             |  69 ++--
 security/selinux/ss/services.c          |  18 +-
 security/smack/smack.h                  |  34 ++
 security/smack/smack_access.c           |  14 +-
 security/smack/smack_lsm.c              | 388 ++++++++++---------
 security/smack/smack_netfilter.c        |  48 ++-
 security/smack/smackfs.c                |  23 +-
 60 files changed, 1855 insertions(+), 961 deletions(-)
