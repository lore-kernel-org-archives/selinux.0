Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1500C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD22B2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EdTo6RuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDIVkJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:09 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:44408
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbfDIVkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554845994; bh=W9Bk1GHOf2dTaz/rUNvsw6t4KBSqP73iCvdQussNTCc=; h=From:To:Cc:Subject:Date:From:Subject; b=EdTo6RuP2rQm2uMWgi9tk4y4Rxcb9P7dYEJNtD2c5Dx91vjUYpjn8PjzApcJdAw7IGFi2rEFyV/sMgth0jFX2v0o8XFRvIyTWx9yyVhlh//j/1HL6k1qteO4VZ6uZbPovKDOqikvJMvz5SqnE1nJSFxxUwm7QlK0QntzQMtWg4gBh1IZepz438BcMSpB/r/xN3jfhCKM+Qj3WzBCdZDop/pm2+hLgLcAqHKIdQ6rsFcccLrWwp0DNW3xPTCNJ7ChngLt61f8HaWS/XYxwgBDg8uTAVrjvv4iKhBwwjDagl2Usb+mITAHOVp2+c2gVMdtk3Ndn+jSslXdeCHEiXCB2g==
X-YMail-OSG: b72_LQ4VM1lD.iiFfKFHcThc0fGTEVc7WhdWbDxbiHDa7_u0Ctv3.deVhR60BaQ
 qRiq3ZB9D97vDkPQ4Upmnl_3DQIcTkgvR4qbvObayYWkZIKJQsnQe88A.b.VFKGGk6ezOvSZ4Jmp
 5G.OrmgFcOtBthpMdsYGlzyAsOh1.ZfbWpeLeWykCzMw8c.i4FGJhkt4SNR1BAhjq8O4UPTeErr7
 biGtZgQ6IlpVdPQA_LeSCkS3CtDtmrkaaS_l06vum1hAa0oA6LMd00HeTgxZFa6Yg0DoBDpn5tDz
 riYCylGJi.Rw9U3C.tN9itP.jxP7zjWp7rlsFRbKBQd8EJGkd0XhPl1Ce7uW2Ui.CSvODyY9RDfL
 3w_.7DOYSd3Ypq2N7mfYw5IQESTrlHCCglFiSpBKI0RLEthNMWneBKuBDaT3W5_dM7rgtCTkZgzq
 ibIa.EEW5Vzhu8Sn_ANyg_pLXSNK0I0r2sNYtKCWdXKMoghqh_tULPmpyyvWls6qVnph2MqTOYxz
 _MS0gpH.XPpiW5zws0p8SbSwtmirG6DtqL56EI4ym.aBuNB28LS2BJIOAKA1l_QUmNFBuzxMEqsm
 RSgg8M6.NBcEeigU8KC.fb9PazdBIbbArt5NTdOLYR3RzTE8ZsN2vGhR49p5vnnxa9hYsb2FsY.9
 8Mwj3YoXzzUk5wjNRN9EEWVp4HLspLBjfX0wtVXZ6zXWqUraNq90bJsRLid3wb5fGxdDpzw1VWke
 Kl7fvdsb3w9..HhBcM6aQAcCwOWGR.EHSDXLDM0Sq8EhK5w0PNXq6jnkeAk6xpS1PiwxBk5sadwM
 y3McvJafFLYOWCgiMFCaWawlFlqWs3wOCwNFlwPX9xBtWu703WeEhM0NJp.ZWi2g.KwF8aKtWfaP
 8zRUuNGvjC9iooz86.RZSO57OUBOj8FvQlyeOVG3CF4jLpRXlypqUtBfj2cjNGec753pjlWRxivP
 QHvK3N6LNqnH88.CKpi7UAD0f0dIo6apsb9N1SGkVur5pQJkiNQQ.vPFb7vwg7DUpabjgb9FwsEK
 KATTaWMvVHkYjVxIEkMXyBaAU2dXxWNPBkcy696Hu.DE7eycJGF30vA8y1gKki_DuUjlwBjLu92A
 adrSlMKO75u3rOjRpJ2DrT8f5s4TjLTREBF1acWWcBxMCoGfgzvWHba.Ia7qdUtsNjLgcW53qoFE
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:39:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9c4e55bd3d312d6c1e8f7ed93770d720;
          Tue, 09 Apr 2019 21:39:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 00/59] LSM: Module stacking for AppArmor
Date:   Tue,  9 Apr 2019 14:38:47 -0700
Message-Id: <20190409213946.1667-1-casey@schaufler-ca.com>
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
