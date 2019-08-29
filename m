Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3DC3A5A3
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62812173E
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qpG31DoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbfH2X3o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:29:44 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:41645
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfH2X3n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121382; bh=QNFfpIuENp2OnNTjoEf6b+PwLh7yejarWuQe1E8hiLI=; h=From:To:Cc:Subject:Date:From:Subject; b=qpG31DoUHhTSfzdTcddJavvjrJHHu2xIZ5/sTZ/abr/pmHSecZrJ6Zl8oUy3IP07rsBp509hsoUYAEewjz2lFCQR09VGwQLk5WWg4MNDYxsNd90e+jgYTnR7uiU9ZH5u96uiBL0Ry//VVUb3RLw8ua5KvY6RVwouVFYjJ8RuNFgupaIwgE1jx0rSLbNUTwbvTq7WHYk8glFKcLEBBzdw4ZE0ISsYHPCtwR8ORKZ0OAW6oFOsDXXy4SOG4pIlPZibOyCsKwMDtVIylUA9nhuiSyvGFjmrcGaX1lKzGSK7+Z0XEfvd5GNI4lOCZHZdIT+3uNY1MzljBXpGz+H/MDIyNA==
X-YMail-OSG: B4DmbSUVM1mfQ5hoIaRsO5qGlw0R1tlBQ1FlHRpw_t4RiO8ZIOuC3XJCBwHn_tT
 pqgYRWnAHOo.rb.XGKXKEqyiyaTuKE3dClkGs2WhitQ_TRhTWcykg84aDBmOi7xZz.am9y2z35DN
 PRQJL6KiKDLAFA4yRU1uQp2BwmRoPk_NXCPS7ex.hEMYdk4Y3dlbNUvGl9NdbCrk3FukpwoVyhqw
 gNFbYJ8KiMrVgtlIUtv.kpr_xNWQszurt57yrgUbGXFnCXLNXWnkfTkLn55BVjsrAlMWC3tJPkE9
 FONhxh0BCmscPm.2nwY.XIECjql8D9AgfmnozhVEdfwSDKUhSAodSL_2h9Cn1W1fCVZLJjCVyUYX
 eQoKcOL93cxj_wA5_4O8zqV5RfYHaygEZpte5VfoDHZ8kNfAQkDHbe6_eySgg7n5jmWVRCNsL3Qp
 w1a6lG87c5qi.JfYRxlL7BfK2GQVfXIfTEKugtoJ5tGLVGUdhFrOR1ISNyxzZ4TFR5toWyJ4VeXh
 7zlijRBXa2q4sC9ewo4fqh7_uc5oJPlKGr.p4ifp8uCaIww5ccpoz7lnsWhc0JE0t3gGWbWxrMgk
 W1f0q.BAeoxu87e4EbJUC9ARZLcOIQ016ObvWfUpkfUBY04Grdv.M78mOpc.KcJvv75gT8nWSfwX
 zCsRkHump4_G1UKJRadxY2SxqEQWPlGv3hf_VN2U3u.7BchAY9W.a45JGYE_l_xGtCEpq75gX0Qs
 eeoAFxRyXCXa_.S8aPElN7IkRDNWoF1GqGA1Vbp1JiHZRpXAxwT2yqglWKhXF6H8XvPIK6MV1pzq
 LKrCK_A6dvCbHQ6HXVvf_U0kgfDCEiuZpQ2TWcoW3650qo4WurH9mwK1Gu_VkgqwsC5Ji.FDExDF
 zShuV5GMdF_Q6rGBCMKIdsyH4SbSNS.QH3jV13561EY4LXbxaGJOopsldUe6moM.X6MZmMK07z5v
 ri_y93Mum0rtJXM8AYpBwhWGFm23qAo9xEXEn1dk1INLX1t_oO71HQzs6DXxbv.3ANwEvWZbclfX
 J5sJJDrG8n9zrcFxAENyJdXss0YQ5wDxqkUS0fgY2KlmqO5yI8NazcoF0W5wftyZ4gvYLbp4wD9K
 Z_zAcewLzLLzaZl1XIA8pgtmsMhlquK4uxUAREM.JsWhiIn_soPFTs3FCOkG66jwo28zHldm8Din
 zkpBQWA4W065qxbF4f3XGCyCTSGsUNSm.kilj.p1TLVrBPbm92ewapGR.75_P0ggGDPp8QRFV27Z
 0SRIfMiNtfCxPDRfQ9C5qNBt5dKvJTcgl1WQXT9n30TOd.eQZ6Go653PXlGoRNCDdf8P7j0I4i4n
 6ntsb8Ai__6bIdQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:29:42 +0000
