Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D3CA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7F621D71
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FlZMiJCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJXUxI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:08 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:36812
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbfJXUxI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950383; bh=YzXnW5/L6igDxgI2K1OLnntyttuTMtL4IbcD3npVEWM=; h=From:To:Cc:Subject:Date:From:Subject; b=FlZMiJCnF8OgIaxR1SxlggyaJsr/3iQiS0ZPB2gDRarS6kxdkWIfxDeOcYNhz4nMrXtgw0A3fEWE1whFmAn+BA/+5agnUViJx9iYcD+MJyuAqv2Vni3uyKFAXO8wpMfYxbE4TD2CXObg4TyHhTdNRFXCaQCaFz1ZU9xYaLNsPHYruFXHAmiuddmxf18p4bnuUcakpRCJ5qw/CNbQ+Nhw2T+uuA2NhUDkv2gWPT08m6MJWl5F/m1z8F5V4bq5DduhAIdmAMw7I2bCPAajN5wFoHAlfnyvtUoALhHuhaU8nKUyFKZ+Ee5sQ8En7HXuFxeG4zKoFPgDxgmhYvgN9rFXeg==
X-YMail-OSG: Dl8aPuQVM1lh3cGuKfTlmRwGMYvbyPFzdVOt4v8ghW7a4Cf.KqoVlJmhez9OfbB
 3kTnCWYJNP63RBsdOc1B1J3Vh0Ef4ACuVJYuKYic5YUgVoUIop.mt0WWDIDuYG7qR6qx3Nq511C1
 sXf0UleQ3Rngsd4y4VD8GJWJe5HWnlA.l5YoleKjZFQamT5U_0YISIyZX6XlwdDlgzlZ8Di.XSjb
 ZAn6cO11CrHtSa9MSlEoz_Ktu6sV2FQCbKE0bYnPCX1ECf1pNKqcJgK6VEbc.y8Q9ZgiWShRxaMd
 y08a2Xpyda3FbEKhqiKXrrPx1oUPVtN2.1eQ9sKfFR6f7hSDkpmPVKZh3XGhlshTh3xnsJEqy24T
 SEygrU.JFl8Vfq7marVogCATFXn.7TlVoEh00tsoUD6s5ixg3N8VBh0AC8YgFa5lIn_7ziawHZQb
 _lMSIIIjE11d01M6B_IrOMJBVtaxSQgioPRtAP2bL15SZW.PIHh5DEWuJOwC.CCY0lzyU9p8oO8H
 l5yIjLPthW_p8QD1oTIpZnJw6.LVdHsUlucu_c_NPithBGPJ4OiINU3A_xm5eWSkYAuP1KiRpqdP
 hJmEC1Hd8XGA4P5D.kU0hyfcUauBMwnDIhaVaxGcyZwUj1UDjU28.z0wfasjQN_g08GJ1y_iWKOa
 ZrO4BrjTksv4nKj0lqwnW8jec_scRbxxRbqRxEsHv6BVJBwFO.NA837Z8pHc3fjBfgQ6kFTd2Dfo
 R5c_qD57SgeFGrPy9tUqFW7F5kTuAXXlTerpIRacxFZqsBe_.J7eVSlic_sNdIGgF7BVX_9eXh9K
 Xo5KOu0nmRczs1mcQSKQ0G2.Ws0_e1ildt065loE08rqz.FaAYEAYsTh6z8r.r13h5fsiFKnrH7D
 mhlDTa_dwh1Ju21VGrl396vIUZD2XdLSq4DB8JIEZcoG.EWkDYdF0aau0nvZAPAMMaHc4f8HYCAB
 pDFSCtwGVTf3yRRYmaVvmdqCrLWBvAEmtbraSO3JSiQlRTOdVvMMObOzr5HUNxE97yFIJf2inkw.
 Wj.evB5_PZy3UMgHsxME0Mpz5BDBrg3YjuDllXjIPB_bprSBDomty4RWLHiu0eoDoZDFnkYHbxuL
 uTvVPW7.0NeGJl8b6jiDHih5zL4zIJm1Ds59bcEXLbCXZ2wGOjSy3lVFtER3UC.49JKmptQXSDO5
 fAk6DiC31sMy3AdaPudz2hgWMN44fyBhdN.rbPWcs58cP5zuy7nhQh7PPmuVFyu45ONAo3uqN9oW
 6Maz5gygL.ICkoUDZrKzelo642GJ4GXeezONh6UyYW_iAXzvJ829kLPWzd68tx18xcGPLllMVZcx
 OcQ1kvFE1gAGGEdBzJK1Yqz6lZSNHI0UwGCP12m8zN37LoUiRRjVJ.dEE3MVcSr0sdHSmJCyHTGA
 hrZH1cw_OIINCfjpdkkSyL5Rl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:03 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5303e37f81df37f0f883923f3f0a8567;
          Thu, 24 Oct 2019 20:52:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 00/25] LSM: Module stacking for AppArmor
