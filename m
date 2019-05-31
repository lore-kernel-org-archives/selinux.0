Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D248C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F26A26FE1
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mZ9ZwXGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaXKa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:10:30 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:35079
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbfEaXKa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344229; bh=hp70s42sLJvM/zJRYPFnublS5r/YV4V9DcOROooBKGM=; h=From:To:Cc:Subject:Date:From:Subject; b=mZ9ZwXGOFs3SgjzBaw/G6vrqQu6vQdU2/KKj1k8jv4WMByfz//TP51eMdmHIMTOseOhfFrRb8w3ZTRHW93DMW0/ktvgZnq9gZctD+64+wSou24i66cVj8Z+nLpMSjHVywtcDYonLnPsrtH7FdxnMqUIbQVEVSl6sGC5SlpwQuQZ0PnG6BTEQx8D/yAE400fazy3WoWMyVmECCWdEnkof4dAeWAXh4DfxYkziPPvzRoxKDvTRGYFgMRU78V3m8rMYFScLFQjG90va8CJzySQZjbQV1EiVeV76Sn82sDcSyhwRO0H9TihpwqOEpI66zw74vKGLS5dPohOLpU7qiF9MxA==
X-YMail-OSG: piW.N1kVM1lsq8Gex2KwTMvtqStwZGM3OaUrfhbEU8IHlH_ducHfqdXUCz2bZff
 4lH9VwXRyYN1Ze3SoqSNA.4hLWObVe5po5Xd1t_t1PPUhhkwjDx7_iqoW93zOiMcfzk8gK.uihaM
 EyYERYBJHk4GbeyyetdM2yeE0N9k8Wssnwrzwx2cSJu4v.o4._2E2u2JAz.rH2ba47K0MAQPVHIH
 r4cmWUWj17BwV.0MSrt_f42ge7KOGXUrPM67zyeYUWX9IJIxzuH5F4evpNq0T.UhnNYDPAPf7j68
 VjenkQ2.g1jHtlmm6RLllCojp7K4GLYFrnc1HbJEjDMJtMt2KFeNrzxRJ02KdgTeoZqhwP8gQp9L
 WE8G_2aizKAaL0khQVuv9Q6tJMmvjBwZm_dZJRDnOXUJAMkuWyDZaLNHBY1WInNr8PHgrcPHQ6E6
 uGSO7YVzJzEs5qST4_mDmwM13P0igXsUQpwMZff20KBEzWwE8tHGkExKg6VsIUlN5WzqiTbFl2Jh
 TL.cv8bZXID5UtM5Y5gB3blA5iT3b5.TGQEdevD7MMnGoKihKZdGCeRFFlCitYhBpyA8_dFFrEK.
 JOOeVcwYsAhu8hCoaisztvvexKuQkGGkuKYgWprH9WH72bIUXtJ22WuH0Npa_xAYJpMIxXCDSOs0
 LS6W4jUwLS_leRWXPK6QovlTdCPH_bW4I0M5TvKFfdhErX8Nz3wFv5LdDQ7p5Dqqq4IOYq1YOSl.
 1.Aj79rmpb0_gkX.F4EJqIH1wAv4WUdpfkpYT0_aFTmM8CkXZQSdt.J6hrtcG3.X1pPfVjN7LrbU
 wAwU3jwbFyiNRNKvTyqZ2AMpJmk_aSc.d8nI_tefbp10onG4pMQLPUS7HgIkiN5QPv3u6a2ZDsNM
 YBkg0JgqgnltS_X2P2ex8xvT7KkRzIBSw7Kf4ZZ0rkuvtbjAyMpxlYMKmiiqIt3uBA4SAVXl8YZd
 Y0YhdUR9l6kAXB51GAGfytQbqueBl53OiJtFX6MwefwiOI1idsTnsVps5efVokrBifdWktEsXHVC
 O3JNdU4Ww4G_1i.NyC35th0e2SQg2GSup3I5.PpmV.cw_PaGCr7TXQM3udFD9XODC_wd_EJEL9SG
 sxWy2r0jfF2_t4c3b14drgksDv5kzCuRBiPKNxMpiqRT0XXAETIAiZrx51k3D_iT_CiX5rKqGYib
 32RukrVNKaOg5v2W4HGgFlkasaYrbkHJqSpIl8d2At._TfUKJMEGWNOg9toUz5qynyRlnWF0VNFI
 07vtPRDKAspJx37cPU56rXB1eOMrASjRcfdA5ItxJMhtkvLyh9cVnW4gpV2qTr7OS6cOABi1r45W
 V.AC6Lg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:10:29 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID af9421ba70442785cc6539d958422e31;
          Fri, 31 May 2019 23:10:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 00/58] LSM: Module stacking for AppArmor
Date:   Fri, 31 May 2019 16:09:22 -0700
Message-Id: <20190531231020.628-1-casey@schaufler-ca.com>
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