Received: by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 348e1bb830015a550a7ef552e960420a;
          Thu, 29 Aug 2019 23:29:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 00/28] LSM: Module stacking for AppArmor
Date:   Thu, 29 Aug 2019 16:29:07 -0700
Message-Id: <20190829232935.7099-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v8: Incorporate feedback from v7
    - Minor clean-up in display value management
    - refactor "compound" context creation to use a common
      append_ctx() function.

v7: Incorporate feedback from v6
    - Make setting the display a privileged operation. The
      availability of compound contexts reduces the need for
      setting the display.

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
is then stored in the task security blob. Setting the
display requires CAP_MAC_ADMIN.

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
instead of secids in Patches 0020-21.

Patch 0022 adds checks to the SELinux binder hooks
which verify that if either "display" used is SELinux
both are.

Patches 0023-24 add addition data to the audit records
to identify the LSM specific data for all active
modules.

Patches 0025-0027 add new interfaces for getting the
compound security contexts.

Finally, with all interference on the AppArmor hooks
removed, Patch 0028 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". The sockperf and dbench results
are on the order of 0.2% to 0.8% difference, with
better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v8-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h    |   1 +
 arch/mips/include/uapi/asm/socket.h     |   1 +
 arch/parisc/include/uapi/asm/socket.h   |   1 +
 arch/sparc/include/uapi/asm/socket.h    |   1 +
 drivers/android/binder.c                |  24 +-
 fs/kernfs/dir.c                         |   5 +-
 fs/kernfs/inode.c                       |  35 +-
 fs/kernfs/kernfs-internal.h             |   3 +-
 fs/nfs/nfs4proc.c                       |  22 +-
 fs/nfsd/nfs4xdr.c                       |  20 +-
 fs/proc/base.c                          |   2 +
 include/linux/audit.h                   |   1 +
 include/linux/cred.h                    |   3 +-
 include/linux/lsm_hooks.h               |  39 +-
 include/linux/security.h                | 184 ++++++++--
 include/net/af_unix.h                   |   2 +-
 include/net/netlabel.h                  |   8 +-
 include/net/scm.h                       |  15 +-
 include/uapi/asm-generic/socket.h       |   1 +
 kernel/audit.c                          |  70 +++-
 kernel/audit.h                          |   9 +-
 kernel/audit_fsnotify.c                 |   1 +
 kernel/auditfilter.c                    |  10 +-
 kernel/auditsc.c                        | 129 ++++---
 kernel/cred.c                           |  12 +-
 net/core/sock.c                         |   7 +-
 net/ipv4/cipso_ipv4.c                   |   6 +-
 net/ipv4/ip_sockglue.c                  |  12 +-
 net/netfilter/nf_conntrack_netlink.c    |  20 +-
 net/netfilter/nf_conntrack_standalone.c |  11 +-
 net/netfilter/nfnetlink_queue.c         |  26 +-
 net/netfilter/nft_meta.c                |  13 +-
 net/netfilter/xt_SECMARK.c              |   5 +-
 net/netlabel/netlabel_kapi.c            |   6 +-
 net/netlabel/netlabel_unlabeled.c       |  98 ++---
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 net/xfrm/xfrm_policy.c                  |   2 +
 net/xfrm/xfrm_state.c                   |   2 +
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 |  85 ++---
 security/commoncap.c                    |   7 +-
 security/inode.c                        |  22 +-
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |  10 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  36 +-
 security/integrity/ima/ima_policy.c     |  19 +-
 security/integrity/integrity_audit.c    |   1 +
 security/loadpin/loadpin.c              |   8 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 632 +++++++++++++++++++++++++++++---
 security/selinux/hooks.c                | 213 +++++------
 security/selinux/include/objsec.h       |  18 +
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   7 +-
 security/smack/smack.h                  |  19 +
 security/smack/smack_lsm.c              | 185 +++++-----
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 security/tomoyo/tomoyo.c                |   8 +-
 security/yama/yama_lsm.c                |   7 +-
 65 files changed, 1503 insertions(+), 686 deletions(-)
