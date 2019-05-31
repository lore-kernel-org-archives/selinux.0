Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57116C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBDD26FF8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KlmWmAE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfEaXb7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:31:59 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:38361
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfEaXb7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345518; bh=hp70s42sLJvM/zJRYPFnublS5r/YV4V9DcOROooBKGM=; h=From:To:Cc:Subject:Date:From:Subject; b=KlmWmAE/ZUaQu4uCY9YfdyOW9pw2ayNjEkydEU+SdeykPCSZYm+LtwVoHo8NDMtl5AZoHh0rpJ7RZy0oMXj2aRyijkVwRDWw+XgBnLH4L8L8FSbX/+IXPIBmO4PCszDNQxNtyZhWTpNolUbIM9KRNVHzREmkllcxMZAEWJ1fKaAL6EYbZ7eipzkd9Vibvi5S//kTK34lFzaZKI370G492iZZlnJzd2tYRFoMu6oUH8/Q0vvZX7VHFf9BFRe8ejT+RoflHzx7ZCfAylQU8hr3Rh7LdXooIe9vdDTSy5kn6U2qJwfDu5c0dbmazoILak+3DWcOEusVlKG9dFo+ZEyTMA==
X-YMail-OSG: KPynPnoVM1k_0xpXX5Ft8sywLju4HrHGmlxeut9zHYxUMYh2KWShBZvl9NfvzSw
 QxCSbWMzR6Vgnppa_2e1FtFA_WN7KqLWh2HsljGpvUCQqdYGP.5aZtAE_8zM4hxQZuA8SFpMA_DR
 IlXJjro9yWJuN.XPnKYwPl76aXYH9XsnXqxezdO70IhjyhPGwxfSo87g3zSekncuWh6IqthrlKTq
 1Pk5dl_ye.EcsTNPwoKD9D_oCPLvSCzOBl_Ff3OVzKMiP.YqEZqzg5aP9p4Rw4g31NswI5HhSen6
 S0BYEfq.1DBcn8WBtH45G.E5oHh5TdYqxILUZs3Tk4yp.skoBNOk3s8P1gmUz8dL1k3Pjp7YLvjR
 i1zU4qScNb0jZxk1mKBpXQ1AtrqIdtxGTygnh1qn3MMJ1rtYtsTIxz0H2AU6ip_Dpx53N6xhkT7L
 3dFuCa0Hggra9c1FVD.6FajEGWSmuDsDRFRQ1u0NI0VWG4otTThxYx8QWXyAcOvW.bUdogqv0vgk
 AahLuAKBbn6vpv4qOkD.Qc7o2CbtbFKXuxUe2CPiRsizjDV8xLMuwt158Y_MvRJ_0Q5e2UCzLBhw
 knW4a14slX9ohHc6hHv_IpkmboHf.P7q1iYFnxAx9G9HGGkw68KIODYzIBav29OL7Peyogeeazp7
 BwjFxGx2PbD8H1jnlHoUvXnxEhceOW73uvi5KQTcLDevb36hQLXNF1O1nfNSIO2WdUvsTNn2qjYU
 ZS4d5E962Mvd8r63DzNCd6bsiPMEgdn1Jj.vTb3CRK8aRkZgmpzSlRHTbKGZRPnoqO3wb7clxPe6
 Vd2oqolXfcEMsZ875hpwdq4vw0XvEWfPPGT0zzAq7Xq_0e0zky2zWp2sJGNzHAZ1Ax0NicwSoZ2G
 KjHr_818Sm8kP22ZnmSr9mQEu0gpybADUqBOP8h13zj.PMCVgSbMpT2c.rzUN7UiFp9hX3bcX3E4
 tMy.tDGeBelcIYGWzcud6SW4Z3PnF5a6FWkTU_p04m5GidyPMShEGtAD0Ud2UyjUKJIeoy1svfke
 bCV33uVqS_X4IlaR52kv8WVpWfRXzEmrIfs8b5NWSYWxRLR8SmdKHkPRnZ5diwnQlkL.GIIp2D2z
 fliQDxDIivA1Ju9HqppcV5sQVuz.WBvTmieu1WcCOS_Vrnuy0Y_u7GL96GlW1UvZzYgWkqcbBXx7
 Mo8FzbmvcvGOHRNBdAGzQtT_J.7kH15pqDVU.ECOZtdAwKs2v0sRVFAHtARXSVBK5f7.J3T0tlcb
 ke5cr5pL0MN7Xo6jj0IbA00H8w_UYdAePLS5D.Mfj4IixaceVDBL_UCVs2XW870ZNZy4UU0tGS18
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:31:58 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c9debc343e8a4b0660a80e20d6fcb3d3;
          Fri, 31 May 2019 23:31:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 00/58] LSM: Module stacking for AppArmor
Date:   Fri, 31 May 2019 16:30:51 -0700
Message-Id: <20190531233149.715-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor

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
 include/linux/lsm_hooks.h               |  91 +++++----
 include/linux/nfs4.h                    |   8 +-
 include/linux/security.h                | 133 +++++++++----
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |  10 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  43 ++--
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   6 +-
 kernel/auditsc.c                        |  77 ++++----
 kernel/cred.c                           |  15 +-
 net/ipv4/cipso_ipv4.c                   |  13 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  29 ++-
 net/netfilter/nf_conntrack_standalone.c |  16 +-
 net/netfilter/nfnetlink_queue.c         |  38 ++--
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |  14 +-
 net/netlabel/netlabel_kapi.c            |   5 +-
 net/netlabel/netlabel_unlabeled.c       | 101 +++++-----
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   2 +-
 net/unix/af_unix.c                      |   6 +-
 security/apparmor/audit.c               |   4 +-
 security/apparmor/include/audit.h       |   2 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/include/secid.h       |   9 +-
 security/apparmor/lsm.c                 |  64 +++---
 security/apparmor/secid.c               |  42 ++--
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  34 ++--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/security.c                     | 338 +++++++++++++++++++++++++++-----
 security/selinux/hooks.c                | 259 ++++++++++++------------
 security/selinux/include/audit.h        |   5 +-
 security/selinux/include/objsec.h       |  42 +++-
 security/selinux/netlabel.c             |  25 +--
 security/selinux/ss/services.c          |  18 +-
 security/smack/smack.h                  |  18 ++
 security/smack/smack_lsm.c              | 238 +++++++++++-----------
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  12 +-
 58 files changed, 1217 insertions(+), 779 deletions(-)
