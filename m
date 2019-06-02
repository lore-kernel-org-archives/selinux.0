Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355BFC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6B27982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dSFlodrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfFBQvJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:09 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:42908 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbfFBQvJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494267; bh=hp70s42sLJvM/zJRYPFnublS5r/YV4V9DcOROooBKGM=; h=From:To:Cc:Subject:Date:From:Subject; b=dSFlodrfgukvmhPhTVAVZWH0JuSkYLworhC7C+7zFA1eHgQNe0RXDbtOfL96QUAOnxm4Rtx6Xl0XM3IRzBTMB2VrXPwmdDDbgr//g0uXLefwmZoOVNiPdUSeAlkIgrK5YNnyLgQVfXKVnW6FwTmAxXegwpqExr34NghhuY9ypys8fcD4aHteKm5fLKaLigx76jTR3A0HmNcPnkPZBcs8DL69Qjfu0M3m2fUmOzgs44gA4kyDrc058wNCiDv/u+WxrY9ne6b84pjPXolEc9ytDAwUukod0K63dqmPwJXSiYo4/am6C006rox4X6Ov0z3OUOTr/14w4othdJ3+2CvsbQ==
X-YMail-OSG: jqYvZxUVM1ls.TCbtcv78TdbjV.BWnYT4m4fw1fu2sgn6QbI7Z9uF2LsKAn09jz
 Cbc2Q.HYbPitQm3x153SBNKQnp_wKO0vKLO07fmHnu2PDXIukeXgcak.pMMSl0.ZIRY4RP2StoL.
 RucDA068.UGbacH_mZkE.Ik3g6qIhgcxj1w0yIAntIc9gDCNB2ff.AQZp.r2gDIEg1VA3KfvpxIr
 LI_IYB0HfrW_zWgNJTcRfXv3JvPTvIOOTnPkwlvONP3eOmPx5P7R1S1qPZQtVerQJqI6ybQdf6PK
 MdiqNAvegSNthqEAvwiMnDq6VTbDyYXhX9AnhHb4VEreExOZS0IKl4JFOD1lhWEtKqXveacdQrdn
 UjtH5.2YJd1vV9e61jVgoFaWc7.dah921lrLDvDyB5dC6phc5w3t0MnWzu7Ts2aeXUggPAQUfwTf
 zoIKewJTbqxp_3odiZKBdw_Qqi0tV2GFdPH_b66aPtUvVEmCdzhOB8hLCwJGDVMJjaQsFQt8C18y
 AQvxoArM_9q4a_T5ZeOjtKU89TozeVoJFlcrmbF7hSxqgTY5W1QwxEyo4sOdJ1Qb5WarL12MVF5J
 4CCwCocI5EYbKs5WeDE9TM0WlOOUKcE9N5lharVhtQSlHMVYCflbNwojrBszjcNhXaaWSEmjiGag
 8xqP3uT2.1z.fLN6rBmcjt9GoV0N4ZEQafKoO1r48ElJNIYBbh5RzhZavpvHPepSnR7vf4hLUdL2
 QUQhUiHX.Uuh7zp3QeVdFFuz8ybLyCtV2QetBcgVHz2KG_ttos_bySkeMCgcJMaqDKwIZ7WpEHwC
 bPS1Fko7xF1Nen_ja6s70PL8IJlX6eKyBzK3miH1Zb0Wxefv1V5.qPElZYXcTiQJ4deeBJPZXnGw
 J6lOoDKdr90hOpjt7iXs3UMA1A3zTXQhYRZL.X4lhrZjwOeP5LIKANGwhFmwnYrOF9G_xA1j5xPx
 a6f6FKYYtiBP3hF93jlNgFrMewA2s2L_zXwyb6p4aDoPg.WcS0H78m5vWnjfoAwmiGN4CDVVQPPN
 LMXs2gldwb0sjzrTbN2Vo9cvjClX8he7P0UXzMPHk..Ji.Kz5FuDCt6_relBR4_s9vlhOyJ930JO
 qcqJZQ.rbkIcQy1DvLfFBv6x6oglpOgKtkzgKNXpwkY_HRjOm5mOwtsCmNl1eQOokd9Xm9XIsEyF
 3qAxBeJAuR155huKhPWDVg3Af6FQbmAzxRDvop0iqoEIX.ik5OkhxCW8OyBkZbN6Av1xJK7DzJ18
 jshbXwF.rf3eHkuMJKlLRtHF7dP9tGKNipBDkTYfNygH0JoI7_5.Sa7ANal7QJPseWg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:07 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 844f659d1e234107537a664739855744;
          Sun, 02 Jun 2019 16:51:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 00/58] LSM: Module stacking for AppArmor
Date:   Sun,  2 Jun 2019 09:50:03 -0700
Message-Id: <20190602165101.25079-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