Date:   Thu, 24 Oct 2019 13:52:03 -0700
Message-Id: <20191024205228.6922-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v10: Ask the security modules if the display can be changed.

v9: There is no version 9

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

Patche 0001 moves management of the sock security blob from the individual
modules to the infrastructure.

Patches 0002-0012 replace system use of a "secid" with
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

Patch 0013 provides a mechanism for a process to
identify which security module's hooks should be used
when displaying or converting a security context string.
A new interface /proc/.../attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob. Setting the
display requires that all modules using the /proc interfaces
allow the transition.

Patch 0014 Starts the process of changing how a security
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

Patches 0015-0017 convert the security interfaces from
(string,len) pointer pairs to a lsmcontext pointer.
The slot number identifying the creating module is
added by the infrastructure. Where the security context
is stored for extended periods the data type is changed.

The Netlabel code is converted to save lsmblob structures
instead of secids in Patches 0018-0019.

Patch 0020 adds checks to the binder hooks which verify
that if both ends of a transaction use the same "display".

Patches 0021-0022 add addition data to the audit records
to identify the LSM specific data for all active modules.

Patches 0023-0024 add new interfaces for getting the
compound security contexts.

Finally, with all interference on the AppArmor hooks
removed, Patch 0025 removes the exclusive bit from
AppArmor. An unnecessary stub hook was also removed.

The Ubuntu project is using an earlier version of
this patchset in their distribution to enable stacking
for containers.

Performance measurements to date have the change
within the "noise". The sockperf and dbench results
are on the order of 0.2% to 0.8% difference, with
better performance being as common as worse. The
benchmarks were run with AppArmor and Smack on Ubuntu.

https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v10-apparmor

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
 include/linux/lsm_hooks.h               |  37 +-
 include/linux/security.h                | 175 ++++++++--
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
 net/netlabel/netlabel_unlabeled.c       |  97 +++---
 net/netlabel/netlabel_unlabeled.h       |   2 +-
 net/netlabel/netlabel_user.c            |  13 +-
 net/netlabel/netlabel_user.h            |   6 +-
 net/unix/af_unix.c                      |   6 +-
 net/xfrm/xfrm_policy.c                  |   2 +
 net/xfrm/xfrm_state.c                   |   2 +
 security/apparmor/include/apparmor.h    |   3 +-
 security/apparmor/include/net.h         |   6 +-
 security/apparmor/lsm.c                 | 121 ++++---
 security/commoncap.c                    |   7 +-
 security/integrity/ima/ima.h            |  14 +-
 security/integrity/ima/ima_api.c        |  10 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  36 +-
 security/integrity/ima/ima_policy.c     |  19 +-
 security/integrity/integrity_audit.c    |   1 +
 security/loadpin/loadpin.c              |   8 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 586 +++++++++++++++++++++++++++++---
 security/selinux/hooks.c                | 109 +++---
 security/selinux/include/classmap.h     |   2 +-
 security/selinux/include/objsec.h       |   5 +
 security/selinux/include/security.h     |   1 +
 security/selinux/netlabel.c             |  25 +-
 security/selinux/ss/services.c          |   4 +-
 security/smack/smack.h                  |   6 +
 security/smack/smack_lsm.c              | 124 ++++---
 security/smack/smack_netfilter.c        |   8 +-
 security/smack/smackfs.c                |  10 +-
 security/tomoyo/tomoyo.c                |   8 +-
 security/yama/yama_lsm.c                |   7 +-
 66 files changed, 1376 insertions(+), 580 deletions(-)
