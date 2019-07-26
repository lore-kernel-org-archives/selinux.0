Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CAC41514
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECAC22BEF
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OGpYZT4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGZXj3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:29 -0400
Received: from sonic308-14.consmr.mail.gq1.yahoo.com ([98.137.68.38]:39269
        "EHLO sonic308-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbfGZXj2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184367; bh=P82m65XECjur2oE45PRe6X9XHs51PCnitUM5jAeUwBo=; h=From:To:Cc:Subject:Date:From:Subject; b=OGpYZT4DoBCivH7Rs73+UPROQDIO/2HpiRhv2v+yTarsTiWLiqaTBgEIURm4bn+AqZ2oSvKpinr6j5Iv9PqCYX62OnkOuDXhFarRr4XBDm6QZTKjj+BLQRcFygQ6TjWn5sC725K5XUCum29I72lr+s1Mr3iu8f9CaDEsUeuyMT9eopu0uzQxF0VB8MgIuYy5yRIHt6HgQ5zKW+aQu6eJVEq/IDPCf29LUhsNqtDb52NBHh0oE0SLwkQmhgfVSiGkFKP6Audb5kedAr74EaONNHT1snFFPt6CdFgYHp3ahFeLKJDxkuKHttyDc+HCjeQ5LJMW8yR4m28U8lOvwjVYYQ==
X-YMail-OSG: zjLh284VM1k6muNUhCGFVV7NuiLj222Ij_WOW..iEeJOraE2GBVRVHurNXGJdeg
 9VQcf93aLbbaz3z4VCkjTgorhgVOAW1R0kJ69WdvRL5UW7BP7h06T12bfkIkqqFmmsLG4rgIBPNB
 uRcQLwUGzexMYXn.u9jq1Ubcb7o43DeKA.1Ej45of0M3TUSf6byQ2i1SOzzCHyYiHKNkaXXyMR2I
 JhY_c_ieEj6d6qPp.Dh9BRCLcourXL5T6KwmL10lMlMr4.FSvfuZ0y1q.DzaN4g225wgEbFFY_hQ
 mcaOMAqVlK6PYpCZO48HanomTqPYTLfVKx3mho9H0gsgRE6aNqc1h5X5.XE.fJye4Ixnrs87moWn
 b.k.IrIOjD4DeVpU3HNXOhur_pQkk_lBBs.EkEKTVrw6qfijMRRrKqHjlo8uFmCpLEpHoIqy.vY7
 fzUTDNpHOag9le1AdzJInTrkojgN0_QDwmrLLWAvO.dx9vLgYHX5KFb_arZn09fixzOPFt9dgpAx
 9Zi081WiG0JfMjJasAbTuSXpMgPOdIgfEYe8fF9yJ3AmmlWJz_2m5C0agmvcJ1DzFbsZoTLlA059
 wLZ7NuJoUbEXD0tO2mnNQteWyGoDFi5yOez.Nm5YHNVYz3IKnghbt4k5u4RttLUYTBG2Yak4ezCe
 hdS.yVM2DNkQ4QyFdI0x_rJNSwGXwaRVq3wnzVbEhL1vnSrukHp6j9WhGwnXkjM4BMbbaSQc2lb6
 qVpLSP1lyLNjfasBsHAuzsSFCQ9dcqTys3BEmoR0LSxS0N1xzKR8neNGO5XcU_Xqqujx6AI1VVk1
 UBfeh9dKbSI0R5HkU3DcDP3VAgimErKgHtjVNsD9PZNXxwUITQe.Hf4rmC5xfKbUuQjccRI49bR6
 spCGRLhVCW_uP8y7FVmIna8gJXfx_onkdx087BTZbKIJ7QtPg.7aitM1IWnAn4l0_XQbkVJ.ZqzI
 bq5.1IjQSVQ.MhuEz7OTTboj2dcqoI3LoRCPJ.bpPkk_E6nntgr81aRbjsU7PRgS0hZ_3q_RNkKW
 1ruWmeF_NZJ4YW.cjoy4U6XUl4_1gpTRjT_I1K9GxlbXCFM.q4q17y5SztiSpZCAvaCD8bL5x77b
 CU4OQ69y1mUmNw56Ur9Qu6Riq_arZ6xdSKx0TRuAQi7kZcS3dBRfI4giyKZdVgvzmkB0GBoM.RVD
 RMzD1YcKRcthahOprZUdtUsUv3MNHwNkj9bksgSGyIWLGc2GAfoVqBnCSV2RZkoYrRHIHp9n_H8g
 kPWUFW2yCyizNd.3XOnskOUTeAA6IJnoLQIyKtP6EiuoRY4QVdSb3jL9AnyLnaDna
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:27 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 30b69319e1d1bc38abcc56c11a8a57c2;
          Fri, 26 Jul 2019 23:39:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 00/27] LSM: Module stacking for AppArmor
