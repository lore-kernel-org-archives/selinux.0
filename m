Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36D4C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809BC21835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RIVKbai2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfLPWdv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:33:51 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:34456
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbfLPWdv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535628; bh=+R0f5Pb+jzFZ/4+zq9nYc4/3+i9YVKFRUdvUCQRbbB4=; h=From:To:Cc:Subject:Date:References:From:Subject; b=RIVKbai2pUPKEqL3Pns3WJMqXfIidjCuvmHVoEII7GEM9vKT8MGh2+QMVIkPUjmxUiq8qKNU40zGJq8A1ZcSa84ymQol8B1TGkQ9P5sdC5XFTpg44UZ4s6qQUsZ1H+Ig6kdM2UZhSJ6kOqzGJMh5XfvLctBGhHmCguKzu0JOhLHppwZQEOXNtLkXzV26P6VCgZFTyJOqasw4GYLYBfVaVPiFULJzenffRtP5/3VauWNFUA+d0QZNheHIe/lmHmYs+a2OJw5J/k5guDuGkkWzzfwR5XsDp4pTc9A0UmJ8wW0y+wKh1Ox/xjkCQSmpAg1eIjt8LBZXAl+LETrqMq+i9Q==
X-YMail-OSG: OFq_wc8VM1klgCAn4Tfz.kFfGXavKthK7z0woFyidSE9Tg8WwHjPGeHxE0nZMo0
 EflM4_I2vBOIaxIJjKZOlnjgWGvzyVmkeW_NEq18S_gfKGKVg4mXeoDX8r99bjMxVkshq7iS0ZjF
 X59MFzs5eHwNc0nMoVwKojAa47JOgDbQr3kPqU_yx1pIomfKlGsU3EjLylQhJ6h837ruJGIbRGu2
 J3D5yIn717A4iBkARJZdPRD2PWhdkvP4WawZF56kw9ir7cDnVZt1QDNAaszLJwez55DiI3BhR_wY
 uvxmVj4gD8ui61XXnbsu5bBTTSYPNwphoOldsIGExjFgBdcz4Uev9YPZXF0FclemLHgNqSarW1B3
 1sbhpQZYStrlYxF803XI96BNh2N.8QCVX2lZQhVbqUlijNY5EHVX0XBLHP3zjQpq6ZEhQ_zTHKaq
 NhAh30lbANvcg9bowbsRalmv53.meHSNc_QyQoU2SIykjE0g2ckZjzqcvVgbCiLHacpgimT4d02U
 .virLTdfFQOSSPkUeUWmVzd8qk4XKcD7Z.v2wnL9texhFqhxMgkOzrREBv961R4z8KO7TgqGUXbo
 Z_7RWZ9eSpNZwLp2SaWF7jVfk8UWK4ayf1W2hakumE_lLR8lWvJYfJvVVDHu8qQdFq.9PTIGm7w_
 HHNiLZwjup0F8PAQGm6GYBd2jzkUC96zjgwDKsCSdOSi.X1LoeGt7Jre12aufzL5ANNKFpstZ_Xw
 ZQueKiHBe7gxzhoDMwy0eHtJ0hxRCVJlApf2oYtdotsayKV4GpkBaPOc1QN3UNCCY9Ja0H.962l4
 nNS_uOjcuL5yF9kvgJN9nptDjEU_g9rL86cvtLedo5SvL0.TdORJQtJMTk79.J0Emt2DAWyMaVK8
 oxKYdoXt5b5QvYG0k6.7JmX_3wHg5_1vkTmiieBsac_ChgGhf3v6n2TXktglirNV4FvEH4GN4EI.
 8dNysFY8JBlpd62Gn8.ObtaDd6i_chgQgqW0Lh_x7B5GtS_aDXC.QmuMzxHTVX16DZ7AcxUUfgw5
 cXPw1jNhqS8xuZPBvH0G3bqY0M9gtJMfRX6Aw80evKvZ78rwtnf3nNOJtBS8.LFkwSHBFamS9oLK
 ZGXUyqiL2vTm5oBnMv7vC1OZLPsB82QVsQF_tWYx2fykElYzc2ZZx0fjip83bBinSP096UQApBI3
 fS.m9NZamlxCxQUcsLrRilE1qsgm4EG6EZAN8EUn7LHLJCnaDHx6amXnUJctMKThnsfoAqP5c1ye
 zYXNaXmLwA9WLM8BwFPGL9Ud79kefieVA.L7XbxAWm.HhoKTyiNHRh4_1h3XoJv4pnWNBK9LMyR6
 Bgg77NWBVXurga5M4iFUXt5K0raOIxkJs_wOZ5wWTd14PEqN.AoW4gGiXrIKF3OA4hwZjkQleh.A
 lWK4n5TE9JXsY2447dn77tgxBd6bdjjtn9UDOPMVS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:33:48 +0000
Received: by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID df0d9b9ca902229e8a3f24aecb3674a2;
          Mon, 16 Dec 2019 22:33:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 00/25] LSM: Module stacking for AppArmor
Date:   Mon, 16 Dec 2019 14:33:20 -0800
Message-Id: <20191216223345.5066-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20191216223345.5066-1-casey.ref@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset provides the changes required for
the AppArmor security module to stack safely with any other.

v12: Rebase to 5.5-rc1
     Fixed a couple of incorrect contractions in the text.

v11: Rebase to 5.4-rc6
     Incorporate feedback from v10
     - Disambiguate reading /proc/.../attr/display by restricting
       all use of the interface to the current process.
     - Fix a merge error in AppArmor's display attribute check

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
A new interface /proc/self/attr/display contains the name
of the security module to show. Reading from this file
will present the name of the module, while writing to
it will set the value. Only names of active security
modules are accepted. Internally, the name is translated
to the appropriate "slot" number for the module which
is then stored in the task security blob. Setting the
display requires that all modules using the /proc interfaces
allow the transition. The "display" of other processess
can be neither read nor written. All suggested cases
for reading the display of a different process have race
conditions.

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

https://github.com/cschaufler/lsm-stacking.git#stack-5.4-rc6-v11-apparmor

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 arch/alpha/include/uapi/asm/socket.h    |   1 +
 arch/mips/include/uapi/asm/socket.h     |   1 +
 arch/parisc/include/uapi/asm/socket.h   |   1 +
 arch/sparc/include/uapi/asm/socket.h    |   1 +
 drivers/android/binder.c                |  26 +-
 fs/ceph/xattr.c                         |   6 +-
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
 kernel/audit.c                          |  72 +++-
 kernel/audit.h                          |   9 +-
 kernel/audit_fsnotify.c                 |   1 +
 kernel/auditfilter.c                    |  10 +-
 kernel/auditsc.c                        | 127 ++++---
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
 security/apparmor/lsm.c                 | 117 +++----
 security/commoncap.c                    |   7 +-
 security/integrity/ima/ima.h            |  15 +-
 security/integrity/ima/ima_api.c        |  11 +-
 security/integrity/ima/ima_appraise.c   |   6 +-
 security/integrity/ima/ima_main.c       |  42 +--
 security/integrity/ima/ima_policy.c     |  19 +-
 security/integrity/integrity_audit.c    |   1 +
 security/loadpin/loadpin.c              |   8 +-
 security/safesetid/lsm.c                |   8 +-
 security/security.c                     | 593 +++++++++++++++++++++++++++++---
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
 64 files changed, 1372 insertions(+), 560 deletions(-)
