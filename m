Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF2C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7455521EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GhVB8BQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbfHGToU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:20 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:40784
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388713AbfHGToT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207057; bh=oQyOiejdpH0Sf0Ix7FJU9ROEJfXztoRmy+B9v+pqz0k=; h=From:To:Cc:Subject:Date:From:Subject; b=GhVB8BQm/TE/bGDas6gxlqhxWNbc1dMy1LO/tz8ZEbOcjBfk/F2vqpORYkwumzeY7JCElzyTTn+6csyIxrUL0M4FqhtxHhoslqZ6wSaaH5/Q+SKQ2Ig/F/q+xOy7vMN7OXwianji3xC57HvUn0J8964u/QwngB5ijXpdNQSyn2KQK4BQ7GoztAduf1pg29n+CxJS3nDhyaXN8o8JMQWRJ6ACeQ98J8z39aNhfixaSLaObSCSHv0uyFPbbVhF+dJPAwj/5lKCm850lSqRLwBkyX/PerdCUJJPvMO1m8Us0hUqhPjw1gMUh492Kj0QHfdMsNoxO6mi463CUZMlfzeLaQ==
X-YMail-OSG: yopMKoUVM1kiexriQewbIUfNP8BaIPb1EkoAST2za3DotZisrQ_VerzenuuRQnR
 dI3wGGDNmNpNHiFGbKTnF7.XDntCozkV3YgULx1_R7yzIp6NLqIobZUzTpxJDdA3RTJ.x2_YQzlI
 KJdTFggsWBeHFbWfNq3C6c7KLtyyQExNsLC195fpSdYjO_7795CGMxQ4zGSlgQ4R6dmdEi4.MLpx
 HFCxJt42SyWeMSpEkDaWRxR9RHXNJlkbMQ3fSFa7N0bLQ0Qbp4DGl_AlgZkwbSCvO814y6NdUhNx
 K17o_aPLniMcEivG2dn7Zb_RDsWs3Dq6.1.3EL2aWa0hdGKOiTSEz42XjxXSjBelH89YnMEKYv4I
 6f1hd9AVbJL7UqKP6OkhEpkyY_eaY8VmZgXbg.U6YW2ZSE1VZrhiLl8Sr3tNtxjXvFucVXsqHw1T
 tMq9ecO2UeVD5eLgZlcc8tA0LA49MT8zrDoF9lmMp47LZdonDv4goKcTjkXPWw5skMuJ9jncTj1t
 JmqrqLomUgiy3P.1IlV7A5HkL535HdznlCkZdydJeQT8FoiBSIGXBFpb5EL1XsCLSieg.ybkUBj_
 EaFuByNIWFmJyeBRNbHhaiUgBpS2I_HadWss3Ag3RnJapyuiqfKwn6T2RTsn5KMalyLScNtK0aso
 XCdJT17Z4lnoKofX1on7gDIs8vc8WaYUrhgp84hj4uZjaaekjHq8mvs4XwEkiY9Wm_FB3Eq8baNc
 26wBnmObgriiKyGKVoAgDJD0suMhokMBUtukw4Nakc9OCAehBVewdGnmEoo.VoPCnHwjf9a4IrMC
 d.M4P0o4.KtEcKtlhiRYnzsLtYZZAWurpjvjNmI3KBhpz83ab4HUQ3ppoZXaOOB70EMbX3EznbA6
 S5t0fbJ5eb6mvudMUvx_2ZerJ9PCOr82dU23fS5b14UEqrXnnBCZFBBgcnHgfxuxpaJwMVtNxOE7
 G9TccZdMjTZ8coWDiddRMG5vPVCaYAGknAzRZM5w3cCJb.W9gVH.jSuAFefr8UlDFyiNK1AzekL.
 jeKo53PqJnzQnd3GUknJHmhcLcANU2LEuJ0xJxD_upsQJG6wNxouX9oEwbUUjUas0hHD8QohldKF
 Gwj8gOgEAim8mQC9dyepbWBJZmS545tnvMOYDlxOSGQ3AaF6H9ECawbZ7SReVDyslqqeWI.fGUCX
 H_Afp_gr7rizI52Gka9tHgfAe7IuOvSbPj.BfPSsPj8tjujEhcbf2339QKkO01pqRr0xwQsDBqXf
 pNhohAlxuAJps00pfpZGLAYab0SQtG.IAPm26e2YtxZsuTFKLaDAS81B_L7CI3OZSbxRqmxM0yab
 aiRYzlO.yOYHg_t660w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:17 +0000
Received: by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5e31aa314e44fa49b0fc0446bd9aa9ca;
          Wed, 07 Aug 2019 19:44:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 00/28] LSM: Module stacking for AppArmor
Date:   Wed,  7 Aug 2019 12:43:42 -0700
Message-Id: <20190807194410.9762-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v7-apparmor

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
 security/security.c                     | 619 +++++++++++++++++++++++++++++---
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
 65 files changed, 1490 insertions(+), 686 deletions(-)