Date:   Fri, 26 Jul 2019 16:38:56 -0700
Message-Id: <20190726233923.2570-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v6: Incorporate feedback from v5
    - Add subj_<lsm>= and obj_<lsm>= fields to audit records
    - Add /proc/.../attr/context to get the full context in
      lsmname\0value\0... format as suggested by Simon McVittie
    - Add SO_PEERCONTEXT for getsockopt() to get the full context
      in the same format, also suggested by Simon McVittie.
    - Add /sys/kernel/security/lsm_display_default to provide
      the display default value.
v5: Incorporate feedback from v4
    - Initialize the lsmcontext in security_secid_to_secctx()
    - Clear the lsmcontext in all security_release_secctx() cases
    - Don't use the "display" on strictly internal context
      interfaces.
    - The SELinux binder hooks check for cases where the context
      "display" isn't compatible with SELinux.

v4: Incorporate feedback from v3
    - Mark new lsm_<blob>_alloc functions static
    - Replace the lsm and slot fields of the security_hook_list
      with a pointer to a LSM allocated lsm_id structure. The
      LSM identifies if it needs a slot explicitly. Use the
      lsm_id rather than make security_add_hooks return the
      slot value.
    - Validate slot values used in security.c
    - Reworked the "display" process attribute handling so that
      it works right and doesn't use goofy list processing.
    - fix display value check in dentry_init_security
    - Replace audit_log of secids with '?' instead of deleting
      the audit log

v3: Incorporate feedback from v2
    - Make lsmblob parameter and variable names more
      meaningful, changing "le" and "l" to "blob".
    - Improve consistency of constant naming.
    - Do more sanity checking during LSM initialization.
    - Be a bit clearer about what is temporary scaffolding.
    - Rather than clutter security_getpeersec_dgram with
      otherwise unnecessary checks remove the apparmor
      stub, which does nothing useful.

Patches 0001-0003 complete the process of moving management
of security blobs that might be shared from the individual
modules to the infrastructure.

Patches 0004-0014 replace system use of a "secid" with
a structure "lsmblob" containing information from the
security modules to be held and reused later. At this
point lsmblob contains an array of u32 secids, one "slot"
for each of the security modules compiled into the
kernel that used secids. A "slot" is allocated when
a security module requests one.
The infrastructure is changed to use the slot number
to pass the correct secid to or from the security module
hooks.

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

Patches 0017-0019 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patch 0020.

Patch 0021 adds checks to the SELinux binder hooks
which verify that if either "display" used is SELinux
both are.

Patches 0022-23 add addition data to the audit records
to identify the LSM specific data for all active
modules.

Patches 0024-0026 add new interfaces for getting the
compound security contexts.

Finally, with all interference on the AppArmor hooks
removed, Patch 0027 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". Better benchmarks are in the
works.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v6-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  24 +-
 fs/kernfs/dir.c                         |   5 +-
 fs/kernfs/inode.c                       |  35 +--
 fs/kernfs/kernfs-internal.h             |   3 +-
 fs/nfs/nfs4proc.c                       |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  28 +-
 include/linux/security.h                | 169 +++++++++---
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  14 +-
 kernel/audit.c                          |  34 +--
 kernel/audit.h                          |   5 +-
 kernel/auditfilter.c                    |   9 +-
 kernel/auditsc.c                        |  83 +++---
 kernel/cred.c                           |  12 +-
 net/ipv4/cipso_ipv4.c                   |   6 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 +-
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |   5 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  95 ++++---
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 |  65 ++---
 security/commoncap.c                    |   7 +-
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |   9 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  36 +--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/loadpin/loadpin.c              |   8 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 445 ++++++++++++++++++++++++++++----
 security/selinux/hooks.c                | 201 ++++++++-------
 security/selinux/include/objsec.h       |  18 ++
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   7 +-
 security/smack/smack.h                  |  19 ++
 security/smack/smack_lsm.c              | 156 ++++++-----
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 security/tomoyo/tomoyo.c                |   8 +-
 security/yama/yama_lsm.c                |   7 +-
 53 files changed, 1167 insertions(+), 614 deletions(-)
