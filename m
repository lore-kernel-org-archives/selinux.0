Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175DEC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE8B20833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oZBYzO8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfDIT7i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:38 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:34574
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbfDIT7i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839976; bh=W9Bk1GHOf2dTaz/rUNvsw6t4KBSqP73iCvdQussNTCc=; h=From:To:Cc:Subject:Date:From:Subject; b=oZBYzO8sCjpaHZXOzL/T/yTtJWr4Ei7Aloo38gSd2VLSHS9c1XPRvHiiIbOBk0QRKfO5AWkyBCd59qcXgmT8P1pWiWRfkP8ZmvdEcotqKhTW4c8+3FLNU39prfU/N88wWAgILiBiQyVIgx0kPEwenwZMBzSS5goBp0K5WmAAKEthIKBwYbmvxbo85gmMZAHkafjEwPi0VLjyqWDKeHKvnuZ7lp6+KB5CZm0w9QtlXzT5BRoGA8w6gw8/lkSiQ6Sp7yykN30p7EkvKneDCw8gTHv9F7ypudIyirP+NONjtjdW60bOE51IpiVyzL65SeAhIVUoCDTi/iCBEY/6Xjav2g==
X-YMail-OSG: lFK.IpIVM1k4_xUROrsnr0cS2088XprQq22vsIIjglwZ0jAD7X0GznYccc6enJe
 aHS8cNc.QnOOyJuZXQ3NBWX5WA3u4uyfFO2cRHiktCvry5XwQ47X9gMvlDMpWv8YBJ6koT4ctzGu
 hLQdjJ0n5Bhr30_t1VFOZbVJMe7PT3B3seL2PO3Lu1aPWo_ErjUWg3fxJvvk7BjvhcVrJhz8L1rW
 YAHJ1KtKTIX6A.q9KohLTvGTc.JxwVuSyCO7uLnH1AwWTOBjCcbhljfxO8krkdOTSakmmPJlLptx
 mSpMCFfigpW7_D86V1dCcGN9BsKrqSDSkAkqkSnsHia8oKK1nmShJRiCdVub5YLcYOL8PkJUl0o1
 1M8i81vk.Ds1a3SanzmbZ3bYH4UDcHJz8DN0hHDvjUpw9M4TtMQlmpIDHIM897vqwZD3HTZEA2ex
 CgXIDVDX9LUnxUSBefH63hX6cLY027uGZi77N0Nom9qs4.UB6IN8AKRw8IBx3Xa5uv9UNF31OZdr
 hneC32Z1vwmQNHu0AZ5hzI8SDEIxN__V2L3cma_vd4dSJxEKQlWYkvXJW8mjyASO9nRhjEDjodjY
 eMq8Y.IJIbg95ZX5dY68WHQO16Y0ULMALm5XsR79TOe8FtJbpF7eI2389YiJGH7_aTKwNMg5rjcs
 Rc4g8BxN48Ziu36Md032G76.7JKb3h2QpRBkJuLaRN81u4lEaKSPeDZVPuR8bNJ9YR7iqGRmqmkI
 IwQETouBr4MMU2XO0xgVo7u5feuLeo6gXSemVjBHlN.g8j8rZav8WeqeTmH8vm_JUI.ZN3pc3Vky
 xD5wbe_VFCfqfWcthg5Yt6dyaTKmUjDcWBK5_j4ANqn.cPsofMieEJFkQpvmMm_v68ZR7anGw0mS
 8XItAcsxK1nFfe3yz2ayT5M1SEM2p4ZjLdqSd0_x_PCdcEA6r2M6bJQA9SAoLY33NJlditMyxCOx
 wBJmmQbvx_Ro_s4K2iyPM0b.tlo.5hbZ_h5z1vzOexC7p7EAFYxCCLtigdtZgjMpGHSUpbRSnALJ
 HuvIDx52vijZzx1vFgQhjrxk6JIRyeXMPQjlu4ZZTEQUFlJFP1DGeQtqPnWcgIzGfyceBVOwS5ag
 _X.8ia7Wd8c3e0G.qd3G6nsHFGicPnLxqa3cdyl0XLR9anojDTPghHoWTtvKBEsXRCiAolcTnLdl
 INA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 353dc739e5c49befbce16148938a824a;
          Tue, 09 Apr 2019 19:59:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 00/59] LSM: Module stacking for AppArmor
Date:   Tue,  9 Apr 2019 12:58:25 -0700
Message-Id: <20190409195924.1509-1-casey@schaufler-ca.com>
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
