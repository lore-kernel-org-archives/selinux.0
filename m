Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C3C31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD712080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rl+ySgft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfFRXF4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:05:56 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:42378
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730429AbfFRXF4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899154; bh=QNCp0LyRM7XsaP8SeqCKsDElJHYYjkuSpYXOjPhyPN4=; h=From:To:Cc:Subject:Date:From:Subject; b=Rl+ySgftAhKtXYoSvtVwPH5V0bsMzrXWARK2qIybnFbH3uEqdNMaCRhNrFS1UgwiT9KPey3+WWO+vQ0zumAKbCqeI3YpaoNIY3VTaIR6UL8GK22IuVpc0FDIzxHnPTAyS1Whu6qJT5o9rlo3s7gb3rqAG9d0rE4lYJyU9j62ZdBgwHbYj5od5UanyUSwS/hM/gDKlkOHS+Z4x/ptRcXKPCgp+hTxujcvcFGGIhpU2j2Ne9SWfNHDlwcfAkJebG8Qz3bzz/NB9jrqEOi/+4IegzfhQEt7YF8y5N4TO8ppfVpq/7jOrw+6uhG7QnJJ0cBJhJ3WHvYCCafn4MQrXhKLjQ==
X-YMail-OSG: Q2aWPBgVM1mVtSQlZE7Mv70sgVyyzRL1ijKM3sloJ4ki922qvOAegWxn4Z_tMwc
 m5rhMFu5CbU3.anRE0erg8UBtuI53Q2TfE8jn17_MgW88ZuIrcogDbgUlAzIDMKJxqOIoZZT2jO3
 3I4Vl4eWJZ5RUt8giCX6SHjLcgzOE4ipvXo4Pqy8onsJ09_P03pT2zLVeJZVuvAmJGasUDmtsvkK
 Hpvo1vqfQwdQH1w2jjW9k.7cWg4DIyVnOlz_RtEhz0L7hoVcnClCZdlX8Ehmee6WhcqGHw2Tlkkp
 ayI5yaN0LRIyWlTATHCfyTnc_yLZkMD3UHLQGpntSPDZbosRyTdR8xXhZomL448XHdIXT9yLBslO
 Vq3t1kYBtTo9VBxHFKn9ZwIQF.G4llk3hm.TjdGPXNeysf3t2KOwOBGQPHOLIQP19rbLJ_wuJwaL
 4.rWTxVu7X4OZ8ymgCQ6zrnKO11SAYU2PvnhdE9C4jxBlBgS7pLmOQ6oaWGqJTRdCtEaZ6_VNy0N
 ol9jYxZs7EA7lXDJ.LR4Wq48pVJwijh0WXffLPMC_n8tJifDn22gYeJEfhn9AKzw9mNmF.9DZLFM
 rScouNFQbJ40ZYXJQgAt7xFyTN_pOq07LjNpoiI3kz2vCP.G4BBjpwqlAZw.w0c2iXTB0y46Zb.i
 dzZyuCGs4.2UHpwOIXjsbElodMZs2BHQ5ZwMpAbi_LhA.nmv23e4TlJi_mmKtO03qJYJtPUyLLkG
 UBOa8nHWG75SuJiSZ1cfxIjuBKHvrstQO743SKlLpS.8ms7lC6Nm9QXXYW5AWPmnLNvUGeVrECVV
 KkjirKrDVAHVJ5I3NqM_zKFJItmFuVuc2OYwPIvj9DN2cybjwA4pZE3lmOe.YZC0vf.OoHhf46TL
 CQkaf093bsvVvmW4E6VmpkWuKD_YiWhc.Cq.4l_1lFXJaS1__4EoQ3chRkIWowXdYeNCZMCYalVK
 EqnFhsmzuJ1xQmdZ8HGgErZ7y2E60Y_7ZLTQUnIWG81XOQFiQhv0yctD444pPb4cF.uPKwrykUTu
 X9Bte7Qeq4wTbt4NPOZIrqsvCjWKGbwZkCSsII6_MVnTiEu4iJcfCA9DbiV0l7cTQwBMybwLjeRW
 44a78dgViMw1egk_iBVBWC6xHn_s6di4TukKkhYApWDR5UKF2itG308J4G.M6bV6oWCI3xLJA.P1
 uB0kp67y1PC7kA3yy3cMlBy1afZIh96kzXtYfbyi3AuT9_LsXY.gUH5AtUYS11G5vzt4Z9SCMi0D
 F6iCYnA0TNJYxKewpoXhOlvlN80aYwfIAQx3F_lFHMSKDJqLw4QY9rZY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Jun 2019 23:05:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2437e85e03d954d21019d208f67457d8;
          Tue, 18 Jun 2019 23:05:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 00/25] LSM: Module stacking for AppArmor
Date:   Tue, 18 Jun 2019 16:05:26 -0700
Message-Id: <20190618230551.7475-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

Patches 0001-0003 complete the process of moving managment
of security blobs that might be shared from the individual
modules to the infrastructure.

Patches 0004-0014 replace system use of a "secid" with
a structure "lsmblob" containing information from the
security modules to be held and reused later. At this
point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the
kernel that used secids. A "slot" is allocated when
a security module registers a hook for one of the interfaces
that uses a secid or a security context. The infrastructure
is changed to use the slot number to pass the correct
secid to or from the security module hooks.

It is important that the lsmblob be a fixed size entity
that does not have to be allocated. Several of the places
where it is used would have performance and/or locking
issues with dynamic allocation.

Patch 0015 provides a mechanism for a process to
identify which security module's hooks should be used
when displaying or converting a security context string.
A new interface /proc/.../attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob.

Patch 0016 Starts the process of changing how a security
context is represented. Since it is possible for a
security context to have been generated by more than one
security module it is now necessary to note which module
created a security context so that the correct "release"
hook can be called. There are several places where the
module that created a security context cannot be inferred.

This is achieved by introducing a "lsmcontext" structure
which contains the context string, its length and the
"slot" number of the security module that created it.
The security_release_secctx() interface is changed,
replacing the (string,len) pointer pair with a lsmcontext
pointer.

Patches 0012-0021 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

Patch 0022 provides a simple way for a security module
to know its "slot" number. The security_add_hooks()
initialization function returns the slot number, and the
security module need but stash the value for later use,
as is required by the Netlabel subsystem. The Netlabel
code is converted to save lsmblob structures instead
of secids in Patch 0023.

Patch 0024 allows for an error return of -ENOPROTOOPT
to be ignored while processing security_getprocattr().

Finally, with all interference on the AppArmor hooks
removed, Patch 0025 removes the exclusive bit from
them.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". Better benchmarks are in the
works.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v4-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  24 +-
 fs/kernfs/dir.c                         |   5 +-
 fs/kernfs/inode.c                       |  35 ++-
 fs/kernfs/kernfs-internal.h             |   3 +-
 fs/nfs/nfs4proc.c                       |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |   8 +-
 include/linux/security.h                | 163 ++++++++++---
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  34 +--
 kernel/audit.h                          |   9 +-
 kernel/auditfilter.c                    |   6 +-
 kernel/auditsc.c                        |  77 +++----
 kernel/cred.c                           |  12 +-
 net/ipv4/cipso_ipv4.c                   |   6 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 ++-
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |   6 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  95 ++++----
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 |  48 ++--
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  38 ++--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/security.c                     | 392 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                | 164 ++++++-------
 security/selinux/include/objsec.h       |  18 ++
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   7 +-
 security/smack/smack.h                  |  19 ++
 security/smack/smack_lsm.c              | 154 ++++++-------
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 48 files changed, 1010 insertions(+), 596 deletions(-)
